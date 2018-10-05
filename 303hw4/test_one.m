q = 10^-2;
X0 = 100;
n = 50;
[X, n_alive, n_extinct] = simulate(n, q, X0, 512);

% clear rows of zero at the bottom
row_is_zero = all(X==0, 2);
X = unique( X(~row_is_zero, :), 'rows');

stairs(1:50, X', 'LineWidth', 2)
xlabel 'Generations'
ylabel 'Number of women'
title 'number of women in each type'
grid on;

plot(1:n, n_alive, 'LineWidth', 2)
xlabel 'Generations'
ylabel 'Number of existing type'
title 'number of existing type'
grid on;

plot(1:n, n_extinct, 'LineWidth', 2)
xlabel 'Generations'
ylabel 'Number of extinct type'
title 'number of accumulated extinct type'
grid on;

end_types = n_alive(n) + n_extinct(n);
bar(1:end_types, X(1:end_types, n), 'LineWidth', 2);
xlabel 'Final Types'
ylabel 'Number of women in each type'
title 'number of women in each final type'
grid on;