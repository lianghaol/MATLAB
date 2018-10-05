function ruin_pplot()
p = 0.3:0.02:0.7;
w0(1:length(p)) = 10;
N(1:length(p)) = 5000;
ruin_prob = arrayfun(@prob_ruin, N, w0, p);
figure
plot(p, ruin_prob);
xlabel 'success probability p'
ylabel 'probability of ruin within 100 bets with w0=10, N = 5000'
title 'Relation of success probability and ruin probability'
grid on;
end