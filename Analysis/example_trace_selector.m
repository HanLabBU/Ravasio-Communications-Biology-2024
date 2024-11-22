% example_trace_selector.m
% Author: Cara
% Date: 05/17/23
% Purpose: To Select example traces from the modulation groups
function example_traces  = example_trace_selector(mod,Fs)
% mod_ID is a string (i.e. 'pos','neg','rebound')
% Fs = 20; %Hz
%% Setup
traces = mod.traces;
trial_traces = mod.trial_traces;

num_neurons = size(traces, 1);
num_frames = size(traces, 2);
trial_length = num_frames/Fs;
roiPerPlot = 5;
num_plots = ceil(num_neurons/roiPerPlot);
neuronIdx = [1:num_neurons];

good_trace_idx = [];

%% Plot 5 neurons at a time
for ff = 1:num_plots
    roiIdxs = roiPerPlot*(ff-1)+1:roiPerPlot*(ff);
    roiIdxs(roiIdxs>num_neurons) = [];
    roiIdxs = neuronIdx(roiIdxs);
    
    figure('units','normalized','outerposition',[0 0.5 1 0.75],'WindowStyle', 'Docked');
    
    for i = 1:numel(roiIdxs)
        trace = traces(roiIdxs(i),:);
        subplot(5,1,i)
        hold on
        num_trials = size(squeeze(trial_traces{1,roiIdxs(i)}),2);
        for j=1:num_trials
            trial_trace = squeeze(trial_traces{1,roiIdxs(i)});
            plot([1:num_frames],trial_trace(:,j),'-','Color',[0.8,0.8,0.8]);
        end
        plot(trace,'r-');
        xline(5*Fs,'k');
        xline(10*Fs,'k');
        set(gca,'XTick',[0:Fs:num_frames],'XTickLabel',[0:trial_length]);
        
    end
    
    selectedIdxRaw = input("SelectedIdxs: ",'s'); %This section isn't actually contributing to anything except moving on to the next plot
    selectedIdxRaw = str2double(num2cell(selectedIdxRaw));
    selectedIdxRaw(isnan(selectedIdxRaw)) = [];
    selectedIdxRaw = unique(selectedIdxRaw);
    selectedIdxRaw(selectedIdxRaw>numel(roiIdxs)) = [];
    good_trace_idx = [good_trace_idx, selectedIdxRaw+(5*(ff-1))];
    if ~selectedIdxRaw(selectedIdxRaw<1)
        selectedIdxRaw(selectedIdxRaw<1) = [];
        close all
        break
    end
        
    close all

end
disp('end of selection');
example_traces.neurons = mod.neurons(good_trace_idx,:);
example_traces.traces = mod.traces(good_trace_idx,:);
for k=1:numel(good_trace_idx)
    example_traces.trial_traces{k,1} = mod.trial_traces{1,good_trace_idx(k)};
end
end