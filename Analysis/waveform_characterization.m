% waveform_characterization.m
% 
% Date: 12/05/22
% Author: Cara Ravasio
% Purpose: This script characterizes the average traces from the transient
% DBS GCaMP recordings. It uses the (1) slope, (2) AUC, (3) delay (time to
% half peak), (4) FWHM, (5) peak height, and (6) sharpness (assymmetry?) .
% The output is violin plots comparing the populations.

%% Setup
addpath(genpath('/home/hanlabadmins/handata_server/Cara_Ravasio/Code/GCaMP_Data_Extraction'));
save_path = '/home/hanlabadmins/handata_server/Cara_Ravasio/Data/GCaMP_Data_Extraction/Paper_Figures_Clean_Data';

cd(save_path);
Fs = 20; % Hz
pvals_struct = {};

%Setting up color scheme for figures (Colorblind friendly)
white = [255 255 255]/255;
purple = [0.494,0.184,0.556];%[197 28 124]/255;%[136 26 88]/255; %40Hz
orange = [0.85,0.325,0.098];%[249 81 8]/255;%[165 54 6]/255; %140Hz
blue = [0, 0.447,0.741];%[57 150 191]/255;%[22 76 100]/255; %100Hz
length = 200; % the number of color steps included in the colormap

color_40_CA1 = purple;
color_140_CA1 = orange;
color_1000_CA1 = blue;

colormap_40 = [linspace(white(1),purple(1), length)',linspace(white(2),purple(2), length)',linspace(white(3),purple(3), length)'];
colormap_140 = [linspace(white(1),orange(1), length)',linspace(white(2),orange(2), length)',linspace(white(3),orange(3), length)'];
colormap_1000 = [linspace(white(1),blue(1), length)',linspace(white(2),blue(2), length)',linspace(white(3),blue(3), length)'];

color_40_M1 = colormap_40(length/2,:);
color_140_M1 = colormap_140(length/2,:);
color_1000_M1 = colormap_1000(length/2,:);

bcolor=[color_40_CA1;color_40_M1;color_140_CA1;color_140_M1;color_1000_CA1;color_1000_M1];
%% Load .mat waveform files

try
    %CA1
    load([save_path,'/pos_40_hip.mat']);
    load([save_path,'/pos_140_hip.mat']);
    load([save_path,'/pos_1000_hip.mat']);
    
    load([save_path,'/neg_40_hip.mat']);
    load([save_path,'/neg_140_hip.mat']);
    load([save_path,'/neg_1000_hip.mat']);
    
    load([save_path,'/reb_40_hip.mat']);
    load([save_path,'/reb_140_hip.mat']);
    load([save_path,'/reb_1000_hip.mat']);
    
    base_hip_path = '/home/hanlabadmins/handata_server/Cara_Ravasio/Data/GCaMP_Data_Extraction/Hippocampus/Good_Recordings_Data_Files/';
    load([base_hip_path, 'non_mod_40_struct_s.mat']);
    load([base_hip_path, 'non_mod_140_struct_s.mat']);
    load([base_hip_path, 'non_mod_1000_struct_s.mat']);
    non_40_hip = non_mod_40_s;
    non_140_hip = non_mod_140_s;
    non_1000_hip = non_mod_1000_s;
    
    %M1
    load([save_path,'/pos_40_cort.mat']);
    load([save_path,'/pos_140_cort.mat']);
    load([save_path,'/pos_1000_cort.mat']);
    
    load([save_path,'/neg_40_cort.mat']);
    load([save_path,'/neg_140_cort.mat']);
    load([save_path,'/neg_1000_cort.mat']);
    
    load([save_path,'/reb_40_cort.mat']);
    load([save_path,'/reb_140_cort.mat']);
    load([save_path,'/reb_1000_cort.mat']);
    
    base_cort_path = '/home/hanlabadmins/handata_server/Cara_Ravasio/Data/GCaMP_Data_Extraction/Neocortex/Good_Recordings_Data_Files/';
    load([base_cort_path, 'non_mod_40_struct_s.mat']);
    load([base_cort_path, 'non_mod_140_struct_s.mat']);
    load([base_cort_path, 'non_mod_1000_struct_s.mat']);
    non_40_cort = non_mod_40_s;
    non_140_cort = non_mod_140_s;
    non_1000_cort = non_mod_1000_s;
    
catch
%CA1
    base_hip_path = '/home/hanlabadmins/handata_server/Cara_Ravasio/Data/GCaMP_Data_Extraction/Hippocampus/Good_Recordings_Data_Files/';
    
    %40Hz
    load([base_hip_path, 'pos_mod_40_struct_s.mat']);
    load([base_hip_path, 'rebound_40_struct_s.mat']);
    load([base_hip_path, 'neg_mod_40_struct_s.mat']);
    pos_40_hip = pos_mod_40_s; 
    reb_40_hip = rebound_40_s;
    neg_40_hip = neg_mod_40_s;
    
    %140Hz
    load([base_hip_path, 'pos_mod_140_struct_s.mat']);
    load([base_hip_path, 'rebound_140_struct_s.mat']);
    load([base_hip_path, 'neg_mod_140_struct_s.mat']);
    pos_140_hip = pos_mod_140_s; 
    reb_140_hip = rebound_140_s;
    neg_140_hip = neg_mod_140_s;

    %1000Hz
    load([base_hip_path, 'pos_mod_1000_struct_s.mat']);
    load([base_hip_path, 'rebound_1000_struct_s.mat']);
    load([base_hip_path, 'neg_mod_1000_struct_s.mat']);
    pos_1000_hip = pos_mod_1000_s; 
    reb_1000_hip = rebound_1000_s;
    neg_1000_hip = neg_mod_1000_s;
    
%M1
base_cort_path = '/home/hanlabadmins/handata_server/Cara_Ravasio/Data/GCaMP_Data_Extraction/Neocortex/Good_Recordings_Data_Files/';

    %40Hz
    load([base_cort_path, 'pos_mod_40_struct_s.mat']);
    load([base_cort_path, 'rebound_40_struct_s.mat']);
    load([base_cort_path, 'neg_mod_40_struct_s.mat']);
    load([base_cort_path, 'non_mod_40_struct_s.mat']);
    pos_40_cort = pos_mod_40_s; 
    reb_40_cort = rebound_40_s;
    neg_40_cort = neg_mod_40_s;
    non_40_cort = non_mod_40_s;
    
    %140Hz
    load([base_cort_path, 'pos_mod_140_struct_s.mat']);
    load([base_cort_path, 'rebound_140_struct_s.mat']);
    load([base_cort_path, 'neg_mod_140_struct_s.mat']);
    load([base_cort_path, 'non_mod_140_struct_s.mat']);
    pos_140_cort = pos_mod_140_s; 
    reb_140_cort = rebound_140_s;
    neg_140_cort = neg_mod_140_s;
    non_140_cort = non_mod_140_s;

    %1000Hz
    load([base_cort_path, 'pos_mod_1000_struct_s.mat']);
    load([base_cort_path, 'rebound_1000_struct_s.mat']);
    load([base_cort_path, 'neg_mod_1000_struct_s.mat']);
    load([base_cort_path, 'non_mod_1000_struct_s.mat']);
    pos_1000_cort = pos_mod_1000_s; 
    reb_1000_cort = rebound_1000_s;
    neg_1000_cort = neg_mod_1000_s;
    non_1000_cort = non_mod_1000_s;
    
%% Session wise comparison of average waveforms (avg over a session)
%Any session with 3 or more neurons responding in certain manner are used
%to create an average waveform for the session

% pos hip
pos_40_hip = session_avg(pos_40_hip);
pos_140_hip = session_avg(pos_140_hip);
pos_1000_hip = session_avg(pos_1000_hip);

% pos cort
pos_40_cort = session_avg(pos_40_cort);
pos_140_cort = session_avg(pos_140_cort);
pos_1000_cort = session_avg(pos_1000_cort);

% neg hip
neg_40_hip = session_avg(neg_40_hip);
neg_140_hip = session_avg(neg_140_hip);
neg_1000_hip = session_avg(neg_1000_hip);

% neg cort
neg_40_cort = session_avg(neg_40_cort);
neg_140_cort = session_avg(neg_140_cort);
neg_1000_cort = session_avg(neg_1000_cort);

% reb hip
reb_40_hip = session_avg(reb_40_hip);
reb_140_hip = session_avg(reb_140_hip);
reb_1000_hip = session_avg(reb_1000_hip);

% reb cort
reb_40_cort = session_avg(reb_40_cort);
reb_140_cort = session_avg(reb_140_cort);
reb_1000_cort = session_avg(reb_1000_cort);

  
%% Smooth Traces
smooth_win = 5;
%============================= Positive ==================================%
%pos hip
smooth_avg_pos_40_hip = smooth(pos_40_hip.avg_trace)';
smooth_avg_pos_140_hip = smooth(pos_140_hip.avg_trace)';
smooth_avg_pos_1000_hip = smooth(pos_1000_hip.avg_trace)';

smooth_pos_40_hip = smoothdata(pos_40_hip.traces,2,'movmean',smooth_win); %smooth data along the second dimension with a moving average window size 5
smooth_pos_140_hip = smoothdata(pos_140_hip.traces,2,'movmean',smooth_win);
smooth_pos_1000_hip = smoothdata(pos_1000_hip.traces,2,'movmean',smooth_win);

smooth_sess_pos_40_hip = smoothdata(pos_40_hip.session_avg_traces,2,'movmean',smooth_win);
smooth_sess_pos_140_hip = smoothdata(pos_140_hip.session_avg_traces,2,'movmean',smooth_win);
smooth_sess_pos_1000_hip = smoothdata(pos_1000_hip.session_avg_traces,2,'movmean',smooth_win);

%pos cort
smooth_avg_pos_40_cort = smooth(pos_40_cort.avg_trace)';
smooth_avg_pos_140_cort = smooth(pos_140_cort.avg_trace)';
smooth_avg_pos_1000_cort = smooth(pos_1000_cort.avg_trace)';

smooth_pos_40_cort = smoothdata(pos_40_cort.traces,2,'movmean',smooth_win); 
smooth_pos_140_cort = smoothdata(pos_140_cort.traces,2,'movmean',smooth_win);
smooth_pos_1000_cort = smoothdata(pos_1000_cort.traces,2,'movmean',smooth_win);

smooth_sess_pos_40_cort = smoothdata(pos_40_cort.session_avg_traces,2,'movmean',smooth_win);
smooth_sess_pos_140_cort = smoothdata(pos_140_cort.session_avg_traces,2,'movmean',smooth_win);
smooth_sess_pos_1000_cort = smoothdata(pos_1000_cort.session_avg_traces,2,'movmean',smooth_win);

%=========================== Negative ====================================%
%neg hip
smooth_avg_neg_40_hip = smooth(neg_40_hip.avg_trace)';
smooth_avg_neg_140_hip = smooth(neg_140_hip.avg_trace)';
smooth_avg_neg_1000_hip = smooth(neg_1000_hip.avg_trace)';

smooth_neg_40_hip = smoothdata(neg_40_hip.traces,2,'movmean',smooth_win); 
smooth_neg_140_hip = smoothdata(neg_140_hip.traces,2,'movmean',smooth_win);
smooth_neg_1000_hip = smoothdata(neg_1000_hip.traces,2,'movmean',smooth_win);

smooth_sess_neg_40_hip = smoothdata(neg_40_hip.session_avg_traces,2,'movmean',smooth_win);
smooth_sess_neg_140_hip = smoothdata(neg_140_hip.session_avg_traces,2,'movmean',smooth_win);
smooth_sess_neg_1000_hip = smoothdata(neg_1000_hip.session_avg_traces,2,'movmean',smooth_win);

%neg cort
smooth_avg_neg_40_cort = smooth(neg_40_cort.avg_trace)';
smooth_avg_neg_140_cort = smooth(neg_140_cort.avg_trace)';
smooth_avg_neg_1000_cort = smooth(neg_1000_cort.avg_trace)';

smooth_neg_40_cort = smoothdata(neg_40_cort.traces,2,'movmean',smooth_win); 
smooth_neg_140_cort = smoothdata(neg_140_cort.traces,2,'movmean',smooth_win);
smooth_neg_1000_cort = smoothdata(neg_1000_cort.traces,2,'movmean',smooth_win);

smooth_sess_neg_40_cort = smoothdata(neg_40_cort.session_avg_traces,2,'movmean',smooth_win);
smooth_sess_neg_140_cort = smoothdata(neg_140_cort.session_avg_traces,2,'movmean',smooth_win);
smooth_sess_neg_1000_cort = smoothdata(neg_1000_cort.session_avg_traces,2,'movmean',smooth_win);

%========================== Rebound ======================================%
%reb hip
smooth_avg_reb_40_hip = smooth(reb_40_hip.avg_trace)';
smooth_avg_reb_140_hip = smooth(reb_140_hip.avg_trace)';
smooth_avg_reb_1000_hip = smooth(reb_1000_hip.avg_trace)';

smooth_reb_40_hip = smoothdata(reb_40_hip.traces,2,'movmean',smooth_win); 
smooth_reb_140_hip = smoothdata(reb_140_hip.traces,2,'movmean',smooth_win);
smooth_reb_1000_hip = smoothdata(reb_1000_hip.traces,2,'movmean',smooth_win);

smooth_sess_reb_40_hip = smoothdata(reb_40_hip.session_avg_traces,2,'movmean',smooth_win);
smooth_sess_reb_140_hip = smoothdata(reb_140_hip.session_avg_traces,2,'movmean',smooth_win);
smooth_sess_reb_1000_hip = smoothdata(reb_1000_hip.session_avg_traces,2,'movmean',smooth_win);

%reb cort
smooth_avg_reb_40_cort = smooth(reb_40_cort.avg_trace)';
smooth_avg_reb_140_cort = smooth(reb_140_cort.avg_trace)';
smooth_avg_reb_1000_cort = smooth(reb_1000_cort.avg_trace)';

smooth_reb_40_cort = smoothdata(reb_40_cort.traces,2,'movmean',smooth_win); 
smooth_reb_140_cort = smoothdata(reb_140_cort.traces,2,'movmean',smooth_win);
smooth_reb_1000_cort = smoothdata(reb_1000_cort.traces,2,'movmean',smooth_win);

smooth_sess_reb_40_cort = smoothdata(reb_40_cort.session_avg_traces,2,'movmean',smooth_win);
smooth_sess_reb_140_cort = smoothdata(reb_140_cort.session_avg_traces,2,'movmean',smooth_win);
smooth_sess_reb_1000_cort = smoothdata(reb_1000_cort.session_avg_traces,2,'movmean',smooth_win);

%% Peak, FWHM, time-to-peak, and asymmetry

%========================== Positive =====================================%
% pos hip
[pos_40_hip.avg_pk,pos_40_hip.avg_loc,pos_40_hip.avg_fwhm,...
pos_40_hip.avg_lhs,pos_40_hip.avg_rhs]=fwhm_and_pk(smooth_avg_pos_40_hip,Fs,0);

[pos_40_hip.pks, pos_40_hip.locs, pos_40_hip.fwhm,...
 pos_40_hip.lhs,pos_40_hip.rhs]=fwhm_and_pk(smooth_pos_40_hip,Fs,0);

[pos_40_hip.sess_pk,pos_40_hip.sess_loc,pos_40_hip.sess_fwhm,...
pos_40_hip.sess_lhs,pos_40_hip.sess_rhs]=fwhm_and_pk(smooth_sess_pos_40_hip,Fs,0);

[pos_140_hip.avg_pk,pos_140_hip.avg_loc,pos_140_hip.avg_fwhm,...
pos_140_hip.avg_lhs,pos_140_hip.avg_rhs]=fwhm_and_pk(smooth_avg_pos_140_hip,Fs,0);

[pos_140_hip.pks, pos_140_hip.locs, pos_140_hip.fwhm,...
 pos_140_hip.lhs,pos_140_hip.rhs]=fwhm_and_pk(smooth_pos_140_hip,Fs,0);

[pos_140_hip.sess_pk,pos_140_hip.sess_loc,pos_140_hip.sess_fwhm,...
pos_140_hip.sess_lhs,pos_140_hip.sess_rhs]=fwhm_and_pk(smooth_sess_pos_140_hip,Fs,0);

[pos_1000_hip.avg_pk,pos_1000_hip.avg_loc,pos_1000_hip.avg_fwhm,...
pos_1000_hip.avg_lhs,pos_1000_hip.avg_rhs]=fwhm_and_pk(smooth_avg_pos_1000_hip,Fs,0);

[pos_1000_hip.pks, pos_1000_hip.locs, pos_1000_hip.fwhm,...
 pos_1000_hip.lhs,pos_1000_hip.rhs]=fwhm_and_pk(smooth_pos_1000_hip,Fs,0);

[pos_1000_hip.sess_pk,pos_1000_hip.sess_loc,pos_1000_hip.sess_fwhm,...
pos_1000_hip.sess_lhs,pos_1000_hip.sess_rhs]=fwhm_and_pk(smooth_sess_pos_1000_hip,Fs,0);

% pos cort
[pos_40_cort.avg_pk,pos_40_cort.avg_loc,pos_40_cort.avg_fwhm,...
pos_40_cort.avg_lhs,pos_40_cort.avg_rhs]=fwhm_and_pk(smooth_avg_pos_40_cort,Fs,0);

[pos_40_cort.pks, pos_40_cort.locs, pos_40_cort.fwhm,...
 pos_40_cort.lhs,pos_40_cort.rhs]=fwhm_and_pk(smooth_pos_40_cort,Fs,0);

[pos_40_cort.sess_pk,pos_40_cort.sess_loc,pos_40_cort.sess_fwhm,...
pos_40_cort.sess_lhs,pos_40_cort.sess_rhs]=fwhm_and_pk(smooth_sess_pos_40_cort,Fs,0);

[pos_140_cort.avg_pk,pos_140_cort.avg_loc,pos_140_cort.avg_fwhm,...
pos_140_cort.avg_lhs,pos_140_cort.avg_rhs]=fwhm_and_pk(smooth_avg_pos_140_cort,Fs,0);

[pos_140_cort.pks, pos_140_cort.locs, pos_140_cort.fwhm,...
 pos_140_cort.lhs,pos_140_cort.rhs]=fwhm_and_pk(smooth_pos_140_cort,Fs,0);

[pos_140_cort.sess_pk,pos_140_cort.sess_loc,pos_140_cort.sess_fwhm,...
pos_140_cort.sess_lhs,pos_140_cort.sess_rhs]=fwhm_and_pk(smooth_sess_pos_140_cort,Fs,0);

[pos_1000_cort.avg_pk,pos_1000_cort.avg_loc,pos_1000_cort.avg_fwhm,...
pos_1000_cort.avg_lhs,pos_1000_cort.avg_rhs]=fwhm_and_pk(smooth_avg_pos_1000_cort,Fs,0);

[pos_1000_cort.pks, pos_1000_cort.locs, pos_1000_cort.fwhm,...
 pos_1000_cort.lhs,pos_1000_cort.rhs]=fwhm_and_pk(smooth_pos_1000_cort,Fs,0);

[pos_1000_cort.sess_pk,pos_1000_cort.sess_loc,pos_1000_cort.sess_fwhm,...
pos_1000_cort.sess_lhs,pos_1000_cort.sess_rhs]=fwhm_and_pk(smooth_sess_pos_1000_cort,Fs,0);

%=========================== Negative ====================================%
% avg neg hip
[neg_40_hip.avg_pk,neg_40_hip.avg_loc,neg_40_hip.avg_fwhm,...
neg_40_hip.avg_lhs,neg_40_hip.avg_rhs]=fwhm_and_pk(-smooth_avg_neg_40_hip,Fs,0);
neg_40_hip.avg_pk = -neg_40_hip.avg_pk;

[neg_40_hip.pks, neg_40_hip.locs, neg_40_hip.fwhm,...
 neg_40_hip.lhs,neg_40_hip.rhs]=fwhm_and_pk(-smooth_neg_40_hip,Fs,0);
neg_40_hip.pks = -neg_40_hip.pks;

[neg_40_hip.sess_pk,neg_40_hip.sess_loc,neg_40_hip.sess_fwhm,...
neg_40_hip.sess_lhs,neg_40_hip.sess_rhs]=fwhm_and_pk(-smooth_sess_neg_40_hip,Fs,0);
neg_40_hip.sess_pk = -neg_40_hip.sess_pk;

[neg_140_hip.avg_pk,neg_140_hip.avg_loc,neg_140_hip.avg_fwhm,...
neg_140_hip.avg_lhs,neg_140_hip.avg_rhs]=fwhm_and_pk(-smooth_avg_neg_140_hip,Fs,0);
neg_140_hip.avg_pk = -neg_140_hip.avg_pk;

[neg_140_hip.pks, neg_140_hip.locs, neg_140_hip.fwhm,...
 neg_140_hip.lhs,neg_140_hip.rhs]=fwhm_and_pk(-smooth_neg_140_hip,Fs,0);
neg_140_hip.pks = -neg_140_hip.pks;

[neg_140_hip.sess_pk,neg_140_hip.sess_loc,neg_140_hip.sess_fwhm,...
neg_140_hip.sess_lhs,neg_140_hip.sess_rhs]=fwhm_and_pk(-smooth_sess_neg_140_hip,Fs,0);
neg_140_hip.sess_pk = -neg_140_hip.sess_pk;

[neg_1000_hip.avg_pk,neg_1000_hip.avg_loc,neg_1000_hip.avg_fwhm,...
neg_1000_hip.avg_lhs,neg_1000_hip.avg_rhs]=fwhm_and_pk(-smooth_avg_neg_1000_hip,Fs,0);
neg_1000_hip.avg_pk = -neg_1000_hip.avg_pk;

[neg_1000_hip.pks, neg_1000_hip.locs, neg_1000_hip.fwhm,...
 neg_1000_hip.lhs,neg_1000_hip.rhs]=fwhm_and_pk(-smooth_neg_1000_hip,Fs,0);
neg_1000_hip.pks = -neg_1000_hip.pks;

[neg_1000_hip.sess_pk,neg_1000_hip.sess_loc,neg_1000_hip.sess_fwhm,...
neg_1000_hip.sess_lhs,neg_1000_hip.sess_rhs]=fwhm_and_pk(-smooth_sess_neg_1000_hip,Fs,0);
neg_1000_hip.sess_pk = -neg_1000_hip.sess_pk;

% avg neg cort
[neg_40_cort.avg_pk,neg_40_cort.avg_loc,neg_40_cort.avg_fwhm,...
neg_40_cort.avg_lhs,neg_40_cort.avg_rhs]=fwhm_and_pk(-smooth_avg_neg_40_cort,Fs,0);
neg_40_cort.avg_pk = -neg_40_cort.avg_pk;

[neg_40_cort.pks, neg_40_cort.locs, neg_40_cort.fwhm,...
 neg_40_cort.lhs,neg_40_cort.rhs]=fwhm_and_pk(-smooth_neg_40_cort,Fs,0);
neg_40_cort.pks = -neg_40_cort.pks;

[neg_40_cort.sess_pk,neg_40_cort.sess_loc,neg_40_cort.sess_fwhm,...
neg_40_cort.sess_lhs,neg_40_cort.sess_rhs]=fwhm_and_pk(-smooth_sess_neg_40_cort,Fs,0);
neg_40_cort.sess_pk = -neg_40_cort.sess_pk;

[neg_140_cort.avg_pk,neg_140_cort.avg_loc,neg_140_cort.avg_fwhm,...
neg_140_cort.avg_lhs,neg_140_cort.avg_rhs]=fwhm_and_pk(-smooth_avg_neg_140_cort,Fs,0);
neg_140_cort.avg_pk = -neg_140_cort.avg_pk;

[neg_140_cort.pks, neg_140_cort.locs, neg_140_cort.fwhm,...
 neg_140_cort.lhs,neg_140_cort.rhs]=fwhm_and_pk(-smooth_neg_140_cort,Fs,0);
neg_140_cort.pks = -neg_140_cort.pks;

[neg_140_cort.sess_pk,neg_140_cort.sess_loc,neg_140_cort.sess_fwhm,...
neg_140_cort.sess_lhs,neg_140_cort.sess_rhs]=fwhm_and_pk(-smooth_sess_neg_140_cort,Fs,0);
neg_140_cort.sess_pk = -neg_140_cort.sess_pk;

[neg_1000_cort.avg_pk,neg_1000_cort.avg_loc,neg_1000_cort.avg_fwhm,...
neg_1000_cort.avg_lhs,neg_1000_cort.avg_rhs]=fwhm_and_pk(-smooth_avg_neg_1000_cort,Fs,0);
neg_1000_cort.avg_pk = -neg_1000_cort.avg_pk;

[neg_1000_cort.pks, neg_1000_cort.locs, neg_1000_cort.fwhm,...
 neg_1000_cort.lhs,neg_1000_cort.rhs]=fwhm_and_pk(-smooth_neg_1000_cort,Fs,0);
neg_1000_cort.pks = -neg_1000_cort.pks;

[neg_1000_cort.sess_pk,neg_1000_cort.sess_loc,neg_1000_cort.sess_fwhm,...
neg_1000_cort.sess_lhs,neg_1000_cort.sess_rhs]=fwhm_and_pk(-smooth_sess_neg_1000_cort,Fs,0);
neg_1000_cort.sess_pk = -neg_1000_cort.sess_pk;

%================================ Rebound ================================%
% avg reb hip
[reb_40_hip.avg_pk,reb_40_hip.avg_loc,reb_40_hip.avg_fwhm,...
reb_40_hip.avg_lhs,reb_40_hip.avg_rhs]=fwhm_and_pk(smooth_avg_reb_40_hip,Fs,1);

[reb_40_hip.pks, reb_40_hip.locs, reb_40_hip.fwhm,...
 reb_40_hip.lhs,reb_40_hip.rhs]=fwhm_and_pk(smooth_reb_40_hip,Fs,1);

[reb_40_hip.sess_pk,reb_40_hip.sess_loc,reb_40_hip.sess_fwhm,...
reb_40_hip.sess_lhs,reb_40_hip.sess_rhs]=fwhm_and_pk(smooth_sess_reb_40_hip,Fs,1);

[reb_140_hip.avg_pk,reb_140_hip.avg_loc,reb_140_hip.avg_fwhm,...
reb_140_hip.avg_lhs,reb_140_hip.avg_rhs]=fwhm_and_pk(smooth_avg_reb_140_hip,Fs,1);

[reb_140_hip.pks, reb_140_hip.locs, reb_140_hip.fwhm,...
 reb_140_hip.lhs,reb_140_hip.rhs]=fwhm_and_pk(smooth_reb_140_hip,Fs,1);

[reb_140_hip.sess_pk,reb_140_hip.sess_loc,reb_140_hip.sess_fwhm,...
reb_140_hip.sess_lhs,reb_140_hip.sess_rhs]=fwhm_and_pk(smooth_sess_reb_140_hip,Fs,1);

[reb_1000_hip.avg_pk,reb_1000_hip.avg_loc,reb_1000_hip.avg_fwhm,...
reb_1000_hip.avg_lhs,reb_1000_hip.avg_rhs]=fwhm_and_pk(smooth_avg_reb_1000_hip,Fs,1);

[reb_1000_hip.pks, reb_1000_hip.locs, reb_1000_hip.fwhm,...
 reb_1000_hip.lhs,reb_1000_hip.rhs]=fwhm_and_pk(smooth_reb_1000_hip,Fs,1);

[reb_1000_hip.sess_pk,reb_1000_hip.sess_loc,reb_1000_hip.sess_fwhm,...
reb_1000_hip.sess_lhs,reb_1000_hip.sess_rhs]=fwhm_and_pk(smooth_sess_reb_1000_hip,Fs,1);

% avg reb cort
[reb_40_cort.avg_pk,reb_40_cort.avg_loc,reb_40_cort.avg_fwhm,...
reb_40_cort.avg_lhs,reb_40_cort.avg_rhs]=fwhm_and_pk(smooth_avg_reb_40_cort,Fs,1);

[reb_40_cort.pks, reb_40_cort.locs, reb_40_cort.fwhm,...
 reb_40_cort.lhs,reb_40_cort.rhs]=fwhm_and_pk(smooth_reb_40_cort,Fs,1);

[reb_40_cort.sess_pk,reb_40_cort.sess_loc,reb_40_cort.sess_fwhm,...
reb_40_cort.sess_lhs,reb_40_cort.sess_rhs]=fwhm_and_pk(smooth_sess_reb_40_cort,Fs,1);

[reb_140_cort.avg_pk,reb_140_cort.avg_loc,reb_140_cort.avg_fwhm,...
reb_140_cort.avg_lhs,reb_140_cort.avg_rhs]=fwhm_and_pk(smooth_avg_reb_140_cort,Fs,1);

[reb_140_cort.pks, reb_140_cort.locs, reb_140_cort.fwhm,...
 reb_140_cort.lhs,reb_140_cort.rhs]=fwhm_and_pk(smooth_reb_140_cort,Fs,1);

[reb_140_cort.sess_pk,reb_140_cort.sess_loc,reb_140_cort.sess_fwhm,...
reb_140_cort.sess_lhs,reb_140_cort.sess_rhs]=fwhm_and_pk(smooth_sess_reb_140_cort,Fs,1);

[reb_1000_cort.avg_pk,reb_1000_cort.avg_loc,reb_1000_cort.avg_fwhm,...
reb_1000_cort.avg_lhs,reb_1000_cort.avg_rhs]=fwhm_and_pk(smooth_avg_reb_1000_cort,Fs,1);

[reb_1000_cort.pks, reb_1000_cort.locs, reb_1000_cort.fwhm,...
 reb_1000_cort.lhs,reb_1000_cort.rhs]=fwhm_and_pk(smooth_reb_1000_cort,Fs,1);

[reb_1000_cort.sess_pk,reb_1000_cort.sess_loc,reb_1000_cort.sess_fwhm,...
reb_1000_cort.sess_lhs,reb_1000_cort.sess_rhs]=fwhm_and_pk(smooth_sess_reb_1000_cort,Fs,1);

%% Visual Check
% x=[1/Fs:1/Fs:20];
% figure; 
% plot(x,neg_40_cort.avg_trace); 
% hold on; 
% plot(neg_40_cort.avg_loc/Fs,neg_40_cort.avg_pk,'r.','MarkerSize',12);
% plot((neg_40_cort.avg_loc - neg_40_cort.avg_lhs)/Fs,neg_40_cort.avg_pk/2,'r.','MarkerSize',12);
% plot((neg_40_cort.avg_rhs+neg_40_cort.avg_loc)/Fs,neg_40_cort.avg_pk/2,'r.','MarkerSize',12);

%% Slope
%================================== Positive =============================%
% pos hip
[pos_40_hip.avg_inc_slope, pos_40_hip.avg_dec_slope]= find_slopes(smooth_avg_pos_40_hip,Fs,pos_40_hip.avg_loc,0); %reb_flag=0
[pos_140_hip.avg_inc_slope, pos_140_hip.avg_dec_slope]= find_slopes(smooth_avg_pos_140_hip,Fs,pos_140_hip.avg_loc,0); 
[pos_1000_hip.avg_inc_slope, pos_1000_hip.avg_dec_slope]= find_slopes(smooth_avg_pos_1000_hip,Fs,pos_1000_hip.avg_loc,0); 

[pos_40_hip.inc_slope, pos_40_hip.dec_slope]= find_slopes(smooth_pos_40_hip,Fs,pos_40_hip.locs,0); %reb_flag=0
[pos_140_hip.inc_slope, pos_140_hip.dec_slope]= find_slopes(smooth_pos_140_hip,Fs,pos_140_hip.locs,0); 
[pos_1000_hip.inc_slope, pos_1000_hip.dec_slope]= find_slopes(smooth_pos_1000_hip,Fs,pos_1000_hip.locs,0); 

[pos_40_hip.sess_inc_slope, pos_40_hip.sess_dec_slope]= find_slopes(smooth_sess_pos_40_hip,Fs,pos_40_hip.sess_loc,0); %reb_flag=0
[pos_140_hip.sess_inc_slope, pos_140_hip.sess_dec_slope]= find_slopes(smooth_sess_pos_140_hip,Fs,pos_140_hip.sess_loc,0); 
[pos_1000_hip.sess_inc_slope, pos_1000_hip.sess_dec_slope]= find_slopes(smooth_sess_pos_1000_hip,Fs,pos_1000_hip.sess_loc,0); 

% pos cort
[pos_40_cort.avg_inc_slope, pos_40_cort.avg_dec_slope]= find_slopes(smooth_avg_pos_40_cort,Fs,pos_40_cort.avg_loc,0); %reb_flag=0
[pos_140_cort.avg_inc_slope, pos_140_cort.avg_dec_slope]= find_slopes(smooth_avg_pos_140_cort,Fs,pos_140_cort.avg_loc,0); 
[pos_1000_cort.avg_inc_slope, pos_1000_cort.avg_dec_slope]= find_slopes(smooth_avg_pos_1000_cort,Fs,pos_1000_cort.avg_loc,0); 

[pos_40_cort.inc_slope, pos_40_cort.dec_slope]= find_slopes(smooth_pos_40_cort,Fs,pos_40_cort.locs,0); %reb_flag=0
[pos_140_cort.inc_slope, pos_140_cort.dec_slope]= find_slopes(smooth_pos_140_cort,Fs,pos_140_cort.locs,0); 
[pos_1000_cort.inc_slope, pos_1000_cort.dec_slope]= find_slopes(smooth_pos_1000_cort,Fs,pos_1000_cort.locs,0); 

[pos_40_cort.sess_inc_slope, pos_40_cort.sess_dec_slope]= find_slopes(smooth_sess_pos_40_cort,Fs,pos_40_cort.sess_loc,0); %reb_flag=0
[pos_140_cort.sess_inc_slope, pos_140_cort.sess_dec_slope]= find_slopes(smooth_sess_pos_140_cort,Fs,pos_140_cort.sess_loc,0); 
[pos_1000_cort.sess_inc_slope, pos_1000_cort.sess_dec_slope]= find_slopes(smooth_sess_pos_1000_cort,Fs,pos_1000_cort.sess_loc,0); 

%================================= Negative ==============================%
% neg hip
[neg_40_hip.avg_inc_slope, neg_40_hip.avg_dec_slope]= find_slopes(smooth_avg_neg_40_hip,Fs,neg_40_hip.avg_loc,0); %reb_flag=0
[neg_140_hip.avg_inc_slope, neg_140_hip.avg_dec_slope]= find_slopes(smooth_avg_neg_140_hip,Fs,neg_140_hip.avg_loc,0);
[neg_1000_hip.avg_inc_slope, neg_1000_hip.avg_dec_slope]= find_slopes(smooth_avg_neg_1000_hip,Fs,neg_1000_hip.avg_loc,0);

[neg_40_hip.inc_slope, neg_40_hip.dec_slope]= find_slopes(smooth_neg_40_hip,Fs,neg_40_hip.locs,0); %reb_flag=0
[neg_140_hip.inc_slope, neg_140_hip.dec_slope]= find_slopes(smooth_neg_140_hip,Fs,neg_140_hip.locs,0);
[neg_1000_hip.inc_slope, neg_1000_hip.dec_slope]= find_slopes(smooth_neg_1000_hip,Fs,neg_1000_hip.locs,0);

[neg_40_hip.sess_inc_slope, neg_40_hip.sess_dec_slope]= find_slopes(smooth_sess_neg_40_hip,Fs,neg_40_hip.sess_loc,0); %reb_flag=0
[neg_140_hip.sess_inc_slope, neg_140_hip.sess_dec_slope]= find_slopes(smooth_sess_neg_140_hip,Fs,neg_140_hip.sess_loc,0);
[neg_1000_hip.sess_inc_slope, neg_1000_hip.sess_dec_slope]= find_slopes(smooth_sess_neg_1000_hip,Fs,neg_1000_hip.sess_loc,0);

% neg cort
[neg_40_cort.avg_inc_slope, neg_40_cort.avg_dec_slope]= find_slopes(smooth_avg_neg_40_cort,Fs,neg_40_cort.avg_loc,0); %reb_flag=0
[neg_140_cort.avg_inc_slope, neg_140_cort.avg_dec_slope]= find_slopes(smooth_avg_neg_140_cort,Fs,neg_140_cort.avg_loc,0);
[neg_1000_cort.avg_inc_slope, neg_1000_cort.avg_dec_slope]= find_slopes(smooth_avg_neg_1000_cort,Fs,neg_1000_cort.avg_loc,0);

[neg_40_cort.inc_slope, neg_40_cort.dec_slope]= find_slopes(smooth_neg_40_cort,Fs,neg_40_cort.locs,0); %reb_flag=0
[neg_140_cort.inc_slope, neg_140_cort.dec_slope]= find_slopes(smooth_neg_140_cort,Fs,neg_140_cort.locs,0);
[neg_1000_cort.inc_slope, neg_1000_cort.dec_slope]= find_slopes(smooth_neg_1000_cort,Fs,neg_1000_cort.locs,0);

[neg_40_cort.sess_inc_slope, neg_40_cort.sess_dec_slope]= find_slopes(smooth_sess_neg_40_cort,Fs,neg_40_cort.sess_loc,0); %reb_flag=0
[neg_140_cort.sess_inc_slope, neg_140_cort.sess_dec_slope]= find_slopes(smooth_sess_neg_140_cort,Fs,neg_140_cort.sess_loc,0);
[neg_1000_cort.sess_inc_slope, neg_1000_cort.sess_dec_slope]= find_slopes(smooth_sess_neg_1000_cort,Fs,neg_1000_cort.sess_loc,0);

%================================== Rebound ==============================%
% reb hip
[reb_40_hip.avg_inc_slope, reb_40_hip.avg_dec_slope]= find_slopes(smooth_avg_reb_40_hip,Fs,reb_40_hip.avg_loc,1); %reb_flag=1
[reb_140_hip.avg_inc_slope, reb_140_hip.avg_dec_slope]= find_slopes(smooth_avg_reb_140_hip,Fs,reb_140_hip.avg_loc,1); 
[reb_1000_hip.avg_inc_slope, reb_1000_hip.avg_dec_slope]= find_slopes(smooth_avg_reb_1000_hip,Fs,reb_1000_hip.avg_loc,1); 

[reb_40_hip.inc_slope, reb_40_hip.dec_slope]= find_slopes(smooth_reb_40_hip,Fs,reb_40_hip.locs,1); %reb_flag=1
[reb_140_hip.inc_slope, reb_140_hip.dec_slope]= find_slopes(smooth_reb_140_hip,Fs,reb_140_hip.locs,1); 
[reb_1000_hip.inc_slope, reb_1000_hip.dec_slope]= find_slopes(smooth_reb_1000_hip,Fs,reb_1000_hip.locs,1); 

[reb_40_hip.sess_inc_slope, reb_40_hip.sess_dec_slope]= find_slopes(smooth_sess_reb_40_hip,Fs,reb_40_hip.sess_loc,1); %reb_flag=1
[reb_140_hip.sess_inc_slope, reb_140_hip.sess_dec_slope]= find_slopes(smooth_sess_reb_140_hip,Fs,reb_140_hip.sess_loc,1); 
[reb_1000_hip.sess_inc_slope, reb_1000_hip.sess_dec_slope]= find_slopes(smooth_sess_reb_1000_hip,Fs,reb_1000_hip.sess_loc,1); 

% reb cort
[reb_40_cort.avg_inc_slope, reb_40_cort.avg_dec_slope]= find_slopes(smooth_avg_reb_40_cort,Fs,reb_40_cort.avg_loc,1); %reb_flag=1
[reb_140_cort.avg_inc_slope, reb_140_cort.avg_dec_slope]= find_slopes(smooth_avg_reb_140_cort,Fs,reb_140_cort.avg_loc,1); 
[reb_1000_cort.avg_inc_slope, reb_1000_cort.avg_dec_slope]= find_slopes(smooth_avg_reb_1000_cort,Fs,reb_1000_cort.avg_loc,1);

[reb_40_cort.inc_slope, reb_40_cort.dec_slope]= find_slopes(smooth_reb_40_cort,Fs,reb_40_cort.locs,1); %reb_flag=1
[reb_140_cort.inc_slope, reb_140_cort.dec_slope]= find_slopes(smooth_reb_140_cort,Fs,reb_140_cort.locs,1); 
[reb_1000_cort.inc_slope, reb_1000_cort.dec_slope]= find_slopes(smooth_reb_1000_cort,Fs,reb_1000_cort.locs,1);

[reb_40_cort.sess_inc_slope, reb_40_cort.sess_dec_slope]= find_slopes(smooth_sess_reb_40_cort,Fs,reb_40_cort.sess_loc,1); %reb_flag=1
[reb_140_cort.sess_inc_slope, reb_140_cort.sess_dec_slope]= find_slopes(smooth_sess_reb_140_cort,Fs,reb_140_cort.sess_loc,1); 
[reb_1000_cort.sess_inc_slope, reb_1000_cort.sess_dec_slope]= find_slopes(smooth_sess_reb_1000_cort,Fs,reb_1000_cort.sess_loc,1);

%% AUC
%======================== Positive =======================================%
% pos hip
pos_40_hip.avg_auc = trapz(smooth_avg_pos_40_hip(5*Fs:end));
pos_140_hip.avg_auc = trapz(smooth_avg_pos_140_hip(5*Fs:end));
pos_1000_hip.avg_auc = trapz(smooth_avg_pos_1000_hip(5*Fs:end));

pos_40_hip.auc = trapz(smooth_pos_40_hip(:,5*Fs:end),2);
pos_140_hip.auc = trapz(smooth_pos_140_hip(:,5*Fs:end),2);
pos_1000_hip.auc = trapz(smooth_pos_1000_hip(:,5*Fs:end),2);

pos_40_hip.sess_auc = trapz(smooth_sess_pos_40_hip(:,5*Fs:end),2);
pos_140_hip.sess_auc = trapz(smooth_sess_pos_140_hip(:,5*Fs:end),2);
pos_1000_hip.sess_auc = trapz(smooth_sess_pos_1000_hip(:,5*Fs:end),2);

% pos cort
pos_40_cort.avg_auc = trapz(smooth_avg_pos_40_cort(5*Fs:end));
pos_140_cort.avg_auc = trapz(smooth_avg_pos_140_cort(5*Fs:end));
pos_1000_cort.avg_auc = trapz(smooth_avg_pos_1000_cort(5*Fs:end));

pos_40_cort.auc = trapz(smooth_pos_40_cort(:,5*Fs:end),2);
pos_140_cort.auc = trapz(smooth_pos_140_cort(:,5*Fs:end),2);
pos_1000_cort.auc = trapz(smooth_pos_1000_cort(:,5*Fs:end),2);

pos_40_cort.sess_auc = trapz(smooth_sess_pos_40_cort(:,5*Fs:end),2);
pos_140_cort.sess_auc = trapz(smooth_sess_pos_140_cort(:,5*Fs:end),2);
pos_1000_cort.sess_auc = trapz(smooth_sess_pos_1000_cort(:,5*Fs:end),2);

%======================== Negative =======================================%
% neg hip
neg_40_hip.avg_auc = trapz(smooth_avg_neg_40_hip(5*Fs:end));
neg_140_hip.avg_auc = trapz(smooth_avg_neg_140_hip(5*Fs:end));
neg_1000_hip.avg_auc = trapz(smooth_avg_neg_1000_hip(:,5*Fs:end));

neg_40_hip.auc = trapz(smooth_neg_40_hip(:,5*Fs:end),2);
neg_140_hip.auc = trapz(smooth_neg_140_hip(:,5*Fs:end),2);
neg_1000_hip.auc = trapz(smooth_neg_1000_hip(:,5*Fs:end),2);

neg_40_hip.sess_auc = trapz(smooth_sess_neg_40_hip(:,5*Fs:end),2);
neg_140_hip.sess_auc = trapz(smooth_sess_neg_140_hip(:,5*Fs:end),2);
neg_1000_hip.sess_auc = trapz(smooth_sess_neg_1000_hip(:,5*Fs:end),2);

% neg cort
neg_40_cort.avg_auc = trapz(smooth_avg_neg_40_cort(5*Fs:end));
neg_140_cort.avg_auc = trapz(smooth_avg_neg_140_cort(5*Fs:end));
neg_1000_cort.avg_auc = trapz(smooth_avg_neg_1000_cort(5*Fs:end));

neg_40_cort.auc = trapz(smooth_neg_40_cort(:,5*Fs:end),2);
neg_140_cort.auc = trapz(smooth_neg_140_cort(:,5*Fs:end),2);
neg_1000_cort.auc = trapz(smooth_neg_1000_cort(:,5*Fs:end),2);

neg_40_cort.sess_auc = trapz(smooth_sess_neg_40_cort(:,5*Fs:end),2);
neg_140_cort.sess_auc = trapz(smooth_sess_neg_140_cort(:,5*Fs:end),2);
neg_1000_cort.sess_auc = trapz(smooth_sess_neg_1000_cort(:,5*Fs:end),2);

%======================== Rebound =======================================%
% reb hip
reb_40_hip.avg_auc = trapz(smooth_avg_reb_40_hip);
reb_140_hip.avg_auc = trapz(smooth_avg_reb_140_hip);
reb_1000_hip.avg_auc = trapz(smooth_avg_reb_1000_hip);

reb_40_hip.auc = trapz(smooth_reb_40_hip,2);
reb_140_hip.auc = trapz(smooth_reb_140_hip,2);
reb_1000_hip.auc = trapz(smooth_reb_1000_hip,2);

reb_40_hip.sess_auc = trapz(smooth_sess_reb_40_hip,2);
reb_140_hip.sess_auc = trapz(smooth_sess_reb_140_hip,2);
reb_1000_hip.sess_auc = trapz(smooth_sess_reb_1000_hip,2);

reb_40_hip.avg_pre_reb_auc = trapz(smooth_avg_reb_40_hip(5*Fs:10*Fs));
reb_140_hip.avg_pre_reb_auc = trapz(smooth_avg_reb_140_hip(5*Fs:10*Fs));
reb_1000_hip.avg_pre_reb_auc = trapz(smooth_avg_reb_1000_hip(5*Fs:10*Fs));

reb_40_hip.pre_reb_auc = trapz(smooth_reb_40_hip(:,5*Fs:10*Fs),2);
reb_140_hip.pre_reb_auc = trapz(smooth_reb_140_hip(:,5*Fs:10*Fs),2);
reb_1000_hip.pre_reb_auc = trapz(smooth_reb_1000_hip(:,5*Fs:10*Fs),2);

reb_40_hip.sess_pre_reb_auc = trapz(smooth_sess_reb_40_hip(:,5*Fs:10*Fs),2);
reb_140_hip.sess_pre_reb_auc = trapz(smooth_sess_reb_140_hip(:,5*Fs:10*Fs),2);
reb_1000_hip.sess_pre_reb_auc = trapz(smooth_sess_reb_1000_hip(:,5*Fs:10*Fs),2);

reb_40_hip.avg_only_reb_auc = trapz(smooth_avg_reb_40_hip(5*Fs:10*Fs));
reb_140_hip.avg_only_reb_auc = trapz(smooth_avg_reb_140_hip(5*Fs:10*Fs));
reb_1000_hip.avg_only_reb_auc = trapz(smooth_avg_reb_1000_hip(5*Fs:10*Fs));

reb_40_hip.only_reb_auc = trapz(smooth_reb_40_hip(:,5*Fs:10*Fs),2);
reb_140_hip.only_reb_auc = trapz(smooth_reb_140_hip(:,5*Fs:10*Fs),2);
reb_1000_hip.only_reb_auc = trapz(smooth_reb_1000_hip(:,5*Fs:10*Fs),2);

reb_40_hip.sess_only_reb_auc = trapz(smooth_sess_reb_40_hip(:,5*Fs:10*Fs),2);
reb_140_hip.sess_only_reb_auc = trapz(smooth_sess_reb_140_hip(:,5*Fs:10*Fs),2);
reb_1000_hip.sess_only_reb_auc = trapz(smooth_sess_reb_1000_hip(:,5*Fs:10*Fs),2);

% reb cort
reb_40_cort.avg_auc = trapz(smooth_avg_reb_40_cort);
reb_140_cort.avg_auc = trapz(smooth_avg_reb_140_cort);
reb_1000_cort.avg_auc = trapz(smooth_avg_reb_1000_cort);

reb_40_cort.auc = trapz(smooth_reb_40_cort,2);
reb_140_cort.auc = trapz(smooth_reb_140_cort,2);
reb_1000_cort.auc = trapz(smooth_reb_1000_cort,2);

reb_40_cort.sess_auc = trapz(smooth_sess_reb_40_cort,2);
reb_140_cort.sess_auc = trapz(smooth_sess_reb_140_cort,2);
reb_1000_cort.sess_auc = trapz(smooth_sess_reb_1000_cort,2);

reb_40_cort.avg_pre_reb_auc = trapz(smooth_avg_reb_40_cort(5*Fs:10*Fs));
reb_140_cort.avg_pre_reb_auc = trapz(smooth_avg_reb_140_cort(5*Fs:10*Fs));
reb_1000_cort.avg_pre_reb_auc = trapz(smooth_avg_reb_1000_cort(5*Fs:10*Fs));

reb_40_cort.pre_reb_auc = trapz(smooth_reb_40_cort(:,5*Fs:10*Fs),2);
reb_140_cort.pre_reb_auc = trapz(smooth_reb_140_cort(:,5*Fs:10*Fs),2);
reb_1000_cort.pre_reb_auc = trapz(smooth_reb_1000_cort(:,5*Fs:10*Fs),2);

reb_40_cort.sess_pre_reb_auc = trapz(smooth_sess_reb_40_cort(:,5*Fs:10*Fs),2);
reb_140_cort.sess_pre_reb_auc = trapz(smooth_sess_reb_140_cort(:,5*Fs:10*Fs),2);
reb_1000_cort.sess_pre_reb_auc = trapz(smooth_sess_reb_1000_cort(:,5*Fs:10*Fs),2);

reb_40_cort.avg_only_reb_auc = trapz(smooth_avg_reb_40_cort(5*Fs:10*Fs));
reb_140_cort.avg_only_reb_auc = trapz(smooth_avg_reb_140_cort(5*Fs:10*Fs));
reb_1000_cort.avg_onlyl_reb_auc = trapz(smooth_avg_reb_1000_cort(5*Fs:10*Fs));

reb_40_cort.only_reb_auc = trapz(smooth_reb_40_cort(:,5*Fs:10*Fs),2);
reb_140_cort.only_reb_auc = trapz(smooth_reb_140_cort(:,5*Fs:10*Fs),2);
reb_1000_cort.only_reb_auc = trapz(smooth_reb_1000_cort(:,5*Fs:10*Fs),2);

reb_40_cort.sess_only_reb_auc = trapz(smooth_sess_reb_40_cort(:,5*Fs:10*Fs),2);
reb_140_cort.sess_only_reb_auc = trapz(smooth_sess_reb_140_cort(:,5*Fs:10*Fs),2);
reb_1000_cort.sess_only_reb_auc = trapz(smooth_sess_reb_1000_cort(:,5*Fs:10*Fs),2);
end

%% Box Plots -- Compare within CA1 (One-way ANOVA)
% %Neuron-Wise
% pvals_struct = compare_CA1_anovan(pos_40_hip,pos_140_hip,pos_1000_hip,...
%                                             neg_40_hip, neg_140_hip, neg_1000_hip,...
%                                             reb_40_hip, reb_140_hip,reb_1000_hip,...
%                                             pvals_struct,bcolor);
% % Session-Wise
% pvals_struct = sess_compare_CA1_anovan(pos_40_hip,pos_140_hip,pos_1000_hip,...
%                                                 neg_40_hip, neg_140_hip, neg_1000_hip,...
%                                                 reb_40_hip, reb_140_hip,reb_1000_hip,...
%                                                 pvals_struct,bcolor);
%% Box Plots -- Compare within CA1 (Kruskal-Wallis)
%Neuron-Wise
pvals_struct = compare_CA1_KW(pos_40_hip,pos_140_hip,pos_1000_hip,...
                                            neg_40_hip, neg_140_hip, neg_1000_hip,...
                                            reb_40_hip, reb_140_hip,reb_1000_hip,...
                                            pvals_struct,bcolor);
% Session-Wise
pvals_struct = sess_compare_CA1_KW(pos_40_hip,pos_140_hip,pos_1000_hip,...
                                                neg_40_hip, neg_140_hip, neg_1000_hip,...
                                                reb_40_hip, reb_140_hip,reb_1000_hip,...
                                                pvals_struct,bcolor);
%% Box Plots -- Compare within M1 (One-way ANOVA)
% %Neuron-Wise
% pvals_struct = compare_M1_anovan(pos_40_cort,pos_140_cort,pos_1000_cort,...
%                                  neg_40_cort, neg_140_cort, neg_1000_cort,...
%                                  reb_40_cort, reb_140_cort,reb_1000_cort,...
%                                  pvals_struct,bcolor);
%                              
% % Session-Wise
% pvals_struct = sess_compare_M1_anovan(pos_40_cort,pos_140_cort,pos_1000_cort,...
%                                             neg_40_cort, neg_140_cort, neg_1000_cort,...
%                                             reb_40_cort, reb_140_cort,reb_1000_cort,...
%                                             pvals_struct,bcolor);
%% Box Plots -- Compare within M1 (Kuskal-Wallis)
% %Neuron-Wise
pvals_struct = compare_M1_KW(pos_40_cort,pos_140_cort,pos_1000_cort,...
                                 neg_40_cort, neg_140_cort, neg_1000_cort,...
                                 reb_40_cort, reb_140_cort,reb_1000_cort,...
                                 pvals_struct,bcolor);
                             
% Session-Wise
pvals_struct = sess_compare_M1_KW(pos_40_cort,pos_140_cort,pos_1000_cort,...
                                            neg_40_cort, neg_140_cort, neg_1000_cort,...
                                            reb_40_cort, reb_140_cort,reb_1000_cort,...
                                            pvals_struct,bcolor);
%% Box Plots -- Compare within 40Hz (Two Sample T-Test)
% %Neuron-Wise
% pvals_struct = compare_40Hz_ttest(pos_40_hip,pos_40_cort,...
%                                             neg_40_hip, neg_40_cort,...
%                                             reb_40_hip, reb_40_cort,...
%                                             pvals_struct,bcolor);
% % Session-Wise
% pvals_struct = sess_compare_40Hz_ttest(pos_40_hip,pos_40_cort,...
%                                             neg_40_hip, neg_40_cort,...
%                                             reb_40_hip, reb_40_cort,...
%                                             pvals_struct,bcolor);
%% Box Plots -- Compare within 40Hz (Wilcoxon Ranksum)
%Neuron-Wise
pvals_struct = compare_40Hz_ranksum(pos_40_hip,pos_40_cort,...
                                            neg_40_hip, neg_40_cort,...
                                            reb_40_hip, reb_40_cort,...
                                            pvals_struct,bcolor);
% Session-Wise
pvals_struct = sess_compare_40Hz_ranksum(pos_40_hip,pos_40_cort,...
                                            neg_40_hip, neg_40_cort,...
                                            reb_40_hip, reb_40_cort,...
                                            pvals_struct,bcolor);
%% Box Plots -- Compare within 140Hz (Two Sample T-Test)
% %Neuron-Wise
% pvals_struct = compare_140Hz_ttest(pos_140_hip,pos_140_cort,...
%                                             neg_140_hip, neg_140_cort,...
%                                             reb_140_hip, reb_140_cort,...
%                                             pvals_struct,bcolor);
% 
% % Session-Wise
% pvals_struct = sess_compare_140Hz_ttest(pos_140_hip,pos_140_cort,...
%                                             neg_140_hip, neg_140_cort,...
%                                             reb_140_hip, reb_140_cort,...
%                                             pvals_struct,bcolor);
%% Box Plots -- Compare within 140Hz (Wilcoxon Ranksum)
%Neuron-Wise
pvals_struct = compare_140Hz_ranksum(pos_140_hip,pos_140_cort,...
                                            neg_140_hip, neg_140_cort,...
                                            reb_140_hip, reb_140_cort,...
                                            pvals_struct,bcolor);

% Session-Wise
pvals_struct = sess_compare_140Hz_ranksum(pos_140_hip,pos_140_cort,...
                                            neg_140_hip, neg_140_cort,...
                                            reb_140_hip, reb_140_cort,...
                                            pvals_struct,bcolor);
%% Box Plots -- Compare within 1000Hz (Two Sample T-Test)
% %Neuron-Wise
% pvals_struct = compare_1000Hz_ttest(pos_1000_hip,pos_1000_cort, ...
%                                              neg_1000_hip,neg_1000_cort,...
%                                              reb_1000_hip,reb_1000_cort,...
%                                              pvals_struct,bcolor);
% % Session-Wise
% pvals_struct = sess_compare_1000Hz_ttest(pos_1000_hip,pos_1000_cort, ...
%                                              neg_1000_hip,neg_1000_cort,...
%                                              reb_1000_hip,reb_1000_cort,...
%                                              pvals_struct,bcolor);
%% Box Plots -- Compare within 1000Hz (Wilcoxon Ranksum)
%Neuron-Wise
pvals_struct = compare_1000Hz_ranksum(pos_1000_hip,pos_1000_cort, ...
                                             neg_1000_hip,neg_1000_cort,...
                                             reb_1000_hip,reb_1000_cort,...
                                             pvals_struct,bcolor);
% Session-Wise
pvals_struct = sess_compare_1000Hz_ranksum(pos_1000_hip,pos_1000_cort, ...
                                             neg_1000_hip,neg_1000_cort,...
                                             reb_1000_hip,reb_1000_cort,...
                                             pvals_struct,bcolor);
%% Box Plots -- Across all frequencies and regions (Two-way ANOVA)
% %Neuron-Wise
% pvals_struct = compare_all_anovan(pos_40_hip,pos_140_hip,pos_1000_hip,...
%                                     neg_40_hip, neg_140_hip, neg_1000_hip,...
%                                     reb_40_hip, reb_140_hip,reb_1000_hip,...
%                                     pos_40_cort,pos_140_cort,pos_1000_cort,...
%                                     neg_40_cort, neg_140_cort, neg_1000_cort,...
%                                     reb_40_cort, reb_140_cort,reb_1000_cort,...
%                                     pvals_struct,bcolor,Fs);
% % Session-Wise      
% pvals_struct = sess_compare_all_anovan(pos_40_hip,pos_140_hip,pos_1000_hip,...
%                                         neg_40_hip, neg_140_hip, neg_1000_hip,...
%                                         reb_40_hip, reb_140_hip,reb_1000_hip,...
%                                         pos_40_cort,pos_140_cort,pos_1000_cort,...
%                                         neg_40_cort, neg_140_cort, neg_1000_cort,...
%                                         reb_40_cort, reb_140_cort,reb_1000_cort,...
%                                         pvals_struct,bcolor,Fs);

%% Plot the average of the session average traces 
%(this weighs every session as opposed to every neuron equally)

%Positive
avg_sess_avg_pos_40_hip = smooth(mean(pos_40_hip.session_avg_traces,1));
avg_sess_avg_pos_140_hip = smooth(mean(pos_140_hip.session_avg_traces,1));
avg_sess_avg_pos_1000_hip = smooth(mean(pos_1000_hip.session_avg_traces,1));

avg_sess_avg_pos_40_cort = smooth(mean(pos_40_cort.session_avg_traces,1));
avg_sess_avg_pos_140_cort = smooth(mean(pos_140_cort.session_avg_traces,1));
avg_sess_avg_pos_1000_cort = smooth(mean(pos_1000_cort.session_avg_traces,1));

%Negative
avg_sess_avg_neg_40_hip = smooth(mean(neg_40_hip.session_avg_traces,1));
avg_sess_avg_neg_140_hip = smooth(mean(neg_140_hip.session_avg_traces,1));
avg_sess_avg_neg_1000_hip = smooth(mean(neg_1000_hip.session_avg_traces,1));

avg_sess_avg_neg_40_cort = smooth(mean(neg_40_cort.session_avg_traces,1));
avg_sess_avg_neg_140_cort = smooth(mean(neg_140_cort.session_avg_traces,1));
avg_sess_avg_neg_1000_cort = smooth(mean(neg_1000_cort.session_avg_traces,1));

%Rebound
avg_sess_avg_reb_40_hip = smooth(mean(reb_40_hip.session_avg_traces,1));
avg_sess_avg_reb_140_hip = smooth(mean(reb_140_hip.session_avg_traces,1));
avg_sess_avg_reb_1000_hip = smooth(mean(reb_1000_hip.session_avg_traces,1));

avg_sess_avg_reb_40_cort = smooth(mean(reb_40_cort.session_avg_traces,1));
avg_sess_avg_reb_140_cort = smooth(mean(reb_140_cort.session_avg_traces,1));
avg_sess_avg_reb_1000_cort = smooth(mean(reb_1000_cort.session_avg_traces,1));

figure; hold on
plot(avg_sess_avg_pos_40_hip,'-','Color',color_40_CA1)
plot(avg_sess_avg_pos_140_hip,'-','Color',color_140_CA1)
plot(avg_sess_avg_pos_1000_hip,'-','Color',color_1000_CA1)
plot(avg_sess_avg_pos_40_cort,'--','Color',color_40_M1)
plot(avg_sess_avg_pos_140_cort,'--','Color',color_140_M1)
plot(avg_sess_avg_pos_1000_cort,'--','Color',color_1000_M1)
title('Pos Mod: Avg of Session Avgs')

figure; hold on
plot(avg_sess_avg_neg_40_hip,'-','Color',color_40_CA1)
plot(avg_sess_avg_neg_140_hip,'-','Color',color_140_CA1)
plot(avg_sess_avg_neg_1000_hip,'-','Color',color_1000_CA1)
plot(avg_sess_avg_neg_40_cort,'--','Color',color_40_M1)
plot(avg_sess_avg_neg_140_cort,'--','Color',color_140_M1)
plot(avg_sess_avg_neg_1000_cort,'--','Color',color_1000_M1)
title('Neg Mod: Avg of Session Avgs')

figure; hold on
plot(avg_sess_avg_reb_40_hip,'-','Color',color_40_CA1)
plot(avg_sess_avg_reb_140_hip,'-','Color',color_140_CA1)
plot(avg_sess_avg_reb_1000_hip,'-','Color',color_1000_CA1)
plot(avg_sess_avg_reb_40_cort,'--','Color',color_40_M1)
plot(avg_sess_avg_reb_140_cort,'--','Color',color_140_M1)
plot(avg_sess_avg_reb_1000_cort,'--','Color',color_1000_M1)
title('Reb: Avg of Session Avgs')


% Now plot normal avg traces
figure; hold on
plot(pos_40_hip.avg_trace,'-','Color',color_40_CA1)
plot(pos_140_hip.avg_trace,'-','Color',color_140_CA1)
plot(pos_1000_hip.avg_trace,'-','Color',color_1000_CA1)
plot(pos_40_cort.avg_trace,'--','Color',color_40_M1)
plot(pos_140_cort.avg_trace,'--','Color',color_140_M1)
plot(pos_1000_cort.avg_trace,'--','Color',color_1000_M1)
title('Pos Mod: Avg trace')

figure; hold on
plot(neg_40_hip.avg_trace,'-','Color',color_40_CA1)
plot(neg_140_hip.avg_trace,'-','Color',color_140_CA1)
plot(neg_1000_hip.avg_trace,'-','Color',color_1000_CA1)
plot(neg_40_cort.avg_trace,'--','Color',color_40_M1)
plot(neg_140_cort.avg_trace,'--','Color',color_140_M1)
plot(neg_1000_cort.avg_trace,'--','Color',color_1000_M1)
title('Neg Mod: Avg trace')

figure; hold on
plot(reb_40_hip.avg_trace,'-','Color',color_40_CA1)
plot(reb_140_hip.avg_trace,'-','Color',color_140_CA1)
plot(reb_1000_hip.avg_trace,'-','Color',color_1000_CA1)
plot(reb_40_cort.avg_trace,'--','Color',color_40_M1)
plot(reb_140_cort.avg_trace,'--','Color',color_140_M1)
plot(reb_1000_cort.avg_trace,'--','Color',color_1000_M1)
title('Reb: Avg trace')


%% Save all Data structures to save_path
save([save_path,'/pvals_struct.mat'],'pvals_struct');
%============================== Positive =================================%
save([save_path,'/pos_40_hip.mat'],'pos_40_hip');
save([save_path,'/pos_140_hip.mat'],'pos_140_hip');
save([save_path,'/pos_1000_hip.mat'],'pos_1000_hip');

save([save_path,'/pos_40_cort.mat'],'pos_40_cort');
save([save_path,'/pos_140_cort.mat'],'pos_140_cort');
save([save_path,'/pos_1000_cort.mat'],'pos_1000_cort');

%=============================== Negative ================================%
save([save_path,'/neg_40_hip.mat'],'neg_40_hip');
save([save_path,'/neg_140_hip.mat'],'neg_140_hip');
save([save_path,'/neg_1000_hip.mat'],'neg_1000_hip');

save([save_path,'/neg_40_cort.mat'],'neg_40_cort');
save([save_path,'/neg_140_cort.mat'],'neg_140_cort');
save([save_path,'/neg_1000_cort.mat'],'neg_1000_cort');

%========================= Rebound =======================================%
save([save_path,'/reb_40_hip.mat'],'reb_40_hip');
save([save_path,'/reb_140_hip.mat'],'reb_140_hip');
save([save_path,'/reb_1000_hip.mat'],'reb_1000_hip');

save([save_path,'/reb_40_cort.mat'],'reb_40_cort');
save([save_path,'/reb_140_cort.mat'],'reb_140_cort');
save([save_path,'/reb_1000_cort.mat'],'reb_1000_cort');
