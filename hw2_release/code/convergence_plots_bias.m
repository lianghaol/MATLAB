load('../data/X_noisy.mat');
load('../data/Y.mat');

iterations = 100;
step_size = 0.000097;

[~, errors_iter_fixed] = gradient_ascent_fixed(X_noisy,Y,step_size, iterations);
y = errors_iter_fixed; x = 1:iterations; % <- computes mean across all trials
plot(x, y);
hold on;
X_noisy = [X_noisy ones(size(X_noisy, 1), 1)];
[~, errors_iter_fixed] = gradient_ascent_fixed(X_noisy,Y,step_size, iterations);
y = errors_iter_fixed; x = 1:iterations; % <- computes mean across all trials
plot(x, y);

title('Noisy data, Max Iterations = 100, Stepsize = 0.000097');
xlabel('Iterations');
ylabel('Error');
legend('Without Feature','With Constant Feature');
hold off;