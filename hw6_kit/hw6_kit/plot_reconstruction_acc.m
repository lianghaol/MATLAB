load data/MNIST_train.mat
X = X_train;
loading = pca(X);
acc = zeros(size(X, 2),1);
% mean center the X first
X_m = mean(X);
X = X - X_m;
% compute reconstruction error for each component setting

for i = 1 : size(X, 2) - 1
    p_component = loading(:,1:i);
    Z = X * p_component;
    X_hat = Z * p_component';
    acc(i) = sum(sum((X_hat).^2)) / sum(sum((X).^2));
end
disp(sum(acc < 0.85))