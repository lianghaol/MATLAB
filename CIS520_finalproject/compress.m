function compressed = compress(X)
    load(fullfile('include','stemmed_projections.mat'), 'stemmed_projections');
    compressions = stemmed_projections;
    compressed = zeros(size(X,1), max(compressions));

    for i=1:length(compressions)
        un_id = compressions(i);
        compressed(:, un_id) = compressed(:, un_id) + X(:, i);
    end
    compressed = sparse(compressed);