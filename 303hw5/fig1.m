clear all
close all

J = 16; % Number of users
p = 1/J; % Optimal transmission probability (pˆ\star)
lambda = 0.9 * p*(1-p)^(J-1); % Packet arrival rate
N = 10^4; % Length of the simulation

% Simulation
R = aloha( J, p, lambda, N );

% Queue lengths of terminals 1-4
figure();
stairs(1:N, R(1:4,:)', 'LineWidth', 2);
xlabel('Time slot');
ylabel('Queue length');
legend('Terminal 1','Terminal 2','Terminal 3','Terminal 4', 'Location', 'Best')
grid;
