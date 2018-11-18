function [nb_model] = nb_train(X_train_part, Y_train_part)
    % Add a bias feature of 1's for each category. 
    X_train_part_b = [X_train_part; ones(5, size(X_train_part,2))];
    Y_train_part_b = [Y_train_part; 1;2;3;4;5];
    
    X_train_part_b_joy = X_train_part_b(Y_train_part_b == 1, :);
    X_train_part_b_sadness = X_train_part_b(Y_train_part_b == 2, :);
    X_train_part_b_surprise = X_train_part_b(Y_train_part_b == 3, :);
    X_train_part_b_anger = X_train_part_b(Y_train_part_b == 4, :);
    X_train_part_b_fear = X_train_part_b(Y_train_part_b == 5, :);
    
    P_word_given_joy = sum(X_train_part_b_joy) ./ size(X_train_part_b_joy,1);
    P_word_given_sadness = sum(X_train_part_b_sadness) ./ size(X_train_part_b_sadness,1);
    P_word_given_surprise = sum(X_train_part_b_surprise) ./ size(X_train_part_b_surprise,1);
    P_word_given_anger = sum(X_train_part_b_anger) ./ size(X_train_part_b_anger,1);
    P_word_given_fear = sum(X_train_part_b_fear) ./ size(X_train_part_b_fear,1);
    
    nb_model = [P_word_given_joy ; 
                P_word_given_sadness ;
                P_word_given_surprise ;
                P_word_given_anger ;
                P_word_given_fear ];
end