load data/breast_cancer.mat
X = X_train;
Y = double(Y_train);
Z = ((X'*X)^(-0.5))*X'*Y*((Y'*Y)*(-0.5));
[U, S, V] = svd(Z);
U = U(:,1);
V = V(:,1);
disp(corr(Y*V', X*U))