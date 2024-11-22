% generate_mod_heatmaps.m
% Author: Cara
% Date: 05/16/23
% Purpose: Clean up the heatmap generation section of my postprocessing
% code

function generate_mod_heatmaps(pos_mod, neg_mod, rebound, freq, region, Fs)
% send in frequency and region specific pos and neg mod structs
% freq is a number (eg. 40, 140, 1000)
% region is a str (eg. 'CA1', 'M1')

std_colors = colormap('parula');
%========================= 40Hz Heatmaps ==================================%
% Positive Modulation
num_recordings = numel(unique(pos_mod.neurons(:,1)));
num_neurons = size(pos_mod.neurons,1);
end_frame = 5+5; % sort using 5 seconds after onset and 
start_frame = 5-2; % 2 seconds before onset
postSum = sum(pos_mod.traces(:,5*Fs+1:end_frame*Fs),2);
preSum = sum(pos_mod.traces(:, start_frame*Fs:5*Fs),2);   

[~,sortIdx] = sort(postSum-preSum);
pos_mod_traces_plot = pos_mod.traces(sortIdx,:);

heatmap_Cara(pos_mod_traces_plot,num_recordings, Fs,std_colors,...
    ['Pos-Mod ' num2str(freq) 'Hz Heatmap ',region,' (Scaled)'], ...
    ['pos_mod_' num2str(freq) '_' region '_heatmap.fig']);

% Negative Modulation
num_recordings = numel(unique(neg_mod.neurons(:,1)));
num_neurons = size(neg_mod.neurons,1);
end_frame = 5+5; % sort using 5 seconds after onset and 
start_frame = 5-2; % 2 seconds before onset
postSum = sum(neg_mod.traces(:,5*Fs+1:end_frame*Fs),2);
preSum = sum(neg_mod.traces(:, start_frame*Fs:5*Fs),2);   

[~,sortIdx] = sort(postSum-preSum);
neg_mod_traces_plot = neg_mod.traces(sortIdx,:);

heatmap_Cara(neg_mod_traces_plot,num_recordings,Fs,std_colors,...
    ['Neg-Mod ' num2str(freq) 'Hz Heatmap ',region,' (Scaled)'], ...
    ['neg_mod_' num2str(freq) '_' region '_heatmap.fig']);

% Rebound
num_recordings = numel(unique(rebound.neurons(:,1)));
num_neurons = size(rebound.neurons,1);
end_frame = 5+5; % sort using 5 seconds after onset and 
start_frame = 5-2; % 2 seconds before onset
postSum = sum(rebound.traces(:,5*Fs+1:end_frame*Fs),2);
preSum = sum(rebound.traces(:, start_frame*Fs:5*Fs),2);   

[~,sortIdx] = sort(postSum-preSum);
rebound_traces_plot = rebound.traces(sortIdx,:);

heatmap_Cara(rebound_traces_plot,num_recordings,Fs,std_colors,...
    ['Rebound ' num2str(freq) ' Heatmap ',region,' (Scaled)'], ...
    ['rebound_' num2str(freq) '_' region 'heatmap.fig']);
end