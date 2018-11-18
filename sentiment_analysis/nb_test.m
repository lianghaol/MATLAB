function [P] = nb_test(nb_model, X_test_part)
    P_word_given_joy = nb_model(1, :);
    P_word_given_sadness = nb_model(2, :);
    P_word_given_surprise = nb_model(3, :);
    P_word_given_anger = nb_model(4, :);
    P_word_given_fear = nb_model(5, :);

    P = zeros(size(X_test_part,1), 5);
    parfor (j = 1:size(X_test_part,1))
        P_joy = prod(nonzeros((X_test_part(j, :) ~= 0) .* P_word_given_joy.^X_test_part(j, :)));
        P_sadness = prod(nonzeros((X_test_part(j, :) ~= 0) .* P_word_given_sadness.^X_test_part(j, :)));
        P_surprise = prod(nonzeros((X_test_part(j, :) ~= 0) .* P_word_given_surprise.^X_test_part(j, :)));
        P_anger = prod(nonzeros((X_test_part(j, :) ~= 0) .* P_word_given_anger.^X_test_part(j, :)));
        P_fear = prod(nonzeros((X_test_part(j, :) ~= 0) .* P_word_given_fear.^X_test_part(j, :)));
        P(j, :) = [P_joy, P_sadness, P_surprise, P_anger, P_fear];
        P(j, :) = P(j, :) ./ sum(P(j, :));
    end
end