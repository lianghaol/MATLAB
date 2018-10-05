% Function encapsulating the loop to simulate bets. 
%
% At each time instant t, player bets $b and wins with probability p. If 
% she wins she receives a payoff of $b. Player starts with wealth w(0) and 
% plays until his wealth is depleted. To avoid infinite loops we also add 
% a restriction max_t times on the number of bets placed.
%
% The function returns a vector w with the history of the bets and a scalar
% t with the number of bets placed. If the player didn't go bankrupt,
% t = max_t.
function [w, t, h] = ssas_gambling(w_0, b, p, max_t)

t = 1; % Time index.
h = 0; %Boolean to indicate bankruptcy
w(t) = w_0;
while ( (w(t)>0) && (t<max_t) ) % Halt the iteration when wealth is depleted or after max_t bets.
   x = random('bino',1,p);      % draw random number determining bet's outcome. 
                                % Variable win equals 1 with probability p and 0 otherwise.
   if (x==1)                     
       w(t+1) = w(t) + b;       % If win = 1 then wealth increases by b.
   else 
       w(t+1) = w(t) - b;       % If win = 0 wealth decreases by b.
   end
   t = t + 1;                   % Increase time and repeat.
end
if t < max_t
        h = 1;  %If the actual number of rounds is less than the max,
                %h=1 because the player went bankrupt.
end
end
