n = [6 10 20 50];
p = 5 ./ n;
l_n = length(n);
n = num2cell(n);
p = num2cell(p);
% pdf_names = "Binomial";
% pdf_names = repmat(pdf_names, 1, l_n);
% pdf_names = cellstr(pdf_names);
pdf_values = cell(1, l_n);
for i = 1:l_n
    pdf_values{i} = 0:n{i};
end
pd = cellfun(@binopdf, pdf_values, n, p, 'UniformOutput', false);
cd = cellfun(@binocdf, pdf_values, n, p, 'UniformOutput', false);

for i = 1 : l_n
    subplot(2, l_n, i);
    plot(pdf_values{i}, pd{i}, 'LineWidth', 2)
    title(['pmf ', 'n =', num2str(n{i}), ' p =', num2str(p{i})])
    grid on;
    subplot(2, l_n, i+l_n);
    plot(pdf_values{i}, cd{i}, 'LineWidth', 2)
    title(['cdf ', 'n =', num2str(n{i}), ' p =', num2str(p{i})])
    grid on;
end