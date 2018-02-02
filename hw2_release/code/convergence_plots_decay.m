load('../data/X_noisy.mat');
load('../data/Y.mat');
%X_noisy = [X_noisy ones(size(X_noisy, 1), 1)];
iterations = 100;
step_size = 0.000093;
[~, errors_iter_fixed] = gradient_ascent_fixed(X_noisy,Y,step_size, iterations);
[~, errors_iter_decay] = gradient_ascent_decay(X_noisy,Y,step_size, iterations);
y = errors_iter_fixed; x = 1:iterations; % <- computes mean across all trials
plot(x, y);
hold on;
y = errors_iter_decay; x = 1:iterations; % <- computes mean across all trials
plot(x, y);
title('Noisy data, Max Iterations = 100, Stepsize = 0.000093');
xlabel('Iterations');
ylabel('Error');
legend('Fixed Stepsize','1/sqrt(n) Decay');
hold off;