load('../data/X_noisy.mat'); % change this to X_noisy if you want to run the code on the noisy data
load('../data/Y.mat');
errors_train = zeros(100, 1);
errors_test = zeros(100, 1);
for trial = 1:100
    
    % fill in the rest of your code here.
    partTrainTest = [ones(1, 450) zeros(1, 150)];
    partTrainTest = logical(partTrainTest(randperm(600)));
    Xtrain = X_noisy(partTrainTest, :);
    Ytrain = Y(partTrainTest);
    Xtest = X_noisy(~partTrainTest, :);
    Ytest = Y(~partTrainTest);
    root = dt_train(Xtrain, Ytrain, 8);
    Yhat = zeros(size(Ytrain));
    Ypred = zeros(size(Ytest));
    for i = 1 : size(Ytrain, 1)
        Yhat(i) = dt_value(root, Xtrain(i, :));
    end
    for i = 1 : size(Ytest, 1)
        Ypred(i) = dt_value(root, Xtest(i, :));
    end
    errors_train(trial) = sum(xor(Yhat, Ytrain)) / size(Ytrain, 1);
    errors_test(trial) = sum(xor(Ypred, Ytest)) / size(Ytest, 1);
    
end
disp(mean(errors_train))
disp(mean(errors_test))