load data/MNIST_train.mat
load data/MNIST_test.mat
[loading, score_train, ~] = pca(X_train);
dim_num = [100 150 200];
for dim = dim_num
    X_train_p = score_train(:, 1:dim);
    % Since pca centers X_train then find the loadings of centered X_train,
    % we need to center X_test as well
    X_test_p = (X_test - mean(X_test)) * loading(:, 1:dim);
    precision = k_means(X_train_p, Y_train, X_test_p, Y_test, 25 );
    fprintf('The precision with %d dimensions:', dim)
    disp(precision)
end
