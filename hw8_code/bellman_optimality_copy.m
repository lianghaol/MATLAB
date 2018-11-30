states = [0 1 2 3 4];
actions = ['f' 'b'];
V = rand(1, 5) .* 10;
policy = zeros(1, length(states));
% p(s, s', a) = p(s' | s, a)
p = zeros(length(states), length(states), length(actions));
% r(s, s', a)
r = zeros(length(states), length(states), length(actions));
% state 0
p(1, 1, 1) = 0.1;
r(1, 1, 1) = 2;
p(1, 2, 1) = 0.9;
p(1, 1, 2) = 0.9; 
r(1, 1, 2) = 2;
p(1, 2, 2) = 0.1;
% state 1
p(2, 1, 1) = 0.1;
r(2, 1, 1) = 2;
p(2, 3, 1) = 0.9;
p(2, 1, 2) = 0.9;
r(2, 1, 2) = 2;
p(2, 3, 2) = 0.1;
% state 2
p(3, 1, 1) = 0.1;
r(3, 1, 1) = 2;
p(3, 4, 1) = 0.9;
p(3, 1, 2) = 0.9;
r(3, 1, 2) = 2;
p(3, 4, 2) = 0.1;
% state 3
p(4, 1, 1) = 0.1;
r(4, 1, 1) = 2;
p(4, 5, 1) = 0.9;
p(4, 1, 2) = 0.9;
r(4, 1, 2) = 2;
p(4, 5, 2) = 0.1;
% state 4
p(5, 1, 1) = 0.1;
r(5, 1, 1) = 2;
p(5, 5, 1) = 0.9;
r(5, 5, 1) = 10;
p(5, 1, 2) = 0.9;
r(5, 1, 2) = 2;
p(5, 5, 2) = 0.1;
r(5, 5, 2) = 10;

q_value = zeros(1,2);
while norm(V - V_old) > 0.005
    policy_old = policy;
    V_old = V;
    for state_idx = 1 : length(states)
        q_value(1) = p(state_idx, :, 1) * (r(state_idx, :, 1) + 0.9 * V_old)';
        q_value(2) = p(state_idx, :, 2) * (r(state_idx, :, 2) + 0.9 * V_old)';
%         disp(q_value)
        V(state_idx) = max(q_value);
        policy(state_idx) = find(q_value == V(state_idx));
    end
%     if change happens print the new policy
    if (sum(policy_old ~= policy) ~= 0)
        disp(actions(policy))
    end
end
disp(V)


