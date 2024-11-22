% transient_DBS_figure_generation.m
% Author: Cara
% Date: 05/16/23
% Purpose: All of the post-processing which results in a figure or
% important statistics to be saved.
%% Setup
%- Linux -%
addpath(genpath('~/handata_server/Cara_Ravasio/Code/GCaMP_Data_Extraction'));
hip_path = '~/handata_server/Cara_Ravasio/Data/GCaMP_Data_Extraction/Hippocampus/Good_Recordings_Data_Files';
cort_path = '~/handata_server/Cara_Ravasio/Data/GCaMP_Data_Extraction/Neocortex/Good_Recordings_Data_Files';
sham_path = '~/handata_server/eng_research_handata3/Cara_Ravasio/Transient_DBS_Ctrl/output_ctrl_data';
save_path = '~/handata_server/Cara_Ravasio/Data/GCaMP_Data_Extraction/Paper_Figures_Clean_Data/Source_Data_Run';
% 
% %- Windows -%
% addpath(genpath('Z:\Cara_Ravasio\Code\GCaMP_Data_Extraction'));
% hip_path = 'Z:\Cara_Ravasio\Data\GCaMP_Data_Extraction\Hippocampus\Good_Recordings_Data_Files';
% cort_path = 'Z:\Cara_Ravasio\Data\GCaMP_Data_Extraction\Neocortex\Good_Recordings_Data_Files';
% sham_path = 'Z:\eng_research_handata3\Cara_Ravasio\Transient_DBS_Ctrl\output_ctrl_data';
% save_path = 'Z:\Cara_Ravasio\Data\GCaMP_Data_Extraction\Paper_Figures_Clean_Data';

Fs = 20; %Hz, 20Hz recordin
num_frames = 400; %20s at 20Hz frame rate

%Setting up color scheme for figures
white = [255 255 255]/255;
purple = [0.494,0.184,0.556];%[197 28 124]/255;%[136 26 88]/255; %40Hz
orange = [0.85,0.325,0.098];%[249 81 8]/255;%[165 54 6]/255; %140Hz
blue = [0, 0.447,0.741];%[57 150 191]/255;%[22 76 100]/255; %1000Hz
green = [0.4660, 0.6740, 0.1880]; %matlab default green
length = 200; % the number of color steps included in the colormap

colormap_40 = [linspace(white(1),purple(1), length)',linspace(white(2),purple(2), length)',linspace(white(3),purple(3), length)'];
colormap_140 = [linspace(white(1),orange(1), length)',linspace(white(2),orange(2), length)',linspace(white(3),orange(3), length)'];
colormap_1000 = [linspace(white(1),blue(1), length)',linspace(white(2),blue(2), length)',linspace(white(3),blue(3), length)'];

%CA1 colors
color_40_CA1 = purple;
color_140_CA1 = orange;
color_1000_CA1 = blue;
CA1_colors = [color_40_CA1; color_140_CA1; color_1000_CA1];
    
%Cortex colors
color_40_M1 = colormap_40(length/2,:);
color_140_M1 = colormap_140(length/2,:);
color_1000_M1 = colormap_1000(length/2,:);
M1_colors = [color_40_M1; color_140_M1; color_1000_M1];

% Sham color
color_sham = green;

%pie chart colors
red = [204 0 0]/255;
grey = [220 219 219]/255;
dark_blue = [22 83 126]/255;
yellow = [255 191 0]/255;
pie_colors = [grey; red; dark_blue; yellow];

%% Load in all data

load([hip_path '/data40_CA1.mat']);
load([hip_path '/data140_CA1.mat']);
load([hip_path '/data1000_CA1.mat']);
data40_CA1 = data40;
data140_CA1 = data140;
data1000_CA1 = data1000;

load([cort_path '/data40_M1.mat']);
load([cort_path '/data140_M1.mat']);
load([cort_path '/data1000_M1.mat']);
data40_M1 = data40;
data140_M1 = data140;
data1000_M1 = data1000;

%load([sham_path '/data_ctrl.mat']);

%% Try to load previously identified modulation info
try
    %- CA1 -%
    load([save_path '/neg_mod_40_CA1.mat']);
    load([save_path '/non_mod_40_CA1.mat']);
    load([save_path '/pos_mod_40_CA1.mat']);

    load([save_path '/neg_mod_140_CA1.mat']);
    load([save_path '/non_mod_140_CA1.mat']);
    load([save_path '/pos_mod_140_CA1.mat']);

    load([save_path '/neg_mod_1000_CA1.mat']);
    load([save_path '/non_mod_1000_CA1.mat']);
    load([save_path '/pos_mod_1000_CA1.mat']);

    %- M1 -%
    load([save_path '/neg_mod_40_M1.mat']);
    load([save_path '/non_mod_40_M1.mat']);
    load([save_path '/pos_mod_40_M1.mat']);

    load([save_path '/neg_mod_140_M1.mat']);
    load([save_path '/non_mod_140_M1.mat']);
    load([save_path '/pos_mod_140_M1.mat']);

    load([save_path '/neg_mod_1000_M1.mat']);
    load([save_path '/non_mod_1000_M1.mat']);
    load([save_path '/pos_mod_1000_M1.mat']);
catch
end
%% Change directories to save_path
cd(save_path)
%% Overall Average Trace for each condition

%- Neuron-wise -%
all_roi_avg_trace_plusMinus_95CI(data40_CA1, 40, 'CA1',CA1_colors);
all_roi_avg_trace_plusMinus_95CI(data140_CA1, 140, 'CA1',CA1_colors);
all_roi_avg_trace_plusMinus_95CI(data1000_CA1, 1000, 'CA1',CA1_colors);

all_roi_avg_trace_plusMinus_95CI(data40_M1, 40, 'M1',M1_colors);
all_roi_avg_trace_plusMinus_95CI(data140_M1, 140, 'M1',M1_colors);
all_roi_avg_trace_plusMinus_95CI(data1000_M1, 1000, 'M1',M1_colors);

%Sanity check control data
%all_roi_avg_trace_plusMinus_95CI(data_ctrl, 0, 'CA1',CA1_colors);

%- Session-wise -%
all_roi_avg_sess_avg_trace_plusMinus_95CI(data40_CA1, 40, 'CA1',CA1_colors);
all_roi_avg_sess_avg_trace_plusMinus_95CI(data140_CA1, 140, 'CA1',CA1_colors);
all_roi_avg_sess_avg_trace_plusMinus_95CI(data1000_CA1, 1000, 'CA1',CA1_colors);

all_roi_avg_sess_avg_trace_plusMinus_95CI(data40_M1, 40, 'M1',M1_colors);
all_roi_avg_sess_avg_trace_plusMinus_95CI(data140_M1, 140, 'M1',M1_colors);
all_roi_avg_sess_avg_trace_plusMinus_95CI(data1000_M1, 1000, 'M1',M1_colors);

%% Testing for significant inhibition during DBS aross neuron average traces for every condition
% NOTE: Labeled as "_t", but this is in fact a two-tailed signrank test

[p_40_CA1_t, h_40_CA1_t] = total_avg_trace_inhib_sig(data40_CA1, Fs, 40,'CA1',color_40_CA1);
[p_140_CA1_t, h_140_CA1_t] = total_avg_trace_inhib_sig(data140_CA1, Fs, 140,'CA1',color_140_CA1);
[p_1000_CA1_t, h_1000_CA1_t,stats] = total_avg_trace_inhib_sig(data1000_CA1, Fs, 1000,'CA1',color_1000_CA1);

[p_40_M1_t, h_40_M1_t] = total_avg_trace_inhib_sig(data40_M1, Fs, 40,'M1',color_40_M1);
[p_140_M1_t, h_140_M1_t] = total_avg_trace_inhib_sig(data140_M1, Fs, 140,'M1',color_140_M1);
[p_1000_M1_t, h_1000_M1_t] = total_avg_trace_inhib_sig(data1000_M1, Fs, 1000,'M1',color_1000_M1);

colors = [CA1_colors; M1_colors];
p_auc = total_avg_trace_dbs_auc_comp(data40_CA1,data140_CA1,data1000_CA1,...
                                      data40_M1, data140_M1, data1000_M1,Fs,colors);


%% New Classification Process -> Ranksum trial by trial for a neuron
cd(save_path)
% Wilcoxon Test
    % Note: Rebound is no longer analyzed (replaced with ~)
%=============================== 40 Hz ==================================%
%CA1
for i=1:numel(data40_CA1)
    [stats_40_CA1_s{i},z_40_CA1_s{i}]= stats_gcamp_DBS(data40_CA1(i).roi_data.avg_trace_minusBG_new_scaled(data40_CA1(i).roi_data.goodIdx,:),data40_CA1(i).roi_data.trace_minusBG_new_DN_reshaped_scaled(data40_CA1(i).roi_data.goodIdx,:,:),Fs);
end
[pos_mod_40_CA1, neg_mod_40_CA1, non_mod_40_CA1, ~] = DBS_modulation_check_v2(stats_40_CA1_s,z_40_CA1_s,40,'CA1',1,Fs);
save('pos_mod_40_CA1.mat','pos_mod_40_CA1');
save('neg_mod_40_CA1.mat','neg_mod_40_CA1');
save('non_mod_40_CA1.mat','non_mod_40_CA1');

%M1
for i=1:numel(data40_M1)
    [stats_40_M1_s{i},z_40_M1_s{i}]= stats_gcamp_DBS(data40_M1(i).roi_data.avg_trace_minusBG_new_scaled(data40_M1(i).roi_data.goodIdx,:),data40_M1(i).roi_data.trace_minusBG_new_DN_reshaped_scaled(data40_M1(i).roi_data.goodIdx,:,:),Fs);
end
[pos_mod_40_M1, neg_mod_40_M1, non_mod_40_M1, ~] = DBS_modulation_check_v2(stats_40_M1_s,z_40_M1_s,40,'M1',1,Fs);
save('pos_mod_40_M1.mat','pos_mod_40_M1');
save('neg_mod_40_M1.mat','neg_mod_40_M1');
save('non_mod_40_M1.mat','non_mod_40_M1');

%=============================== 140 Hz ==================================%
%CA1
for i=1:numel(data140_CA1)
    [stats_140_CA1_s{i},z_140_CA1_s{i}]= stats_gcamp_DBS(data140_CA1(i).roi_data.avg_trace_minusBG_new_scaled(data140_CA1(i).roi_data.goodIdx,:),data140_CA1(i).roi_data.trace_minusBG_new_DN_reshaped_scaled(data140_CA1(i).roi_data.goodIdx,:,:),Fs);
end
[pos_mod_140_CA1, neg_mod_140_CA1, non_mod_140_CA1, ~] = DBS_modulation_check_v2(stats_140_CA1_s,z_140_CA1_s,140,'CA1',1,Fs);
save('pos_mod_140_CA1.mat','pos_mod_140_CA1');
save('neg_mod_140_CA1.mat','neg_mod_140_CA1');
save('non_mod_140_CA1.mat','non_mod_140_CA1');

%M1
for i=1:numel(data140_M1)
    [stats_140_M1_s{i},z_140_M1_s{i}]= stats_gcamp_DBS(data140_M1(i).roi_data.avg_trace_minusBG_new_scaled(data140_M1(i).roi_data.goodIdx,:),data140_M1(i).roi_data.trace_minusBG_new_DN_reshaped_scaled(data140_M1(i).roi_data.goodIdx,:,:),Fs);
end
[pos_mod_140_M1, neg_mod_140_M1, non_mod_140_M1, ~] = DBS_modulation_check_v2(stats_140_M1_s,z_140_M1_s,140,'M1',1,Fs);
save('pos_mod_140_M1.mat','pos_mod_140_M1');
save('neg_mod_140_M1.mat','neg_mod_140_M1');
save('non_mod_140_M1.mat','non_mod_140_M1');


%============================== 1000 Hz ==================================%
%CA1
for i=1:numel(data1000_CA1)
    [stats_1000_CA1_s{i},z_1000_CA1_s{i}]= stats_gcamp_DBS(data1000_CA1(i).roi_data.avg_trace_minusBG_new_scaled(data1000_CA1(i).roi_data.goodIdx,:),data1000_CA1(i).roi_data.trace_minusBG_new_DN_reshaped_scaled(data1000_CA1(i).roi_data.goodIdx,:,:),Fs);
end
[pos_mod_1000_CA1, neg_mod_1000_CA1, non_mod_1000_CA1, ~] = DBS_modulation_check_v2(stats_1000_CA1_s,z_1000_CA1_s,1000,'CA1',1,Fs);
save('pos_mod_1000_CA1.mat','pos_mod_1000_CA1');
save('neg_mod_1000_CA1.mat','neg_mod_1000_CA1');
save('non_mod_1000_CA1.mat','non_mod_1000_CA1');

%M1
for i=1:numel(data1000_M1)
    [stats_1000_M1_s{i},z_1000_M1_s{i}]= stats_gcamp_DBS(data1000_M1(i).roi_data.avg_trace_minusBG_new_scaled(data1000_M1(i).roi_data.goodIdx,:),data1000_M1(i).roi_data.trace_minusBG_new_DN_reshaped_scaled(data1000_M1(i).roi_data.goodIdx,:,:),Fs);
end
[pos_mod_1000_M1, neg_mod_1000_M1, non_mod_1000_M1, ~] = DBS_modulation_check_v2(stats_1000_M1_s,z_1000_M1_s,1000,'M1',1,Fs);
save('pos_mod_1000_M1.mat','pos_mod_1000_M1');
save('neg_mod_1000_M1.mat','neg_mod_1000_M1');
save('non_mod_1000_M1.mat','non_mod_1000_M1');

%==============================  SHAM  ===================================%
[stats_sham_CA1_s,z_sham_CA1_s]= stats_gcamp_DBS(data_ctrl.traces,data_ctrl.trial_traces,Fs);

[pos_mod_sham_CA1, neg_mod_sham_CA1, non_mod_sham_CA1, ~] = DBS_modulation_check_v2(stats_sham_CA1_s,z_sham_CA1_s,0,'CA1',1,Fs);
save('pos_mod_sham_CA1.mat','pos_mod_sham_CA1');
save('neg_mod_sham_CA1.mat','neg_mod_sham_CA1');
save('non_mod_sham_CA1.mat','non_mod_sham_CA1');
%% Average trace plus/minus 95% confidence interval
%- CA1 -%
avg_trace_plusMinus_95CI(pos_mod_40_CA1, pos_mod_140_CA1, pos_mod_1000_CA1,'Pos', 'CA1', 0, 20, CA1_colors);
avg_trace_plusMinus_95CI(neg_mod_40_CA1, neg_mod_140_CA1, neg_mod_1000_CA1,'Neg', 'CA1', 0, 20, CA1_colors);
avg_trace_plusMinus_95CI(non_mod_40_CA1, non_mod_140_CA1, non_mod_1000_CA1,'Non', 'CA1', 0, 20, CA1_colors);

%- M1 -%
avg_trace_plusMinus_95CI(pos_mod_40_M1, pos_mod_140_M1, pos_mod_1000_M1,'Pos', 'M1', 0, 20, M1_colors);
avg_trace_plusMinus_95CI(neg_mod_40_M1, neg_mod_140_M1, neg_mod_1000_M1,'Neg', 'M1', 0, 20, M1_colors);
avg_trace_plusMinus_95CI(non_mod_40_M1, non_mod_140_M1, non_mod_1000_M1,'Non', 'M1', 0, 20, M1_colors);

%% Average trace plus/minus SEM or STD (change manually) and sham
%- CA1 -%
avg_stim_sham_plusMinus_SEM(pos_mod_40_CA1, pos_mod_140_CA1, pos_mod_1000_CA1, pos_mod_sham_CA1, 'Pos', 'CA1', 0, Fs,CA1_colors)
avg_stim_sham_plusMinus_SEM(neg_mod_40_CA1, neg_mod_140_CA1, neg_mod_1000_CA1, neg_mod_sham_CA1, 'Neg', 'CA1', 0, Fs,CA1_colors)
avg_stim_sham_plusMinus_SEM(non_mod_40_CA1, non_mod_140_CA1, non_mod_1000_CA1, non_mod_sham_CA1, 'Non', 'CA1', 0, Fs,CA1_colors)
avg_stim_sham_plusMinus_SEM(rebound_40_CA1, rebound_140_CA1, rebound_1000_CA1, rebound_sham_CA1, 'Reb', 'CA1', 1, Fs,CA1_colors)

% Note: No M1 sham data
%% Average trace plus/minus 95CI (All Comparisons)
% Note: It is currently set for +/- 95th percent confidence interval, 
% but you can go into the function and uncomment the lines that would make
% it +/- std or sem

%Neuron-sise
avg_mod_waveform_comparison(pos_mod_40_CA1,neg_mod_40_CA1,rebound_40_CA1,...
                                    pos_mod_140_CA1,neg_mod_140_CA1,rebound_140_CA1,...
                                    pos_mod_1000_CA1,neg_mod_1000_CA1,rebound_1000_CA1,...
                                    pos_mod_40_M1,neg_mod_40_M1,rebound_40_M1,...
                                    pos_mod_140_M1,neg_mod_140_M1,rebound_140_M1,...
                                    pos_mod_1000_M1,neg_mod_1000_M1,rebound_1000_M1)

%% Session-wise trace analysis
%- CA1 -%
pos_mod_40_CA1 = session_avg(pos_mod_40_CA1);
pos_mod_140_CA1 = session_avg(pos_mod_140_CA1);
pos_mod_1000_CA1 = session_avg(pos_mod_1000_CA1);

neg_mod_40_CA1 = session_avg(neg_mod_40_CA1);
neg_mod_140_CA1 = session_avg(neg_mod_140_CA1);
neg_mod_1000_CA1 = session_avg(neg_mod_1000_CA1);

rebound_40_CA1 = session_avg(rebound_40_CA1);
rebound_140_CA1 = session_avg(rebound_140_CA1);
rebound_1000_CA1 = session_avg(rebound_1000_CA1);

%- M1 -%
pos_mod_40_M1 = session_avg(pos_mod_40_M1);
pos_mod_140_M1 = session_avg(pos_mod_140_M1);
pos_mod_1000_M1 = session_avg(pos_mod_1000_M1);

neg_mod_40_M1 = session_avg(neg_mod_40_M1);
neg_mod_140_M1 = session_avg(neg_mod_140_M1);
neg_mod_1000_M1 = session_avg(neg_mod_1000_M1);

rebound_40_M1 = session_avg(rebound_40_M1);
rebound_140_M1 = session_avg(rebound_140_M1);
rebound_1000_M1 = session_avg(rebound_1000_M1);

%Session-wise
avg_sess_waveform_comparison(pos_mod_40_CA1,neg_mod_40_CA1,rebound_40_CA1,...
                                    pos_mod_140_CA1,neg_mod_140_CA1,rebound_140_CA1,...
                                    pos_mod_1000_CA1,neg_mod_1000_CA1,rebound_1000_CA1,...
                                    pos_mod_40_M1,neg_mod_40_M1,rebound_40_M1,...
                                    pos_mod_140_M1,neg_mod_140_M1,rebound_140_M1,...
                                    pos_mod_1000_M1,neg_mod_1000_M1,rebound_1000_M1);
                                
%% Heatmaps -- All Neurons collected for condition, line denotes modulation cutoff
%- CA1 -%
all_neuron_heatmaps(pos_mod_40_CA1, non_mod_40_CA1, neg_mod_40_CA1, 40, 'CA1');
all_neuron_heatmaps(pos_mod_140_CA1, non_mod_140_CA1, neg_mod_140_CA1, 140, 'CA1');
all_neuron_heatmaps(pos_mod_1000_CA1, non_mod_1000_CA1, neg_mod_1000_CA1, 1000, 'CA1');

%- M1 -%
all_neuron_heatmaps(pos_mod_40_M1, non_mod_40_M1, neg_mod_40_M1, 40, 'M1');
all_neuron_heatmaps(pos_mod_140_M1, non_mod_140_M1, neg_mod_140_M1, 140, 'M1');
all_neuron_heatmaps(pos_mod_1000_M1, non_mod_1000_M1, neg_mod_1000_M1, 1000, 'M1');
%% Heatmaps for neg and pos traces only
%- CA1 -%
generate_mod_heatmaps(pos_mod_40_CA1, neg_mod_40_CA1, rebound_40_CA1, 40, 'CA1', Fs);
generate_mod_heatmaps(pos_mod_140_CA1, neg_mod_140_CA1, rebound_140_CA1, 140, 'CA1', Fs);
generate_mod_heatmaps(pos_mod_1000_CA1, neg_mod_1000_CA1, rebound_1000_CA1,1000, 'CA1', Fs);

%- M1 -%
generate_mod_heatmaps(pos_mod_40_M1, neg_mod_40_M1, rebound_40_M1, 40,'M1', Fs);
generate_mod_heatmaps(pos_mod_140_M1, neg_mod_140_M1,rebound_140_M1, 140, 'M1', Fs);
generate_mod_heatmaps(pos_mod_1000_M1, neg_mod_1000_M1,rebound_1000_M1, 1000, 'M1', Fs);
%% Pie Charts, Bar Charts, and Modulation Scatter Breakdown
% Compare within and across regions the ratio of modulated and 
% non-modulated neurons
bar_colors = [grey;dark_blue;red];
chi2test_stats = run_pie_bar_scatter_chi2(non_mod_40_CA1, neg_mod_40_CA1, pos_mod_40_CA1,...
                                          non_mod_140_CA1, neg_mod_140_CA1, pos_mod_140_CA1,...
                                          non_mod_1000_CA1, neg_mod_1000_CA1, pos_mod_1000_CA1,...
                                          non_mod_40_M1, neg_mod_40_M1, pos_mod_40_M1,...
                                          non_mod_140_M1, neg_mod_140_M1, pos_mod_140_M1,...
                                          non_mod_1000_M1, neg_mod_1000_M1, pos_mod_1000_M1,...
                                          bar_colors);
save([save_path '/chi2test_stats.mat'], 'chi2test_stats');

%% Sham Pie charts
% run_sham_pie(pos_mod_sham_CA1, neg_mod_sham_CA1, non_mod_sham_CA1, rebound_sham_CA1,pie_colors);
          
%% Breakdown of mod neurons/session
bar_colors = [grey;dark_blue;red];

%- CA1 -%
session_variation_bar(non_mod_40_CA1, neg_mod_40_CA1, pos_mod_40_CA1, 40, 'CA1', bar_colors);
session_variation_bar(non_mod_140_CA1, neg_mod_140_CA1, pos_mod_140_CA1, 140, 'CA1', bar_colors);
session_variation_bar(non_mod_1000_CA1, neg_mod_1000_CA1, pos_mod_1000_CA1, 1000, 'CA1', bar_colors);

%- M1 -%
session_variation_bar(non_mod_40_M1, neg_mod_40_M1, pos_mod_40_M1, 40, 'M1', bar_colors);
session_variation_bar(non_mod_140_M1, neg_mod_140_M1, pos_mod_140_M1, 140, 'M1', bar_colors);
session_variation_bar(non_mod_1000_M1, neg_mod_1000_M1, pos_mod_1000_M1, 1000, 'M1', bar_colors);

%% Example traces
try
    load('example_traces_struct.mat');
catch
end

example_pos_40_M1_traces = example_trace_selector(pos_mod_40_M1,Fs);
example_neg_40_M1_traces = example_trace_selector(neg_mod_40_M1,Fs);
example_non_40_M1_traces = example_trace_selector(non_mod_40_M1,Fs);

example_pos_40_CA1_traces = example_trace_selector(pos_mod_40_CA1,Fs);
example_neg_40_CA1_traces = example_trace_selector(neg_mod_40_CA1,Fs);
example_non_40_CA1_traces = example_trace_selector(non_mod_40_CA1,Fs);

example_pos_140_M1_traces = example_trace_selector(pos_mod_140_M1,Fs);
example_neg_140_M1_traces = example_trace_selector(neg_mod_140_M1,Fs);
example_non_140_M1_traces = example_trace_selector(non_mod_140_M1,Fs);

example_pos_140_CA1_traces = example_trace_selector(pos_mod_140_CA1,Fs);
example_neg_140_CA1_traces = example_trace_selector(neg_mod_140_CA1,Fs);
example_non_140_CA1_traces = example_trace_selector(non_mod_140_CA1,Fs);

example_pos_1000_M1_traces = example_trace_selector(pos_mod_1000_M1,Fs);
example_neg_1000_M1_traces = example_trace_selector(neg_mod_1000_M1,Fs);
example_non_1000_M1_traces = example_trace_selector(non_mod_1000_M1,Fs);

example_pos_1000_CA1_traces = example_trace_selector(pos_mod_1000_CA1,Fs);
example_neg_1000_CA1_traces = example_trace_selector(neg_mod_1000_CA1,Fs);
example_non_1000_CA1_traces = example_trace_selector(non_mod_1000_CA1,Fs);

% Make example trace struct then save
example_traces.hz40.pos.CA1 = example_pos_40_CA1_traces;
example_traces.hz40.neg.CA1 = example_neg_40_CA1_traces;
example_traces.hz40.non.CA1 = example_non_40_CA1_traces;
example_traces.hz40.pos.M1 = example_pos_40_M1_traces;
example_traces.hz40.neg.M1 = example_neg_40_M1_traces;
example_traces.hz40.non.M1 = example_non_40_M1_traces;
example_traces.hz140.pos.CA1 = example_pos_140_CA1_traces;
example_traces.hz140.neg.CA1 = example_neg_140_CA1_traces;
example_traces.hz140.non.CA1 = example_non_140_CA1_traces;
example_traces.hz140.pos.M1 = example_pos_140_M1_traces;
example_traces.hz140.neg.M1 = example_neg_140_M1_traces;
example_traces.hz140.non.M1 = example_non_140_M1_traces;
example_traces.hz1000.pos.CA1 = example_pos_1000_CA1_traces;
example_traces.hz1000.neg.CA1 = example_neg_1000_CA1_traces;
example_traces.hz1000.non.CA1 = example_non_1000_CA1_traces;
example_traces.hz1000.pos.M1 = example_pos_1000_M1_traces;
example_traces.hz1000.neg.M1 = example_neg_1000_M1_traces;
example_traces.hz1000.non.M1 = example_non_1000_M1_traces;
save('example_traces_struct.mat','example_traces');

% Note: Use example_trace_plotting.m to create exanple trce suppl. figures

%% Event detection (using the new GCaMP7f detection algorithm)
%- CA1 -%
roi_list_final_40_CA1 = run_event_detection_transient_DBS(data40_CA1);
roi_list_final_140_CA1 = run_event_detection_transient_DBS(data140_CA1);
roi_list_final_1000_CA1 = run_event_detection_transient_DBS(data1000_CA1);

%- M1 -%
roi_list_final_40_M1 = run_event_detection_transient_DBS(data40_M1);
roi_list_final_140_M1 = run_event_detection_transient_DBS(data140_M1);
roi_list_final_1000_M1 = run_event_detection_transient_DBS(data1000_M1);
%% Event rate and shape analysis
% NOTE: 11/14/23 Nothing significant was observed when looking at the
% trends in normalized # of events/trial/frequency so I deleted the
% rudimentary testing code

%- CA1 -%
[event_traces_40_CA1, event_counts_40_CA1, p_rate_40_CA1,fwhm_40_CA1]=event_analysis(roi_list_final_40_CA1,pos_mod_40_CA1,neg_mod_40_CA1,non_mod_40_CA1,40,'CA1', color_40_CA1);
[event_traces_140_CA1, event_counts_140_CA1, p_rate_140_CA1,fwhm_140_CA1]=event_analysis(roi_list_final_140_CA1,pos_mod_140_CA1,neg_mod_140_CA1,non_mod_140_CA1,140,'CA1', color_140_CA1);
[event_traces_1000_CA1, event_counts_1000_CA1, p_rate_1000_CA1,fwhm_1000_CA1]=event_analysis(roi_list_final_1000_CA1,pos_mod_1000_CA1,neg_mod_1000_CA1,non_mod_1000_CA1,1000,'CA1', color_1000_CA1);

%- M1 -%
[event_traces_40_M1, event_counts_40_M1, p_rate_40_M1,fwhm_40_M1]=event_analysis(roi_list_final_40_M1,pos_mod_40_M1,neg_mod_40_M1,non_mod_40_M1,40,'M1', color_40_M1);
[event_traces_140_M1, event_counts_140_M1, p_rate_140_M1,fwhm_140_M1]=event_analysis(roi_list_final_140_M1,pos_mod_140_M1,neg_mod_140_M1,non_mod_140_M1,140,'M1', color_140_M1);
[event_traces_1000_M1, event_counts_1000_M1, p_rate_1000_M1,fwhm_1000_M1]=event_analysis(roi_list_final_1000_M1,pos_mod_1000_M1,neg_mod_1000_M1,non_mod_1000_M1,1000,'M1', color_1000_M1);

%% Waveform Characterization
% NOTE: Right now my KW_ranksum_dunnsidak_box actually outputs violin
% plots, but should probably be adjusted so it is either labeled as violin
% or so that both box and violin outputs get labeled and saved. Also get
% rid of jpg output.

colors = [color_40_CA1;color_40_M1;color_140_CA1;color_140_M1;color_1000_CA1;color_1000_M1];

[pos_mod_40_CA1,neg_mod_40_CA1,pos_mod_140_CA1,neg_mod_140_CA1,...
pos_mod_1000_CA1,neg_mod_1000_CA1,pos_mod_40_M1,neg_mod_40_M1,...
pos_mod_140_M1,neg_mod_140_M1,pos_mod_1000_M1,neg_mod_1000_M1,...
pvals_struct] = characterize_waveforms(pos_mod_40_CA1,neg_mod_40_CA1,...
                                    pos_mod_140_CA1,neg_mod_140_CA1,...
                                    pos_mod_1000_CA1,neg_mod_1000_CA1,...
                                    pos_mod_40_M1,neg_mod_40_M1,...
                                    pos_mod_140_M1,neg_mod_140_M1,...
                                    pos_mod_1000_M1,neg_mod_1000_M1,...
                                    colors);
                                
% Add the prev signrank population level signrank results to pvals struct
pvals_struct.pop_level.Hz40.CA1 = p_40_CA1_t;
pvals_struct.pop_level.Hz40.M1 = p_40_M1_t;
pvals_struct.pop_level.Hz140.CA1 = p_140_CA1_t;
pvals_struct.pop_level.Hz140.M1 =  p_140_M1_t;
pvals_struct.pop_level.Hz1000.CA1 = p_1000_CA1_t;
pvals_struct.pop_level.Hz1000.M1 = p_1000_M1_t;

save('pvals_struct.mat','pvals_struct');

%% Check for latency 
% NOTE: This did not yield much significant difference. Not worth
% analyizing further. I think the cortical neuron activity inparticular
% makes it hard.

lat_40_pos = check_latency(pos_mod_40_CA1, pos_mod_40_M1, Fs, '40', 'pos',[color_40_CA1;color_40_M1]);
lat_40_neg = check_latency(neg_mod_40_CA1, neg_mod_40_M1, Fs, '40', 'neg',[color_40_CA1;color_40_M1]);

lat_140_pos = check_latency(pos_mod_140_CA1, pos_mod_140_M1, Fs, '140', 'pos',[color_140_CA1;color_140_M1]);
lat_140_neg = check_latency(neg_mod_140_CA1, neg_mod_140_M1, Fs, '140', 'neg',[color_140_CA1;color_140_M1]);

lat_1000_pos = check_latency(pos_mod_1000_CA1, pos_mod_1000_M1, Fs, '1000', 'pos',[color_1000_CA1;color_1000_M1]);
lat_1000_neg = check_latency(neg_mod_1000_CA1, neg_mod_1000_M1, Fs, '1000', 'neg',[color_1000_CA1;color_1000_M1]);
%% Effect Size calculation (Cliff's Delta)

%- THESE ONLY WORK IN MATLAB 2022 OR HIGHER -%
cliffs_d = effect_size_check_cliffs_d(); % Refers to probability that a sample from distribution 1 is larger than distribution2. Thresholds provided in Romano 2006 d<0.147 “negligible”, d<0.33 “small”,d<0.474 “medium” otherwise “large”
% median_diff = effect_size_check_median_diff(); % If the confidence interval never passes 0, then do not reject p-value significance
% cohen_d = effect_size_check(save_path); % compares means, therefore not good for nonparametric data

%% Ratio neurons modulated vs charge density and vs total absolute charge delivered
% current amplitudes
[CA1_40_uA, CA1_40_ID]= find_currents(data40_CA1);
[CA1_140_uA, CA1_140_ID] = find_currents(data140_CA1);
[CA1_1000_uA, CA1_1000_ID] = find_currents(data1000_CA1);
[M1_40_uA, M1_40_ID] = find_currents(data40_M1);
[M1_140_uA, M1_140_ID] = find_currents(data140_M1);
[M1_1000_uA, M1_1000_ID] = find_currents(data1000_M1);

%Charge Density Calculation (uC/cm^2/phase)
R_wire = 63.5e-6; % in meters 127um diameter core wire
A_wire = pi * R_wire^2;
A_wire_cm2 = A_wire*100*100; %(A_screw+A_wire)*100*100

CA1_40_chargeDens =  ((CA1_40_uA).*(200e-6))./A_wire_cm2;
CA1_140_chargeDens =  ((CA1_140_uA).*(200e-6))./A_wire_cm2;
CA1_1000_chargeDens =  ((CA1_1000_uA).*(45e-6))./A_wire_cm2;
M1_40_chargeDens =  ((M1_40_uA).*(200e-6))./A_wire_cm2;
M1_140_chargeDens =  ((M1_140_uA).*(200e-6))./A_wire_cm2;
M1_1000_chargeDens =  ((M1_1000_uA).*(45e-6))./A_wire_cm2;

% Total absolute charge delivered Calculation (uC)
% total charge(uC) = 5(s) * f(Hz) * PW(s) * curr(uC/s)
CA1_40_totCharge =  (5*40.*(CA1_40_uA).*(400e-6));
CA1_140_totCharge =  (5*140.*(CA1_140_uA).*(400e-6));
CA1_1000_totCharge =  (5*1000.*(CA1_1000_uA).*(90e-6));
M1_40_totCharge =  (5*40.*(M1_40_uA).*(400e-6));
M1_140_totCharge =  (5*140.*(M1_140_uA).*(400e-6));
M1_1000_totCharge =  (5*1000.*(M1_1000_uA).*(90e-6));

%plot %mod neurons vs charge density
% note: exclude any sess with fewer than 10 neurons

N = 1:numel(CA1_40_uA);
for i = 1:numel(N)
    num_pos(i) = sum(pos_mod_40_CA1.neurons(:,1)== N(i));
    num_neg(i) = sum(neg_mod_40_CA1.neurons(:,1)== N(i));
    num_mod(i) = num_pos(i) + num_neg(i);
    num_non(i) = sum(non_mod_40_CA1.neurons(:,1) == N(i));
end
sess_tot_40_CA1 = num_mod + num_non;
num_pos_40_CA1 = num_pos(sess_tot_40_CA1 > 10)./sess_tot_40_CA1(sess_tot_40_CA1 >10).*100;
num_neg_40_CA1 = num_neg(sess_tot_40_CA1 > 10)./sess_tot_40_CA1(sess_tot_40_CA1 >10).*100;
mod_rat_40_CA1 = num_mod(sess_tot_40_CA1 > 10)./sess_tot_40_CA1(sess_tot_40_CA1 >10).*100;
clearvars num_mod num_non num_pos num_neg

N = 1:numel(CA1_140_uA);
for i = 1:numel(N)
    num_pos(i) = sum(pos_mod_140_CA1.neurons(:,1)== N(i));
    num_neg(i) = sum(neg_mod_140_CA1.neurons(:,1)== N(i));
    num_mod(i) = num_pos(i) + num_neg(i);
    num_non(i) = sum(non_mod_140_CA1.neurons(:,1) == N(i));
end
sess_tot_140_CA1 = num_mod + num_non;
num_pos_140_CA1 = num_pos(sess_tot_140_CA1 > 10)./sess_tot_140_CA1(sess_tot_140_CA1 >10).*100;
num_neg_140_CA1 = num_neg(sess_tot_140_CA1 > 10)./sess_tot_140_CA1(sess_tot_140_CA1 >10).*100;
mod_rat_140_CA1 = num_mod(sess_tot_140_CA1 > 10)./sess_tot_140_CA1(sess_tot_140_CA1 >10).*100;
clearvars num_mod num_non num_pos num_neg

N = 1:numel(CA1_1000_uA);
for i = 1:numel(N)
    num_pos(i) = sum(pos_mod_1000_CA1.neurons(:,1)== N(i));
    num_neg(i) = sum(neg_mod_1000_CA1.neurons(:,1)== N(i));
    num_mod(i) = num_pos(i) + num_neg(i);
    num_non(i) = sum(non_mod_1000_CA1.neurons(:,1) == N(i));
end
sess_tot_1000_CA1 = num_mod + num_non;
num_pos_1000_CA1 = num_pos(sess_tot_1000_CA1 > 10)./sess_tot_1000_CA1(sess_tot_1000_CA1 >10).*100;
num_neg_1000_CA1 = num_neg(sess_tot_1000_CA1 > 10)./sess_tot_1000_CA1(sess_tot_1000_CA1 >10).*100;
mod_rat_1000_CA1 = num_mod(sess_tot_1000_CA1 > 10)./sess_tot_1000_CA1(sess_tot_1000_CA1 >10).*100;
clearvars num_mod num_non num_pos num_neg

N = 1:numel(M1_40_uA);
for i = 1:numel(N)
    num_pos(i) = sum(pos_mod_40_M1.neurons(:,1)== N(i));
    num_neg(i) = sum(neg_mod_40_M1.neurons(:,1)== N(i));
    num_mod(i) = num_pos(i) + num_neg(i);
    num_non(i) = sum(non_mod_40_M1.neurons(:,1) == N(i));
end
sess_tot_40_M1 = num_mod + num_non;
num_pos_40_M1 = num_pos(sess_tot_40_M1 > 10)./sess_tot_40_M1(sess_tot_40_M1 >10).*100;
num_neg_40_M1 = num_neg(sess_tot_40_M1 > 10)./sess_tot_40_M1(sess_tot_40_M1 >10).*100;
mod_rat_40_M1 = num_mod(sess_tot_40_M1 > 10)./sess_tot_40_M1(sess_tot_40_M1 >10).*100;
clearvars num_mod num_non num_pos num_neg

N = 1:numel(M1_140_uA);
for i = 1:numel(N)
    num_pos(i) = sum(pos_mod_140_M1.neurons(:,1)== N(i));
    num_neg(i) = sum(neg_mod_140_M1.neurons(:,1)== N(i));
    num_mod(i) = num_pos(i) + num_neg(i);
    num_non(i) = sum(non_mod_140_M1.neurons(:,1) == N(i));
end
sess_tot_140_M1 = num_mod + num_non;
num_pos_140_M1 = num_pos(sess_tot_140_M1 > 10)./sess_tot_140_M1(sess_tot_140_M1 >10).*100;
num_neg_140_M1 = num_neg(sess_tot_140_M1 > 10)./sess_tot_140_M1(sess_tot_140_M1 >10).*100;
mod_rat_140_M1 = num_mod(sess_tot_140_M1 > 10)./sess_tot_140_M1(sess_tot_140_M1 >10).*100;
clearvars num_mod num_non num_pos num_neg

N = 1:numel(M1_1000_uA);
for i = 1:numel(N)
    num_pos(i) = sum(pos_mod_1000_M1.neurons(:,1)== N(i));
    num_neg(i) = sum(neg_mod_1000_M1.neurons(:,1)== N(i));
    num_mod(i) = num_pos(i) + num_neg(i);
    num_non(i) = sum(non_mod_1000_M1.neurons(:,1) == N(i));
end
sess_tot_1000_M1 = num_mod + num_non;
num_pos_1000_M1 = num_pos(sess_tot_1000_M1 > 10)./sess_tot_1000_M1(sess_tot_1000_M1 >10).*100;
num_neg_1000_M1 = num_neg(sess_tot_1000_M1 > 10)./sess_tot_1000_M1(sess_tot_1000_M1 >10).*100;
mod_rat_1000_M1 = num_mod(sess_tot_1000_M1 > 10)./sess_tot_1000_M1(sess_tot_1000_M1 >10).*100;
clearvars num_mod num_non num_pos num_neg

figure;
hold on
plot(CA1_40_chargeDens(sess_tot_40_CA1 > 10), mod_rat_40_CA1,'.','Color',color_40_CA1,'MarkerSize',12);
plot(CA1_140_chargeDens(sess_tot_140_CA1 > 10), mod_rat_140_CA1,'.','Color',color_140_CA1,'MarkerSize',12);
plot(CA1_1000_chargeDens(sess_tot_1000_CA1 > 10), mod_rat_1000_CA1,'.','Color',color_1000_CA1,'MarkerSize',12);
plot(M1_40_chargeDens(sess_tot_40_M1 > 10), mod_rat_40_M1,'.','Color',color_40_M1,'MarkerSize',12);
plot(M1_140_chargeDens(sess_tot_140_M1 > 10), mod_rat_140_M1,'.','Color',color_140_M1,'MarkerSize',12);
plot(M1_1000_chargeDens(sess_tot_1000_M1 > 10), mod_rat_1000_M1,'.','Color',color_1000_M1,'MarkerSize',12);
legend({'40Hz in CA1','140Hz in CA1','1kHz in CA1','40Hz in M1','140Hz in M1','1kHz in M1'});
xlabel('Charge Density (uC/cm^2/phase)')
ylabel('%modulated')
title('Charge Density vs %modulated neurons (exclude sess with < 10 neurons)');
saveas(gcf,[save_path '/charge_density_vs_ratio_modulated.fig']);

figure;
hold on
plot(CA1_40_chargeDens(sess_tot_40_CA1 > 10), num_pos_40_CA1,'.','Color',color_40_CA1,'MarkerSize',12);
plot(CA1_140_chargeDens(sess_tot_140_CA1 > 10), num_pos_140_CA1,'.','Color',color_140_CA1,'MarkerSize',12);
plot(CA1_1000_chargeDens(sess_tot_1000_CA1 > 10), num_pos_1000_CA1,'.','Color',color_1000_CA1,'MarkerSize',12);
plot(M1_40_chargeDens(sess_tot_40_M1 > 10), num_pos_40_M1,'.','Color',color_40_M1,'MarkerSize',12);
plot(M1_140_chargeDens(sess_tot_140_M1 > 10), num_pos_140_M1,'.','Color',color_140_M1,'MarkerSize',12);
plot(M1_1000_chargeDens(sess_tot_1000_M1 > 10), num_pos_1000_M1,'.','Color',color_1000_M1,'MarkerSize',12);

x = [CA1_40_chargeDens(sess_tot_40_CA1 > 10),...
    CA1_140_chargeDens(sess_tot_140_CA1 > 10),...
    CA1_1000_chargeDens(sess_tot_1000_CA1 > 10),...
    M1_40_chargeDens(sess_tot_40_M1 > 10),...
    M1_140_chargeDens(sess_tot_140_M1 > 10),...
    M1_1000_chargeDens(sess_tot_1000_M1 > 10)];
y = [num_pos_40_CA1,...
     num_pos_140_CA1,...
     num_pos_1000_CA1,...
     num_pos_40_M1,...
     num_pos_140_M1,...
     num_pos_1000_M1]; 
p = polyfit(x,y,1);
yfit = polyval(p,x);
yresid = yfit-y;
SSresid = sum(yresid.^2);
SStotal = (size(y,2)-1) * var(y);
rsq = 1 - SSresid/SStotal

yfit2 = polyval(p,linspace(0,300,100));
plot(linspace(0,300,100),yfit2,'k-');
text(150,20,['R^2 = ' num2str(rsq)])
legend({'40Hz in CA1','140Hz in CA1','1kHz in CA1','40Hz in M1','140Hz in M1','1kHz in M1'});
xlabel('Charge Density (uC/cm^2/phase)')
ylabel('%activated')
title('Charge Density vs %activated neurons (exclude sess with < 10 neurons)');
saveas(gcf,[save_path '/charge_density_vs_ratio_activated.fig']);

figure;
hold on
plot(CA1_40_chargeDens(sess_tot_40_CA1 > 10), num_neg_40_CA1,'.','Color',color_40_CA1,'MarkerSize',12);
plot(CA1_140_chargeDens(sess_tot_140_CA1 > 10), num_neg_140_CA1,'.','Color',color_140_CA1,'MarkerSize',12);
plot(CA1_1000_chargeDens(sess_tot_1000_CA1 > 10), num_neg_1000_CA1,'.','Color',color_1000_CA1,'MarkerSize',12);
plot(M1_40_chargeDens(sess_tot_40_M1 > 10), num_neg_40_M1,'.','Color',color_40_M1,'MarkerSize',12);
plot(M1_140_chargeDens(sess_tot_140_M1 > 10), num_neg_140_M1,'.','Color',color_140_M1,'MarkerSize',12);
plot(M1_1000_chargeDens(sess_tot_1000_M1 > 10), num_neg_1000_M1,'.','Color',color_1000_M1,'MarkerSize',12);

y = [num_neg_40_CA1,...
     num_neg_140_CA1,...
     num_neg_1000_CA1,...
     num_neg_40_M1,...
     num_neg_140_M1,...
     num_neg_1000_M1]; 
p = polyfit(x,y,1);
yfit = polyval(p,x);
yresid = yfit-y;
SSresid = sum(yresid.^2);
SStotal = (size(y,2)-1) * var(y);
rsq = 1 - SSresid/SStotal

yfit2 = polyval(p,linspace(0,300,100));
plot(linspace(0,300,100),yfit2,'k-');
text(150,20,['R^2 = ' num2str(rsq)])
legend({'40Hz in CA1','140Hz in CA1','1kHz in CA1','40Hz in M1','140Hz in M1','1kHz in M1'});
xlabel('Charge Density (uC/cm^2/phase)')
ylabel('%suppressed')
title('Charge Density vs %inhibited neurons (exclude sess with < 10 neurons)');
saveas(gcf,[save_path '/charge_density_vs_ratio_inhibited.fig']);

figure;
hold on
plot(categorical(CA1_40_ID), CA1_40_chargeDens,'.','Color',color_40_CA1,'MarkerSize',12);
plot(categorical(CA1_140_ID), CA1_140_chargeDens,'.','Color',color_140_CA1,'MarkerSize',12);
plot(categorical(CA1_1000_ID), CA1_1000_chargeDens,'.','Color',color_1000_CA1,'MarkerSize',12);
plot(categorical(M1_40_ID), M1_40_chargeDens,'.','Color',color_40_M1,'MarkerSize',12);
plot(categorical(M1_140_ID), M1_140_chargeDens,'.','Color',color_140_M1,'MarkerSize',12);
plot(categorical(M1_1000_ID), M1_1000_chargeDens,'.','Color',color_1000_M1,'MarkerSize',12);
legend({'40Hz in CA1','140Hz in CA1','1kHz in CA1','40Hz in M1','140Hz in M1','1kHz in M1'});
xlabel('Mouse ID')
ylabel('Charge Density (uC/cm^2/phase)')
title('Mouse ID vs Charge Density');
saveas(gcf,[save_path '/charge_density_vs_mouseID.fig']);

% figure;
% hold on
% plot(CA1_40_chargeDens(sess_tot_40_CA1 > 10), num_neg_40_CA1-num_pos_40_CA1,'.','Color',color_40_CA1,'MarkerSize',12);
% plot(CA1_140_chargeDens(sess_tot_140_CA1 > 10), num_neg_140_CA1-num_pos_140_CA1,'.','Color',color_140_CA1,'MarkerSize',12);
% plot(CA1_1000_chargeDens(sess_tot_1000_CA1 > 10), num_neg_1000_CA1-num_pos_1000_CA1,'.','Color',color_1000_CA1,'MarkerSize',12);
% plot(M1_40_chargeDens(sess_tot_40_M1 > 10), num_neg_40_M1-num_pos_40_M1,'.','Color',color_40_M1,'MarkerSize',12);
% plot(M1_140_chargeDens(sess_tot_140_M1 > 10), num_neg_140_M1-num_pos_140_M1,'.','Color',color_140_M1,'MarkerSize',12);
% plot(M1_1000_chargeDens(sess_tot_1000_M1 > 10), num_neg_1000_M1-num_pos_1000_M1,'.','Color',color_1000_M1,'MarkerSize',12);
% yline(0);
% legend({'40Hz in CA1','140Hz in CA1','1kHz in CA1','40Hz in M1','140Hz in M1','1kHz in M1'});
% xlabel('Charge Density (uC/cm^2/phase)')
% ylabel('Difference in %modulated')
% title('Charge Density vs %inhibited - %activated (exclude sess with < 10 neurons)');
% saveas(gcf,[save_path '/charge_density_vs_inhib_minus_act.fig']);

figure;
hold on
plot(CA1_40_totCharge(sess_tot_40_CA1 > 10), mod_rat_40_CA1,'.','Color',color_40_CA1,'MarkerSize',12);
plot(CA1_140_totCharge(sess_tot_140_CA1 > 10), mod_rat_140_CA1,'.','Color',color_140_CA1,'MarkerSize',12);
plot(CA1_1000_totCharge(sess_tot_1000_CA1 > 10), mod_rat_1000_CA1,'.','Color',color_1000_CA1,'MarkerSize',12);
plot(M1_40_totCharge(sess_tot_40_M1 > 10), mod_rat_40_M1,'.','Color',color_40_M1,'MarkerSize',12);
plot(M1_140_totCharge(sess_tot_140_M1 > 10), mod_rat_140_M1,'.','Color',color_140_M1,'MarkerSize',12);
plot(M1_1000_totCharge(sess_tot_1000_M1 > 10), mod_rat_1000_M1,'.','Color',color_1000_M1,'MarkerSize',12);
legend({'40Hz in CA1','140Hz in CA1','1kHz in CA1','40Hz in M1','140Hz in M1','1kHz in M1'});
xlabel('Total Absolute Charge Delivered (uC)')
ylabel('%modulated')
title('Charge Delivered vs %modulated neurons (exclude sess with < 10 neurons)');
saveas(gcf,[save_path '/charge_delivered_vs_ratio_modulated.fig']);

figure;
hold on
plot(CA1_40_totCharge(sess_tot_40_CA1 > 10), num_pos_40_CA1,'.','Color',color_40_CA1,'MarkerSize',12);
plot(CA1_140_totCharge(sess_tot_140_CA1 > 10), num_pos_140_CA1,'.','Color',color_140_CA1,'MarkerSize',12);
plot(CA1_1000_totCharge(sess_tot_1000_CA1 > 10), num_pos_1000_CA1,'.','Color',color_1000_CA1,'MarkerSize',12);
plot(M1_40_totCharge(sess_tot_40_M1 > 10), num_pos_40_M1,'.','Color',color_40_M1,'MarkerSize',12);
plot(M1_140_totCharge(sess_tot_140_M1 > 10), num_pos_140_M1,'.','Color',color_140_M1,'MarkerSize',12);
plot(M1_1000_totCharge(sess_tot_1000_M1 > 10), num_pos_1000_M1,'.','Color',color_1000_M1,'MarkerSize',12);

x = [CA1_40_totCharge(sess_tot_40_CA1 > 10),...
    CA1_140_totCharge(sess_tot_140_CA1 > 10),...
    CA1_1000_totCharge(sess_tot_1000_CA1 > 10),...
    M1_40_totCharge(sess_tot_40_M1 > 10),...
    M1_140_totCharge(sess_tot_140_M1 > 10),...
    M1_1000_totCharge(sess_tot_1000_M1 > 10)];
y = [num_pos_40_CA1,...
     num_pos_140_CA1,...
     num_pos_1000_CA1,...
     num_pos_40_M1,...
     num_pos_140_M1,...
     num_pos_1000_M1]; 
p = polyfit(x,y,1);
yfit = polyval(p,x);
yresid = yfit-y;
SSresid = sum(yresid.^2);
SStotal = (size(y,2)-1) * var(y);
rsq = 1 - SSresid/SStotal

yfit2 = polyval(p,linspace(0,300,100));
plot(linspace(0,300,100),yfit2,'k-');
text(150,20,['R^2 = ' num2str(rsq)])
legend({'40Hz in CA1','140Hz in CA1','1kHz in CA1','40Hz in M1','140Hz in M1','1kHz in M1'});
xlabel('Total Absolute Charge Delivered (uC)')
ylabel('%activated')
title('Charge Delivered vs %activated neurons (exclude sess with < 10 neurons)');
saveas(gcf,[save_path '/charge_delivered_vs_ratio_activated.fig']);

figure;
hold on
plot(CA1_40_totCharge(sess_tot_40_CA1 > 10), num_neg_40_CA1,'.','Color',color_40_CA1,'MarkerSize',12);
plot(CA1_140_totCharge(sess_tot_140_CA1 > 10), num_neg_140_CA1,'.','Color',color_140_CA1,'MarkerSize',12);
plot(CA1_1000_totCharge(sess_tot_1000_CA1 > 10), num_neg_1000_CA1,'.','Color',color_1000_CA1,'MarkerSize',12);
plot(M1_40_totCharge(sess_tot_40_M1 > 10), num_neg_40_M1,'.','Color',color_40_M1,'MarkerSize',12);
plot(M1_140_totCharge(sess_tot_140_M1 > 10), num_neg_140_M1,'.','Color',color_140_M1,'MarkerSize',12);
plot(M1_1000_totCharge(sess_tot_1000_M1 > 10), num_neg_1000_M1,'.','Color',color_1000_M1,'MarkerSize',12);

y = [num_neg_40_CA1,...
     num_neg_140_CA1,...
     num_neg_1000_CA1,...
     num_neg_40_M1,...
     num_neg_140_M1,...
     num_neg_1000_M1]; 
p = polyfit(x,y,1);
yfit = polyval(p,x);
yresid = yfit-y;
SSresid = sum(yresid.^2);
SStotal = (size(y,2)-1) * var(y);
rsq = 1 - SSresid/SStotal

yfit2 = polyval(p,linspace(0,300,100));
plot(linspace(0,300,100),yfit2,'k-');
text(150,20,['R^2 = ' num2str(rsq)])
legend({'40Hz in CA1','140Hz in CA1','1kHz in CA1','40Hz in M1','140Hz in M1','1kHz in M1'});
xlabel('Total Absolute Charge Delivered (uC)')
ylabel('%suppressed')
title('Charge Delivered vs %inhibited neurons (exclude sess with < 10 neurons)');
saveas(gcf,[save_path '/charge_delivered_vs_ratio_inhibited.fig']);

figure;
hold on
plot(categorical(CA1_40_ID), CA1_40_totCharge,'.','Color',color_40_CA1,'MarkerSize',12);
plot(categorical(CA1_140_ID), CA1_140_totCharge,'.','Color',color_140_CA1,'MarkerSize',12);
plot(categorical(CA1_1000_ID), CA1_1000_totCharge,'.','Color',color_1000_CA1,'MarkerSize',12);
plot(categorical(M1_40_ID), M1_40_totCharge,'.','Color',color_40_M1,'MarkerSize',12);
plot(categorical(M1_140_ID), M1_140_totCharge,'.','Color',color_140_M1,'MarkerSize',12);
plot(categorical(M1_1000_ID), M1_1000_totCharge,'.','Color',color_1000_M1,'MarkerSize',12);
legend({'40Hz in CA1','140Hz in CA1','1kHz in CA1','40Hz in M1','140Hz in M1','1kHz in M1'});
xlabel('Mouse ID')
ylabel('Total Absolute Charge Delivered (uC)')
title('Mouse ID vs Charge Density');
saveas(gcf,[save_path '/charge_delivered_vs_mouseID.fig']);

%% Current vs days-post surgery

 %- CA1 -%
data40_CA1_dates = readmatrix('/home/hanlabadmins/handata_server/Cara_Ravasio/Data/GCaMP_Data_Extraction/Hippocampus/data40_CA1_dates.txt');
for i=1:size(data40_CA1_dates,1)
    temp = string(split(between(datetime(num2str(data40_CA1_dates(i,2)),'InputFormat','yyyyMMdd'),...
           datetime(num2str(data40_CA1_dates(i,1)),'InputFormat','yyyyMMdd'),'days'),{'days'}));
    data40_CA1_days_post_surg(i) = str2num(temp);

    temp = split(data40_CA1(i).name,{'_trials'});
    temp = split(temp{1},'_');
    curr_40CA1(i) = str2num(temp{end});
    

    temp = split(data40_CA1(i).name,{'_'});
    mouse_id_40CA1{i} = temp{3}; 
end

data140_CA1_dates = readmatrix('/home/hanlabadmins/handata_server/Cara_Ravasio/Data/GCaMP_Data_Extraction/Hippocampus/data140_CA1_dates.txt');
for i=1:size(data140_CA1_dates,1)
    temp = string(split(between(datetime(num2str(data140_CA1_dates(i,2)),'InputFormat','yyyyMMdd'),...
           datetime(num2str(data140_CA1_dates(i,1)),'InputFormat','yyyyMMdd'),'days'),{'days'}));
    data140_CA1_days_post_surg(i) = str2num(temp);

    temp = split(data140_CA1(i).name,{'_trials'});
    temp = split(temp{1},'_');
    curr_140CA1(i) = str2num(temp{end});

    temp = split(data140_CA1(i).name,{'_'});
    mouse_id_140CA1{i} = temp{3}; 
end

% The dates are saved so rec_date is first and surgery_date is second
data1000_CA1_dates = readmatrix('/home/hanlabadmins/handata_server/Cara_Ravasio/Data/GCaMP_Data_Extraction/Hippocampus/data1000_CA1_dates.txt');
for i=1:size(data1000_CA1_dates,1)
    temp = string(split(between(datetime(num2str(data1000_CA1_dates(i,2)),'InputFormat','yyyyMMdd'),...
           datetime(num2str(data1000_CA1_dates(i,1)),'InputFormat','yyyyMMdd'),'days'),{'days'}));
    data1000_CA1_days_post_surg(i) = str2num(temp);

    temp = split(data1000_CA1(i).name,{'_trials'});
    temp = split(temp{1},'_');
    curr_1000CA1(i) = str2num(temp{end});

    temp = split(data1000_CA1(i).name,{'_'});
    mouse_id_1000CA1{i} = temp{3}; 
end

marker_style = {'o','d','^','s','>','p','v','h'};
figure;
hold on
mice = unique([mouse_id_40CA1,mouse_id_140CA1, mouse_id_1000CA1]);
for i=1:numel(mice)
    mask40 = strcmp(mouse_id_40CA1,mice{1,i}); 
    [sorted,idx] = sort(data40_CA1_days_post_surg(mask40),'ascend');
    temp = curr_40CA1(mask40);
    plot(sorted,temp(idx),'Marker',marker_style{i},'Color',color_40_CA1,...
        'MarkerFaceColor',color_40_CA1,'MarkerSize', 12);
    
    mask140 = strcmp(mouse_id_140CA1,mice{1,i}); 
    [sorted,idx] = sort(data140_CA1_days_post_surg(mask140),'ascend');
    temp = curr_140CA1(mask140);
    plot(sorted, temp(idx),'Marker',marker_style{i},'Color',color_140_CA1,...
        'MarkerFaceColor', color_140_CA1,'MarkerSize', 8);

    mask1000 = strcmp(mouse_id_1000CA1,mice{1,i});
    [sorted,idx] = sort(data1000_CA1_days_post_surg(mask1000),'ascend');
    temp = curr_1000CA1(mask1000);
    plot(sorted, temp(idx),'Marker',marker_style{i},'Color',color_1000_CA1,...
        'MarkerFaceColor', color_1000_CA1,'MarkerSize', 6); 
end
legend(sort([unique(mouse_id_40CA1),unique(mouse_id_140CA1), unique(mouse_id_1000CA1)])...
       ,'Location','northeastoutside');
xlabel('Days post surgery');
ylabel('Current delivered (uA)');
title('Current Delivered in CA1 as a function of time');
saveas(gcf,[save_path '/Current_over_time/CA1_current_ov_time.fig']);


%- M1 -%

data40_M1_dates = readmatrix('/home/hanlabadmins/handata_server/Cara_Ravasio/Data/GCaMP_Data_Extraction/Neocortex/data40_M1_dates.txt');
for i=1:size(data40_M1_dates,1)
    temp = string(split(between(datetime(num2str(data40_M1_dates(i,2)),'InputFormat','yyyyMMdd'),...
           datetime(num2str(data40_M1_dates(i,1)),'InputFormat','yyyyMMdd'),'days'),{'days'}));
    data40_M1_days_post_surg(i) = str2num(temp);

    temp = split(data40_M1(i).name,{'_trials'});
    temp = split(temp{1},'_');
    curr_40M1(i) = str2num(temp{end});

    temp = split(data40_M1(i).name,{'_'});
    mouse_id_40M1{i} = temp{3}; 
end

data140_M1_dates = readmatrix('/home/hanlabadmins/handata_server/Cara_Ravasio/Data/GCaMP_Data_Extraction/Neocortex/data140_M1_dates.txt');
for i=1:size(data140_M1_dates,1)
    temp = string(split(between(datetime(num2str(data140_M1_dates(i,2)),'InputFormat','yyyyMMdd'),...
           datetime(num2str(data140_M1_dates(i,1)),'InputFormat','yyyyMMdd'),'days'),{'days'}));
    data140_M1_days_post_surg(i) = str2num(temp);

    temp = split(data140_M1(i).name,{'_trials'});
    temp = split(temp{1},'_');
    curr_140M1(i) = str2num(temp{end});

    temp = split(data140_M1(i).name,{'_'});
    mouse_id_140M1{i} = temp{3}; 
end

data1000_M1_dates = readmatrix('/home/hanlabadmins/handata_server/Cara_Ravasio/Data/GCaMP_Data_Extraction/Neocortex/data1000_M1_dates.txt');
for i=1:size(data1000_M1_dates,1)
    temp = string(split(between(datetime(num2str(data1000_M1_dates(i,2)),'InputFormat','yyyyMMdd'),...
           datetime(num2str(data1000_M1_dates(i,1)),'InputFormat','yyyyMMdd'),'days'),{'days'}));
    data1000_M1_days_post_surg(i) = str2num(temp);

    temp = split(data1000_M1(i).name,{'_trials'});
    temp = split(temp{1},'_');
    curr_1000M1(i) = str2num(temp{end});

    temp = split(data1000_M1(i).name,{'_'});
    mouse_id_1000M1{i} = temp{3}; 
end

marker_style = {'o','d','^','s','>','p','v','h'};
figure;
hold on
mice = unique([mouse_id_40M1,mouse_id_140M1, mouse_id_1000M1]);
for i=1:numel(mice)
    mask40 = strcmp(mouse_id_40M1,mice{1,i}); 
    [sorted,idx] = sort(data40_M1_days_post_surg(mask40),'ascend');
    temp = curr_40M1(mask40);
    plot(sorted,temp(idx),'Marker',marker_style{i},'Color',color_40_M1,...
        'MarkerFaceColor',color_40_M1,'MarkerSize', 12);
    
    mask140 = strcmp(mouse_id_140M1,mice{1,i}); 
    [sorted,idx] = sort(data140_M1_days_post_surg(mask140),'ascend');
    temp = curr_140M1(mask140);
    plot(sorted, temp(idx),'Marker',marker_style{i},'Color',color_140_M1,...
        'MarkerFaceColor', color_140_M1,'MarkerSize', 8);

    mask1000 = strcmp(mouse_id_1000M1,mice{1,i});
    [sorted,idx] = sort(data1000_M1_days_post_surg(mask1000),'ascend');
    temp = curr_1000M1(mask1000);
    plot(sorted, temp(idx),'Marker',marker_style{i},'Color',color_1000_M1,...
        'MarkerFaceColor', color_1000_M1,'MarkerSize', 6); 
end
legend(sort([unique(mouse_id_40M1),unique(mouse_id_140M1), unique(mouse_id_1000M1)])...
       ,'Location','northeastoutside');
xlabel('Days post surgery');
ylabel('Current delivered (uA)');
title('Current Delivered in M1 as a function of time');
saveas(gcf,[save_path '/Current_over_time/M1_current_ov_time.fig']);

%% Creating a table of "Source Data" for the reviewers
% Cols: region, freq(Hz), mouseID, rec#, rec_date, current(uA), neuron#, neuronID, trial, frame_1, frame_2..., frame_400

source_data_table = table([],[],[],[],[],[],[],[],[],[],'VariableNames',...
                    {'brain_region','stim_freq_Hz','mouseID','rec_num',...
                    'rec_date_days_post_surgery','current_uA',...
                    'neuron_num','stim_evoked_responseID',...
                    'trial_num','BG_subtracted_scaled_trace_frame'});
for i=1:2 % iterate through brain regions ("CA1" or "Cortex")
    for j=1:3 % iterate through stim freq  
        %- Set Freq and Region -%
        if i == 1 % 1 = 'CA1'
            temp_reg = "CA1";
            if j == 1 % 40Hz
                temp_freq = 40;
                data = data40_CA1;
                days_post = data40_CA1_days_post_surg;
                pos_mod = pos_mod_40_CA1;
                neg_mod = neg_mod_40_CA1;
            elseif j == 2 % 140Hz
                temp_freq = 140;
                data = data140_CA1;
                days_post = data140_CA1_days_post_surg;
                pos_mod = pos_mod_140_CA1;
                neg_mod = neg_mod_140_CA1;
            else % 1kHz
                temp_freq = 1000;
                data = data1000_CA1;
                days_post = data1000_CA1_days_post_surg;
                pos_mod = pos_mod_1000_CA1;
                neg_mod = neg_mod_1000_CA1;
            end
        else
            temp_reg = "Cortex";
            if j == 1 % 40Hz
                temp_freq = 40;
                data = data40_M1;
                days_post = data40_M1_days_post_surg;
                pos_mod = pos_mod_40_M1;
                neg_mod = neg_mod_40_M1;
            elseif j == 2 % 140Hz
                temp_freq = 140;
                data = data140_M1;
                days_post = data140_M1_days_post_surg;
                pos_mod = pos_mod_140_M1;
                neg_mod = neg_mod_140_M1;
            else % 1kHz
                temp_freq = 1000;
                data = data1000_M1;
                days_post = data1000_M1_days_post_surg;
                pos_mod = pos_mod_1000_M1;
                neg_mod = neg_mod_1000_M1;
            end
        end
        
        %- Set MouseID rec# rec_date and current -%
        for k=1:numel(data) % iterate through recording sessions
            s = strsplit(data(k).name,'_');

            temp_mouseID = convertCharsToStrings(s{3}); % Will go back through to fix
            temp_rec = str2num(s{4}(4:end)) + str2num(s{5}(end)); % Will go back and fix after, but for now rec.fov
            temp_date = days_post(k);
            temp_curr = str2num(s{end-2});

            for m = 1:numel(data(k).roi_data.goodIdx) % iterate through neurons
                temp_neuron = m;
                if sum(pos_mod.neurons(:,1) == k & pos_mod.neurons(:,2) == m)
                    temp_classID = "activated";
                elseif sum(neg_mod.neurons(:,1) == k & neg_mod.neurons(:,2) == m)
                    temp_classID = "suppressed";
                else
                    temp_classID = "unchanged";
                end

                temp_trial = [1:size(data(k).roi_data.trace_minusBG_new_DN_reshaped,3)]'; % 3rd dim is # trials
                temp_trace = squeeze(data(k).roi_data.trace_minusBG_new_DN_reshaped(m,:,:))';

                reps = numel(temp_trial);
                temp_tbl = table(repmat(temp_reg,[reps,1]), repmat(temp_freq,[reps,1]),...
                                repmat(temp_mouseID,[reps,1]),repmat(temp_rec,[reps,1]),...
                                repmat(temp_date,[reps,1]), repmat(temp_curr,[reps,1]),...
                                repmat(temp_neuron,[reps,1]),repmat(temp_classID,[reps,1]),...
                                temp_trial, temp_trace,'VariableNames',...
                                {'brain_region','stim_freq_Hz','mouseID','rec_num',...
                                'rec_date_days_post_surgery','current_uA',...
                                'neuron_num','stim_evoked_responseID',...
                                'trial_num','BG_subtracted_scaled_trace_frame'});
                source_data_table = [source_data_table; temp_tbl];
            end
        end
    end
end

% Correct for the mouse and rec numbers to be more generic
mice_names = unique(source_data_table.mouseID);
for i=1:numel(mice_names)
    mouse_mask = strcmp(source_data_table.mouseID, mice_names(i));
    temp_recs = unique(source_data_table(mouse_mask));
    for j = 1:numel(temp_recs)
        rec_mask = source_data_table.rec == temp_recs(j);
        source_data_table(mouse_mask & rec_mask) = j;
    end
    source_data_table(mouse_mask) = i; 
end

writetable(source_data_table,'source_data_table.csv');