clear;
%for this to work, comment out the call to clear in main, and comment out
%the declaration of the variable word_count_cutoff;
%This is done very hacky because I am lazy.
limit = 20;
%the z's are there so it goes to the bottom of the workspace. I'm lazy.
znumber_of_features = zeros(1, limit+1);
zmeans_peformance_measure = zeros(1, limit+1);
zmeans_accuracy = zeros(1, limit+1);
zmeans_L0_loss = zeros(1, limit+1);
for word_count_cutoff = 0:limit
    main
    znumber_of_features(word_count_cutoff+1) = size(selected_features, 2);
    zmeans_peformance_measure(word_count_cutoff+1) = mean_performance_measure;
    zmeans_accuracy(word_count_cutoff+1) = mean_accuracy;
    zmeans_L0_loss(word_count_cutoff+1) = mean_L0_loss;
end

figure()
plot(0:limit, zmeans_peformance_measure)
title("performance")

figure()
plot(0:limit, zmeans_accuracy)
title("accuracy")

figure()
plot(0:limit, zmeans_L0_loss)
title("L0 loss")

