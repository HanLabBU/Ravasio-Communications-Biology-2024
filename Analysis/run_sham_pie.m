% run_sham_pie.m
% Author: Cara
% Date: 05/16/23
% Purpose: Clean up the sham pie chart creation in post-processing script

function run_sham_pie(pos_mod_sham_CA1, neg_mod_sham_CA1, non_mod_sham_CA1,...
                      rebound_sham_CA1,colors)
%% Setup colors and tables
%pie chart colors
grey = colors(1,:);
red = colors(2,:);
dark_blue = colors(3,:);
yellow = colors(4,:);

mod_ctrl = [numel(non_mod_sham_CA1.neurons(:,1)),numel(pos_mod_sham_CA1.neurons(:,1)),numel(neg_mod_sham_CA1.neurons(:,1))];
reb_ctrl = [sum(mod_ctrl)-numel(rebound_sham_CA1.neurons(:,1)),numel(rebound_sham_CA1.neurons(:,1))];

%% Creat Pie Charts
% Modulation
figure;
labels = {'non-modulated','positively modulated','negatively modulated'};
explode = [0,1,1];

hctrl = pie(mod_ctrl,explode);
title(sprintf(['Control ' '\n n=' num2str(sum(mod_ctrl))]))
patchHand = findobj(hctrl, 'Type', 'Patch');
patchHand(1).FaceColor = grey;
patchHand(2).FaceColor = red;
patchHand(3).FaceColor = dark_blue;

legend(labels);
saveas(gcf, 'mod_pie_chart_ctrl.fig');

% Rebound
figure;
labels = {'No rebound','Rebound'};
explode = [0,1];

hctrl = pie(reb_ctrl,explode);
title(sprintf(['Control ' '\n n=' num2str(sum(reb_ctrl))]))
patchHand = findobj(hctrl, 'Type', 'Patch');
patchHand(1).FaceColor = grey;
patchHand(2).FaceColor = yellow;

legend(labels);
saveas(gcf, 'reb_pie_chart_ctrl.fig');

end