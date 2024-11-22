% all_neuron_heatmaps.m
% Author: Cara
% Date: 06/07/23
% Purpose: Generate heatmaps in the blue, white, red colorscale. Sort
% heatmap so that pos mod traces are on top, neg mod traces are on bottom,
% and moiddle is spectrum in between. Horizontal lines denote cutoff for pos and neg
% mod.
function all_neuron_heatmaps(pos_mod, non_mod, neg_mod, freq, region)
% Setup
Fs = 20;
div_colors = cbrewer('div','RdBu',100);
div_colors = div_colors(end:-1:1,:); %flip so blue-->neg mod, red-->pos mod
avg_trace_plot = [];
num_recordings = max([max(pos_mod.neurons(:,1)), max(neg_mod.neurons(:,1)),max(non_mod.neurons(:,1))]);
num_frames = 20*Fs;
num_pos_neurons = size(pos_mod.neurons,1);
num_neg_neurons = size(neg_mod.neurons,1);
num_non_neurons = size(non_mod.neurons,1);
num_neurons = num_pos_neurons + num_neg_neurons + num_non_neurons;
whitespace = ceil(0.03*num_neurons); 

%sort neurons in each modulation identity by df/f pre vs post, then
%concatenate in array for plotting (pos mod on top, non mod in middle, neg
%mod bottom)
end_frame = 5+5; % sort using 5 seconds after onset and 
start_frame = 5-2; % 2 seconds before onset
postSum_pos = sum(pos_mod.traces(:,5*Fs+1:end_frame*Fs),2);
preSum_pos = sum(pos_mod.traces(:, start_frame*Fs:5*Fs),2);
postSum_neg = sum(neg_mod.traces(:,5*Fs+1:end_frame*Fs),2);
preSum_neg = sum(neg_mod.traces(:, start_frame*Fs:5*Fs),2);
postSum_non = sum(non_mod.traces(:,5*Fs+1:end_frame*Fs),2);
preSum_non = sum(non_mod.traces(:, start_frame*Fs:5*Fs),2);

% Sort
[~,sortIdx] = sort(postSum_pos-preSum_pos);
avg_trace_plot = vertcat(avg_trace_plot,flip(pos_mod.traces(sortIdx,:)));
avg_trace_plot = vertcat(avg_trace_plot,zeros(whitespace,400)); %Add 100 neurons worth of white space for an offset

[~,sortIdx] = sort(postSum_non-preSum_non);
avg_trace_plot = vertcat(avg_trace_plot,flip(non_mod.traces(sortIdx,:)));
avg_trace_plot = vertcat(avg_trace_plot,zeros(whitespace,400)); %Add 100 neurons worth of white space for an offset

[~,sortIdx] = sort(postSum_neg-preSum_neg);
avg_trace_plot = vertcat(avg_trace_plot,flip(neg_mod.traces(sortIdx,:)));

%Plot heatmap
figure('units','normalized','outerposition',[0 0 1 1])
imagesc(avg_trace_plot);
hold on
xline(5*Fs,'Color','black','linewidth',1.5) %Stim onset
xline(10*Fs,'Color','black','linewidth',1.5) %Stim offset
yline(num_pos_neurons,'Color','black','linewidth',1.5) %Pos mod cutoff
yline(num_neurons+2*whitespace-num_neg_neurons,'Color','black','linewidth',1.5) %Neg mod cutoff
yline(num_pos_neurons+whitespace,'Color','black','linewidth',1.5) %non mod start
yline(num_pos_neurons+whitespace+num_non_neurons,'Color','black','linewidth',1.5) %Non mod cutoff
ylabel('cell')
set(gca,'XTick',[0:Fs:num_frames],'XTickLabel',[0:1:20],...
    'YTick',[1:floor(num_pos_neurons/2):num_pos_neurons,... 
            num_pos_neurons+whitespace:floor(num_non_neurons)/2:num_non_neurons+num_pos_neurons+whitespace,...
            num_pos_neurons+num_non_neurons+2*whitespace:floor(num_neg_neurons)/2:num_neurons+2*whitespace],...
            'YTickLabel',[1:floor(num_pos_neurons/2):num_pos_neurons,...
                          1:floor(num_non_neurons/2):num_non_neurons,...
                          1:floor(num_neg_neurons/2):num_neg_neurons]);
xlabel('Time (s)')
title([num2str(freq), 'Hz ', region,' (',...
    num2str(num_neurons), ' Neurons, ', ...
    num2str(num_recordings), ' Sessions)']);
colormap(div_colors);
colorbar
caxis([-0.25 0.25]);

%Save figure
saveas(gcf, ['full_heatmap_' num2str(freq) 'Hz_' region '.fig']);

end




























