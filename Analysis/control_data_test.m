% control_data_test.m
% Author: Cara Ravasio
% Date: 05/10/23
% Purpose: Repeat the transient DBS analysis approach but on traces where
% DBS was never introduced. Based off of gcamp_analysis_redo.m and 
% All control data comes from the baseline periods of the chronic DBS 
% recordings conducted by Cara and Yangyang.

clear all
close all
clc
%% Setup
addpath(genpath('~/handata_server/Cara_Ravasio/Code/GCaMP_Data_Extraction'));
base_path = '~/handata_server/eng_research_handata3/Cara_Ravasio/Transient_DBS_Ctrl';
read_path = [base_path '/original_data'];
save_path = [base_path '/output_ctrl_data'];

file_names = {{'52713',40,1}, {'52713',40,2}, {'52713',40,3}, ...
                {'52713',140,1}, {'52713',140,2},...
                {'60464',40,1}, {'60464',40,2}, {'60464',40,3},...
                {'60464',140,1}, {'60464',140,2}, {'60464',140,3}};

%% ======================== Initial Processing ========================= %%
for curr_file = 1:numel(file_names)
    close all
    clc
    clearvars -except base_path read_path save_path file_names curr_file roi_data_ctrl
    curr_file %report where we are
    mouse = file_names{1,curr_file}{1,1};
    freq = file_names{1,curr_file}{1,2};
    rec = file_names{1,curr_file}{1,3};
    
    %Artificial data structure imposition
    trial_length = 20; %artificial trial length in sec
    trial_delay = 18; %artificail time between trials in sec
    stim_on = 5; %theoretically when did stim turn on (s)
    stim_off = 10; %theoretically when did stim turn off (s)
    
    %load current roi_data
    cd(read_path)
    load(['roi_data_' mouse '_' num2str(freq) 'hz_rec' num2str(rec)]);
    if exist('roi_data_network','var')
        roi_data = roi_data_network;
    end
    
    %% Find dimensions of interest
    Fs = 20; %20Hz frame rate
    num_trials = 9; %Always 9 trials
    try        
        [num_neurons,num_frames_total] = size(roi_data.raw_traces);
    catch
        [num_neurons,num_frames_total] = size(roi_data.trace);
    end
    num_frames = num_frames_total/num_trials;
    num_new_trials = 6;
    num_new_frames = 600;
    
    
    %% Snip Trials 1 and 2 into "transient trials"
    % Leave at least 10s in between each to simulate the inter-trial
    % interval of our orginial data (30s total, 600 frames)
    
    % Take the BG subtracted but unnormalized data
    try
        trace1 = roi_data.subBG_traces(:,1:3600);
        trace2 = roi_data.subBG_traces(:,3601:7200);
    catch
        trace_minusBG_new = roi_data.trace - roi_data.BGtrace_new;
        trace1 = trace_minusBG_new(:,1:3600);
        trace2 = trace_minusBG_new(:,3601:7200);
    end
    
    % Reshape into 30 second pieces
    trace1 = reshape(trace1,[num_neurons,num_new_frames,num_new_trials]);
    trace2 = reshape(trace2,[num_neurons,num_new_frames,num_new_trials]);
    
    % Now cut off last 10s
    trace1 = trace1(:,1:400,:);
    trace2 = trace2(:,1:400,:);
    
    % concatenate into 12 trials (3rd dimension)
    traces = cat(3,trace1,trace2);
    num_trials = 12;
    num_frames = 400;
    
    %% Normalization (no detrending) and scaling
    %Subtract each trial's avg baseline value,then normalize all by 
    %dividing by the magnitude of the average of the average baselines
    
    %Normalization
    for j=1:num_neurons
        for i=1:num_trials
            trialTrace(i,:) = traces(j,:,i);
            baselineAvg(i,:) = mean(trialTrace(i,1:(stim_on-2)*Fs)); %'stim_on*Fs-2', used to be 3*Fs
            trialTrace(i,:) = trialTrace(i,:) - baselineAvg(i,:); 
        end
        
        baselineAvg = mean(abs(baselineAvg),1);
        for i=1:num_trials
            traces_dn(j,:,i) = trialTrace(i,:)/baselineAvg;
        end
    end
    
  %Scaling      
    minTrace = min(min(traces_dn,[],2),[],3); %find min over each trace, then min over all trials for each neuron
    maxTrace = max(max(traces_dn,[],2),[],3); %find max over each trace, then max over all trials for each neuron
    rangeTrace = abs(maxTrace - minTrace);
    traces_dn_s = (traces_dn - repmat(minTrace,1,num_frames,num_trials))./rangeTrace;

    %% Find avg trace
    avg_traces_dn_s = mean(traces_dn_s,3); %avg across all trials
    baseline_avg_temp = mean(avg_traces_dn_s(:,2:5*Fs-1),2);
    avg_traces_dn_s = avg_traces_dn_s - repmat(baseline_avg_temp,1,num_frames);

    %% Construct roi_data_ctrl struct in proper session
    roi_data_ctrl.sess(curr_file).pixel_idx = roi_data.pixel_idx;
    try
        roi_data_ctrl.sess(curr_file).original_raw_trace = roi_data.raw_traces;
        roi_data_ctrl.sess(curr_file).original_BG_trace = roi_data.BG_traces;
    catch
        roi_data_ctrl.sess(curr_file).original_raw_trace = roi_data.trace;
        roi_data_ctrl.sess(curr_file).original_BG_trace = roi_data.BGtrace_new;
    end
    
    roi_data_ctrl.sess(curr_file).trace_minusBG_new = traces;
    roi_data_ctrl.sess(curr_file).trace_minusBG_new_DN_reshaped_scaled = traces_dn_s;
    roi_data_ctrl.sess(curr_file).avg_trace_minusBG_new_scaled= avg_traces_dn_s;
    
    try
        roi_data_ctrl.sess(curr_file).badIdx = roi_data.badIdx;
        roi_data_ctrl.sess(curr_file).goodIdx = roi_data.goodIdx;
    catch
        roi_data_ctrl.sess(curr_file).badIdx = [];
        roi_data_ctrl.sess(curr_file).goodIdx = [1:num_neurons];
    end
   
end
%% Save roi_data_ctrl variable
 save([save_path '/roi_data_ctrl_' mouse '_' num2str(freq) 'hz_rec' num2str(rec)],'roi_data_ctrl','-v7.3');
%% ================== Group Analysis/Post-processing =================== %%
% Construct an easy to use data form with all of the neurons in one array
data_ctrl.traces = []; data_ctrl.trial_traces = [];
data_ctrl.raw_traces = []; data_ctrl.BG_traces = [];
for i=1:numel(roi_data_ctrl.sess)
    data_ctrl.traces = vertcat(data_ctrl.traces, roi_data_ctrl.sess(i).avg_trace_minusBG_new_scaled);
    data_ctrl.trial_traces = vertcat(data_ctrl.trial_traces, roi_data_ctrl.sess(i).trace_minusBG_new_DN_reshaped_scaled);
    data_ctrl.raw_traces = vertcat(data_ctrl.raw_traces, roi_data_ctrl.sess(i).original_raw_trace );
    data_ctrl.BG_traces = vertcat(data_ctrl.BG_traces, roi_data_ctrl.sess(i).original_BG_trace);
end

save([save_path,'/data_ctrl.mat'],'data_ctrl','-v7.3')

%% Z-test for waveform classification
for i=1:size(data_ctrl.traces,1)
    %Each Neuron' average separately
    [stats_ctrl_s{i},z_ctrl_s{i}]= stats_gcamp_DBS(data_ctrl.traces(i,:),data_ctrl.trial_traces(i,:,:),Fs);
end

%% Waveform classification separation
cd(save_path)
%positive_modulation
pos_mod_ctrl_s = DBS_modulation_check(z_ctrl_s,0,1,1,Fs); %inputs: data,freq, flag, sampling_freq
save('pos_mod_ctrl_struct_s.mat','pos_mod_ctrl_s');
%non_modulation
non_mod_ctrl_s = DBS_modulation_check(z_ctrl_s,0,0,1,Fs);
save('non_mod_ctrl_struct_s.mat','non_mod_ctrl_s');
%negative_modulation
neg_mod_ctrl_s = DBS_modulation_check(z_ctrl_s,0,-1,1,Fs);
save('neg_mod_ctrl_struct_s.mat','neg_mod_ctrl_s');
%rebound
rebound_ctrl_s = DBS_modulation_check(z_ctrl_s,0,2,1,Fs);
save('rebound_ctrl_struct_s.mat','rebound_ctrl_s');

%% Visualize average traces +/- SEM
%Note: Load in the pos,neg,non mod structs from experimental frequencies before running
purple = [0.4940, 0.1840, 0.5560];%[197 28 124]/255;%[136 26 88]/255; %40Hz
orange = [0.8500, 0.3250, 0.0980];%[249 81 8]/255;%[165 54 6]/255; %140Hz
blue = [0, 0.4470, 0.7410];%[57 150 191]/255;%[22 76 100]/255; %100Hz
colors = vertcat(purple, orange, blue);
avg_stim_sham_plusMinus_SEM(pos_mod_40_s, pos_mod_140_s, pos_mod_1000_s, pos_mod_ctrl_s, 'Pos', 'CA1', 0, Fs,colors)
avg_stim_sham_plusMinus_SEM(neg_mod_40_s, neg_mod_140_s, neg_mod_1000_s, neg_mod_ctrl_s, 'Neg', 'CA1', 0, Fs,colors)
avg_stim_sham_plusMinus_SEM(non_mod_40_s, non_mod_140_s, non_mod_1000_s, non_mod_ctrl_s, 'Non', 'CA1', 0, Fs,colors)
avg_stim_sham_plusMinus_SEM(rebound_40_s, rebound_140_s, rebound_1000_s, rebound_ctrl_s, 'Reb', 'CA1', 1, Fs,colors)

%% Heatmap
std_colors = colormap(parula);
% Positive Modulation
num_recordings = 11;
num_neurons = size(data_ctrl.traces,1);
end_frame = 5+5; % sort using 5 seconds after onset and 
start_frame = 5-2; % 2 seconds before onset
postSum = sum(data_ctrl.traces(:,5*Fs+1:end_frame*Fs),2);
preSum = sum(data_ctrl.traces(:, start_frame*Fs:5*Fs),2);   

[~,sortIdx] = sort(postSum-preSum);
traces_plot = data_ctrl.traces(sortIdx,:);

heatmap_Cara(traces_plot,num_recordings,Fs,std_colors,...
    ['Sham Heatmap (Scaled)'], ...
    'Sham_heatmap.fig');


%% Pie Charts and Fisher's Test

mod_ctrl = [numel(non_mod_sham_CA1.neurons(:,1)),numel(pos_mod_sham_CA1.neurons(:,1)),numel(neg_mod_sham_CA1.neurons(:,1))];
reb_ctrl = [sum(mod_ctrl)-numel(rebound_sham_CA1.neurons(:,1)),numel(rebound_sham_CA1.neurons(:,1))];


% Plot ===================================================================%
%pie chart colors
red = [204 0 0]/255;
grey = [220 219 219]/255;
dark_blue = [22 83 126]/255;
yellow = [255 191 0]/255;

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
