clear all
close all

J = 16; % Number of users
p = 1/J; % Optimal transmission probability (pˆ\star)
lambda = 0.9 * p*(1-p)^(J-1); % Packet arrival rate
N = 10^4; % Length of the simulation

% Simulation
R = aloha( J, p, lambda, N );

% We use only terminal 1 from now on
R1 = R(1,:);
maxR1 = max(R1);
prob_sim = histcounts(R1, 0:maxR1+1)/N;

% Analytical distribution
rho = lambda/(p*(1-p)^(J-1));
prob_theo = (1-rho) * rho.^(0:maxR1);

% Plots
figure;
stem(0:maxR1, prob_sim, 'LineWidth', 2);
hold on
stem(0:maxR1, prob_theo, 'x', 'LineWidth', 2);
xlabel('Queue length');
ylabel('Probability');
legend('Estimated probability (\xi_k)', ...
    'Analytical probability (\pi_k)');
grid;
