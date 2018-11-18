load data/breast_cancer.mat
X = X_train;
%pca
x_mean = mean(X);
X_c = X - x_mean;
[U, S, V] = svd(X_c);
X_pca = X_c * V(:,1);
%OLS predict
y_train = double(Y_train);
y_hat = X_pca * (X_pca' * X_pca) * X_pca' * y_train;
disp(corr(y_train, y_hat))