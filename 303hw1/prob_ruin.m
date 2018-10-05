function p = prob_ruin(N, w0, p)
ruins = 0;
for i = 1 : N
    [~, bl] = random_walk(p, w0, 100);
    if ~bl
        ruins = ruins + 1;
    end
end
p = ruins / N;
end