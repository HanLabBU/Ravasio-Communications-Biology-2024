% gcamp_postprocess_clean.m
% Author: Cara R
% Date: 09/07/22
% Purpose: Final version of the post-processing meta-analysis code for the
% GCaMP DBS data. Does not have any of the unnecessary filler parts of the
% code. Just the essential figure making steps.

%% Setup
addpath(genpath('~/handata_server/Cara_Ravasio/Code/GCaMP_Data_Extraction'));
base_path = '~/handata_server/Cara_Ravasio/Data/GCaMP_Data_Extraction/Hippocampus/Good_Recordings_Data_Files'; %/media/hanlabadmins/Elements/DBS/Hippocampus/GCaMP';
cd(base_path);
region = 'CA1';

Fs = 20; %Hz, 20Hz recordings
num_frames = 400; %20s at 20Hz frame rate

%Setting up color scheme for figures (Colorblind friendly) (?)
white = [255 255 255]/255;
purple = [0.494,0.184,0.556];%[197 28 124]/255;%[136 26 88]/255; %40Hz
orange = [0.85,0.325,0.098];%[249 81 8]/255;%[165 54 6]/255; %140Hz
blue = [0, 0.447,0.741];%[57 150 191]/255;%[22 76 100]/255; %100Hz
length = 200; % the number of color steps included in the colormap

colormap_40 = [linspace(white(1),purple(1), length)',linspace(white(2),purple(2), length)',linspace(white(3),purple(3), length)'];
colormap_140 = [linspace(white(1),orange(1), length)',linspace(white(2),orange(2), length)',linspace(white(3),orange(3), length)'];
colormap_1000 = [linspace(white(1),blue(1), length)',linspace(white(2),blue(2), length)',linspace(white(3),blue(3), length)'];

if strcmp(region,'CA1')
    color_40 = purple;
    color_140 = orange;
    color_1000 = blue;
else
    color_40 = colormap_40(length/2,:);
    color_140 = colormap_140(length/2,:);
    color_1000 = colormap_1000(length/2,:);
end

%pie chart colors
red = [204 0 0]/255;
grey = [220 219 219]/255;
dark_blue = [22 83 126]/255;
yellow = [255 191 0]/255;

%% Load all the good roi_data files
% These files all should have been manually moved into the 
% Good_Recordings_Data_Files directory.
%========================= Load 40Hz Files ===============================%
try
    load(['./data40_' region '.mat']);
catch
    cd([base_path '/40Hz'])
    files_40 = dir(fullfile(pwd, '*.mat'));
    for i=1:numel(files_40)
        load(files_40(i).name);
        data40(i).roi_data = roi_data;
        data40(i).name = files_40(i).name;    
    end
    save([base_path,sprintf(['/data40_' region '.mat'])],'data40');
end
%=========================================================================%

%======================== Load 140Hz Files ===============================%
try
    load(['./data140_' region '.mat']);
catch
    cd([base_path '/140Hz'])
    files_140 = dir(fullfile(pwd, '*.mat'));
    for i=1:numel(files_140)
        load(files_140(i).name);
        data140(i).roi_data = roi_data;
        data140(i).name = files_140(i).name;    
    end
    save([base_path,sprintf(['/data140_' region '.mat'])],'data140','-v7.3'); %Use '-v7.3' because data140_CA1 is to large
end
%=========================================================================%

%======================== Load 1000Hz Files ==============================%
try
    load(['./data1000_' region '.mat']);
catch
    cd([base_path '/1000Hz'])
    files_1000 = dir(fullfile(pwd, '*.mat'));
    for i=1:numel(files_1000)
        load(files_1000(i).name);
        data1000(i).roi_data = roi_data;
        data1000(i).name = files_1000(i).name;    
    end
    save([base_path,sprintf(['/data1000_' region '.mat'])],'data1000','-v7.3');
end
%=========================================================================%
cd(base_path)

%% Make a vectors of only the good cells from each recording (Scaled and Unscaled)
% Construct matrix of all good 40Hz neurons
good_40Hz_cells = []; good_40Hz_cells_scaled = [];
for i=1:numel(data40)
    goodCellsTemp = data40(i).roi_data.goodIdx;
    good_40Hz_cells = [good_40Hz_cells; data40(i).roi_data.avg_trace_minusBG_new(goodCellsTemp,:)];
    good_40Hz_cells_scaled = [good_40Hz_cells_scaled; data40(i).roi_data.avg_trace_minusBG_new_scaled(goodCellsTemp,:)-repmat(mean(data40(i).roi_data.avg_trace_minusBG_new_scaled(goodCellsTemp,2:5*Fs-1),2),1,num_frames)];
end

% Construct matrix of all good 140Hz neurons
good_140Hz_cells = []; good_140Hz_cells_scaled = [];
for i=1:numel(data140)
    goodCellsTemp = data140(i).roi_data.goodIdx;
    good_140Hz_cells = [good_140Hz_cells; data140(i).roi_data.avg_trace_minusBG_new(goodCellsTemp,:)];
    good_140Hz_cells_scaled = [good_140Hz_cells_scaled; data140(i).roi_data.avg_trace_minusBG_new_scaled(goodCellsTemp,:)-repmat(mean(data140(i).roi_data.avg_trace_minusBG_new_scaled(goodCellsTemp,2:5*Fs-1),2),1,num_frames)];
end

% Construct matrix of all good 1000Hz neurons
good_1000Hz_cells = []; good_1000Hz_cells_scaled = [];
for i=1:numel(data1000)
    goodCellsTemp = data1000(i).roi_data.goodIdx;
    good_1000Hz_cells = [good_1000Hz_cells; data1000(i).roi_data.avg_trace_minusBG_new(goodCellsTemp,:)];
    good_1000Hz_cells_scaled = [good_1000Hz_cells_scaled; data1000(i).roi_data.avg_trace_minusBG_new_scaled(goodCellsTemp,:)-repmat(mean(data1000(i).roi_data.avg_trace_minusBG_new_scaled(goodCellsTemp,2:5*Fs-1),2),1,num_frames)];
end

%% Generate heatmaps (stim period avg - prestim avg 3-5s (2s total)) (scaled)
div_colors = cbrewer('div','RdBu',100);
div_colors = div_colors(end:-1:1,:); %flip so blue-->neg mod, red-->pos mod
%========================= 40Hz Heatmap ==================================%
num_recordings = numel(data40);
%Heatmap generation
end_frame = 5+5; % sort using 5 seconds after onset and 
start_frame = 5-2; % 2 seconds before onset
postSum = sum(good_40Hz_cells_scaled(:,5*Fs+1:end_frame*Fs),2);
preSum = sum(good_40Hz_cells_scaled(:, start_frame*Fs:5*Fs),2);   

[~,sortIdx] = sort(postSum-preSum);
avg_40Hz_trace_minusBG_new_plot = good_40Hz_cells_scaled(sortIdx,:);

heatmap_Cara(avg_40Hz_trace_minusBG_new_plot,num_recordings,Fs,div_colors,...
    'Average 40Hz Heatmap (Scaled)', ...
    'Avg_40Hz_Heatmap_scaled.fig');

%=========================================================================%

%========================= 140Hz Heatmap =================================%
num_recordings = numel(data140);
%Heatmap generation
end_frame = 5+5; % sort using 5 seconds after onset and 
start_frame = 5-2; % 2 seconds before onset
postSum = sum(good_140Hz_cells_scaled(:,5*Fs+1:end_frame*Fs),2);
preSum = sum(good_140Hz_cells_scaled(:, start_frame*Fs:5*Fs),2);   

[~,sortIdx] = sort(postSum-preSum);
avg_140Hz_trace_minusBG_new_plot = good_140Hz_cells_scaled(sortIdx,:);

heatmap_Cara(avg_140Hz_trace_minusBG_new_plot,num_recordings,Fs,div_colors,...
    'Average 140Hz Heatmap (Scaled)', ...
    'Avg_140Hz_Heatmap_scaled.fig');

%=========================================================================%

%======================== 1000Hz Heatmap =================================%
num_recordings = numel(data1000);
%Heatmap generation
end_frame = 5+5; % sort using 5 seconds after onset and 
start_frame = 5-2; % 2 seconds before onset
postSum = sum(good_1000Hz_cells_scaled(:,5*Fs+1:end_frame*Fs),2);
preSum = sum(good_1000Hz_cells_scaled(:, start_frame*Fs:5*Fs),2);   

[~,sortIdx] = sort(postSum-preSum);
avg_1000Hz_trace_minusBG_new_plot = good_1000Hz_cells_scaled(sortIdx,:);

heatmap_Cara(avg_1000Hz_trace_minusBG_new_plot,num_recordings,Fs,div_colors,...
    'Average 1000Hz Heatmap (Scaled)', ...
    'Avg_1000Hz_Heatmap_scaled.fig');

%=========================================================================%

%% Wilcoxon Ranksum and Z-test for waveform classification
%=============================== 40 Hz ===================================%
%Each Recording's average separately (_s means scaled)
for i=1:numel(data40)
    %Each Neuron' average separately
    [stats_40{i},z_40{i}]= stats_gcamp_DBS(data40(i).roi_data.avg_trace_minusBG_new(data40(i).roi_data.goodIdx,:),data40(i).roi_data.trace_minusBG_new_DN_reshaped(data40(i).roi_data.goodIdx,:,:),Fs);
    [stats_40_s{i},z_40_s{i}]= stats_gcamp_DBS(data40(i).roi_data.avg_trace_minusBG_new_scaled(data40(i).roi_data.goodIdx,:),data40(i).roi_data.trace_minusBG_new_DN_reshaped_scaled(data40(i).roi_data.goodIdx,:,:),Fs);

end

%=============================== 140 Hz ==================================%
%Each Recording's average separately (_s means scaled)
for i=1:numel(data140)
    %Each Neuron' average separately
    [stats_140{i},z_140{i}]= stats_gcamp_DBS(data140(i).roi_data.avg_trace_minusBG_new(data140(i).roi_data.goodIdx,:),data140(i).roi_data.trace_minusBG_new_DN_reshaped(data140(i).roi_data.goodIdx,:,:),Fs);
    [stats_140_s{i},z_140_s{i}]= stats_gcamp_DBS(data140(i).roi_data.avg_trace_minusBG_new_scaled(data140(i).roi_data.goodIdx,:),data140(i).roi_data.trace_minusBG_new_DN_reshaped_scaled(data140(i).roi_data.goodIdx,:,:),Fs);
end

%============================== 1000 Hz ==================================%
%Each Recording's average separately (_s means scaled)
for i=1:numel(data1000)
    %Each Neuron' average separately
    [stats_1000{i},z_1000{i}]= stats_gcamp_DBS(data1000(i).roi_data.avg_trace_minusBG_new(data1000(i).roi_data.goodIdx,:),data1000(i).roi_data.trace_minusBG_new_DN_reshaped(data1000(i).roi_data.goodIdx,:,:),Fs);
    [stats_1000_s{i},z_1000_s{i}]= stats_gcamp_DBS(data1000(i).roi_data.avg_trace_minusBG_new_scaled(data1000(i).roi_data.goodIdx,:),data1000(i).roi_data.trace_minusBG_new_DN_reshaped_scaled(data1000(i).roi_data.goodIdx,:,:),Fs);

end

%% Waveform classification separation
%Each Recording's average separately (_s means scaled)
%================================ 40Hz ===================================%
%positive_modulation
pos_mod_40_s = DBS_modulation_check(z_40_s,40,1,1,Fs); %inputs: data,freq, flag, sampling_freq
save('pos_mod_40_struct_s.mat','pos_mod_40_s');
%non_modulation
non_mod_40_s = DBS_modulation_check(z_40_s,40,0,1,Fs);
save('non_mod_40_struct_s.mat','non_mod_40_s');
%negative_modulation
neg_mod_40_s = DBS_modulation_check(z_40_s,40,-1,1,Fs);
save('neg_mod_40_struct_s.mat','neg_mod_40_s');
%rebound
rebound_40_s = DBS_modulation_check(z_40_s,40,2,1,Fs);
save('rebound_40_struct_s.mat','rebound_40_s');

%=============================== 140Hz ===================================%
%positive_modulation
pos_mod_140_s = DBS_modulation_check(z_140_s,140,1,1,Fs); %inputs: data,freq, flag, sampling_freq
save('pos_mod_140_struct_s.mat','pos_mod_140_s');
%non_modulation
non_mod_140_s = DBS_modulation_check(z_140_s,140,0,1,Fs);
save('non_mod_140_struct_s.mat','non_mod_140_s');
%negative_modulation
neg_mod_140_s = DBS_modulation_check(z_140_s,140,-1,1,Fs);
save('neg_mod_140_struct_s.mat','neg_mod_140_s');
%rebound
rebound_140_s = DBS_modulation_check(z_140_s,140,2,1,Fs);
save('rebound_140_struct_s.mat','rebound_140_s');

%============================== 1000Hz ===================================%
%positive_modulation
pos_mod_1000_s = DBS_modulation_check(z_1000_s,1000,1,1,Fs); %inputs: data,freq, flag, sampling_freq
save('pos_mod_1000_struct_s.mat','pos_mod_1000_s');
%non_modulation
non_mod_1000_s = DBS_modulation_check(z_1000_s,1000,0,1,Fs);
save('non_mod_1000_struct_s.mat','non_mod_1000_s');
%negative_modulation
neg_mod_1000_s = DBS_modulation_check(z_1000_s,1000,-1,1,Fs);
save('neg_mod_1000_struct_s.mat','neg_mod_1000_s');
%rebound
rebound_1000_s = DBS_modulation_check(z_1000_s,1000,2,1,Fs);
save('rebound_1000_struct_s.mat','rebound_1000_s');

%% Mean +/- SEM graphs
colors = [color_40',color_140',color_1000'];
avg_trace_plusMinus_SEM(pos_mod_40_s, pos_mod_140_s, pos_mod_1000_s,'Scaled Pos', region,0, 20,colors);
avg_trace_plusMinus_SEM(non_mod_40_s, non_mod_140_s, non_mod_1000_s,'Scaled Non', region,0, 20,colors);
avg_trace_plusMinus_SEM(neg_mod_40_s, neg_mod_140_s, neg_mod_1000_s,'Scaled Neg', region,0, 20,colors);
avg_trace_plusMinus_SEM(rebound_40_s, rebound_140_s, rebound_1000_s,'Scaled Rebound', region,1,20,colors);

%% Generate Heatmaps using just modulated traces (Scaled)
std_colors = colormap('parula');
%========================= 40Hz Heatmaps ==================================%
% Positive Modulation
num_recordings = numel(unique(pos_mod_40_s.neurons(:,1)));
num_neurons = size(pos_mod_40_s.neurons,1);
end_frame = 5+5; % sort using 5 seconds after onset and 
start_frame = 5-2; % 2 seconds before onset
postSum = sum(pos_mod_40_s.traces(:,5*Fs+1:end_frame*Fs),2);
preSum = sum(pos_mod_40_s.traces(:, start_frame*Fs:5*Fs),2);   

[~,sortIdx] = sort(postSum-preSum);
pos_mod_40_s_traces_plot = pos_mod_40_s.traces(sortIdx,:);

heatmap_Cara(pos_mod_40_s_traces_plot,num_recordings, Fs,std_colors,...
    ['Pos-Mod 40Hz Heatmap ',region,' (Scaled)'], ...
    'pos_mod_40_s_heatmap.fig');

% Negative Modulation
num_recordings = numel(unique(neg_mod_40_s.neurons(:,1)));
num_neurons = size(neg_mod_40_s.neurons,1);
end_frame = 5+5; % sort using 5 seconds after onset and 
start_frame = 5-2; % 2 seconds before onset
postSum = sum(neg_mod_40_s.traces(:,5*Fs+1:end_frame*Fs),2);
preSum = sum(neg_mod_40_s.traces(:, start_frame*Fs:5*Fs),2);   

[~,sortIdx] = sort(postSum-preSum);
neg_mod_40_s_traces_plot = neg_mod_40_s.traces(sortIdx,:);

heatmap_Cara(neg_mod_40_s_traces_plot,num_recordings,Fs,std_colors,...
    ['Neg-Mod 40Hz Heatmap ',region,' (Scaled)'], ...
    'neg_mod_40_s_heatmap.fig');

% Rebound
num_recordings = numel(unique(rebound_40_s.neurons(:,1)));
num_neurons = size(rebound_40_s.neurons,1);
end_frame = 5+5; % sort using 5 seconds after onset and 
start_frame = 5-2; % 2 seconds before onset
postSum = sum(rebound_40_s.traces(:,5*Fs+1:end_frame*Fs),2);
preSum = sum(rebound_40_s.traces(:, start_frame*Fs:5*Fs),2);   

[~,sortIdx] = sort(postSum-preSum);
rebound_40_s_traces_plot = rebound_40_s.traces(sortIdx,:);

heatmap_Cara(rebound_40_s_traces_plot,num_recordings,Fs,std_colors,...
    ['Rebound 40Hz Heatmap ',region,' (Scaled)'], ...
    'rebound_40_s_heatmap.fig');

%========================= 140Hz Heatmap =================================%
% Positive Modulation
num_recordings = numel(unique(pos_mod_140_s.neurons(:,1)));
num_neurons = size(pos_mod_140_s.neurons,1);
end_frame = 5+5; % sort using 5 seconds after onset and 
start_frame = 5-2; % 2 seconds before onset
postSum = sum(pos_mod_140_s.traces(:,5*Fs+1:end_frame*Fs),2);
preSum = sum(pos_mod_140_s.traces(:, start_frame*Fs:5*Fs),2);   

[~,sortIdx] = sort(postSum-preSum);
pos_mod_140_s_traces_plot = pos_mod_140_s.traces(sortIdx,:);

heatmap_Cara(pos_mod_140_s_traces_plot,num_recordings,Fs,std_colors,...
    ['Pos-Mod 140Hz Heatmap ',region,' (Scaled)'], ...
    'pos_mod_140_s_heatmap.fig');

% Negative Modulation
num_recordings = numel(unique(neg_mod_140_s.neurons(:,1)));
num_neurons = size(neg_mod_140_s.neurons,1);
end_frame = 5+5; % sort using 5 seconds after onset and 
start_frame = 5-2; % 2 seconds before onset
postSum = sum(neg_mod_140_s.traces(:,5*Fs+1:end_frame*Fs),2);
preSum = sum(neg_mod_140_s.traces(:, start_frame*Fs:5*Fs),2);   

[~,sortIdx] = sort(postSum-preSum);
neg_mod_140_s_traces_plot = neg_mod_140_s.traces(sortIdx,:);

heatmap_Cara(neg_mod_140_s_traces_plot,num_recordings,Fs,std_colors,...
    ['Neg-Mod 140Hz Heatmap ',region,' (Scaled)'], ...
    'neg_mod_140_s_heatmap.fig');

% Rebound
num_recordings = numel(unique(rebound_140_s.neurons(:,1)));
num_neurons = size(rebound_140_s.neurons,1);
end_frame = 5+5; % sort using 5 seconds after onset and 
start_frame = 5-2; % 2 seconds before onset
postSum = sum(rebound_140_s.traces(:,5*Fs+1:end_frame*Fs),2);
preSum = sum(rebound_140_s.traces(:, start_frame*Fs:5*Fs),2);   

[~,sortIdx] = sort(postSum-preSum);
rebound_140_s_traces_plot = rebound_140_s.traces(sortIdx,:);

heatmap_Cara(rebound_140_s_traces_plot,num_recordings,Fs,std_colors,...
    ['Rebound 140Hz Heatmap ',region,' (Scaled)'], ...
    'rebound_140_s_heatmap.fig');

%========================= 1000Hz Heatmap ================================%
% Positive Modulation
num_recordings = numel(unique(pos_mod_1000_s.neurons(:,1)));
num_neurons = size(pos_mod_1000_s.neurons,1);
end_frame = 5+5; % sort using 5 seconds after onset and 
start_frame = 5-2; % 2 seconds before onset
postSum = sum(pos_mod_1000_s.traces(:,5*Fs+1:end_frame*Fs),2);
preSum = sum(pos_mod_1000_s.traces(:, start_frame*Fs:5*Fs),2);   

[~,sortIdx] = sort(postSum-preSum);
pos_mod_1000_s_traces_plot = pos_mod_1000_s.traces(sortIdx,:);

heatmap_Cara(pos_mod_1000_s_traces_plot,num_recordings,Fs,std_colors,...
    ['Pos-Mod 1000Hz Heatmap ',region,' (Scaled)'], ...
    'pos_mod_1000_s_heatmap.fig');

% Negative Modulation
num_recordings = numel(unique(neg_mod_1000_s.neurons(:,1)));
num_neurons = size(neg_mod_1000_s.neurons,1);
end_frame = 5+5; % sort using 5 seconds after onset and 
start_frame = 5-2; % 2 seconds before onset
postSum = sum(neg_mod_1000_s.traces(:,5*Fs+1:end_frame*Fs),2);
preSum = sum(neg_mod_1000_s.traces(:, start_frame*Fs:5*Fs),2);   

[~,sortIdx] = sort(postSum-preSum);
neg_mod_1000_s_traces_plot = neg_mod_1000_s.traces(sortIdx,:);

heatmap_Cara(neg_mod_1000_s_traces_plot,num_recordings,Fs,std_colors,...
    ['Neg-Mod 1000Hz Heatmap ',region,' (Scaled)'], ...
    'neg_mod_1000_s_heatmap.fig');

% Rebound
num_recordings = numel(unique(rebound_1000_s.neurons(:,1)));
num_neurons = size(rebound_1000_s.neurons,1);
end_frame = 5+5; % sort using 5 seconds after onset and 
start_frame = 5-2; % 2 seconds before onset
postSum = sum(rebound_1000_s.traces(:,5*Fs+1:end_frame*Fs),2);
preSum = sum(rebound_1000_s.traces(:, start_frame*Fs:5*Fs),2);   

[~,sortIdx] = sort(postSum-preSum);
rebound_1000_s_traces_plot = rebound_1000_s.traces(sortIdx,:);

heatmap_Cara(rebound_1000_s_traces_plot,num_recordings,Fs,std_colors,...
    ['Rebound 1000Hz Heatmap ',region,' (Scaled)'], ...
    'rebound_1000_s_heatmap.fig');
%% Modulated neuron Pie charts + Fisher's Test
mod_40hz = [numel(non_mod_40_s.neurons(:,1)),numel(pos_mod_40_s.neurons(:,1)),numel(neg_mod_40_s.neurons(:,1))];
mod_140hz = [numel(non_mod_140_s.neurons(:,1)),numel(pos_mod_140_s.neurons(:,1)),numel(neg_mod_140_s.neurons(:,1))];
mod_1000hz = [numel(non_mod_1000_s.neurons(:,1)),numel(pos_mod_1000_s.neurons(:,1)),numel(neg_mod_1000_s.neurons(:,1))];

reb_40hz = [sum(mod_40hz)-numel(rebound_40_s.neurons(:,1)),numel(rebound_40_s.neurons(:,1))];
reb_140hz = [sum(mod_140hz)-numel(rebound_140_s.neurons(:,1)),numel(rebound_140_s.neurons(:,1))];
reb_1000hz = [sum(mod_1000hz)-numel(rebound_1000_s.neurons(:,1)),numel(rebound_1000_s.neurons(:,1))];

% The sub divided rebound information
load([base_path, '/non_reb_40_s.mat'])
load([base_path, '/non_reb_140_s.mat'])
load([base_path, '/non_reb_1000_s.mat'])
load([base_path, '/neg_reb_40_s.mat'])
load([base_path, '/neg_reb_140_s.mat'])
load([base_path, '/neg_reb_1000_s.mat'])
reb_sub_40hz = [sum(mod_40hz)-numel(rebound_40_s.neurons(:,1)),numel(neg_reb_40_s.neurons(:,1)), numel(non_reb_40_s.neurons(:,1))];
reb_sub_140hz = [sum(mod_140hz)-numel(rebound_140_s.neurons(:,1)),numel(neg_reb_140_s.neurons(:,1)), numel(non_reb_140_s.neurons(:,1))];
reb_sub_1000hz = [sum(mod_1000hz)-numel(rebound_1000_s.neurons(:,1)),numel(neg_reb_1000_s.neurons(:,1)), numel(non_reb_1000_s.neurons(:,1))];

% ========================= Fisher's Exact Test ==========================%
%All modulated vs nonmodulated
fisher_table.mod(:,:,1) = [mod_40hz(3)+mod_40hz(2), mod_40hz(1);mod_140hz(3)+mod_140hz(2), mod_140hz(1)];
fisher_table.mod(:,:,2) = [mod_40hz(3)+mod_40hz(2), mod_40hz(1);mod_1000hz(3)+mod_1000hz(2), mod_1000hz(1)];
fisher_table.mod(:,:,3) = [mod_140hz(3)+mod_140hz(2), mod_140hz(1);mod_1000hz(3)+mod_1000hz(2), mod_1000hz(1)];

%Positive vs not positively modulated
fisher_table.pos(:,:,1) = [mod_40hz(2), mod_40hz(1)+mod_40hz(3);mod_140hz(2), mod_140hz(1)+mod_140hz(3)];
fisher_table.pos(:,:,2) = [mod_40hz(2), mod_40hz(1)+mod_40hz(3);mod_1000hz(2), mod_1000hz(1)+mod_1000hz(3)];
fisher_table.pos(:,:,3) = [mod_140hz(2), mod_140hz(1)+mod_140hz(3);mod_1000hz(2), mod_1000hz(1)+mod_1000hz(3)];

%Negative vs not negatively modulated
fisher_table.neg(:,:,1) = [mod_40hz(3), mod_40hz(2)+mod_40hz(1);mod_140hz(3), mod_140hz(2)+mod_140hz(1)];
fisher_table.neg(:,:,2) = [mod_40hz(3), mod_40hz(2)+mod_40hz(1);mod_1000hz(3), mod_1000hz(2)+mod_1000hz(1)];
fisher_table.neg(:,:,3) = [mod_140hz(3), mod_140hz(2)+mod_140hz(1);mod_1000hz(3), mod_1000hz(2)+mod_1000hz(1)];

%Rebound vs no rebound
fisher_table.reb(:,:,1) = [reb_40hz(2), reb_40hz(1); reb_140hz(2), reb_140hz(1)];
fisher_table.reb(:,:,2) = [reb_40hz(2), reb_40hz(1);reb_1000hz(2), reb_1000hz(1)];
fisher_table.reb(:,:,3) = [reb_140hz(2), reb_140hz(1);reb_1000hz(2), reb_1000hz(1)];

%Neg-Reb vs not neg-reb
fisher_table.neg_reb(:,:,1) = [reb_sub_40hz(2), reb_sub_40hz(1)+reb_sub_40hz(3); reb_sub_140hz(2), reb_sub_140hz(1)+reb_sub_140hz(3)];
fisher_table.neg_reb(:,:,2) = [reb_sub_40hz(2), reb_sub_40hz(1)+reb_sub_40hz(3); reb_sub_1000hz(2), reb_sub_1000hz(1)+reb_sub_1000hz(3)];
fisher_table.neg_reb(:,:,3) = [reb_sub_140hz(2),reb_sub_140hz(1)+reb_sub_140hz(3);reb_sub_1000hz(2), reb_sub_1000hz(1)+reb_sub_1000hz(3)];

%Non-reb vs not non-reb
fisher_table.non_reb(:,:,1) = [reb_sub_40hz(3), reb_sub_40hz(1)+reb_sub_40hz(2); reb_sub_140hz(3), reb_sub_140hz(1)+reb_sub_140hz(2)];
fisher_table.non_reb(:,:,2) = [reb_sub_40hz(3), reb_sub_40hz(1)+reb_sub_40hz(2); reb_sub_1000hz(3), reb_sub_1000hz(1)+reb_sub_1000hz(2)];
fisher_table.non_reb(:,:,3) = [reb_sub_140hz(3),reb_sub_140hz(1)+reb_sub_140hz(2);reb_sub_1000hz(3), reb_sub_1000hz(1)+reb_sub_1000hz(2)];

%Fisher Test
for i=1:3
    [h_fisher.mod(i),p_fisher.mod(i),stats_fisher.mod(i)] = fishertest(fisher_table.mod(:,:,i));
    [h_fisher.pos(i),p_fisher.pos(i),stats_fisher.pos(i)] = fishertest(fisher_table.pos(:,:,i));
    [h_fisher.neg(i),p_fisher.neg(i),stats_fisher.neg(i)] = fishertest(fisher_table.neg(:,:,i));
    [h_fisher.reb(i),p_fisher.reb(i),stats_fisher.reb(i)] = fishertest(fisher_table.reb(:,:,i));
    %[h_fisher.neg_reb(i), p_fisher.neg_reb(i),stats_fisher.neg_reb(i)] = fishertest(fisher_table.neg_reb(:,:,i));
    %[h_fisher.non_reb(i), p_fisher.non_reb(i),stats_fisher.non_reb(i)] = fishertest(fisher_table.non_reb(:,:,i));
end
%================== Non, Pos, Neg modulation =============================%
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
text(lim_x(1)-3,lim_y(1),['All Mod: ' num2str(p_fisher.mod)])
text(lim_x(1)-3,lim_y(1)-1,['Pos: ' num2str(p_fisher.pos)])
text(lim_x(1)-3,lim_y(1)-2,['Neg: ' num2str(p_fisher.neg)])
saveas(gcf, sprintf(['mod_pie_chart_' region,'.fig']));

%======================== Rebound ========================================%
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
text(lim_x(1)-3,lim_y(1)-1,['Significance: ' num2str(p_fisher.reb)])
saveas(gcf, sprintf(['reb_pie_chart_' region,'.fig']));

%================== Rebound Subdivided into non and neg mod ==============%
figure;

labels = {'No rebound','Neg Mod Rebound','No mod Rebound'};
explode = [0,1,1];

% Create pie charts
subplot(1,3,1);
h40 = pie(reb_sub_40hz,explode);
title(sprintf(['40Hz ' region '\n n=' num2str(sum(reb_40hz))]))
patchHand = findobj(h40, 'Type', 'Patch');
patchHand(1).FaceColor = grey;
patchHand(2).FaceColor = dark_blue;
patchHand(3).FaceColor = yellow;


subplot(1,3,2);
h140 = pie(reb_sub_140hz,explode);
title(sprintf(['140Hz ' region '\n n=' num2str(sum(reb_140hz))]))
patchHand = findobj(h140, 'Type', 'Patch'); 
patchHand(1).FaceColor = grey;
patchHand(2).FaceColor = dark_blue;
patchHand(3).FaceColor = yellow;

subplot(1,3,3);
h1k = pie(reb_sub_1000hz,explode);
title(sprintf(['1000Hz ' region '\n n=' num2str(sum(reb_1000hz))]))
patchHand = findobj(h1k, 'Type', 'Patch');
patchHand(1).FaceColor = grey;
patchHand(2).FaceColor = dark_blue;
patchHand(3).FaceColor = yellow;

legend(labels);
lim_x = xlim; lim_y = ylim;
text(lim_x(1)-3,lim_y(1)-1,['Neg Reb: ' num2str(p_fisher.neg_reb)])
text(lim_x(1)-3,lim_y(1)-2,['Non Reb: ' num2str(p_fisher.non_reb)])
saveas(gcf, sprintf(['reb_sub_pie_chart_' region,'.fig']));


%% Comparing pie-charts across and within regions
save_path = ['/home/hanlabadmins/handata_server/Cara_Ravasio/Data/GCaMP_Data_Extraction/Paper_Figures_Clean_Data'];
[h_fisher,p_fisher,stats_fisher] = mod_sig_fishertest();
save([save_path '/fisher_stats.mat'], 'h_fisher','p_fisher','stats_fisher');

%% Bar charts + KW + Ranksum for waveform characterization
% Use the waveform characterization.m script in code folder
