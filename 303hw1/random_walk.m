function [w, bl] = random_walk(p, w0, T)
    % Initialize variables
    %w0 = 20;
    b = 1;
    %T = 10;
    %p = 0.3; % success probability
    t = 1; w(t) = w0; 
    % repeat while not broke up to time maxt
    while w(t) > 0 && t <= T
        x = (rand() < p);
        if x == 1 
            w(t + 1) = w(t) + b; % If x = 1 wealth increases by b
        else
            w(t + 1) = w(t) - b; % If x = 0 wealth decreases by b
        end
        t = t + 1;
    end
    if w(t) == 0
      bl = false;
    else
      bl = true;
    end
end





