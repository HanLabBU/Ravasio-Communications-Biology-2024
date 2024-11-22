% KW_ranksum_dunnsidak_box.m
% Author: Cara
% Date: 05/01/23
% Purpose: To run Kruskal-Wallis, dunn-sidak comparison or a Wilcoxon ranksum test
% and create a box plot for a given struct input. The fields of the struct 
% MUST be 'Hz40','Hz140' and 'Hz1000'. There should only ever be three fields 
% (those stimulaion frequencies).

function [pvals] = KW_ranksum_dunnsidak_box(test_struct,bcolor)
%bcolor = [0 0 1; 1 0 0; 0 1 0]; %40Hz is blue, 140Hz is red, 1000Hz is green

if isfield(test_struct, {'CA1_40Hz'}) && isfield(test_struct, {'M1_140Hz'}) %if we compare across regions and frequencies
    test_case = 0; % Multi-way ANOVA - Note: this will never get used in my script
elseif isfield(test_struct, {'CA1_40Hz'}) && isfield(test_struct, {'CA1_140Hz'}) %if we compare within CA1
    test_case = 1; % Kruskal-Wallis
elseif isfield(test_struct, {'M1_40Hz'}) && isfield(test_struct, {'M1_140Hz'}) %if we compare within M1
    test_case = 2; % Kruskal-Wallis
elseif isfield(test_struct, {'CA1_40Hz'}) && isfield(test_struct, {'M1_40Hz'}) %if we compare within 40Hz
    test_case = 3; % Ranksum
elseif isfield(test_struct, {'CA1_140Hz'}) && isfield(test_struct, {'M1_140Hz'}) %if we compare within 140Hz
    test_case = 4; % Ranksum
elseif isfield(test_struct, {'CA1_1000Hz'}) && isfield(test_struct, {'M1_1000Hz'}) %if we compare within 1kHz
    test_case = 5; % Ranksum
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
    
    % TWO-WAY ANOVA
    [~,~,stats]=anovan(test_array, {group_freq, group_reg},'display','off','Model','interaction'); %,'Varnames',['freq','reg']);

    %Bonferroni Comparison Method (reduces false positives; strictest test)
    [results,~,~,~]=multcompare(stats, 'Dimension',[1 2],'ctype', 'bonferroni','display','off');
    pvals = results(:,6); %This is the column with pvalue outputs
    labels = {'CA1_40Hz','M1_40Hz','CA1_140Hz','M1_140Hz','CA1_1000Hz','M1_1000Hz'};

    case 1
        test_array = [test_struct.CA1_40Hz',test_struct.CA1_140Hz',test_struct.CA1_1000Hz'];
        group = [ones(size(test_struct.CA1_40Hz'))*40,ones(size(test_struct.CA1_140Hz'))*140,ones(size(test_struct.CA1_1000Hz'))*1000];
        % KRUSKAL- WALLIS
        [p,~,stats]= kruskalwallis(test_array, group,'off');
        if p<0.05
            c = multcompare(stats, 'ctype', 'dunn-sidak','display','off');
            pvals = c(:,end);
        else
            pvals = [1;1;1];
        end
        labels = {'CA1_40Hz','CA1_140Hz','CA1_1000Hz'};
    case 2
        test_array = [test_struct.M1_40Hz',test_struct.M1_140Hz',test_struct.M1_1000Hz'];
        % KRUSKAL-WALLIS
        group = [ones(size(test_struct.M1_40Hz'))*40,ones(size(test_struct.M1_140Hz'))*140,ones(size(test_struct.M1_1000Hz'))*1000];
        [p,~,stats]= kruskalwallis(test_array, group,'off');
        if p<0.05
            c = multcompare(stats,'ctype', 'dunn-sidak','display','off');
            pvals = c(:,end);
        else
            pvals = [1;1;1];
        end
        labels = {'M1_40Hz','M1_140Hz','M1_1000Hz'};
    case 3    
        test_array = [test_struct.CA1_40Hz',test_struct.M1_40Hz'];
        group = [ones(size(test_struct.CA1_40Hz'))*40,ones(size(test_struct.M1_40Hz'))*80];
        % RANKSUM
        p = ranksum(test_struct.CA1_40Hz, test_struct.M1_40Hz);
        pvals = p;
        labels = {'CA1_40Hz','M1_40Hz'};
    case 4
        test_array = [test_struct.CA1_140Hz',test_struct.M1_140Hz'];
        group = [ones(size(test_struct.CA1_140Hz'))*140,ones(size(test_struct.M1_140Hz'))*280];
        % RANKSUM
        p = ranksum(test_struct.CA1_140Hz, test_struct.M1_140Hz);
        pvals = p;
        labels = {'CA1_140Hz','M1_140Hz'};
    case 5
        test_array = [test_struct.CA1_1000Hz',test_struct.M1_1000Hz'];
        group = [ones(size(test_struct.CA1_1000Hz'))*1000,ones(size(test_struct.M1_1000Hz'))*2000];
        % RANKSUM
        p = ranksum(test_struct.CA1_1000Hz, test_struct.M1_1000Hz);
        pvals = p;
        labels = {'CA1_1000Hz','M1_1000Hz'};
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
    text(lims_x(2)-2,lims_y(2),['Significance: ' num2str(idx')],'FontSize',12);
    
    %Violin Plot
    figure
    switch test_case
        case 0
            vs = violinplot(test_struct,labels,'GroupOrder',labels,...
                'ViolinColor',bcolor,'ShowData',false,'ViolinAlpha',1,...
                'ShowMedian',true);

        otherwise
            vs = violinplot(test_struct,labels,'GroupOrder',labels,...
                'ViolinColor',bcolor,'ShowData',false,'ViolinAlpha',1,...
                'ShowMedian',true);
    end
    hold on
    sig = pvals<0.05;
    idx = find(sig == 1);
    if isempty(idx)
        idx = NaN;
    end
    lims_x = xlim; lims_y = ylim;
    text(lims_x(2)-2,lims_y(2),['Significance: ' num2str(idx')],'FontSize',12);
end
