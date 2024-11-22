% trace_classification_sanity_check.m
% Author: Cara R
% Date: 08/24/22
% Purpose: Take identified example traces, and decide whether there is a
% better approach to classifying traces as positively, negatively or
% non-modulated.

%% Setup 
main_path = '~/handata_server/Cara_Ravasio/Data/GCaMP_Data_Extraction/Paper_Figures_Clean_Data';
load([main_path '/example_traces.mat'])

%% Grab traces, smooth, take first derivative
traces = example_traces.CA1_40.non.stim.traces;
num_neurons = size(traces,1);
std_win = 5; %number of points used for moving std dev window

smooth_traces = [];
first_deriv = [];
std_dev=[];
for i=1:num_neurons
    smooth_traces(i,:) = smooth(traces(i,[2,2:end])); %5-point moving average by default (equivalently 0.5 second window)
    first_deriv(i,:) = smooth(gradient(smooth_traces(i,:),Fs));
    std_dev(i,:) = smooth(movstd(smooth_traces(i,:),std_win)); % extend the second frame to the first frame because the first frame has artifact
end

%% Plot the traces

num_frames = size(traces, 2);
trial_length = num_frames/Fs;
roiPerPlot = 5;
num_plots = ceil(num_neurons/roiPerPlot);
neuronIdx = [1:num_neurons];

trace = [];
deriv_trace = [];
std_trace = [];

for ff = 1:num_plots
    roiIdxs = roiPerPlot*(ff-1)+1:roiPerPlot*(ff);
    roiIdxs(roiIdxs>num_neurons) = [];
    roiIdxs = neuronIdx(roiIdxs);
    
    figure('units','normalized','outerposition',[0 0.5 1 0.75],'WindowStyle', 'Docked');
    
    for i = 1:numel(roiIdxs)
        trace = smooth_traces(roiIdxs(i),:);
        subplot(5,3,3*i-2)
        plot(trace)
        hold on
        plot(mean(trace,'omitnan')*ones(size(trace)));
        xline(5*Fs,'k');
        xline(10*Fs,'k');
        set(gca,'XTick',[0:Fs:num_frames],'XTickLabel',[0:trial_length]);
        
        deriv_trace = first_deriv(roiIdxs(i),:);
        subplot(5,3,3*i-1)
        plot(deriv_trace)
        hold on
        plot(mean(deriv_trace,'omitnan')*ones(size(deriv_trace)));
        xline(5*Fs,'k');
        xline(10*Fs,'k');
        set(gca,'XTick',[0:Fs:num_frames],'XTickLabel',[0:trial_length]);
        
        std_dev_trace = std_dev(roiIdxs(i),:);
        subplot(5,3,3*i)
        plot(std_dev_trace)
        hold on
        plot(mean(std_dev_trace,'omitnan')*ones(size(std_dev_trace)));
        xline(5*Fs,'k');
        xline(10*Fs,'k');
        set(gca,'XTick',[0:Fs:num_frames],'XTickLabel',[0:trial_length]);
        
    end
    
    selectedIdxRaw = input("SelectedIdxs: ",'s'); %This section isn't actually contributing to anything except moving on to the next plot
    selectedIdxRaw = str2double(num2cell(selectedIdxRaw));
    selectedIdxRaw(isnan(selectedIdxRaw)) = [];
    selectedIdxRaw = unique(selectedIdxRaw);
    selectedIdxRaw(selectedIdxRaw>numel(roiIdxs)) = [];
    if ~selectedIdxRaw(selectedIdxRaw<1)
        selectedIdxRaw(selectedIdxRaw<1) = [];
        close all
        break
    end
        
    close all

end
disp('end of selection');

%%
ex_traces = pos_mod_40_CA1.sust.traces(4,:);
%titles = {'no response','silencing?','active baseline, decreased df/f during stim','stim during event'};
figure;
hold on
for i=1:size(ex_traces,1)
    plot([1:num_frames],ex_traces(i,:));
    xline(5*Fs,'k');
    xline(10*Fs,'k');
    set(gca,'XTick',[0:Fs:num_frames],'XTickLabel',[0:trial_length]);
end
title('gradual increase in df/f');