%% Load the files
clear;
restoredefaultpath
load(fullfile('data','train.mat'))
load(fullfile('data','vocabulary.mat'))

addpath(fullfile('.','liblinear'));
% addpath(fullfile('.','lightspeed_fastfit/lightspeed'));
% addpath(fullfile('.','demo_implementations'));

%% Set variable names, for readability
% joy = 1;
% sadness = 2;
% surprise = 3;
% anger = 4;
% fear = 5;

% %% Vocabulary stemming
% X_train_bag_stems = compress(X_train_bag);
% load(fullfile('include','stemmed_vocabulary.mat'), 'stemmed_vocabulary')
% 
% %% Feature selection via word count cutoff
% word_count_cutoff = 2;
% selected_features = find(sum(X_train_bag_stems) > word_count_cutoff);
% save('include\selected_features.mat', 'selected_features');
% X_train_bag_reduced = X_train_bag_stems(:, selected_features);
% reduced_vocabulary = stemmed_vocabulary(:, selected_features);

X_train_bag_reduced = X_train_bag;
% %% Vocabulary stemming
% X_train_bag_stems = compress(X_train_bag);
% load(fullfile('include','stemmed_vocabulary.mat'))
% 
% %% Feature selection via word count cutoff
% word_count_cutoff = 2;
% selected_features = find(sum(X_train_bag_stems) > word_count_cutoff);
% save('include\selected_features.mat', 'selected_features');
% X_train_bag_reduced = X_train_bag_stems(:, selected_features);
% reduced_vocabulary = stemmed_vocabulary(:, selected_features);
% 
% % Emoji boost
% for i = 1:length(reduced_vocabulary)
%     word = reduced_vocabulary(i);
%     if contains(word, ':') || contains(word, '<')
%         X_train_bag_reduced(:, i) = X_train_bag_reduced(:, i)*10;
%     end
% end
%% SVD
% [~, ~, V] = svds(X_train_bag_reduced, 3000);
%[~, ~, V] = rsvd(X_train_bag_reduced, 1000);
%X_train_bag_reduced = X_train_bag_reduced*V;

%% New features
number_of_samples = length(Y_train);
number_of_features = size(X_train_bag_reduced, 2);

% % Word count
% word_count = zeros(number_of_samples, 1);
% for i = 1:length(train_raw)
%     sentence = train_raw(i);
%     word_count(i) = numel(strsplit(char(sentence)));
% end
% X_train_bag_reduced = [X_train_bag_reduced, word_count];
%  
% % Total Length 
% % X_train_bag_reduced = [X_train_bag_reduced, strlength(train_raw)];
% % 
% % Bias 
% % X_train_bag_reduced = [X_train_bag_reduced, ones(number_of_samples, 1)];
% 
% % Emoji boost
% for i = 1:length(reduced_vocabulary)
%     word = reduced_vocabulary(i);
%     if contains(word, ':')
%         X_train_bag_reduced(:, i) = X_train_bag_reduced(:, i)*10;
%     end
% end

%% Std data
% X_train_bag_std = X_train_bag_reduced - mean(X_train_bag_reduced) / std(X_train_bag_reduced);

%% Cross-validation partitions
K = 2;
part = make_xval_partition(number_of_samples, K);

performance_measures = zeros(K, 1);
L1_loss = zeros(K, 1);
accuracy = zeros(K, 1);
models = [];
x_val_i = 1;

%% Cross-validation loop
while x_val_i <= K
    %% Get the partitions
    test_part = find(part == x_val_i);
    train_part = find(part ~= x_val_i);
    
    X_train_part = X_train_bag_reduced(train_part, :);
    X_test_part = X_train_bag_reduced(test_part, :);
    Y_train_part = Y_train(train_part);
    Y_test_part = Y_train(test_part);
    
%     dbn = rbm(X_train_part);
%     [X_train_part, X_test_part] = newFeature_rbm(dbn, X_train_part, X_test_part);

    %% Put code to test here: 
%      nb_model = nb_train(X_train_part, Y_train_part);
%      P1 = nb_test(nb_model, X_test_part);
%      
%      net_Y = ind2vec(Y_train_part');
%      net_X = X_train_part';
%      net = patternnet(10);
%      net = train(net,net_X,net_Y);
%      P2 = net(X_test_part')';
%     tree = fitctree(full(X_train_part), Y_train_part);
%     [~, P2, ~, ~] = predict(tree, full(X_test_part));

%     ens = fitcensemble(full(X_train_part),Y_train,'Method','AdaBoostM2','NumLearningCycles',50,'Learners','Tree');
%     ens = fitcensemble(full(X_train_part),Y_train,'Method','RUSBoost','NumLearningCycles',50,'Learners','Tree');
%     [~,scores] = ens.predict(full(X_test_part));
%     P4 = scores ./ sum(scores, 2);
    
%     B = mnrfit(full(X_train_part),Y_train);
%     [~,scores] = B.predict(full(X_test_part));

    model = train(Y_train_part, sparse(X_train_part), '-q -s 0');
    [Y_hat_svm, ~, prob_est] = predict(Y_test_part, X_test_part, model, '-b 1');

%     P3 = zeros(size(Y_test_part, 1), 5);
%     P3(:, 1) = prob_est(:, model.Label(1));
%     P3(:, 2) = prob_est(:, model.Label(2));
%     P3(:, 3) = prob_est(:, model.Label(3));
%     P3(:, 4) = prob_est(:, model.Label(4));
%     P3(:, 5) = prob_est(:, model.Label(5));
 
    %[w, args, log_posterior, wasted, saved] = smlr(X_train_part, Y_train_part);

    %% Compute the emsemble 
    %P = 0.8*P3 + 0.2*P1;
    
    %% Predict the Y_hat with the lease expected cost
    %Y_hat1 = least_expected_cost(P1);
    %Y_hat3 = least_expected_cost(P3);
    
    
    %% Y_hat
%     Y_hat_optimal = zeros(size(Y_test_part, 1), 1);
%     for i = 1:size(Y_test_part, 1)
%         if Y_hat1(i) == Y_test_part(i)
%             Y_hat_optimal(i) = Y_hat1(i);
%         elseif Y_hat3(i) == Y_test_part(i)
%             Y_hat_optimal(i) = Y_hat3(i);
%         else
%             Y_hat_optimal(i) = Y_hat3(i);
%         end
%     end
%    
%     Y_hat = zeros(size(Y_test_part, 1), 1);
%     for i = 1:size(Y_hat, 1)
%         [~, ind] = max(P3(i));
%         if Y_hat1(i) == Y_hat3(i)
%             Y_hat(i) = Y_hat1(i);
%         elseif Y_hat3(i) == Y_hat_svm(i)
%             Y_hat(i) = Y_hat3(i);
%         elseif Y_hat1(i) == ind
%             Y_hat(i) = Y_hat1(i);
%         else
%             if P3(Y_hat3(i)) > P1(Y_hat1(i))
%                 Y_hat(i) = Y_hat3(i);
%             else
%                 Y_hat(i) = Y_hat1(i);
%             end
%         end
%     end
    Y_hat = Y_hat_svm;
    
    %% Calculate the performance
    models =[models,  model];
    performance_measures(x_val_i) = performance_measure(Y_test_part, Y_hat);
    L1_loss(x_val_i) = sum(Y_test_part - Y_hat ~= 0);
    accuracy(x_val_i) = 1 - (L1_loss(x_val_i) / size(Y_hat, 1));
    x_val_i = x_val_i + 1;
    
    %% Incorrect data
    incorrect_ids = find(Y_test_part - Y_hat ~= 0);
    
end
%% Average performance
mean_performance_measure = mean(performance_measures)
mean_L0_loss = mean(L1_loss)
mean_accuracy = mean(accuracy)

