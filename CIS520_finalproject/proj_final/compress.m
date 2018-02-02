function compressed = compress(X)
load(fullfile('include','stemmed_projections.mat'), 'stemmed_projections');
compressions = stemmed_projections;
compressed = zeros(size(X,1), max(compressions));

% [I,J,Vals] = find(X);
% 
% for i=1:length(I)
%     val = Vals(i);
%     new_j = compressions(J(i));
%     if new_j > 0
%         compressed(I(i), new_j) = compressed(I(i), new_j) + val;
%     end
% end
% compressed = sparse(compressed);

for i=1:length(compressions)
    un_id = compressions(i);
    compressed(:, un_id) = compressed(:, un_id) + X(:, i);
end
compressed = sparse(compressed);