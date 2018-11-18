load data.mat
num_iter = 5;
label = zeros(size(data, 1), num_iter);
centroid = [8 9; 12 6; 12 9];
for j = 1 : num_iter
    % assignment
    for i = 1 : size(data, 1)
        label(i,j) = closestCentroid(data(i,:), centroid);
    end
    % compute new centroids
    for i = 1: size(centroid, 1)
        centroid(i,:) = mean(data(label(:,j) == i,:),1);
    end
    fprintf('after %d iterations\n', j)
    disp('x-y coords of centroids red, blue, green')
    disp(centroid)
end
disp('labels')
disp(label)
disp('data')
disp(data)




function d = distance(x, y)
d = norm(x - y);
end

function label = closestCentroid(x, centroid)
distances = zeros(size(centroid, 1), 1);
for i = 1 : size(centroid, 1)
    distances(i) = distance(x, centroid(i, :));
end
label = find(distances == min(distances));
end