% run_pie_bar_chi2.m
% Author: Cara
% Date: 09/18/23
% Purpose: Clean up and automate the pie chart, bar plot version of pie 
% chart, modulation ratio scatter plot, and Chi^2 test section of
% post-processing. Chi^2 used instead of Fisher because it is more optimal
% for a large number of observations.

function chi2test_stats = run_pie_bar_scatter_chi2(non_mod_40_CA1, neg_mod_40_CA1, pos_mod_40_CA1,...
                                              non_mod_140_CA1, neg_mod_140_CA1, pos_mod_140_CA1,...
                                              non_mod_1000_CA1, neg_mod_1000_CA1, pos_mod_1000_CA1,...
                                              non_mod_40_M1, neg_mod_40_M1, pos_mod_40_M1,...
                                              non_mod_140_M1, neg_mod_140_M1, pos_mod_140_M1,...
                                              non_mod_1000_M1, neg_mod_1000_M1, pos_mod_1000_M1,...
                                              colors)
  %% Setup
    grey = colors(1,:);
    dark_blue = colors(2,:);
    red = colors(3,:);
    non = 1; neg = 2; pos = 3;
    
    % total data struct
    % struct setup
    % col1: Non, col2: Neg, col3: Pos
    % row1: 40Hz CA1, row2: 140Hz CA1, row3: 1000Hz CA1
    % row4: 40Hz M1, row5: 140Hz M1, row6: 1000Hz M1
    data = {non_mod_40_CA1, neg_mod_40_CA1, pos_mod_40_CA1;...
        non_mod_140_CA1, neg_mod_140_CA1, pos_mod_140_CA1;...
        non_mod_1000_CA1, neg_mod_1000_CA1, pos_mod_1000_CA1;...
        non_mod_40_M1, neg_mod_40_M1, pos_mod_40_M1;...
        non_mod_140_M1, neg_mod_140_M1, pos_mod_140_M1;...
        non_mod_1000_M1, neg_mod_1000_M1, pos_mod_1000_M1};
    
    % Bar graph matrix
    % matrix setup
    % col1: Neg, col2: Pos, col3: Non
    % row1: 40Hz CA1, row2: 140Hz CA1, row3: 1000Hz CA1
    % row4: 40Hz M1, row5: 140Hz M1, row6: 1000Hz M1
    bar_mat = [size(neg_mod_40_CA1.neurons,1), size(pos_mod_40_CA1.neurons,1), size(non_mod_40_CA1.neurons,1);...
            size(neg_mod_140_CA1.neurons,1), size(pos_mod_140_CA1.neurons,1), size(non_mod_140_CA1.neurons,1);...
            size(neg_mod_1000_CA1.neurons,1), size(pos_mod_1000_CA1.neurons,1), size(non_mod_1000_CA1.neurons,1);...
            size(neg_mod_40_M1.neurons,1), size(pos_mod_40_M1.neurons,1), size(non_mod_40_M1.neurons,1);...
            size(neg_mod_140_M1.neurons,1), size(pos_mod_140_M1.neurons,1), size(non_mod_140_M1.neurons,1);...
            size(neg_mod_1000_M1.neurons,1), size(pos_mod_1000_M1.neurons,1), size(non_mod_1000_M1.neurons,1)];
   
    
    freq = {'40','140','1000','40','140','1000'};
    region = {'CA1','CA1','CA1','M1','M1','M1'};
    
    %% Run Chi2 Test
    chi2test_stats = run_chi2_test(bar_mat);
    %% Create Pie Charts    
    %================================== CA1 ==================================%
    mod_40hz = [numel(non_mod_40_CA1.neurons(:,1)),numel(pos_mod_40_CA1.neurons(:,1)),numel(neg_mod_40_CA1.neurons(:,1))];
    mod_140hz = [numel(non_mod_140_CA1.neurons(:,1)),numel(pos_mod_140_CA1.neurons(:,1)),numel(neg_mod_140_CA1.neurons(:,1))];
    mod_1000hz = [numel(non_mod_1000_CA1.neurons(:,1)),numel(pos_mod_1000_CA1.neurons(:,1)),numel(neg_mod_1000_CA1.neurons(:,1))];

    %- Non/Pos/Neg Modulation -%
    figure;
    labels = {'non-modulated','positively modulated','negatively modulated'};
    explode = [0,1,1];
    % Create pie charts
    subplot(1,3,1);
    h40 = pie(mod_40hz,explode);
    title(sprintf(['40Hz ' region{1} '\n n=' num2str(sum(mod_40hz))]))
    patchHand = findobj(h40, 'Type', 'Patch');
    patchHand(1).FaceColor = grey;
    patchHand(2).FaceColor = red;
    patchHand(3).FaceColor = dark_blue;

    subplot(1,3,2);
    h140 = pie(mod_140hz,explode);
    title(sprintf(['140Hz ' region{1} '\n n=' num2str(sum(mod_140hz))]))
    patchHand = findobj(h140, 'Type', 'Patch'); 
    patchHand(1).FaceColor = grey;
    patchHand(2).FaceColor = red;
    patchHand(3).FaceColor = dark_blue;


    subplot(1,3,3);
    h1k = pie(mod_1000hz,explode);
    title(sprintf(['1000Hz ' region{1} '\n n=' num2str(sum(mod_1000hz))]))
    patchHand = findobj(h1k, 'Type', 'Patch');
    patchHand(1).FaceColor = grey;
    patchHand(2).FaceColor = red;
    patchHand(3).FaceColor = dark_blue;
    
    saveas(gcf, sprintf(['mod_pie_chart_' region{1},'.fig'])); 
    
    %================================== M1 ==================================%
    mod_40hz = [numel(non_mod_40_M1.neurons(:,1)),numel(pos_mod_40_M1.neurons(:,1)),numel(neg_mod_40_M1.neurons(:,1))];
    mod_140hz = [numel(non_mod_140_M1.neurons(:,1)),numel(pos_mod_140_M1.neurons(:,1)),numel(neg_mod_140_M1.neurons(:,1))];
    mod_1000hz = [numel(non_mod_1000_M1.neurons(:,1)),numel(pos_mod_1000_M1.neurons(:,1)),numel(neg_mod_1000_M1.neurons(:,1))];

    %- Non/Pos/Neg Modulation -%
    figure;
    labels = {'non-modulated','positively modulated','negatively modulated'};
    explode = [0,1,1];
    % Create pie charts
    subplot(1,3,1);
    h40 = pie(mod_40hz,explode);
    title(sprintf(['40Hz ' region{6} '\n n=' num2str(sum(mod_40hz))]))
    patchHand = findobj(h40, 'Type', 'Patch');
    patchHand(1).FaceColor = grey;
    patchHand(2).FaceColor = red;
    patchHand(3).FaceColor = dark_blue;

    subplot(1,3,2);
    h140 = pie(mod_140hz,explode);
    title(sprintf(['140Hz ' region{6} '\n n=' num2str(sum(mod_140hz))]))
    patchHand = findobj(h140, 'Type', 'Patch'); 
    patchHand(1).FaceColor = grey;
    patchHand(2).FaceColor = red;
    patchHand(3).FaceColor = dark_blue;


    subplot(1,3,3);
    h1k = pie(mod_1000hz,explode);
    title(sprintf(['1000Hz ' region{6} '\n n=' num2str(sum(mod_1000hz))]))
    patchHand = findobj(h1k, 'Type', 'Patch');
    patchHand(1).FaceColor = grey;
    patchHand(2).FaceColor = red;
    patchHand(3).FaceColor = dark_blue;
    
    saveas(gcf, sprintf(['mod_pie_chart_' region{6},'.fig']));
   
    %% Generate and save bar charts
    bar_mat_p = bar_mat./sum(bar_mat,2);
    % Confidence Interval on proportion equation:
    % 2*sqrt(p(1-p)/n)
    error_bar_act = 2.*sqrt((bar_mat_p(:,1).*(1-bar_mat_p(:,1)))./sum(bar_mat,2));
    error_bar_deact = 2.*sqrt((bar_mat_p(:,2).*(1-bar_mat_p(:,2)))./sum(bar_mat,2));
    error_bar_act_deact = [error_bar_deact(1),error_bar_act(1),...
                           error_bar_deact(2),error_bar_act(2),...
                           error_bar_deact(3),error_bar_act(3),...
                           error_bar_deact(4),error_bar_act(4),...
                           error_bar_deact(5),error_bar_act(5),...
                           error_bar_deact(6),error_bar_act(6)];
    error_bar_modulated = 2.*sqrt((sum(bar_mat_p(:,1:2),2).*(1-sum(bar_mat_p(:,1:2),2)))./sum(bar_mat,2));
    X = [1:1:6];
    %X = categorical({'40Hz CA1','140Hz CA1','1000Hz CA1','40Hz M1','140Hz M1','1000Hz M1'});
    %X = reordercats(X,{'40Hz CA1','140Hz CA1','1000Hz CA1','40Hz M1','140Hz M1','1000Hz M1'});
    Y = bar_mat_p;
    
    figure
    b = bar(X,Y,'Facecolor','flat');
    b(1,1).CData = dark_blue;
    b(1,2).CData = red;
    b(1,3).CData = grey;
    saveas(gcf,'neg_pos_non_bars_all.fig');

    figure
    b = bar(X,Y(:,1:2),'FaceColor','flat');
    b(1,1).CData = dark_blue;
    b(1,2).CData = red;
    hold on
    % Get the x coordinate of the bars
    x = nan(2, 6); %number bars, number groups                                                    % Earlier MATLAB Versions
    x(1,:) = bsxfun(@plus, b(1).XData, [b(1).XOffset]');
    x(2,:) = bsxfun(@plus, b(2).XData, [b(2).XOffset]');
%     x(1,:) = b(1).XEndPoints; %works for more recent matlab versions
%     x(2,:) = b(2).XEndPoints;
    errorbar(x(1,:)',Y(:,1),error_bar_deact,'k','linestyle','none');
    errorbar(x(2,:)',Y(:,2),error_bar_act,'k','linestyle','none');
    yl = ylim;
    ylim([0,yl(2)]);
    xticklabels({'40Hz CA1','140Hz CA1','1000Hz CA1','40Hz M1','140Hz M1','1000Hz M1'});
    title('Comparing %activated:%inhibited within conditions')
    saveas(gcf,'neg_pos_bars_all.fig');
    

    figure
    b = bar(X,sum(Y(:,1:2),2),'FaceColor','flat');
    hold on
    errorbar(X,sum(Y(:,1:2),2),error_bar_modulated,error_bar_modulated,'k','linestyle','none');
    xticklabels({'40Hz CA1','140Hz CA1','1000Hz CA1','40Hz M1','140Hz M1','1000Hz M1'});
    title('Comparing %modulated across conditions');
    saveas(gcf,'neg_pos_bars_all_stacked.fig');
    
    % Now separate into multiple graphs based on region
    % - Modulated - %
    figure
    subplot(1,2,1)
    b = bar(X(1:3),sum(Y(1:3,1:2),2),'FaceColor','flat');
    hold on
    errorbar(X(1:3),sum(Y(1:3,1:2),2),error_bar_modulated(1:3),error_bar_modulated(1:3),'k','linestyle','none');
    xticklabels({'40Hz','140Hz','1000Hz'});
    title('Comparing %modulated in CA1');

    subplot(1,2,2)
    b = bar(X(1:3),sum(Y(4:6,1:2),2),'FaceColor','flat');
    hold on
    errorbar(X(1:3),sum(Y(4:6,1:2),2),error_bar_modulated(4:6),error_bar_modulated(4:6),'k','linestyle','none');
    xticklabels({'40Hz','140Hz','1000Hz'});
    title('Comparing %modulated in M1');
    saveas(gcf,'neg_pos_bars_all_stacked_subplots.fig');
    
    % - Activated and deactivated - % 
    figure
    subplot(2,2,1);
    b = bar(X(1:3),Y(1:3,2),'FaceColor','flat');
    b.CData = red;
    hold on
    errorbar(X(1:3),Y(1:3,2),error_bar_act(1:3),'k','linestyle','none');
    yl = ylim;
    ylim([0,yl(2)]);
    xticklabels({'40Hz','140Hz','1000Hz'});
    title('Comparing %activated within CA1')
    
    subplot(2,2,2);
    b = bar(X(4:6),Y(4:6,2),'FaceColor','flat');
    b.CData = red;
    hold on
    errorbar(X(4:6),Y(4:6,2),error_bar_act(4:6),'k','linestyle','none');
    yl = ylim;
    ylim([0,yl(2)]);
    xticklabels({'40Hz','140Hz','1000Hz'});
    title('Comparing %activated within M1')

    subplot(2,2,3);
    b = bar(X(1:3),Y(1:3,1),'FaceColor','flat');
    b.CData = dark_blue;
    hold on
    errorbar(X(1:3),Y(1:3,1),error_bar_deact(1:3),'k','linestyle','none');
    yl = ylim;
    ylim([0,yl(2)]);
    xticklabels({'40Hz','140Hz','1000Hz'});
    title('Comparing %inhibited within CA1')
    
    subplot(2,2,4);
    b = bar(X(4:6),Y(4:6,1),'FaceColor','flat');
    b.CData = dark_blue;
    hold on
    errorbar(X(4:6),Y(4:6,1),error_bar_deact(4:6),'k','linestyle','none');
    yl = ylim;
    ylim([0,yl(2)]);
    xticklabels({'40Hz','140Hz','1000Hz'});
    title('Comparing %inhibited within M1')
    saveas(gcf,'neg_pos_bars_all_subplots.fig');
    %% pos/neg ratio session bar chart
        figure
    for i=1:6
      for j = 1:max(data{i,1}.neurons(:,1)) %Iterate through all sessions
            num_non(j) = sum(data{i,non}.neurons(:,1)==j);
            num_neg(j) = sum(data{i,neg}.neurons(:,1)==j); 
            num_pos(j) = sum(data{i,pos}.neurons(:,1)==j);
            total_count(j) = num_non(j) + num_neg(j) + num_pos(j);
       end
        bs = [(num_non./total_count)',(num_neg./total_count)',(num_pos./total_count)'];
        subplot(2,3,i)
        b=bar([1:length(num_pos)],bs,'stacked');
        b(1).FaceColor = grey;
        b(2).FaceColor = dark_blue;
        b(3).FaceColor = red;
        title([freq{i} 'Hz ' region{i}]);
        xlabel('Session'); ylabel('Percentage of total neurons');
        if i == 3
            legend({'Non-Mod neurons','Neg-Mod neurons','Pos-mod neurons'},'Location','NorthEastOutside');
        end
        clearvars num_non num_neg num_pos total_count
    end
    suptitle('Session-wise modulation ratio breakdown' );
    saveas(gcf,'neg_pos_non_bars_sess.fig');
    
    %% pos-neg count scatter plot for each session
    figure
    for i = 1:size(data,1)
        subplot(2,3,i)
        sess_num = [1:max(data{i,1}.neurons(:,1))];
        for j = 1:max(sess_num)
            num_neg(j) = sum(data{i,2}.neurons(:,1) == sess_num(j));
            num_pos(j) = sum(data{i,3}.neurons(:,1) == sess_num(j));
        end
        fit = polyfit(num_neg,num_pos,1);
        plot(num_neg,num_pos,'r.','MarkerSize',14);
        hold on
        yl = ylim; xl = xlim;
        lim = max([yl,xl]);
        xlim([0,lim]); ylim([0,lim]);
        plot(polyval(fit,[0:lim]),'k-');
        SStot = sum((num_pos-mean(num_pos)).^2);        % Total Sum-Of-Squares
        SSres = sum((num_pos-polyval(fit,num_neg)).^2); % Residual Sum-Of-Squares
        Rsq = 1-SSres/SStot;                            % R^2 
        line([0 lim],[0 lim],'Color','b');
        title([region{i} ' ' freq{i} 'Hz R^2 = ' num2str(Rsq)]);
        ylabel('# activated neurons');
        xlabel('# inhibited nuerons');
        if i == 3
            legend({'data','actual fit','1:1 fit'},'Location','NorthEastOutside');
        end
        clearvars num_neg num_pos
    end
    suptitle('Ratio of modulated neurons');
    saveas(gcf,'ratio_mod_neurons_sess_bkdown.fig');
end