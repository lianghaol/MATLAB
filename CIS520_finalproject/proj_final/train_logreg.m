function train_logreg(X_train_bag, Y_train, vocabulary)
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
    Y_train_stems = Y_train;
    X_train_bag = X_train_bag_stems;

    %% Train Logistic regression
    %best = train(Y_train, X_train_bag, '-C -s 0');
    %Best C found was 0.25 with 0.5325 accuracy
    best(1) = 0.25;
    logreg_model = train(Y_train, X_train_bag, sprintf('-c %f -s 0', best(1)));
    save(fullfile('include', 'logreg_model.mat'), 'logreg_model');
end