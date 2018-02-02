function train_knn(X_train_bag, Y_train, vocabulary)
    %% Cost matrix
    costs = [0 3 1 2 3;
             4 0 2 3 2;
             1 2 0 2 1;
             2 1 2 0 2;
             2 2 2 1 0];
         
    %% Feature stemming
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

    %% SVD
    [~, ~, V] = svds(X_train_bag_stems, 200);
    save(fullfile('include','V.mat'), 'V');
    X_train_svd = X_train_bag_stems*V;

    %% Train KNN
    cost_struct = struct('ClassNames', 1:5, 'ClassificationCosts', costs);
    knn_model = fitcknn(X_train_svd,Y_train, ...
                      'Cost', cost_struct, ...
                      'NumNeighbors', 100, ...
                      'Distance', 'cityblock');
    save(fullfile('include','knn_model.mat'), 'knn_model');
end