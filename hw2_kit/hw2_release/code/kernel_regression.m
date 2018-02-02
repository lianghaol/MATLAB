function labels = kernel_regression(Xtrain,Ytrain,Xtest,sigma,distfunc)

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
    for i = 1 : size(Xtest, 1)
         if distfunc == 'l1'
            err = sum(abs(Xtrain - Xtest(i, :)), 2);
         elseif distfunc == 'l2'
            err = sum(abs(Xtrain - Xtest(i, :)).^2, 2).^(1/2);
         elseif distfunc == 'linf'
            err = max(abs(Xtrain - Xtest(i, :)), 2);
         else
            error('distfunc is not recongnized')
         end
         kernel = exp(-err.^2 / sigma^2);
         Yhat = sum(kernel.* double(Ytrain)) >= 0.5;
         labels(i) = Yhat;
    end
end