% Submit your textual answers, and attach these plots in a latex file for
% this homework. 
% This script is merely for your convenience, to generate the plots for each
% experiment. Feel free to change it, as you do not need to submit this
% with your code.

% Loading the data: this loads X, and Ytrain.
load('../data/X_noisy.mat'); % change this to X_noisy if you want to run the code on the noisy data
load('../data/Y.mat');

depth = [1 2 4 6 8];

errors_train = zeros(100,size(depth,2));

errors_test = zeros(100,size(depth,2)); 

for trial = 1:50
    
    % fill in the rest of your code here.
    partTrainTest = [ones(1, 450) zeros(1, 150)];
    partTrainTest = logical(partTrainTest(randperm(600)));
    Xtrain = X_noisy(partTrainTest, :);
    Ytrain = Y(partTrainTest);
    Xtest = X_noisy(~partTrainTest, :);
    Ytest = Y(~partTrainTest);
    for DIdx = 1 : 5
        root = dt_train(Xtrain, Ytrain, depth(DIdx));
        Yhat = zeros(size(Ytrain));
        Ypred = zeros(size(Ytest));
        for i = 1 : size(Ytrain, 1)
            Yhat(i) = dt_value(root, Xtrain(i, :));
        end
        for i = 1 : size(Ytest, 1)
            Ypred(i) = dt_value(root, Xtest(i, :));
        end
        errors_train(trial, DIdx) = sum(xor(Yhat, Ytrain));
        errors_test(trial, DIdx) = sum(xor(Ypred, Ytest));
    end
end

% code to plot the error bars. change these values depending on what
% experiment you are running
y = mean(errors_train); e = std(errors_train); x = [1 2 4 6 8]; % <- computes mean across all trials
errorbar(x, y, e);
hold on;
y = mean(errors_test); e = std(errors_test); x = [1 2 4 6 8]; % <- computes mean across all trials
errorbar(x, y, e);
title('Original data, D = [1 2 4 6 8]');
xlabel('D');
ylabel('Error');
legend('Training Error','Test Error');
hold off;