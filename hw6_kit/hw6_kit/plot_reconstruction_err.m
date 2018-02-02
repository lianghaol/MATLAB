load data/MNIST_train.mat
X = X_train;
loading = pca(X);
err = zeros(size(X, 2),1);
% mean center the X first
X_m = mean(X);
X = X - X_m;
% compute reconstruction error for each component setting

for i = 1 : size(X, 2) - 1
    p_component = loading(:,1:i);
    Z = X * p_component;
    X_hat = Z * p_component';
    err(i) = sum(sum((X - X_hat).^2)) / size(X, 1);
end
x = 1:size(X, 2);
plot(x, err)
title('Reconstruction error over number of principle components')
xlabel('Number of principle components')
ylabel('Reconstruction Error')