load('data/train.mat')

addpath('./DL_toolbox/util','./DL_toolbox/NN','./DL_toolbox/DBN');
 
for i = 1:length(X_train_bag)
    for j = 1:length(X_train_bag(1,:))
        X_train_bag(i,j) = X_train_bag(i,j)/10;
    end
end

% your code to train an Auto-encoder, then learn new features from the original data set
% use rbm.m and newFeature_rbm.m
dbn = rbm(X_train_bag);
X_train = X_train_bag(1:10000,:);
X_test = X_train_bag(10000:15000,:);
[new_feat, new_feat_test] = newFeature_rbm(dbn, X_train, X_test);
