function [error] = kernreg_xval_error(X, Y, sigma, part, distFunc)
    % KERNREG_XVAL_ERROR - Kernel regression cross-validation error.
    %
    % Usage:
    %
    %   ERROR = kernreg_xval_error(X, Y, SIGMA, PART, DISTFUNC)
    %
    % Returns the average N-fold cross validation error of the kernel regression
    % algorithm on the given dataset when the dataset is partitioned according to PART 
    % (see MAKE_XVAL_PARTITION). DISTFUNC is the distance functioned 
    % to be used.
    %
    % Note that N = max(PART).
    %
    % SEE ALSO
    %   MAKE_XVAL_PARTITION, KERNEL_REGRESSION

    % FILL IN YOUR CODE HERE
    numFold = max(part);
    error = 0;
    for s = 1 : numFold
        Xtrain = X(part ~= s, :);
        Xtest = X(part == s, :);
        Ytrain = Y(part ~= s);
        Ytest = Y(part == s);
        Yhat = kernel_regression(Xtrain, Ytrain, Xtest, sigma, distFunc);
        error = error + sum(Ytest ~= Yhat);
    end
    error = error / size(X, 1);
end
