% Clean up workspace. 
close all % Close figures.
clear     % Delete variables.
% Simulation parameters
w_0 = 20;   % Initial wealth.
b = 1;      % Amount bet at every time.
p = 0.55;   % Probability of winning.
max_t=1000; % Simulation will run for at most max_t iterations.

figure; hold on; grid on; xlabel('bet index'); 
ylabel ('wealth (in $)'); axis([0,max_t,0,200])% create new figure

nr_experiments = 100; % number of times a betting sequence is computed.  
broke = 0; % counter for the number of times the players lost all her money.
for experiment = 1:nr_experiments
    [w, t] = ssas_gambling(w_0, b, p, max_t); % Run martinale experiment; see file "ssas_gambling.m"
    plot(w); % plot the bet's history    
    if (t < max_t)
        broke = broke + 1; % Another broken patron.
        plot(w,'r'); % Plot the bet's history in red. 
    end
    fprintf('%5.0f \n', experiment)  
end

% Plot average tendency
plot( w_0+[1:max_t]*(2*p - b), 'r', 'linewidth', 3 )