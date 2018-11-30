%% Load training files
clear;
load('data/train.mat')
load('data/vocabulary.mat')

%% Word count cutoff
X_train_bag_reduced = compress(X_train_bag);

%% Split data by class
joy_count = sum(Y_train == 1);
sadness_count = sum(Y_train == 2);
surprise_count = sum(Y_train == 3);
anger_count = sum(Y_train == 4);
fear_count = sum(Y_train == 5);

joy_id = find(Y_train == 1);
sadness_id = find(Y_train == 2);
surprise_id = find(Y_train == 3);
anger_id = find(Y_train == 4);
fear_id = find(Y_train == 5);

joy_X = X_train_bag_reduced(joy_id, :);
sadness_X = X_train_bag_reduced(sadness_id, :);
surprise_X = X_train_bag_reduced(surprise_id, :);
anger_X = X_train_bag_reduced(anger_id, :);
fear_X = X_train_bag_reduced(fear_id, :);

%% Class balancing
joy_diff = sadness_count - joy_count;
surprise_diff = sadness_count - surprise_count;
anger_diff = sadness_count - anger_count;
fear_diff = sadness_count - fear_count;

X_train_bag_balanced = [X_train_bag_reduced ; joy_X(1:joy_diff, :)];
Y_train_balanced = [Y_train; ones(joy_diff, 1)];

X_train_bag_balanced = [X_train_bag_balanced ; surprise_X(1:surprise_count, :)];
Y_train_balanced = [Y_train_balanced; ones(surprise_diff, 1)*3];
surprise_diff = surprise_diff - surprise_count;
X_train_bag_balanced = [X_train_bag_balanced ; surprise_X(1:surprise_count, :)];
surprise_diff = surprise_diff - surprise_count;
X_train_bag_balanced = [X_train_bag_balanced ; surprise_X(1:surprise_count, :)];
surprise_diff = surprise_diff - surprise_count;
X_train_bag_balanced = [X_train_bag_balanced ; surprise_X(1:surprise_diff, :)];

X_train_bag_balanced = [X_train_bag_balanced ; anger_X(1:anger_count, :)];
Y_train_balanced = [Y_train_balanced; ones(anger_diff, 1)*4];
anger_diff = anger_diff - anger_count;
X_train_bag_balanced = [X_train_bag_balanced ; anger_X(1:anger_count, :)];
anger_diff = anger_diff - anger_count;
X_train_bag_balanced = [X_train_bag_balanced ; anger_X(1:anger_diff, :)];

X_train_bag_balanced = [X_train_bag_balanced ; fear_X(1:fear_diff, :)];
Y_train_balanced = [Y_train_balanced; ones(fear_diff, 1)*5];

%% Split balanced data by class
joy_count = sum(Y_train_balanced == 1);
sadness_count = sum(Y_train_balanced == 2);
surprise_count = sum(Y_train_balanced == 3);
anger_count = sum(Y_train_balanced == 4);
fear_count = sum(Y_train_balanced == 5);

joy_id = find(Y_train_balanced == 1);
sadness_id = find(Y_train_balanced == 2);
surprise_id = find(Y_train_balanced == 3);
anger_id = find(Y_train_balanced == 4);
fear_id = find(Y_train_balanced == 5);

joy_X = X_train_bag_balanced(joy_id, :);
sadness_X = X_train_bag_balanced(sadness_id, :);
surprise_X = X_train_bag_balanced(surprise_id, :);
anger_X = X_train_bag_balanced(anger_id, :);
fear_X = X_train_bag_balanced(fear_id, :);

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
    
    X_train_part = X_train_bag_balanced(train_part, :);
    X_test_part = X_train_bag_balanced(test_part, :);
    Y_train_part = Y_train_balanced(train_part);
    Y_test_part = Y_train_balanced(test_part);

    %% The function they will use
    % Y_hat = predict_labels(X_test_bag, test_raw);
    
    %% Put code to test here: 
        k = 1000;
    
      [ids, kmeans_model] = kmeans(full(X_train_part), k);
     cluster_ys = zeros(k, 5);
     for i2 = 1:k  
        indices_k = find(ids == i2);
        y_vals = Y_train_part(indices_k);
        for j = 1:5
            cluster_ys(i2,j) = sum(y_vals == j)/length(y_vals);
        end
    end
    
     P1 = zeros(length(X_test_part), 5);
    for i2 = 1:length(X_test_part)
        distances = zeros(k, 1);
        for j = 1:k
            distances(j) = norm(X_test_part(i2,:) - kmeans_model(j,:));
        end
        [min_distance, min_index] = min(distances);
        P1(i2,:) = cluster_ys(min_index,:);
     end
    
    tree = fitctree(X_train_part, Y_train_part);
    [~, P2, ~, ~] = predict(tree, X_test_part);    
    
    P = zeros(length(X_test_part),5);
    for i2 = 1:length(X_test_part)
        if sum(X_test_part(i,:)) == 0
            for j = 1:5
                P(i2,j) = sum(Y_train_part == j)/length(j);
            end
        else
            P(i2,:) = (P1(i2,:) + P2(i2,:))/2;
        end
    end
        
    %% Predict the Y_hat with the lease expected cost
    Y_hat = least_expected_cost(P);
    
    %% Calculate the performance
    performance_measures(i) = performance_measure(Y_test_part, Y_hat);
    L1_loss(i) = sum(Y_test_part - Y_hat ~= 0);
    accuracy(i) = 1 - (L1_loss(i) / size(Y_hat, 1));
    i = i + 1;
end
%% Average performance
mean_performance_measure = mean(performance_measures)
mean_L1_loss = mean(L1_loss)
mean_accuracy = mean(accuracy)

