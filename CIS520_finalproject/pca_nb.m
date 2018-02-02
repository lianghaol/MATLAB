function [P] = pca_nb(X_train_part, Y_train_part, X_test_part)   
    [coeff,score,latent] = pca(full(X_train_part));
    accuracy = cumsum(latent) / sum(latent);
    greater = find(accuracy >= 0.9);
    numpc = greater(1);
    top_scores_train = score(:, 1:numpc);
    top_scores_test = X_test_part * coeff(:, 1:numpc);
    
    P = nb(top_scores_train, Y_train_part, top_scores_test);
end