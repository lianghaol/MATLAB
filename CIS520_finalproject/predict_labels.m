function [Y_hat] = predict_labels(X_test_bag, test_raw)
% Inputs:   X_test_bag     nx9995 bag of words features
%           test_raw      nx1 cells containing all the raw tweets in text


% Outputs:  Y_hat           nx1 predicted labels (1 for joy, 2 for sadness, 3 for surprise, 4 for anger, 5 for fear)
         
    %Load models
    load(fullfile('include','logreg_model.mat'), 'logreg_model');
    load(fullfile('include','svm_model.mat'), 'svm_model');
    load(fullfile('include','nb_model.mat'), 'nb_model');
    load(fullfile('include','w1.mat'), 'w1');
    load(fullfile('include','w2.mat'), 'w2');
    load(fullfile('include','w3.mat'), 'w3');
    load(fullfile('include','w4.mat'), 'w4');
    load(fullfile('include','w5.mat'), 'w5');
    load(fullfile('include', 'V.mat'), 'V');
    load(fullfile('include','knn_model.mat'), 'knn_model');
    
    X_test_bag_original = X_test_bag;
    number_of_samples = size(X_test_bag_original, 1);
    
    % Stem
    X_test_bag_stems = compress(X_test_bag);
    X_test_bag = X_test_bag_stems;
    
    % SVD
    X_test_svd = X_test_bag_stems*V;

    % Logistic regression
    [Y_hat_lr_max, ~, P_lr] = predict(zeros(size(X_test_bag, 1), 1), X_test_bag, logreg_model, '-b 1');
    P = zeros(size(X_test_bag, 1), 5);
    P(:, 1) = P_lr(:, logreg_model.Label(1));
    P(:, 2) = P_lr(:, logreg_model.Label(2));
    P(:, 3) = P_lr(:, logreg_model.Label(3));
    P(:, 4) = P_lr(:, logreg_model.Label(4));
    P(:, 5) = P_lr(:, logreg_model.Label(5));
    P_lr = P;
    Y_hat_lr = least_expected_cost(P_lr);

    % NB
    [Y_hat_nb,P_nb,~] = nb_model.predict(X_test_bag_original);

    % SVM regression
    [Y_hat_svm, ~, ~] = predict(zeros(size(X_test_bag, 1), 1), X_test_bag, svm_model);
    P_svm = ind2vec(Y_hat_svm')';
    
    % Ridge regression
    P1 = ones(number_of_samples, 1) ./ (ones(number_of_samples, 1) + exp(-X_test_bag*w1));
    P2 = ones(number_of_samples, 1) ./ (ones(number_of_samples, 1) + exp(-X_test_bag*w2));
    P3 = ones(number_of_samples, 1) ./ (ones(number_of_samples, 1) + exp(-X_test_bag*w3));
    P4 = ones(number_of_samples, 1) ./ (ones(number_of_samples, 1) + exp(-X_test_bag*w4));
    P5 = ones(number_of_samples, 1) ./ (ones(number_of_samples, 1) + exp(-X_test_bag*w5));
    P = [P1, P2, P3, P4, P5];
    [~, Y_hat_ridge] = max(P,[], 2);
    P_ridge = ind2vec(Y_hat_ridge')';
    
    % KNN
    [Y_hat_knn,P_knn,~] = knn_model.predict(X_test_svd);
       
    %Ensemble
    w = [0.4, 0.35, 0.1, 0.1, 0.05];
    assert(int8(sum(w)) == 1);
    P_ensemble = w(1) * P_nb + w(2) * P_lr + w(3) * P_svm + w(4) * P_ridge + w(5) * P_knn;
    Y_hat = least_expected_cost(P_ensemble);    
end