
new_X_train_bag = zeros(18092, 530);

[i,j,s] = find(X_train_bag);

for k = 1:length(i)
    new_vec_j = w2v(j(k)) + 1;
    new_X_train_bag(i(k), new_vec_j) = new_X_train_bag(i(k), new_vec_j) + s(k);
end
