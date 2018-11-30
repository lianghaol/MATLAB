clear all
close all

h = 0.01;
variance = 1; 
T = 10;


W = randn(ceil(T/h), 1)*sqrt(variance * h);
X = cumsum(W);


figure();
plot(h:h:T, X, 'Linewidth', 2);
xlabel('Time')
ylabel('X(t)');
xlim([0 T]);
grid on;

saveas('D_plot.jpg')