%% Perform test of KNN
clear;
load(fullfile('data','validation.mat'));
load(fullfile('data','train.mat'));
load(fullfile('data','vocabulary.mat'))

%%
train_knn(X_train_bag, Y_train, vocabulary);

%%
Y_hat_train = predict_labels_knn(X_train_bag, validation_raw);
performance_measure(Y_train, Y_hat_train)

%%
Y_hat = predict_labels_knn(X_validation_bag, validation_raw);
