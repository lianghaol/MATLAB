n = [6 10 20 50];
lambda = 5;
ln = length(n);
for i = 1:ln
    pd = poisspdf(0:n(i), lambda);
    subplot(1, ln, i)
    plot(0:n(i), pd, 'LineWidth', 2)
    title (['pmf ', 'n=', num2str(i)])
    grid on;
end
