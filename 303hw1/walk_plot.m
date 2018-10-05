function walk_plot(w0, T)
% w0 = 20;
% T = 10^3;
p = [0.25 0.5 0.75];
t = 0:1:T;
[w1, bl1] = random_walk(p(1), w0, T);
[w2, bl2] = random_walk(p(2), w0, T);
[w3, bl3] = random_walk(p(3), w0, T);
x = t(1:length(w1));
figure
hold on;
if bl1
    plot (x, w1, 'b');
else    
    plot (x, w1, 'r');
end
x = t(1:length(w2));
if bl2
    plot (x, w2, 'b');
else    
    plot (x, w2, 'r');
end
x = t(1:length(w3));
if bl3
    plot (x, w3, 'b');
else    
    plot (x, w3, 'r');
end
xlabel 'bet index';
ylabel 'wealth (in $)';
title 'lower bounded random walk';
legend('p=0.25', 'p=0.5', 'p=0.75')
hold off;
end