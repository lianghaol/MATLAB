load data/MNIST_train.mat
X = X_train;
loading = pca(X);
loading = loading(:,1:2);
X_p = (X - mean(X)) * loading;
digit_0 = X_p(Y_train == 1,:);
digit_1 = X_p(Y_train == 2,:);
plot(digit_0(:,1), digit_0(:,2), '+')
hold on
plot(digit_1(:,1), digit_1(:,2), 'o')
hold off
title('Plot of "0"-"1" digits from top 2 PCA dimensions')
xlabel('PC1')
ylabel('PC2')