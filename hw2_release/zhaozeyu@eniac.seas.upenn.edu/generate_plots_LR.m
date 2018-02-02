% Submit your textual answers, and attach these plots in a latex file for
% this homework. 
% This script is merely for your convenience, to generate the plots for each
% experiment. Feel free to change it, as you do not need to submit this
% with your code.

% Loading the data: this loads X, and Ytrain.
load('../data/X_noisy.mat'); % change this to X_noisy if you want to run the code on the noisy data
load('../data/Y.mat');

N = [2 4 8 16];

errors_xval = zeros(100,size(N,2));

errors_test = zeros(100,size(N,2)); 

for trial = 1:100
    
    % fill in the rest of your code here.
    partTrainTest = [ones(1, 450) zeros(1, 150)];
    partTrainTest = logical(partTrainTest(randperm(600)));
    Xtrain = X_noisy(partTrainTest, :);
    Ytrain = Y(partTrainTest);
    Xtest = X_noisy(~partTrainTest, :);
    Ytest = Y(~partTrainTest);
    for NIdx = 1 : 4
        part = make_xval_partition(450, N(NIdx));
        errors_xval(trial, NIdx) = logistic_xval_error(Xtrain, Ytrain, part);
       
    end
    Yhat = logistic_regression(Xtrain,Ytrain,Xtest,0.000093,100);
    errors_test(trial, :) = sum(xor(Yhat, Ytest)) / size(Ytest, 1);
end

% code to plot the error bars. change these values depending on what
% experiment you are running
y = mean(errors_xval); e = std(errors_xval); x = [2 4 8 16]; % <- computes mean across all trials
errorbar(x, y, e);
hold on;
y = mean(errors_test); e = std(errors_test); x = [2 4 8 16]; % <- computes mean across all trials
errorbar(x, y, e);
title('Noisy data, N = [2 4 8 16]');
xlabel('K');
ylabel('Error');
legend('N-Fold Error','Test Error');
hold off;