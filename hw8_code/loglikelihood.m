xchoice = [1 0];
ychoice = [1 -1];
theta_y = [67/154 87/154];
theta_x1_y = [
    99/134 55/174;
    35/134 119/174
];
theta_x2_y =[
    110/201 55/174;
    91/201 119/174;
];
xlabeled = [
    1 1;
1 1;
1 0;
0 0;
1 0;
0 0;
0 0];
ylabel = [
    1;
    1;
    1;
    1;
    -1;
    -1;
    -1;
    -1];
xunlabeled = [
    1 1;
    1 1;
    0 0;
    0 0
    ];
log_likelihood = 0;
for i = 1 : size(xlabeled, 1)
    log_likelihood = log_likelihood + log(theta_y(ychoice == ylabel(i))) ...
    + log( theta_x1_y( find(xchoice == xlabeled(i,1)), find(ychoice == ylabel(i)))...
         )...
    + log( theta_x2_y( find(xchoice == xlabeled(i,2)), find(ychoice == ylabel(i)))...
         );
end
%    the log of a sum of products(computed through sum of logs, then exp)
for i = 1 : size(xunlabeled,1)
     log_likelihood = log_likelihood + ...
     log(...
       exp(log(theta_y(2)) + ...
           log(theta_x1_y(find(xchoice==xunlabeled(i,1)), 2)) + ...
           log(theta_x2_y(find(xchoice==xunlabeled(i,2)), 2)) ...
       ) ...
     + exp(log(theta_y(1)) + ...
           log(theta_x1_y(find(xchoice==xunlabeled(i,1)), 1)) + ...
           log(theta_x2_y(find(xchoice==xunlabeled(i,2)), 1)) ...
       ) ...
      );
end
disp(log_likelihood);
