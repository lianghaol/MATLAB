 clear, clc;

 drift_volatility;

 range = -0.1:0.01:0.1;

 
 n_elements = histcounts(Y_n, range);

 range = range(2:end);
 h1 = figure();
 pdf = n_elements/L/0.01;
 bar(range, pdf);
 hold on;
 plot(range, normpdf(range, drift*h, sqrt(volatility*h)), 'r', 'Linewidth', 2);
 xlabel('x');
 ylabel('pdf');
 grid on;
 legend('Estimated', 'Gaussian pdf');


 h2 = figure();
 cdf = cumsum(n_elements)/L;
 stairs(range, cdf);
 hold on;
 plot(range, normcdf(range, drift*h, sqrt(volatility*h)), 'r', 'Linewidth', 2);
 xlabel('x');
 ylabel('cdf');
 grid on;
 legend('Estimated', 'Gaussian pdf');