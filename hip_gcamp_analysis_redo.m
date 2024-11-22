% hip_gcamp_analysis_redo.m
% Author: Cara R
% Date: 08/08/22
% Purpose: There was a major typo in the original gcamp_analysis script
% during detrending and normalization which caused only the raw data to be
% analyzed throughout the pipeline. This fixes that problem without
% re-extracting traces or classifying good/bad rois from previous pipeline.
% This version does not detrend trials and normalizes by dividing by
% baseline.

clear all
close all
clc
%% Setup
addpath(genpath('~/handata_server/Cara_Ravasio/Code/GCaMP_Data_Extraction'));
base_path = '~/handata_server/Cara_Ravasio/Data/GCaMP_Data_Extraction/Neocortex';

folder_names = {{'607614',8,1,1000}};


%             % CA1 folder_names
%             {{'617428',6,1,40},{'617428',11,1,40},{'617428',11,1,140},{'617428',12,1,40},{'617428',12,1,140},...
%                 {'617429',2,1,40},{'617429',2,1,140},{'617429',3,1,40},{'617429',3,1,140},{'617429',5,1,140},...
%                 {'C00014138',2,1,40},{'C00014138',2,1,140},{'C00014138',3,1,40},{'C00014138',3,1,140},{'C00014138',4,1,40},{'C00014138',4,1,140},...
%                 {'C00014138',5,1,40},{'C00014138',5,1,140},{'C00014138',6,1,40},{'C00014138',6,1,140},{'C00014138',7,1,40,'/fov1'},{'C00014138',7,1,140,'/fov1'},...
%                 {'C00014138',7,2,40,'/fov2'},{'C00014138',7,2,140,'/fov2'},{'C00014138',9,1,1000},{'C00014138',10,1,1000,'/fov1'},{'C00014138',10,2,1000,'/fov2'},...
%                 {'C00014138',10,3,1000,'/fov3'},{'C00014138',11,1,1000},{'C00014138',12,1,1000,'/15uA'},{'C00014138',12,1,1000,'/20uA'},...
%                 {'C00014133',1,1,40},{'C00014133',2,1,140,'/5uA'},{'C00014133',3,1,40},{'C00014133',4,1,140},{'C00014133',5,1,40},{'C00014133',5,1,140},...
%                 {'C00014133',6,1,140},{'C00014133',8,1,40},{'C00014133',8,1,140},...
%                 {'C00014133',9,1,40},{'C00014133',9,1,140},{'C00014133',10,2,40},{'C00014133',10,2,140},{'C00014133',11,1,1000},...
%                 {'C00014133',12,1,1000},{'C00014133',13,1,1000},...
%                 {'C00014139',1,1,40},{'C00014139',2,1,140},{'C00014139',3,1,40},{'C00014139',3,1,140},{'C00014139',4,1,40},{'C00014139',5,1,140},...
%                 {'C00031617',1,1,1000,'/fov1'},{'C00031617',1,2,1000,'/fov2'},{'C00031617',1,3,1000,'/fov3'},{'C00031617',2,1,1000},...
%                 {'C00031617',3,1,1000},{'C00031617',4,1,1000},...
%                 {'C00047125',1,1,1000},{'C00047125',2,1,1000},{'C00047125',3,1,1000},...
%                 {'C00043484',1,1,1000},{'C00043484',2,1,1000},{'C00043484',3,1,1000}};
            %M1 folder names
%             {{'607614',3,1,40,'/fov1'}, {'607614',3,2,40,'/fov2'},{'607614',4,1,140,'/fov1'},...
%              {'607614',4,2,140,'/fov2'},{'607614',5,1,40},...
%              {'607631',2,1,40},{'607631',3,1,140},{'607631',4,1,40,'/fov1'},...
%              {'607631',4,2,40,'/fov2'},{'607631',5,1,140,'/fov1'},{'607631',5,2,140,'/fov2'},...
%              {'C00023114',2,1,40},{'C00023114',2,1,140},{'C00023114',3,1,40,'/fov1'},...
%              {'C00023114',3,1,140,'/fov1'},{'C00023114',3,2,140,'/fov2'},...
%              {'C00023114',6,1,1000},{'C00023114',8,1,1000},...
%              {'C00050354',1,1,40},{'C00050354',2,1,40},{'C00050354',2,1,140},...
%              {'C00050354',3,1,1000},{'C00050354',4,1,40},{'C00050354',5,1,140},{'C00050354',6,1,1000},...
%              {'C00050439',1,1,40},{'C00050439',1,1,140},{'C00050439',2,1,1000},...
%              {'C00050439',3,1,140},{'C00050439',5,1,1000},{'C00050439',6,1,140},...
%              {'C00051546',1,1,40},{'C00051546',2,1,1000},{'C00051546',3,1,1000},...
%              {'C00051546',4,1,140},{'C00051546',5,1,40},{'C00051546',6,1,140}};

for curr_file = 1:numel(folder_names)
    close all
    clc
    clearvars -except base_path folder_names curr_file
    curr_file %report where we are
    mouse = folder_names{1,curr_file}{1,1};
    rec = folder_names{1,curr_file}{1,2};
    fov = folder_names{1,curr_file}{1,3};
    freq = folder_names{1,curr_file}{1,4};
    
    trial_length = 20; %trial length in sec - Cara 08/01/22
    stim_on = 5; %when did stim turn on (s)- Cara 08/01/22
    stim_off = 10; %when did stim turn off (s)- Cara 08/01/22
    
    if numel(folder_names{1,curr_file}) == 5 %if there is a fifth entry for this folder's id
        main_path = [base_path '/' mouse '/rec' num2str(rec) '/' num2str(freq) 'Hz' folder_names{1,curr_file}{1,5}];
    else
        main_path = [base_path '/' mouse '/rec' num2str(rec) '/' num2str(freq) 'Hz'];
    end
    cd(main_path)
    
    % Load tiff associated data
    tif_data = dir([mouse '*.mat']);
    load(tif_data.name);
   
    % Load roi_data
    try
        %For minor reprocessing
        flag_20Hz = 0; %this flag is used to determine whether it is necessary to re-extract traces (0=no)
        listing = dir('roi_data_*.mat');
        load(listing(1).name);   
    catch
        %For 20Hz data conversion
        flag_20Hz = 1; %this flag is used to determine whether it is necessary to re-extract traces (1=yes)
        cd([main_path '/Archive']);
        listing = dir('roi_data_*.mat');
        old_data = load(listing(1).name);
        cd(main_path)
    end
    
    % Setup the save name
    ses=cond_id{1};
    try
        maxTrial = size(roi_data.trace_reshaped,3);
    catch
        maxTrial = size(old_data.roi_data.trace_reshaped,3);
    end
    maxTrial = 15;
    save_name = [mouse '_rec' num2str(rec) '_' ses 'trials_' num2str(maxTrial)];
    
    %extract traces if they don't already exist
    if flag_20Hz
        % Load roiList
        try
            cd(main_path)
            load(['roi_edited_' save_name '.mat']);
        catch
            cd([main_path, '/Archive'])
            load(['roi_edited_' save_name '.mat']);
            cd(main_path)
        end
        %extract traces
        cd([main_path '/motion_corrected'])
        roi_data = extract_trace_Cara(roiList, 0); %1 to use the uigetfile func, 0 to automatically load in all m_*.hdf5 files in pwd
        cd(main_path)
        
        % Load in the previously determined good and bad idxs
        roi_data.goodIdx = old_data.roi_data.goodIdx;
        roi_data.badIdx = old_data.roi_data.badIdx;
    end
    
    %% Find dimensions of interest
    [num_neurons,num_frames_total] = size(roi_data.trace);
    num_trials = maxTrial; %trial_vec(end);
    num_frames = num_frames_total/num_trials;
    Fs = num_frames/trial_length; %number of frames gathered in x-sec trial
    
    %% Reshape Data (neuron x frame x trial) and Subtract Background
    %Subtract background
    roi_data.trace_minusBG_new = roi_data.trace - roi_data.BGtrace_new;
    roi_data.trace_minusBG = roi_data.trace - roi_data.BGtrace;
    
    %reshape neuron traces to be [neurons x frames x trials] 3D matrix
    roi_data.trace_reshaped = reshape(roi_data.trace, num_neurons, num_frames, num_trials);
    roi_data.trace_minusBG_new_reshaped = reshape(roi_data.trace_minusBG_new, num_neurons, num_frames, num_trials);
    roi_data.trace_minusBG_reshaped = reshape(roi_data.trace_minusBG, num_neurons, num_frames, num_trials);
    
    %%
    if strcmp(mouse,'C00023114') && rec == 7
        % only execute on this one specific file because there was a camera
        % related artifact.
        % interpolate frame 101-102 in trace_minusBG_new to remove artifact
        for i=1:num_trials
            for j=1:num_neurons
                x = [100,103]; y = [roi_data.trace_minusBG_new_reshaped(j,100,i),roi_data.trace_minusBG_new_reshaped(j,103,i)];
                roi_data.trace_minusBG_new_reshaped(j,[100 101 102 103],i) = interp1(x,y,[100, 101,102,103]);
            end 
        end
    end
    %% Normalization (no detrending)
    %Subtract each trial's avg baseline value,then normalize all by 
    %dividing by the magnitude of the average of the average baselines
    for j=1:num_neurons
        for i=1:num_trials
            % raw trace detrending and normalizing
            trialTrace(i,:) = roi_data.trace_reshaped(j,:,i);
            baselineAvg(i,:) = mean(trialTrace(i,1:(stim_on-2)*Fs)); %'stim_on*Fs-2', used to be 3*Fs
            trialTrace(i,:) = trialTrace(i,:) - baselineAvg(i,:);
            
            % raw - BG trace detrending and normalizing
            trialTraceMinusBG(i,:) = roi_data.trace_minusBG_reshaped(j,:,i);
            baselineAvgMinusBG(i,:) = mean(trialTraceMinusBG(i,1:(stim_on-2)*Fs));
            trialTraceMinusBG(i,:) = trialTraceMinusBG(i,:) - baselineAvgMinusBG(i,:);
            
            % raw - BG_new trace detrending and normalizing
            trialTraceMinusBG_new(i,:) = roi_data.trace_minusBG_new_reshaped(j,:,i);
            baselineAvgMinusBG_new(i,:) = mean(trialTraceMinusBG_new(i,1:(stim_on-2)*Fs));
            trialTraceMinusBG_new(i,:) = trialTraceMinusBG_new(i,:) - baselineAvgMinusBG_new(i,:);
        end
        
        baselineAvg = mean(abs(baselineAvg),1);
        baselineAvgMinusBG = mean(abs(baselineAvgMinusBG),1);
        baselineAvgMinusBG_new = mean(abs(baselineAvgMinusBG_new),1);
        for i=1:num_trials
            roi_data.trace_DN_reshaped(j,:,i) = trialTrace(i,:)/baselineAvg;
            roi_data.trace_minusBG_DN_reshaped(j,:,i) = trialTraceMinusBG(i,:)/baselineAvgMinusBG;
            roi_data.trace_minusBG_new_DN_reshaped(j,:,i) = trialTraceMinusBG_new(i,:)/baselineAvgMinusBG_new;
        end
    end
    %% Average Neuron Trace
    goodCells = roi_data.goodIdx;
    %========================== Find Traces ==================================%
    %Average the data along the trial dimension(3rd dimension)
    roi_data.avg_raw_trace = mean(roi_data.trace_DN_reshaped, 3);
    roi_data.avg_trace_minusBG_new = mean(roi_data.trace_minusBG_new_DN_reshaped, 3);
    roi_data.avg_trace_minusBG = mean(roi_data.trace_minusBG_DN_reshaped, 3);
    
    %Average avg traces along the neuron dimension (1st dim)
    roi_data.total_avg_raw_trace = mean(roi_data.avg_raw_trace, 1);
    roi_data.total_avg_trace_minusBG_new = mean(roi_data.avg_trace_minusBG_new, 1);
    roi_data.total_avg_trace_minusBG = mean(roi_data.avg_trace_minusBG, 1);
    
    %============== Now Scaled (0 to 1) across all trials ================%    
    %Average the data along the trial dimension(3rd dimension)
    meanTrace = mean(roi_data.trace_DN_reshaped, 3);
    meanTrace_minusBG_new = mean(roi_data.trace_minusBG_new_DN_reshaped, 3);
    meanTrace_minusBG = mean(roi_data.trace_minusBG_DN_reshaped, 3);
    
    %Scale from 0 to 1 for each neuron
    minTrace = min(min(roi_data.trace_DN_reshaped,[],2),[],3); %find min over each trace, then min over all trials for each neuron
    maxTrace = max(max(roi_data.trace_DN_reshaped,[],2),[],3); %find max over each trace, then max over all trials for each neuron
    rangeTrace = abs(maxTrace - minTrace);
    roi_data.trace_DN_reshaped_scaled = (roi_data.trace_DN_reshaped - repmat(minTrace,1,num_frames,num_trials))./rangeTrace;
    roi_data.avg_raw_trace_scaled = mean(roi_data.trace_DN_reshaped_scaled, 3);
    baseline_avg_temp = mean(roi_data.avg_raw_trace_scaled(:,2:5*Fs-1),2);
    roi_data.avg_raw_trace_scaled = roi_data.avg_raw_trace_scaled - repmat(baseline_avg_temp,1,num_frames);
    
    minTrace_minusBG_new = min(min(roi_data.trace_minusBG_new_DN_reshaped,[],2),[],3);
    maxTrace_minusBG_new = max(max(roi_data.trace_minusBG_new_DN_reshaped,[],2),[],3);
    rangeTrace_minusBG_new = abs(maxTrace_minusBG_new - minTrace_minusBG_new);
    roi_data.trace_minusBG_new_DN_reshaped_scaled = (roi_data.trace_minusBG_new_DN_reshaped - repmat(minTrace_minusBG_new,1,num_frames,num_trials))./rangeTrace_minusBG_new;
    roi_data.avg_trace_minusBG_new_scaled = mean(roi_data.trace_minusBG_new_DN_reshaped_scaled, 3);
    baseline_avg_temp = mean(roi_data.avg_trace_minusBG_new_scaled(:,2:5*Fs-1),2);
    roi_data.avg_trace_minusBG_new_scaled = roi_data.avg_trace_minusBG_new_scaled - repmat(baseline_avg_temp,1,num_frames);
    
    minTrace_minusBG = min(min(roi_data.trace_minusBG_DN_reshaped,[],2),[],3);
    maxTrace_minusBG = max(max(roi_data.trace_minusBG_DN_reshaped,[],2),[],3);
    rangeTrace_minusBG = abs(maxTrace_minusBG - minTrace_minusBG);
    roi_data.trace_minusBG_DN_reshaped_scaled = (roi_data.trace_minusBG_DN_reshaped - repmat(minTrace_minusBG,1,num_frames,num_trials))./rangeTrace_minusBG;
    roi_data.avg_trace_minusBG_scaled = mean(roi_data.trace_minusBG_DN_reshaped_scaled, 3);
    baseline_avg_temp = mean(roi_data.avg_trace_minusBG_scaled(:,2:5*Fs-1),2);
    roi_data.avg_trace_minusBG_scaled = roi_data.avg_trace_minusBG_scaled - repmat(baseline_avg_temp,1,num_frames);
        
    %Average avg traces along the neuron dimension (1st dim)
    roi_data.total_avg_raw_trace_scaled = mean(roi_data.avg_raw_trace_scaled, 1);
    roi_data.total_avg_trace_minusBG_new_scaled = mean(roi_data.avg_trace_minusBG_new_scaled, 1);
    roi_data.total_avg_trace_minusBG_scaled = mean(roi_data.avg_trace_minusBG_scaled, 1);
    
    %========================= Plot Results ==================================%
    %cd(main_path)
    %Trial averages
    figure;
    plot([1:num_frames], roi_data.avg_trace_minusBG_new);
    title([sprintf('Average Trace: All Cells (%d trials) ', num_trials) ses]);
    set(gca,'XTick',[0:Fs:num_frames],'XTickLabel',[0:trial_length]);
    saveas(gcf,[ save_name '_TrialAvgTraces.jpg']);
    
    %Total average
    figure;
    plot([1:num_frames], roi_data.total_avg_trace_minusBG_new);
    title([sprintf('Total Average Trace (%d cells) ',numel(roi_data.goodIdx)) ses]);
    set(gca,'XTick',[0:Fs:num_frames],'XTickLabel',[0:trial_length]);
    saveas(gcf,[save_name '_TotalAvgTrace.jpg']);
    
    %Total average Scaled (0 to 1)
    figure;
    plot([1:num_frames], roi_data.total_avg_trace_minusBG_new_scaled);
    title([sprintf('Total Average Trace (%d cells) ',numel(roi_data.goodIdx)) ses]);
    set(gca,'XTick',[0:Fs:num_frames],'XTickLabel',[0:trial_length]);
    saveas(gcf,[save_name '_TotalAvgTrace_scaled.jpg']);
    
    %Total average with all individual traces
    figure;
    hold on
    for i =1:num_trials
        for j = 1:numel(roi_data.goodIdx)
            %plots all neurons from trial in light grey
            plot([1:num_frames],roi_data.trace_minusBG_new_DN_reshaped_scaled(roi_data.goodIdx(j),:,i), 'Color',[0.8 0.8 0.8]);
        end
    end
    plot([1:num_frames], roi_data.total_avg_trace_minusBG_new, 'r'); %Plot total avg tace in red
    set(gca,'XTick',[0:Fs:num_frames],'XTickLabel',[0:trial_length]);
    
    %% Save full roi_data variable
    save([main_path,sprintf(['/roi_data_' save_name '.mat'])],'roi_data');
    
    %% ========================= Data Visualization ==========================%
    %% Heatmap generation
    %===================== Plot heatmap of average trial======================%
    % NOTE: Maybe mess with the end and start frame values...
    end_frame = 5+5; % sort using 5 seconds after onset and
    start_frame = 5-2; % 2 seconds before onset
    postSum = sum(roi_data.avg_trace_minusBG_new(goodCells,stim_on*Fs+1: end_frame*Fs),2);
    preSum = sum(roi_data.avg_trace_minusBG_new(goodCells, start_frame*Fs:stim_on*Fs),2);
    
    [~,sortIdx] = sort(postSum-preSum);
    avg_trace_minusBG_new_plot = roi_data.avg_trace_minusBG_new(goodCells(sortIdx),:)-mean(roi_data.avg_trace_minusBG_new(goodCells(sortIdx),2:5*Fs-1),2).*ones(size(roi_data.avg_trace_minusBG_new(goodCells,:)));
    
    figure
    imagesc(avg_trace_minusBG_new_plot);
    hold on
    plot([stim_on*Fs,stim_on*Fs],[0,num_neurons],'k','linewidth',1.5)
    plot([stim_off*Fs,stim_off*Fs],[0,num_neurons],'k','linewidth',1.5) %Stim offset
    ylabel('trace')
    set(gca,'XTick',[0:Fs:num_frames],'XTickLabel',[0:1:trial_length]);
    xlabel('Time (s)')
    title(['Average pulse onset aligned heatmap ', cond_id{1}])
    colorbar
    saveas(gcf,[save_name '_AvgHeatmap.jpg']);
    
    %=================== Avg Heatmap scaled (0 to 1) =========================%
    end_frame = 5+5; % sort using 5 seconds after onset and
    start_frame = 5-2; % 2 seconds before onset
    postSum = sum(roi_data.avg_trace_minusBG_new_scaled(goodCells,stim_on*Fs+1: end_frame*Fs),2);
    preSum = sum(roi_data.avg_trace_minusBG_new_scaled(goodCells, start_frame*Fs:stim_on*Fs),2);
    
    [~,sortIdx] = sort(postSum-preSum);
    avg_trace_minusBG_new_scaled_plot = roi_data.avg_trace_minusBG_new_scaled(goodCells(sortIdx),:)-mean(roi_data.avg_trace_minusBG_new_scaled(goodCells(sortIdx),2:5*Fs-1),2).*ones(size(roi_data.avg_trace_minusBG_new_scaled(goodCells,:)));
    
    figure
    imagesc(avg_trace_minusBG_new_scaled_plot);
    hold on
    plot([stim_on*Fs,stim_on*Fs],[0,num_neurons],'k','linewidth',1.5)
    plot([stim_off*Fs,stim_off*Fs],[0,num_neurons],'k','linewidth',1.5) %Stim offset
    ylabel('trace')
    set(gca,'XTick',[0:Fs:num_frames],'XTickLabel',[0:1:trial_length]);
    xlabel('Time (s)')
    title(['Average pulse onset aligned heatmap ', cond_id{1}])
    colorbar
    saveas(gcf,[save_name '_AvgHeatmap_scaled.jpg']);
    
    %% Plot all traces by cell and trial
    num_good_cells = numel(roi_data.goodIdx);
    fig=figure;
    
    check = reshape(roi_data.trace,[size(roi_data.BGtrace_new,1),trial_length,num_trials]);
    
    if num_good_cells<20
        cell_samples = num_good_cells;
    else
        cell_samples = 10;
    end
    for i=1:cell_samples %Iterate through all good cells or sample of the first 20
        for j=1:num_trials %iterate through trials
            %subplot(num_good_cells,num_trials,j+10*(i-1));
            subplot(cell_samples,num_trials,j+num_trials*(i-1));
            %plot([1:num_frames], check(roi_data.goodIdx(i),:,j));
            plot([1:num_frames], roi_data.trace_minusBG_new_DN_reshaped_scaled(roi_data.goodIdx(i),:,j));
            %plot([1:num_frames], roi_data.trace_DN_reshaped_scaled(roi_data.goodIdx(i),:,j));
            set(gca,'XTick',[0:Fs*5:num_frames],'XTickLabel',[0:5:trial_length]);
        end
    end
    % Give common xlabel, ylabel and title to figure
    h=axes(fig,'visible','off');
    h.Title.Visible='on';
    h.XLabel.Visible='on';
    h.YLabel.Visible='on';
    ylabel(h,'Cells');
    xlabel(h,'Trials');
    title(h,sprintf('%d Trials of %d Cells (first 20)', num_trials, num_good_cells));
    saveas(gcf,[save_name '_TraceSamples.jpg']);
    
    %% Rank-Sum test for positive and negative modulation of neurons
    % For each neuron separately, take all of the baseline frames from all
    % of the trials, and all of the stimulation frames and make two
    % distributions of fluorescence values. Use ranksum to determine
    % whether these are significantly different.
    posModID = [];
    nonModID = [];
    negModID = [];
    reboundID = [];
    for i=1:numel(roi_data.goodIdx)
        baseline_temp = roi_data.trace_minusBG_new_DN_reshaped(i,2:5*Fs-1,:); %ignore first frame artifact
        baseline_distrib(i,:) = baseline_temp(:);
        stim_temp = roi_data.trace_minusBG_new_DN_reshaped(i,5*Fs:10*Fs,:); %stimulation period
        stim_distrib(i,:) = stim_temp(:);
        post_temp = roi_data.trace_minusBG_new_DN_reshaped(i,10*Fs+1:15*Fs,:); %post-stim rebound
        post_distrib(i,:) = post_temp(:);
        [p_stim(i),h_stim(i)] = ranksum(baseline_distrib(i,:),stim_distrib(i,:)); %flatten the distirbutions into a single vector (order doesn't matter)
        [p_post(i),h_post(i)] = ranksum(baseline_distrib(i,:),post_distrib(i,:));
        [p_stim_post(i),h_stim_post(i)] = ranksum(stim_distrib(i,:),post_distrib(i,:));
        
        %classify stimulation periods.
        if h_stim(i) == 1
            if median(stim_distrib(i,:))> median(baseline_distrib(i,:))
                posModID = [posModID,i];
            elseif median(stim_distrib(i,:))< median(baseline_distrib(i,:))
                negModID = [negModID,i];
            end
        else
            nonModID = [nonModID,i];
        end
        
        %Classify significant rebounds
        if h_post(i) == 1
            if median(post_distrib(i,:))> median(baseline_distrib(i,:)) && median(post_distrib(i,:))> median(stim_distrib(i,:)) %This should take care of the neurons which are still recovering from positive modulation
                reboundID = [reboundID,i];
            end
        end
        
    end
    roi_data.stats_struct.p_stim = p_stim;
    roi_data.stats_struct.h_stim = h_stim;
    roi_data.stats_struct.p_post = p_post;
    roi_data.stats_struct.h_post = h_post;
    roi_data.stats_struct.p_stim_post = p_stim_post;
    roi_data.stats_struct.h_stim_post = h_stim_post;
    roi_data.posModID = posModID;
    roi_data.nonModID = nonModID;
    roi_data.negModID = negModID;
    roi_data.reboundID = reboundID;
    
    
    % Avg positively, negatively, and non modulated waveform
    avgPosModTrace = mean(roi_data.avg_trace_minusBG_new([posModID],:),1);
    avgNonModTrace = mean(roi_data.avg_trace_minusBG_new([nonModID],:),1);
    avgNegModTrace = mean(roi_data.avg_trace_minusBG_new([negModID],:),1);
    avgReboundTrace = mean(roi_data.avg_trace_minusBG_new([reboundID],:),1);
    
    figure;
    subplot(4,1,1)
    plot([1:num_frames], avgPosModTrace);
    set(gca,'XTick',[0:Fs*5:num_frames],'XTickLabel',[0:5:trial_length]);
    title(sprintf('Average Positively Modulated Waveform: %i cells', numel(posModID)));
    subplot(4,1,2)
    plot([1:num_frames], avgNonModTrace);
    set(gca,'XTick',[0:Fs*5:num_frames],'XTickLabel',[0:5:trial_length]);
    title(sprintf('Average Non-Modulated Waveform: %i cells', numel(nonModID)));
    subplot(4,1,3)
    plot([1:num_frames], avgNegModTrace);
    set(gca,'XTick',[0:Fs*5:num_frames],'XTickLabel',[0:5:trial_length]);
    title(sprintf('Average Negatively Modulated Waveform: %i cells', numel(negModID)));
    subplot(4,1,4)
    plot([1:num_frames], avgReboundTrace);
    set(gca,'XTick',[0:Fs*5:num_frames],'XTickLabel',[0:5:trial_length]);
    title(sprintf('Average Rebound Waveform: %i cells', numel(reboundID)));
    saveas(gcf,[save_name '_AvgModWaveforms.jpg']);
    
    %% Save full roi_data variable
    save([main_path,sprintf(['/roi_data_' save_name '.mat'])],'roi_data');
end