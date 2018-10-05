function accept = offer_exp(J, K, L)
ofrs = randperm(J);
disp(ofrs)
rejects = ofrs(1:K);
rejects = mink(rejects,L);
rejected = rejects(L);
disp(rejected)
ofrs = ofrs(K+1:length(ofrs));
ofrs_acc = ofrs < rejected;
accept = ofrs(ofrs_acc);
if isempty(accept)
    accept = ofrs(length(ofrs));
else
    accept = accept(1);
end
end