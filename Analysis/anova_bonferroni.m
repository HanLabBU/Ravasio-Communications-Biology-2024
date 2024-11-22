% sanova_bonferroni.m
% Author: Cara Ravasio
% Date: 12/08/22
% Purpose: To compare session-wise avg traces for each condition and
% determine significant differences

function pvals = anova_bonferroni(test_struct)
%One-Way ANOVA
test_array = [test_struct.CA1_40Hz',test_struct.M1_40Hz',test_struct.CA1_140Hz',...
             test_struct.M1_140Hz',test_struct.CA1_1000Hz',test_struct.M1_1000Hz'];
groups = [ones(size(test_struct.CA1_40Hz'))*40,ones(size(test_struct.M1_40Hz'))*80,ones(size(test_struct.CA1_140Hz'))*140,...
          ones(size(test_struct.M1_140Hz'))*280,ones(size(test_struct.CA1_1000Hz'))*1000,ones(size(test_struct.M1_1000Hz'))*2000];
[~,~,stats]=anova1(test_array, groups,'off');

%Bonferroni Comparison Method (reduces false positives; strictest test)
[c,~,~,~]=multcompare(stats, 'ctype', 'bonferroni','display','off');
pvals = c(:,end);
end