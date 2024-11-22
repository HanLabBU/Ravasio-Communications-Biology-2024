% mod_ratio_sess_bkdwn.m
% Author: Cara
% Date: 09/18/23
% Purpose: Clean up main code pipeline. Make a scatter plot with a linear
% fit that shows the trned in ratio of neurons modulated across all
% sessions for a given condition. Use to prove that the ratios are more
% linear in the CA1 than the cortex

function mod_ratio_sess_bkdwn(non_mod_40_CA1, neg_mod_40_CA1, pos_mod_40_CA1,...
              non_mod_140_CA1, neg_mod_140_CA1, pos_mod_140_CA1,...
              non_mod_1000_CA1, neg_mod_1000_CA1, pos_mod_1000_CA1,...
              non_mod_40_M1, neg_mod_40_M1, pos_mod_40_M1,...
              non_mod_140_M1, neg_mod_140_M1, pos_mod_140_M1,...
              non_mod_1000_M1, neg_mod_1000_M1, pos_mod_1000_M1,colors)
% all modulation data is passed through. 
%
% data struct format: rows 1-3 = CA1 40-1k. rows 4-6 = M1 40-1k. 
% col 1 = non-mod, col 2 = neg-mod, col 3 = pos-mod.
%
% colors order: RGB values every row (3 cols). 40-1k CA1, 40-1k M1
%% Setup
    data = {non_mod_40_CA1, neg_mod_40_CA1, pos_mod_40_CA1,...
              non_mod_140_CA1, neg_mod_140_CA1, pos_mod_140_CA1,...
              non_mod_1000_CA1, neg_mod_1000_CA1, pos_mod_1000_CA1,...
              non_mod_40_M1, neg_mod_40_M1, pos_mod_40_M1,...
              non_mod_140_M1, neg_mod_140_M1, pos_mod_140_M1,...
              non_mod_1000_M1, neg_mod_1000_M1, pos_mod_1000_M1};
    freq = {'40','140','1000','40','140','1000'};
    region = {'CA1','CA1','CA1','M1','M1','M1'};
    
   
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
        plot(num_neg,num_pos,'.','MarkerColor',colors(i,:),'MarkerSize',10);
        hold on
        plot(polyval(fit,[0:max(num_neg)]),'k-');
        line([0 max([num_neg,num_pos])],[0 max([num_neg,num_pos])],'Color','b');
        title([region{i} ' ' freq{i} 'Hz']);
        ylabel('# activated neurons');
        xlabel('# inhibited nuerons');
        if i == 3
            legend({'data','actual fit','1:1 fit'},'Location','NorthEastOutside');
        end
    end
    suptitle('Ratio of modulated neurons');
    saveas(gcf,'ratio_mod_neurons_sess_bkdown.fig');
end