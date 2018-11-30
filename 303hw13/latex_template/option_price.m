drift_volatility;
k = [0.8 ; 1 ; 1.2];
t = 1:251;
[c, mean, mean_up_bound, mean_low_bound] = get_prices(k, drift_n, volatility, close_price,t);
% Plot results
h1 = figure();
plot(t, c, 'LineWidth', 2);
xlabel('Strike time (days)');
ylabel('Option price');
grid on;
legend('K = 0.8 EX', 'K = EX', 'K = 1.2 EX', 'Location', 'Best');
xlim([1 250]);

h2 = figure();
fill([t fliplr(t)], [mean_up_bound fliplr(mean_low_bound)], 'r', 'Linestyle', 'None', 'FaceAlpha', 0.2);
hold on
plot(t, mean, 'k', 'LineWidth', 2);
xlabel('Strike time (days)');
ylabel('Expected stock price');
grid on;
xlim([1 250]);