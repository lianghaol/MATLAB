function labels = k_nearest_neighbours(Xtrain,Ytrain,Xtest,K,distfunc)

    % Function to implement the K nearest neighbours algorithm on the given
    % dataset.
    % Usage: labels = k_nearest_neighbours(Xtrain,Ytrain,Xtest,K)
    
    % Xtrain : N x P Matrix of training data, where N is the number of
    %   training examples, and P is the dimensionality (number of features)
    % Ytrain : N x 1 Vector of training labels (0/1)
    % Xtest : M x P Matrix of testing data, where M is the number of
    %   testing examples.
    % K : number of nearest neighbours used to make predictions on the test
    %     dataset. Remember to take care of corner cases.
    % distfunc: distance function to be used - l1, l2, linf.
    % labels : return an M x 1 vector of predicted labels for testing data.
    
    % YOUR CODE GOES HERE.
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
        [~, sortedIdx] = sort(err);
        Yhat = mode(Ytrain(sortedIdx(1:K)));
        labels(i) = Yhat;
    end 
end