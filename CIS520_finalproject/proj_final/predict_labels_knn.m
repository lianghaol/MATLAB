function [Y_hat] = predict_labels_knn(X_test_bag, test_raw)

% Inputs:   X_test_bag     nx9995 bag of words features
%           test_raw      nx1 cells containing all the raw tweets in text


% Outputs:  Y_hat           nx1 predicted labels (1 for joy, 2 for sadness, 3 for surprise, 4 for anger, 5 for fear)
         
    %Load models
    load(fullfile('include','knn_model.mat'), 'knn_model');
    load(fullfile('include','V.mat'), 'V');
       
    % Feature stemming
    X_test_bag_stems = compress(X_test_bag);
    X_test_bag = X_test_bag_stems;
    
    % SVD
    X_test_svd = X_test_bag_stems*V;

    % KNN
    [Y_hat,P_knn,~] = knn_model.predict(X_test_svd);
end