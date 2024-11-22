function stdpool = pooledstd(group1,group2)
% Calculate pooled n, std from n, std of two groups
%  (to calculate it to N groups (N>2), repeat it N-1 times)
n1 = numel(group1);
n2 = numel(group2);
std1 = std(group1,'omitnan');
std2 = std(group2,'omitnan');

var1= std1^2;
var2= std2^2;
stdpool = sqrt(((n1-1)*var1 + (n2-1)*var2) / (n1+n2-2)); %Cohen's alternative formula for pooled std

end