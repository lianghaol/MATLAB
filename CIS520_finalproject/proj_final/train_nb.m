function train_nb(X_train_bag, Y_train, vocabulary)
    %% Cost matrix
    costs = [0 3 1 2 3;
             4 0 2 3 2;
             1 2 0 2 1;
             2 1 2 0 2;
             2 2 2 1 0];

    %% Train native bayes
    cost_struct = struct('ClassNames', 1:5, 'ClassificationCosts', costs);
    nb_model = fitcnb(X_train_bag, Y_train, ...
                        'Distribution','mn', ...
                        'Cost', cost_struct);
    save(fullfile('include','nb_model.mat'), 'nb_model');
end