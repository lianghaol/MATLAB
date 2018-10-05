% Clean up workspace. 
close all % Close figures.
clear     % Delete variables.
% Simulation parameters
w_0 = 20;   % Initial wealth.
b = 1;      % Amount bet at every time.
p = 0.55;   % Probability of winning.
max_t=200; % Simulation will run for at most max_t iterations.


nr_experiments = 10000; % number of times a betting sequence is computed.  
broke = 0; % counter for the number of times the players lost all her money.
w_matrix = zeros(nr_experiments,max_t);
t_vector = zeros(nr_experiments,1);
for experiment = 1:nr_experiments
    [w, t] = ssas_gambling(w_0, b, p, max_t); % Run martinale experiment; see file "ssas_gambling.m"
    if (t < max_t)
        broke = broke + 1; % Another broken patron.
    end
    if (~mod(experiment,100)) fprintf('%5.0f \n', experiment); end
    w_matrix(experiment,1:t) = w;
    t_vector(experiment,1) = t;
end


avg_tendency_10_experiments = sum(w_matrix(1:10,:))/10;
avg_tendency_20_experiments = sum(w_matrix(11:30,:))/20;
avg_tendency_100_experiments = sum(w_matrix(1:100,:))/100;

figure; hold on; grid on; xlabel('bet index'); 
ylabel ('wealth (in $)'); axis([0,max_t,0,120])% create new figure
% Plot average tendency from simulations
plot(avg_tendency_10_experiments, 'b', 'linewidth', 1 )
plot(avg_tendency_20_experiments, 'r', 'linewidth', 1 )
plot(avg_tendency_100_experiments, 'm', 'linewidth', 1 )
% Plot average tendency as predicted by analysis
plot( w_0+[1:max_t]*(2*p - b), 'k', 'linewidth', 1 )

% Plot histogram at time t=200
figure; hold off; grid on; xlabel('wealth (in $)'); 
ylabel ('frequency'); axis([0,90,0,0.3])% create new figure
hist_points=[0 10 20 30 40 50 60 70 80 90];
hist_values = hist(w_matrix(:,200),hist_points)/nr_experiments;
bar(hist_points,hist_values,1)
print -depsc2 figures/gambling_histogram_t_200.eps