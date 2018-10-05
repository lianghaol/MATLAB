function [R] = aloha(J, p, lambda, N)
% ALOHA simulates the ALOHA protocol
% Inputs:
% J : Number of terminals
% p - Probability of a terminal attempting a transmission
% lambda - Rate of packet arrivals
% N - Length of simulation

    % Initialize terminal queues to 0
    R = zeros(J, N);

    for t = 1:N-1
    %     Determine if each terminal generates a new packet
        arrivals = binornd(1, lambda, [J, 1]);
    %     Update queue length with new packets
        R(:, t+1) = R(:, t) + arrivals;
    %     Check which terminals have non-empty queues
        non_empty_queue = R(:, t) > 0;
    %     Decide if each terminal transmits packet
        transmission = binornd(1, p, [J, 1]);
    %     For each terminal, evaluate whether or not they transmit a packet by
    %     checking if (i) they have not received a packet AND (ii) their queue
    %     is not empty AND (iii) they have chosen to transmit in this time slot
        service = (~arrivals) & non_empty_queue & transmission;
    %     Check if transmission is successful, i.e., if a single terminal
    %     has attempted to transmit a packet...
        if sum(service) == 1
    %     The transmission is successful: remove packet from terminal queue
            R(:,t+1) = R(:,t) - service;
        end
    end
end