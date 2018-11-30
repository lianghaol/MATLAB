cisco_stock_price;
h = 1;
close_price_l = log(close_price);
Y_n = close_price_l(2:252)-close_price_l(1:251);

L = size(Y_n, 1);


drift = sum(Y_n) /(h*L);
volatility = sum((Y_n- h *drift).^2)/((L-1)*h);
format short e
disp([drift, volatility])
