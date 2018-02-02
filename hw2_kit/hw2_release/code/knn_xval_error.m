function [error] = knn_xval_error(X, Y, K, part, distFunc)
    % KNN_XVAL_ERROR - KNN cross-validation error.
    %
    % Usage:
    %
    %   ERROR = knn_xval_error(X, Y, K, PART, DISTFUNC)
    %
    % Returns the average N-fold cross validation error of the K-NN algorithm on the 
    % given dataset when the dataset is partitioned according to PART 
    % (see MAKE_XVAL_PARTITION). DISTFUNC is the distance functioned 
    % to be used.
    %
    % Note that N = max(PART), corresponding to the number of folds.
    %
    % SEE ALSO
    %   MAKE_XVAL_PARTITION, K_NEAREST_NEIGHBOURS

    % FILL IN YOUR CODE HERE
    error = 0;
    for s = 1 : max(part)
        Xtrain = X(part ~= s, :);
        Xtest = X(part == s, :);
        Ytrain = Y(part ~= s);
        Ytest = Y(part == s);
        Yhat = k_nearest_neighbours(Xtrain, Ytrain, Xtest, K, distFunc);
        error = error + sum(Ytest ~= Yhat);
    end
    error = error / size(X, 1);
end