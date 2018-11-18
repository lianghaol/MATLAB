 
function [P] = knn(X_train_part, Y_train_part, X_test_part)   
    Mdl = fitcknn(X_train_part,Y_train_part, 'NumNeighbors',20);
    [~, P, ~] = Mdl.predict(X_test_part);
end