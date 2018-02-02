% Submit your textual answers, and attach these plots in a latex file for
% this homework. 
% This script is merely for your convenience, to generate the plots for each
% experiment. Feel free to change it, as you do not need to submit this
% with your code.

% Loading the data: this loads X, and Ytrain.
load('../data/X.mat'); % change this to X_noisy if you want to run the code on the noisy data
load('../data/Y.mat');

%N = [2 4 8 16];
K = [1,2,3,5,8,13,21,34];
%errors_xval = zeros(100,size(N,2));
errors_xval = zeros(100,size(K,2));
%errors_test = zeros(100,size(N,2)); 
errors_test = zeros(100,size(K,2));
for trial = 1:100
    
    % fill in the rest of your code here.
    partTrainTest = [ones(1, 450) zeros(1, 150)];
    partTrainTest = logical(partTrainTest(randperm(600)));
    Xtrain = X(partTrainTest, :);
    Ytrain = Y(partTrainTest);
    Xtest = X(~partTrainTest, :);
    Ytest = Y(~partTrainTest);
    %for NIdx = 1 : 4
    for KIdx = 1 : 8
        %part = make_xval_partition(450, N(NIdx));
        part = make_xval_partition(450, 10);
        %errors_xval(trial, NIdx) = knn_xval_error(Xtrain,Ytrain,1,part,'l2');
        errors_xval(trial, KIdx) = kernreg_xval_error(Xtrain,Ytrain,K(KIdx),part,'l2');
        Yhat = kernel_regression(Xtrain,Ytrain,Xtest,K(KIdx),'l2');
        errors_test(trial, KIdx) = sum(xor(Yhat, Ytest)) / size(Ytest, 1);
    end
    %Yhat = k_nearest_neighbours(Xtrain,Ytrain,Xtest,1,'l2');
    %errors_test(trial, :) = sum(xor(Yhat, Ytest)) / size(Ytest, 1);
end

% code to plot the error bars. change these values depending on what
% experiment you are running
y = mean(errors_xval); e = std(errors_xval); x = [1,2,3,5,8,13,21,34]; % <- computes mean across all trials
errorbar(x, y, e);
hold on;
y = mean(errors_test); e = std(errors_test); x = [1,2,3,5,8,13,21,34]; % <- computes mean across all trials
errorbar(x, y, e);
title('Original data, K = [1,2,3,5,8,13,21,34]');
xlabel('K');
ylabel('Error');
legend('10-Fold Error','Test Error');
hold off;