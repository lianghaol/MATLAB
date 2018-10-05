function n_dgtr = daughterrnd()
    k = rand;
    if k < 0.179
        count = 0;
    elseif k < 0.179 + 0.174
        count = 1;
    elseif k < 0.179 + 0.174 + 0.354
        count = 2;
    elseif k < 0.179 + 0.174 + 0.354 + 0.189
        count = 3;
    elseif k < 0.179 + 0.174 + 0.354 + 0.189 + 0.068
        count = 4;
    elseif k < 0.179 + 0.174 + 0.354 + 0.189 + 0.068 + 0.028
        if rand < 0.5
            count = 5;
        else
            count = 6;
        end
    else
        count = 7;    
    end
    n_dgtr = 0;
    for i = 1 : count
        if rand < 0.5
            n_dgtr = n_dgtr + 1;
        end
    end
end