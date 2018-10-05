function [X, n_alive, n_extinct] = simulate(n, q, X0, max_types)
% SIMULATE  Simulates n generations of women's Mitochondrial DNA types,
% starting with X0 women of different types.
%   X is a matrix of size (max_types * n), where X(i, j) represents the
%   number of women whose DNA is of type-i in the j-th generation.
%
%   n_alive is a vector of size (1, n), where n_alive(j) represents the
%   number of types that are alive in generation j. Equivalently, there are
%   n_alive(j) non-zero numbers in X(:, j)
% 
%   n_extinct is a vector of size (1, n), where n_alive(j) represents the
%   number of types that are extinct in generation j. 
%
%   n is the total number of generations simulated
%   
%   q is the probability of mutation for each woman of all types and
%   generations
%   
%   X0 is number of women with different types.
%   
%   max_types should be larger than the potential number of types that ever
%   exists.


% max_types = 512;

X = zeros(max_types, n);
n_types = zeros(1, n);
n_extinct = zeros(1, n);

X(1:X0, 1) = 1;
n_types(1) = X0;
% for each generation
for gen = 2 : n
    % inherit the types of last generation, including those extinct
    n_types(gen) = n_types(gen - 1);
    % for each of last generation's types
    for type = 1 : n_types(gen - 1)
        % for each woman in last generation's each type
        % if the number is 0, that type is extinct in last generation,
        % skips the loop
        for i = 1 : X(type, gen - 1)
            % number of daughters for the i-th mom
            n_dgtr = daughterrnd;
            % if mutation
            mutation = rand < q;
            if mutation == 1
%                 the daughters belong to a new type
                n_types(gen) = n_types(gen) + 1;
                X(n_types(gen), gen) = n_dgtr;
            else
%                 add to the type in which their mother belongs
                X(type, gen) = X(type, gen) + n_dgtr;
            end
        end
%         if every mother in this type has mutation or no mother exists,
%         then this type should have no daughters in this generation
        if X(type, gen) == 0
            n_extinct(gen) = n_extinct(gen) + 1;
        end
    end
end
n_alive = n_types - n_extinct;
end