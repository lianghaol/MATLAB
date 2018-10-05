n = [6 10 20 50];
lambda = 5;
ln = length(n);
delta = zeros(1, ln);
for i = 1:ln
    bino = binopdf(0:n(i), n(i), lambda / n(i));
    j = 1;
    poissj = poisspdf(j, lambda);
    while poissj > 0.05 || j <= 6
        if j <= n(i) + 1
            delta(i) =  delta(i) + (bino(j) - poissj)^2 * poissj;
        else
            delta(i) =  delta(i) + poissj^3;
        end
        j = j + 1;
        poissj = poisspdf(j, lambda);
    end
end
disp(delta)