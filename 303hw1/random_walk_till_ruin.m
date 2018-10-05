function t = random_walk_till_ruin(p, w0)
    % Initialize variables
    b = 1;
    t = 1; w(t) = w0; 
    % repeat while not broke up to time maxt
    while w(t) > 0
        x = (rand() < p);
        if x == 1 
            w(t + 1) = w(t) + b; % If x = 1 wealth increases by b
        else
            w(t + 1) = w(t) - b; % If x = 0 wealth decreases by b
        end
        t = t + 1;
    end
end