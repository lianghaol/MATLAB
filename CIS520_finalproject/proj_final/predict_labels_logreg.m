function [Y_hat] = predict_labels_logreg(X_test_bag, test_raw)

% Inputs:   X_test_bag     nx9995 bag of words features
%           test_raw      nx1 cells containing all the raw tweets in text


% Outputs:  Y_hat           nx1 predicted labels (1 for joy, 2 for sadness, 3 for surprise, 4 for anger, 5 for fear)
         
    %Load models
    load(fullfile('include','logreg_model.mat'), 'logreg_model');
       
    % Feature stemming
    X_test_bag_stems = compress(X_test_bag);
    X_test_bag = X_test_bag_stems;
    
    % Logistic regression
    [Y_hat, ~, P_lr] = predict(zeros(size(X_test_bag, 1), 1), X_test_bag, logreg_model, '-b 1');
    P = zeros(size(X_test_bag, 1), 5);
    P(:, 1) = P_lr(:, logreg_model.Label(1));
    P(:, 2) = P_lr(:, logreg_model.Label(2));
    P(:, 3) = P_lr(:, logreg_model.Label(3));
    P(:, 4) = P_lr(:, logreg_model.Label(4));
    P(:, 5) = P_lr(:, logreg_model.Label(5));
    P_lr = P;
    
    % Least expected cost
    Y_hat = least_expected_cost(P_lr);
end