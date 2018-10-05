function until_ruin_plot(lw)
    N = 4096;
    p = zeros(N, 1);
    p(:) = 0.4;
    w0 = zeros(N,1);
    i = 1;
    nplot = sqrt(length(lw));
    for w = lw
        w0(:) = w;
        t = arrayfun(@random_walk_till_ruin, p, w0);
        subplot(nplot, nplot, i);
        histogram(t, 32);
        title (['w0=', int2str(w)])
        xlabel 'number of bets until ruin'
        grid on;
        i = i + 1;
        fprintf('When w0 = %5d, average T0 = %6.3f.\n', w, mean(t))
    end
end
