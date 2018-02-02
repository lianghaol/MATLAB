% Submit your textual answers, and attach these plots in a latex file for
% this homework. 
% This script is merely for your convenience, to generate the plots for each
% experiment. Feel free to change it, as you do not need to submit this
% with your code.

%% Load training files and path
clear;
restoredefaultpath
addpath(fullfile('.', 'liblinear','matlab'));
load(fullfile('data','validation.mat'));
load(fullfile('data','train.mat'));
load(fullfile('data','vocabulary.mat'))

%%
X = X_train_bag;
Y = Y_train;

N_folds = 5;
trial_count = 3;
errors_xval = zeros(N_folds, trial_count); 
N = size(X,1);
K = 1;
%%
for trial = 1:trial_count
    part = make_xval_partition(size(X, 1), N_folds);
    for i = 1:N_folds
        test_ind = find(part == i);
        train_ind = find(part ~= i);
        xtrain = X(train_ind, :);
        xtest = X(test_ind, :);
        ytrain = Y(train_ind, :);
        ytest = Y(test_ind, :);

        train_models(xtrain, ytrain, vocabulary);
        Y_hat = predict_labels(xtest, validation_raw);
        error = performance_measure(ytest, Y_hat);
        errors_xval(i, trial) = error;
    end
end

%%
% code to plot the error bars. change these values depending on what
% experiment you are running
trial_means = mean(errors_xval) 
trial_stds = std(errors_xval)

total_mean = mean(trial_means)
total_std = mean(trial_stds)
