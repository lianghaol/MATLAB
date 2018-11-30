function[c, mean, mean_up_bound, mean_low_bound] = get_prices(k, drift_n, volatility, close_price, t)

X0 = close_price(1,1);
alpha = 0.001;

mean = X0 * exp((drift_n + volatility/2)*t);
K = k*mean;

varX = X0^2 * exp((2*drift_n + volatility)*t) .* (exp(volatility*t) - 1);
mean_up_bound = mean + sqrt(varX);
mean_low_bound = mean - sqrt(varX);

c = zeros(size(K,1), length(t));
for K_i = 1:size(K,1)
    x = (log(K(K_i,:)/X0) - (alpha - volatility/2)*t) ./ sqrt(volatility*t);
    y = x - sqrt(volatility*t);
    N_a = 1 - normcdf(x, 0, 1);
    N_b = 1 - normcdf(y, 0, 1);
    c(K_i,:) = X0 * N_b - exp(-alpha*t) .* K(K_i,:) .* N_a;
end
end