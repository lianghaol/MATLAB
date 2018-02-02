function [error] = logistic_xval_error(X, Y, part)
    % LOGISTIC_XVAL_ERROR - Logistic regression cross-validation error.
    %
    % Usage:
    %
    %   ERROR = logistic_xval_error(X, Y, PART)
    %
    % Returns the average N-fold cross validation error of the logistic regression
    % algorithm on the given dataset when the dataset is partitioned according to PART 
    % (see MAKE_XVAL_PARTITION).
    %
    % Note that N = max(PART).
    %
    % SEE ALSO
    %   MAKE_XVAL_PARTITION, LOGISTIC_REGRESSION
    
    % FILL IN YOUR CODE HERE
    error = 0;
    for i = 1 : max(part)
        Xtrain = X(part~= i,:);
        Ytrain = Y(part~= i);
        Xtest = X(part== i,:);
        Ytest = Y(part== i);
        Yhat = logistic_regression(Xtrain, Ytrain, Xtest, 0.000093, 100);
        error = error + sum(xor(Ytest, Yhat));
    end
    error = error / size(X, 1);
end
