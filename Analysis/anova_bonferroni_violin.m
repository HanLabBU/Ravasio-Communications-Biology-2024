% anova_bonf_violin_Cara.m
% Author: Cara
% Date: 09/21/22
% Purpose: To run ANOVA, bonferroni comparison and create a violin plot for
% a given struct input. The fields of the struct MUST be 'Hz40','Hz140' and
% 'Hz1000'. There should only ever be three fields (those stimulaion
% frequencies).

function [pvals] = anova_bonferroni_violin(test_struct,vcolor)
%vcolor = [0 0 1; 1 0 0; 0 1 0]; %40Hz is blue, 140Hz is red, 1000Hz is green
%One-Way ANOVA
test_array = [test_struct.CA1_40Hz',test_struct.M1_40Hz',test_struct.CA1_140Hz',...
             test_struct.M1_140Hz',test_struct.CA1_1000Hz',test_struct.M1_1000Hz'];
groups = [ones(size(test_struct.CA1_40Hz'))*40,ones(size(test_struct.M1_40Hz'))*80,ones(size(test_struct.CA1_140Hz'))*140,...
          ones(size(test_struct.M1_140Hz'))*280,ones(size(test_struct.CA1_1000Hz'))*1000,ones(size(test_struct.M1_1000Hz'))*2000];
[~,~,stats]=anova1(test_array, groups,'off');

%Bonferroni Comparison Method (reduces false positives; strictest test)
[c,~,~,~]=multcompare(stats, 'ctype', 'bonferroni','display','off');
pvals = c(:,end);

%Violin Plot
figure
vs = violinplot(test_struct, 6,'ViolinColor',vcolor,'GroupOrder', {'CA1_40Hz','M1_40Hz','CA1_140Hz','M1_140Hz','CA1_1000Hz','M1_1000Hz'});
hold on
for i=1:6
    if pvals(i)<0.05
        lims = ylim;
        offset = (lims(2)-lims(1))/10;
        max_y=lims(2)-offset;
        if i==1
            min_x = 1;
            max_x = 2;
        elseif i==2
            min_x = 1;
            max_x = 3;
        elseif i==3
            min_x = 2;
            max_x = 3;
        else %Cara added this for ease of running 12/07/22
            min_x = 0;
            max_x = 0;
        end
        plot([min_x max_x],[max_y max_y], 'k-');
        mean_x=mean([max_x,min_x]);
        T1 = text(mean_x,max_y,'*');
        T2 = text(mean_x-0.3, max_y-offset,sprintf('p=%0.5f',pvals(i)));
        T1.FontSize = 18;
        T2.FontSize= 12;
    end
end
end
