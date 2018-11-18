function [Y_hat] = least_expected_cost(P)
%% Given the PEM, calcuate the expected cost of each label
costs = [0 3 1 2 3;
         4 0 2 3 2;
         1 2 0 2 1;
         2 1 2 0 2;
         2 2 2 1 0];

expected_costs = P*costs;

%% Predict Y_hat using the expected costs
[~, min_index] = min(expected_costs, [], 2);
Y_hat = min_index;

end