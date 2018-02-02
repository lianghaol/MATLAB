function [labels] = kernel_regression(Xtrain,Ytrain,Xtest,sigma)

    % Function that implements kernel regression on the given data (binary classification)
    % Usage: labels = kernel_regression(Xtrain,Ytrain,Xtest)
    
    % Xtrain : N x P Matrix of training data, where N is the number of
    %   training examples, and P is the dimensionality (number of features)
    % Ytrain : N x 1 Vector of training labels (0/1)
    % Xtest : M x P Matrix of testing data, where M is the number of
    %   testing examples.
    % sigma : width of the (gaussian) kernel.
    % labels : return an M x 1 vector of predicted labels for testing data.
    

    
    % YOUR CODE GOES HERE
    labels = false([size(Xtest, 1), 1]);
    %labels = zeros(size(Xtest, 1), 1);
    for i = 1 : size(Xtest, 1)
        err = sqrt(sum(abs(Xtrain - Xtest(i, :)).^2, 2));
        kernel = exp(-err.^2 / sigma^2);
        % what you got wrong last time
        % you did not consider the decision boundary
        % that is, the weighted average decision is exactly half
        % you lost a lot of points! confidence too
        Yhat = sum(kernel.* double(Ytrain)) >= 0.5 * sum(kernel);
        labels(i) = Yhat;
    end
end