% chi2test_Cara
% Date: 09/13/23
% Author: Cara R, adapted from Peder Axensten (chi2test.m, matlab, 2007)
% Purpose: Perform a chi2test by hand and estimate the resulting pvalue.
% Used instead of Fisher's test because we are working with so many
% observations. This code works on any size 2-d matrix, but note that you
% will have to perofom more specific chi2tests on smaller contingency
% tables to determine proper significance.
%
% p is the initial pvalue
% p_adj is the adjusted pval using Bonferroni correction (i.e. multiply by # comparisons)
% w is the Phi power of effect/effect size. (w = 0.1 (small), w=0.3 (med), w=0.5 (large))

function [p, p_adj, w, df, chi2stat, expected] = chi2test_Cara(observed)
expected = sum(observed, 2)/sum(sum(observed)) * sum(observed); %equivalenetly the np variable in chi2 tests (n*p0 the null hypothesis)
chi2stat = sum(sum((observed-expected).^2./(expected)));
df = (size(observed,2)-1)*(size(observed,1)-1); % degrees of freedom
p = 1 - gammainc(chi2stat/2, df/2); % chi2cdf by hand to get to p-value

%Bonferroni Correction
num_compare = sum([1:numel(observed)-1]); %Summation from 1 to number of entries -1 (sanity check with a 2x2 in your head)
p_adj = p*num_compare;

%Effect size (Phi for chi2 test)
w = sqrt(chi2stat/(sum(sum(observed))));  % chi2 values divided by number of observations
end
