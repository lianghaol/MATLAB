function PlotErrors(train_err, test_err, val_err, q, file_to_save)
h = figure;
plot(q, train_err, '-ob');
hold on;

plot(q, test_err, '-or');
plot(q, val_err, '-oy');
title('Train-Test-Validation Errors Over q');
xlabel('q');
ylabel('Error');
legend('Train','Test', 'Validation');
hold off;

filename = strcat('Plots/',file_to_save);
set(gcf, 'PaperPositionMode', 'auto');
%saveas(gcf,filename,'fig');
print(h, '-dpng', filename);