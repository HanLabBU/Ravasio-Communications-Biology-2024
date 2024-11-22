% run_event_detection_transient_DBS.m
% Author: Cara
% Date: 05/25/23
% Purpose: clean up the event detection section of post processing

function roi_list_final = run_event_detection_transient_DBS(data)
[b,a] = butter(12,0.3,'low');
roi_list = struct();
roi_list_final = struct();
for i=1:size(data,2) %number of roi_data struct inside
    for j=1:size(data(i).roi_data.trace_minusBG_new_DN_reshaped,1) %number of neurons for roi_data
        for k=1:size(data(i).roi_data.trace_minusBG_new_DN_reshaped,3) %number of trials
            roi_list(k).trace = filtfilt(b,a,squeeze(data(i).roi_data.trace_minusBG_new_DN_reshaped_scaled(j,:,k)));
        end
        %detect events
        [roi_list,~] = transient_trace_event_detection_GCaMP7f(roi_list);
        roi_list_final(i).roi_list{j}=roi_list;
        %trace_event_plot(roi_list); %visual check step
        clear roi_list
    end
end

% %% Testing -- Set up the traces for event detection?
%     roi_list=struct();
%     for i = 1:size(example_traces.hz40.neg.M1.trial_traces,1) %num_neurons
%         for n = 1:size(example_traces.hz40.neg.M1.trial_traces{i,1},3) %num_trials
%             roi_list(n).trace =  squeeze(example_traces.hz40.neg.M1.trial_traces{i,1}(:,:,n));
%        
%         
%         end
%         % event detect
%         
%         [roi_list,empty_idx] = transient_trace_event_detection_GCaMP7f(roi_list); % Iteratively Detect events in the original fluroscence trace
%         trace_event_plot(roi_list); %visual check step
%         close all
%     end

end