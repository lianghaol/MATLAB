  
function train_models(X_train_bag, Y_train, vocabulary)
    costs = [0 3 1 2 3;
             4 0 2 3 2;
             1 2 0 2 1;
             2 1 2 0 2;
             2 2 2 1 0];
    X_train_bag_original = X_train_bag;
    Y_train_original = Y_train;

    %% Stemming
    stemmed_vocab = strings(1, length(vocabulary));
    for i = 1:length(vocabulary)
        stemmed_vocab(i) = strtrim(porterStemmer(lower(char(vocabulary(i)))));
    end
    [un_vals, un_ids] = unique(stemmed_vocab, 'stable');
    stemmed_vocabulary = stemmed_vocab(un_ids);
    save(fullfile('include', 'stemmed_vocabulary.mat'), 'stemmed_vocabulary');
    stemmed_projections = zeros(length(vocabulary),1);
    for i = 1:length(stemmed_vocab)
        un_id = find(un_ids == i);
        if isempty(un_id)
            un_id_string = find(un_vals == stemmed_vocab(i));
            stemmed_projections(i) = un_id_string;
        else
            stemmed_projections(i) = un_id;
        end
    end         
    save(fullfile('include','stemmed_projections.mat'), 'stemmed_projections');
    X_train_bag_stems = compress(X_train_bag);
    Y_train_stems = Y_train;
    X_train_bag = X_train_bag_stems;

    %% SVD
    [~, ~, V] = svds(X_train_bag_stems, 200);
    save(fullfile('include','V.mat'), 'V');
    X_train_svd = X_train_bag_stems*V;

    %% Train Logistic regression
    %best = train(Y_train, X_train_bag, '-C -s 0');
    %Best C found was 0.25 with 0.5325 accuracy
    best(1) = 0.25;
    logreg_model = train(Y_train, X_train_bag, sprintf('-c %f -s 0', best(1)));
    save(fullfile('include', 'logreg_model.mat'), 'logreg_model');
    
    %% Train SVM
    %best = train(Y_train, X_train_bag, '-C -s 2');
    %Best C found was 0.015625 with 53.3938 accuracy
    best(1) = 0.015625;
    svm_model = train(Y_train, X_train_bag, sprintf('-c %f -s 2', best(1)));
    save(fullfile('include', 'svm_model.mat'), 'svm_model');

    %% Train native bayes
    cost_struct = struct('ClassNames', 1:5, 'ClassificationCosts', costs);
    nb_model = fitcnb(X_train_bag_original, Y_train_original, ...
                        'Distribution','mn', ...
                        'Cost', cost_struct);
    save(fullfile('include','nb_model.mat'), 'nb_model');

    %% Train Ridge regression
    lambda = 1;
    Y_train_1_v_all = (Y_train == 1);
    Y_train_2_v_all = (Y_train == 2);
    Y_train_3_v_all = (Y_train == 3); 
    Y_train_4_v_all = (Y_train == 4);
    Y_train_5_v_all = (Y_train == 5);
    w1 = (X_train_bag' * X_train_bag + lambda*eye(size(X_train_bag, 2))) \ X_train_bag' * Y_train_1_v_all;
    w2 = (X_train_bag' * X_train_bag + lambda*eye(size(X_train_bag, 2))) \ X_train_bag' * Y_train_2_v_all;
    w3 = (X_train_bag' * X_train_bag + lambda*eye(size(X_train_bag, 2))) \ X_train_bag' * Y_train_3_v_all;
    w4 = (X_train_bag' * X_train_bag + lambda*eye(size(X_train_bag, 2))) \ X_train_bag' * Y_train_4_v_all;
    w5 = (X_train_bag' * X_train_bag + lambda*eye(size(X_train_bag, 2))) \ X_train_bag' * Y_train_5_v_all;
    save(fullfile('include','w1.mat'), 'w1');
    save(fullfile('include','w2.mat'), 'w2');
    save(fullfile('include','w3.mat'), 'w3');
    save(fullfile('include','w4.mat'), 'w4');
    save(fullfile('include','w5.mat'), 'w5');

    %% Train knn
    cost_struct = struct('ClassNames', 1:5, 'ClassificationCosts', costs);
    knn_model = fitcknn(X_train_svd,Y_train, ...
                      'Cost', cost_struct, ...
                      'NumNeighbors', 100, ...
                      'Distance', 'cityblock');
    save(fullfile('include','knn_model.mat'), 'knn_model');
end