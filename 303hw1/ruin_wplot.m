function ruin_wplot()
    w0 = 1:20;
    N(1:20) = 5000;
    p(1:20) = 0.55;
    ruin_prob = arrayfun(@prob_ruin, N, w0, p);
    figure
    plot(w0, ruin_prob);
    xlabel 'initial wealth'
    ylabel 'probability of ruin within 100 bets with p=0.55, N = 5000'
    title 'Relation of initital wealth and ruin probability'
    grid on;
end
