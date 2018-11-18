% sing = 1, walk = 2, TV = 3
X = [3 2 3 1 1 1 2 3 1 1];
% happy = 1, sad = 2
transition = log([4/5 1/5; 1/2 1/2]);
emission = log([5/10 3/10 2/10; 1/10 2/10 7/10]);
forward = zeros(2, size(X, 2));
pointer = zeros(2, size(X, 2));
% initialize forward prob f1(1) and f1(2), their backpointer is 0, denoting
% start
forward(1,1) = log(1/2) + emission(1, X(1));
forward(2,1) = log(1/2) + emission(2, X(1));
tmp = zeros(2);
for i = 2 : size(X, 2)
    tmp1 = [forward(1, i-1) +  transition(1, 1), forward(2, i-1) + transition(2, 1)];
    [val1, idx1] = max(tmp1);
    forward(1, i) = val1 + emission(1, X(i));
    pointer(1, i) = idx1;
    tmp2 = [forward(1, i-1) +  transition(1, 2), forward(2, i-1) + transition(2, 2)];
    [val2, idx2] = max(tmp2);
    forward(2, i) = val2 + emission(2, X(i));
    pointer(2, i) = idx2;
end
disp(exp(forward(1,size(X, 2))))
disp(exp(forward(2,size(X, 2))))
disp(pointer)