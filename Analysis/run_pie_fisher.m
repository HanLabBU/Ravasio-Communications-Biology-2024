% run_pie_fisher.m
% Author: Cara
% Date: 05/16/23
% Purpose: Clean up and automate the pie chart and fisher test section of
% post-processing

function [h_fisher, p_fisher, stats_fisher] = run_pie_fisher(pos_mod_40_CA1,neg_mod_40_CA1,non_mod_40_CA1,rebound_40_CA1,...
                                                            pos_mod_140_CA1,neg_mod_140_CA1,non_mod_140_CA1,rebound_140_CA1,...
                                                            pos_mod_1000_CA1,neg_mod_1000_CA1,non_mod_1000_CA1,rebound_1000_CA1,...
                                                            pos_mod_40_M1,neg_mod_40_M1,non_mod_40_M1,rebound_40_M1,...
                                                            pos_mod_140_M1,neg_mod_140_M1,non_mod_140_M1,rebound_140_M1,...
                                                            pos_mod_1000_M1,neg_mod_1000_M1,non_mod_1000_M1,rebound_1000_M1,...
                                                            colors)
                                                        
%% Setup color palette
  grey = colors(1,:);
  red = colors(2,:);
  dark_blue = colors(3,:);
  yellow = colors(4,:);
 
%% Perform fisher test across and within regions
[h_fisher,p_fisher,stats_fisher] = mod_sig_fishertest(pos_mod_40_CA1,neg_mod_40_CA1,non_mod_40_CA1,rebound_40_CA1,...
                                                    pos_mod_140_CA1,neg_mod_140_CA1,non_mod_140_CA1,rebound_140_CA1,...
                                                    pos_mod_1000_CA1,neg_mod_1000_CA1,non_mod_1000_CA1,rebound_1000_CA1,...
                                                    pos_mod_40_M1,neg_mod_40_M1,non_mod_40_M1,rebound_40_M1,...
                                                    pos_mod_140_M1,neg_mod_140_M1,non_mod_140_M1,rebound_140_M1,...
                                                    pos_mod_1000_M1,neg_mod_1000_M1,non_mod_1000_M1,rebound_1000_M1);
%% Create Pie Charts    

%================================== CA1 ==================================%
region = 'CA1';
mod_40hz = [numel(non_mod_40_CA1.neurons(:,1)),numel(pos_mod_40_CA1.neurons(:,1)),numel(neg_mod_40_CA1.neurons(:,1))];
mod_140hz = [numel(non_mod_140_CA1.neurons(:,1)),numel(pos_mod_140_CA1.neurons(:,1)),numel(neg_mod_140_CA1.neurons(:,1))];
mod_1000hz = [numel(non_mod_1000_CA1.neurons(:,1)),numel(pos_mod_1000_CA1.neurons(:,1)),numel(neg_mod_1000_CA1.neurons(:,1))];

reb_40hz = [sum(mod_40hz)-numel(rebound_40_CA1.neurons(:,1)),numel(rebound_40_CA1.neurons(:,1))];
reb_140hz = [sum(mod_140hz)-numel(rebound_140_CA1.neurons(:,1)),numel(rebound_140_CA1.neurons(:,1))];
reb_1000hz = [sum(mod_1000hz)-numel(rebound_1000_CA1.neurons(:,1)),numel(rebound_1000_CA1.neurons(:,1))];

%- Non/Pos/Neg Modulation -%
figure;
labels = {'non-modulated','positively modulated','negatively modulated'};
explode = [0,1,1];
% Create pie charts
subplot(1,3,1);
h40 = pie(mod_40hz,explode);
title(sprintf(['40Hz ' region '\n n=' num2str(sum(mod_40hz))]))
patchHand = findobj(h40, 'Type', 'Patch');
patchHand(1).FaceColor = grey;
patchHand(2).FaceColor = red;
patchHand(3).FaceColor = dark_blue;

subplot(1,3,2);
h140 = pie(mod_140hz,explode);
title(sprintf(['140Hz ' region '\n n=' num2str(sum(mod_140hz))]))
patchHand = findobj(h140, 'Type', 'Patch'); 
patchHand(1).FaceColor = grey;
patchHand(2).FaceColor = red;
patchHand(3).FaceColor = dark_blue;


subplot(1,3,3);
h1k = pie(mod_1000hz,explode);
title(sprintf(['1000Hz ' region '\n n=' num2str(sum(mod_1000hz))]))
patchHand = findobj(h1k, 'Type', 'Patch');
patchHand(1).FaceColor = grey;
patchHand(2).FaceColor = red;
patchHand(3).FaceColor = dark_blue;

legend(labels);
lim_x = xlim; lim_y = ylim;
text(lim_x(1)-3,lim_y(1),['All Mod: ' num2str(p_fisher.hip.mod)])
text(lim_x(1)-3,lim_y(1)-1,['Pos: ' num2str(p_fisher.hip.pos)])
text(lim_x(1)-3,lim_y(1)-2,['Neg: ' num2str(p_fisher.hip.neg)])
saveas(gcf, sprintf(['mod_pie_chart_' region,'.fig']));

%- Rebound -%
figure;
labels = {'No rebound','Rebound'};
explode = [0,1];
% Create pie charts
subplot(1,3,1);
h40 = pie(reb_40hz,explode);
title(sprintf(['40Hz ' region '\n n=' num2str(sum(reb_40hz))]))
patchHand = findobj(h40, 'Type', 'Patch');
patchHand(1).FaceColor = grey;
patchHand(2).FaceColor = yellow;


subplot(1,3,2);
h140 = pie(reb_140hz,explode);
title(sprintf(['140Hz ' region '\n n=' num2str(sum(reb_140hz))]))
patchHand = findobj(h140, 'Type', 'Patch'); 
patchHand(1).FaceColor = grey;
patchHand(2).FaceColor = yellow;

subplot(1,3,3);
h1k = pie(reb_1000hz,explode);
title(sprintf(['1000Hz ' region '\n n=' num2str(sum(reb_1000hz))]))
patchHand = findobj(h1k, 'Type', 'Patch');
patchHand(1).FaceColor = grey;
patchHand(2).FaceColor = yellow;

legend(labels);
lim_x = xlim; lim_y = ylim;
text(lim_x(1)-3,lim_y(1)-1,['Significance: ' num2str(p_fisher.hip.reb)])
saveas(gcf, sprintf(['reb_pie_chart_' region,'.fig']));

%================================== M1 ==================================%
region = 'M1';
mod_40hz = [numel(non_mod_40_M1.neurons(:,1)),numel(pos_mod_40_M1.neurons(:,1)),numel(neg_mod_40_M1.neurons(:,1))];
mod_140hz = [numel(non_mod_140_M1.neurons(:,1)),numel(pos_mod_140_M1.neurons(:,1)),numel(neg_mod_140_M1.neurons(:,1))];
mod_1000hz = [numel(non_mod_1000_M1.neurons(:,1)),numel(pos_mod_1000_M1.neurons(:,1)),numel(neg_mod_1000_M1.neurons(:,1))];

reb_40hz = [sum(mod_40hz)-numel(rebound_40_M1.neurons(:,1)),numel(rebound_40_M1.neurons(:,1))];
reb_140hz = [sum(mod_140hz)-numel(rebound_140_M1.neurons(:,1)),numel(rebound_140_M1.neurons(:,1))];
reb_1000hz = [sum(mod_1000hz)-numel(rebound_1000_M1.neurons(:,1)),numel(rebound_1000_M1.neurons(:,1))];

%- Non/Pos/Neg Modulation -%
figure;
labels = {'non-modulated','positively modulated','negatively modulated'};
explode = [0,1,1];
% Create pie charts
subplot(1,3,1);
h40 = pie(mod_40hz,explode);
title(sprintf(['40Hz ' region '\n n=' num2str(sum(mod_40hz))]))
patchHand = findobj(h40, 'Type', 'Patch');
patchHand(1).FaceColor = grey;
patchHand(2).FaceColor = red;
patchHand(3).FaceColor = dark_blue;

subplot(1,3,2);
h140 = pie(mod_140hz,explode);
title(sprintf(['140Hz ' region '\n n=' num2str(sum(mod_140hz))]))
patchHand = findobj(h140, 'Type', 'Patch'); 
patchHand(1).FaceColor = grey;
patchHand(2).FaceColor = red;
patchHand(3).FaceColor = dark_blue;


subplot(1,3,3);
h1k = pie(mod_1000hz,explode);
title(sprintf(['1000Hz ' region '\n n=' num2str(sum(mod_1000hz))]))
patchHand = findobj(h1k, 'Type', 'Patch');
patchHand(1).FaceColor = grey;
patchHand(2).FaceColor = red;
patchHand(3).FaceColor = dark_blue;

legend(labels);
lim_x = xlim; lim_y = ylim;
text(lim_x(1)-3,lim_y(1),['All Mod: ' num2str(p_fisher.cort.mod)])
text(lim_x(1)-3,lim_y(1)-1,['Pos: ' num2str(p_fisher.cort.pos)])
text(lim_x(1)-3,lim_y(1)-2,['Neg: ' num2str(p_fisher.cort.neg)])
saveas(gcf, sprintf(['mod_pie_chart_' region,'.fig']));

%- Rebound -%
figure;
labels = {'No rebound','Rebound'};
explode = [0,1];
% Create pie charts
subplot(1,3,1);
h40 = pie(reb_40hz,explode);
title(sprintf(['40Hz ' region '\n n=' num2str(sum(reb_40hz))]))
patchHand = findobj(h40, 'Type', 'Patch');
patchHand(1).FaceColor = grey;
patchHand(2).FaceColor = yellow;


subplot(1,3,2);
h140 = pie(reb_140hz,explode);
title(sprintf(['140Hz ' region '\n n=' num2str(sum(reb_140hz))]))
patchHand = findobj(h140, 'Type', 'Patch'); 
patchHand(1).FaceColor = grey;
patchHand(2).FaceColor = yellow;

subplot(1,3,3);
h1k = pie(reb_1000hz,explode);
title(sprintf(['1000Hz ' region '\n n=' num2str(sum(reb_1000hz))]))
patchHand = findobj(h1k, 'Type', 'Patch');
patchHand(1).FaceColor = grey;
patchHand(2).FaceColor = yellow;

legend(labels);
lim_x = xlim; lim_y = ylim;
text(lim_x(1)-3,lim_y(1)-1,['Significance: ' num2str(p_fisher.cort.reb)])
saveas(gcf, sprintf(['reb_pie_chart_' region,'.fig']));
end