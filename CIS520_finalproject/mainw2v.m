%% Load the files
clear all;
load('data/w2v_X_train_bag.mat')
load('data/Y_train.mat')

%% Set variable names, for readability
joy = 1;
sadness = 2;
surprise = 3;
anger = 4;
fear = 5;

%% Cross-validation partitions
number_of_samples = length(Y_train);
K = 5;
part = make_xval_partition(number_of_samples, K);

performance_measures = zeros(K, 1);
L1_loss = zeros(K, 1);
accuracy = zeros(K, 1);
i = 1;
%% Cross-validation loop
while i <= K
    %% Get the partitions
    test_part = find(part == i);
    train_part = find(part ~= i);
    
    X_train_part = w2v_X_train_bag(train_part, :);
    X_test_part = w2v_X_train_bag(test_part, :);
    Y_train_part = Y_train(train_part);
    Y_test_part = Y_train(test_part);

    %% The function they will use
    % Y_hat = predict_labels(X_test_bag, test_raw);
    
    %% Put code to test here: 
     k = 500;
    
     [ids, kmeans_model] = kmeans(full(X_train_part), k);
     cluster_ys = zeros(k, 5);
     for i2 = 1:k  
        indices_k = find(ids == i2);
        y_vals = Y_train_part(indices_k);
        for j = 1:5
            cluster_ys(i2,j) = sum(y_vals == j)/length(y_vals);
        end
    end
    
    P = zeros(length(X_test_part), 5);
    for i2 = 1:length(X_test_part)
        distances = zeros(k, 1);
        for j = 1:k
            distances(j) = norm(X_test_part(i2,:) - kmeans_model(j,:));
        end
        [min_distance, min_index] = min(distances);
        P(i2,:) = cluster_ys(min_index,:);
    end
    
    %tree = fitctree(X_train_part, Y_train_part);
    %[~, P, ~, ~] = predict(tree, X_test_part);    
    
    
    %% Predict the Y_hat with the lease expected cost
    Y_hat = least_expected_cost(P);
    
    %% Calculate the performance
    performance_measures(i) = performance_measure(Y_test_part, Y_hat);
    L1_loss(i) = sum(Y_test_part - Y_hat ~= 0);
    accuracy(i) = 1 - (L1_loss(i) / size(Y_hat, 1));
    i = i + 1;
end
%% Average performance
mean_performance_measure = mean(performance_measures);
mean_L1_loss = mean(L1_loss);
mean_accuracy = mean(accuracy);

