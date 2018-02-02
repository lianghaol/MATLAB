C = 0.01: 0.01: 0.99;
plot(C, cv_acc_1,'DisplayName', '2-fold');
hold on;
plot(C, cv_acc_2, 'DisplayName', '5-fold');
plot(C, cv_acc_3, 'DisplayName', '10-fold');
legend('show')
title("k-fold CV over C LogReg")
xlabel('C')
ylabel('CV acc')
figure