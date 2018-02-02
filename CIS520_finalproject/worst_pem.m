function [P] = worst_pem(X_train_part, Y_train_part, X_test_part)   

%% The very best probability estimate model I could think of
joy_count = sum(Y_train_part == 1);
sadness_count = sum(Y_train_part == 2);
surprise_count = sum(Y_train_part == 3);
anger_count = sum(Y_train_part == 4);
fear_count = sum(Y_train_part == 5);

P_joy = joy_count / size(Y_train_part,1);
P_sadness = sadness_count / size(Y_train_part,1);
P_surprise = surprise_count / size(Y_train_part,1);
P_anger = anger_count / size(Y_train_part,1);
P_fear = fear_count / size(Y_train_part,1);

P = [P_joy, P_sadness, P_surprise, P_anger, P_fear];
P = repmat(P, size(X_test_part,1), 1);
