%anova_bonferroni_box.m
% Author: Cara
% Date: 04/11/23
% Purpose: To run ANOVA, bonferroni comparison and create a box plot for
% a given struct input. The fields of the struct MUST be 'Hz40','Hz140' and
% 'Hz1000'. There should only ever be three fields (those stimulaion
% frequencies).

function [pvals] = anova_bonferroni_box(test_struct,bcolor)
%bcolor = [0 0 1; 1 0 0; 0 1 0]; %40Hz is blue, 140Hz is red, 1000Hz is green
%Multi-Way ANOVA

if isfield(test_struct, {'CA1_40Hz'}) && isfield(test_struct, {'M1_140Hz'}) %if we compare across regions and frequencies
    test_case = 0;
elseif isfield(test_struct, {'CA1_40Hz'}) && isfield(test_struct, {'CA1_140Hz'}) %if we compare within CA1
    test_case = 1;
elseif isfield(test_struct, {'M1_40Hz'}) && isfield(test_struct, {'M1_140Hz'}) %if we compare within M1
    test_case = 2;
elseif isfield(test_struct, {'CA1_40Hz'}) && isfield(test_struct, {'M1_40Hz'}) %if we compare within 40Hz
    test_case = 3;
elseif isfield(test_struct, {'CA1_140Hz'}) && isfield(test_struct, {'M1_140Hz'}) %if we compare within 140Hz
    test_case = 4;
elseif isfield(test_struct, {'CA1_1000Hz'}) && isfield(test_struct, {'M1_1000Hz'}) %if we compare within 1kHz
    test_case = 5;
end

switch test_case
    case 0
    %This is if I give a struct with 6 inputs (all conditions)
    test_array = [test_struct.CA1_40Hz',test_struct.M1_40Hz',test_struct.CA1_140Hz',...
                 test_struct.M1_140Hz',test_struct.CA1_1000Hz',test_struct.M1_1000Hz'];
    group_freq = [ones(size(test_struct.CA1_40Hz'))*40,ones(size(test_struct.M1_40Hz'))*40,ones(size(test_struct.CA1_140Hz'))*140,...
              ones(size(test_struct.M1_140Hz'))*140,ones(size(test_struct.CA1_1000Hz'))*1000,ones(size(test_struct.M1_1000Hz'))*1000];
    %group_freq is 40, 140, or 1000
    group_reg = [ones(size(test_struct.CA1_40Hz')),ones(size(test_struct.M1_40Hz'))*2,ones(size(test_struct.CA1_140Hz')),...
              ones(size(test_struct.M1_140Hz'))*2,ones(size(test_struct.CA1_1000Hz')),ones(size(test_struct.M1_1000Hz'))*2];
    % group_reg has 1 for CA1, 2 for M1
    [~,~,stats]=anovan(test_array, {group_freq, group_reg},'display','off','Model','interaction'); %,'Varnames',['freq','reg']);

    %Bonferroni Comparison Method (reduces false positives; strictest test)
    [results,~,~,gnames]=multcompare(stats, 'Dimension',[1 2],'ctype', 'bonferroni','display','off');
    pvals = results(:,6); %This is the column with pvalue outputs
    labels = {'CA1_40Hz','M1_40Hz','CA1_140Hz','M1_140Hz','CA1_1000Hz','M1_1000Hz'};

    case 1
        test_array = [test_struct.CA1_40Hz',test_struct.CA1_140Hz',test_struct.CA1_1000Hz'];
        group = [ones(size(test_struct.CA1_40Hz'))*40,ones(size(test_struct.CA1_140Hz'))*140,ones(size(test_struct.CA1_1000Hz'))*1000];
        [~,~,stats]= anova1(test_array, group,'off');
        c = multcompare(stats,'ctype', 'bonferroni','display','off');
        pvals = c(:,end);
        labels = {'CA1_40Hz','CA1_140Hz','CA1_1000Hz'};
    case 2
        test_array = [test_struct.M1_40Hz',test_struct.M1_140Hz',test_struct.M1_1000Hz'];
        group = [ones(size(test_struct.M1_40Hz'))*40,ones(size(test_struct.M1_140Hz'))*140,ones(size(test_struct.M1_1000Hz'))*1000];
        [~,~,stats]= anova1(test_array, group,'off');
        c = multcompare(stats,'ctype', 'bonferroni','display','off');
        pvals = c(:,end);
        labels = {'M1_40Hz','M1_140Hz','M1_1000Hz'};
    case 3
        test_array = [test_struct.CA1_40Hz', test_struct.M1_40Hz'];
        group = [ones(size(test_struct.CA1_40Hz'))*40,ones(size(test_struct.M1_40Hz'))*80];
        [~,~,stats]= anova1(test_array, group,'off');
        c = multcompare(stats,'ctype', 'bonferroni','display','off');
        pvals = c(:,end);
        labels = {'CA1_40Hz','M1_40Hz'};
    case 4
        test_array = [test_struct.CA1_140Hz', test_struct.M1_140Hz'];
    case 5
        test_array = [test_struct.CA1_1000Hz', test_struct.M1_1000Hz'];
    otherwise
        disp('Sorry, something went wrong');
end  

    %Box Plot
    figure
    switch test_case
        case 0
            bs = boxplot(test_array,group_freq.*group_reg,'Labels', labels ,...
                'Colors',bcolor, 'OutlierSize', 6,'Symbol', '.k');
        otherwise
             bs = boxplot(test_array,group,'Labels', labels ,...
            'Colors',bcolor, 'OutlierSize', 6,'Symbol', '.k'); 
    end
    hold on
    sig = pvals<0.05;
    idx = find(sig == 1);
    if isempty(idx)
        idx = NaN;
    end
    lims_x = xlim; lims_y = ylim;
    T1 = text(lims_x(2)-4,lims_y(2),['Significance: ' num2str(idx')],'FontSize',12);
end
