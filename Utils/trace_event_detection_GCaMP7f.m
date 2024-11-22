function [roi_list,empty_idx] = trace_event_detection_GCaMP7f(roi_list, save_keyword, sample_freq)
% Cara Ravasio
% Date: 03/21/23
% Adapted from iterative_trace_event_detection_ext2 by Hua-an Tseng
% Purpose: Script optimized for detecting the "bursts" we found in CA1
% GCaMP7f traces due to its much faster kinetics which were overlooked by
% Hua-an's original code. Has some issues finding the event start time.

%Hua-an's original Notes:
% Hua-an Tseng, huaantseng at gmail
% To detect the event, run:
% 1. trace_event_detection
% 2. trace_event_remove_overlap
% 3. trace_waveform
% 4. trace_waveform_remove_empty
% Then you can use trace_event_plot to check the trace and the detected events.

whole_tic = tic;

if nargin<3 || isempty(sample_freq)
    sample_freq = 20;
end

if nargin<2 || isempty(save_keyword)
    save_keyword = datestr(now,'yyyymmdd');
end

pre_window = 60;%35; %Maybe Change this %difficult because the pos mod traces don't follow normal event shape stuff
empty_idx = [];
%%
for roi_idx=1:numel(roi_list)
    fprintf(['ROI ',num2str(roi_idx),'/',num2str(numel(roi_list)),'\n']);
    whole_trace = roi_list(roi_idx).trace;
    smooth_trace = smooth(whole_trace);
    spread = (max(whole_trace)-mean(whole_trace)) - (mean(whole_trace)-min(whole_trace));
    if spread > 0.06 || range(whole_trace) > 0.5 %var(whole_trace) > 0.002 || spread > 0.05
        [pks,locs,widths,proms] = findpeaks(smooth_trace,'MinPeakHeight', 1.5*std(smooth_trace)+mean(smooth_trace),'MinPeakProminence',0.003*1/std(smooth_trace));
        %works for neg mod trace event detection... %[pks,locs,widths,proms] = findpeaks(smooth_trace,'MinPeakHeight', std(smooth_trace)+mean(smooth_trace),'MinPeakProminence',0.0025*1/std(smooth_trace)); % Find the peaks of the smoothed signal
    else
        pks = [];
        locs = [];
        widths = [];
        proms = [];
    end
    event_start = [];
 
    for i=1:numel(pks)
        %Invert a small window preceding each identified spike and find new peaks
        try
            [~,locs_i]=findpeaks(-smooth_trace(locs(i)-pre_window:locs(i)),'MinPeakProminence',0.15*abs(median(-smooth_trace(locs(i)-pre_window:locs(i)))));
            pre_win_flag = 0; %ensure flag is low
        catch
            %If an identified peak occurred before the 60th frame, do not use pre-window
            try
                [~,locs_i]=findpeaks(-smooth_trace(1:locs(i)),'MinPeakProminence',0.15*abs(median(-smooth_trace(1:locs(i)))));
                pre_win_flag = 1; %set flag high
            catch %if identified peak was one of the first few frames set location to first frame
                locs_i = 1;
                pre_win_flag = 1;
            end
        end
        try
            if ~pre_win_flag
                j=0;
                while (smooth_trace(locs(i))-(smooth_trace(locs_i(end-j)+(locs(i)-pre_window)))) < 0.5*std(smooth_trace)
                    j=j+1;
                end
                start_idx = locs_i(end-j)+(locs(i)-pre_window); %use the most recent possible variance spike for the beginning of the spike
            else %If the pre-window did not introduce any shift
                j=0;
                while (smooth_trace(locs(i))-(smooth_trace(locs_i(end-j)))) < 0.5*std(smooth_trace)
                    j=j+1;
                end
                start_idx = locs_i(end-j);
            end
        catch
            if ~pre_win_flag
                start_idx = locs(i)-pre_window;
            else %If the pre-window did not introduce any shift
                start_idx = 1;
            end
        end
        event_start = [event_start; start_idx];
    end
    event_idx = [event_start,locs];
    event_time = event_idx/sample_freq;
    if isempty(pks) %update empty_idx if no peaks were identified
        empty_idx = [empty_idx,roi_idx];
        event_idx = [nan,nan];
        event_time = [nan,nan];
    end
    %check by plotting
    %figure; plot(smooth_trace); hold on; scatter(event_times(:,1),smooth_trace(event_times(:,1)),'ro');scatter(event_times(:,2),smooth_trace(event_times(:,2)),'ko');
%% Check whether starts are overlapping with previous spikes
i=2;
total_events = 1;
new_event_flag = 1;
startIdx = 1;
endIdx = 1;
while i< size(event_time,1)
    if event_time(i,1) < event_time(i-1,2) || event_time(i,1)< event_time(endIdx(end),2) %If the event starts before the previous one ends..
        endIdx(total_events) = i-1;
        if pks(i) > pks(endIdx(total_events))
            endIdx(total_events) = i;
        end
        if event_time(i,1) < event_time(i-1,1)
            startIdx(total_events) = i;
        else
            startIdx(total_events) = i-1;
        end
        i=i+1;
        if new_event_flag
            total_events = total_events+1;
            new_event_flag = 0;
        end
    else
        total_events = total_events +1;
        startIdx(total_events) = i;
        endIdx(total_events) = i;
        new_event_flag = 1;
        i=i+1;
    end
end
try
    for i=1:total_events
        consolidated_event_time(i,1) = event_time(startIdx(i), 1);
        consolidated_event_time(i,2) = event_time(endIdx(i), 2);
        new_pks(i) = pks(endIdx(i));

    end
catch
end
%% OLD CODE
        try
            roi_list(roi_idx).event_time = consolidated_event_time;
            roi_list(roi_idx).event_idx = consolidated_event_time * sample_freq;
            roi_list(roi_idx).event_amp = new_pks;
        catch
            roi_list(roi_idx).event_time = event_time;
            roi_list(roi_idx).event_idx = event_idx;
            roi_list(roi_idx).event_amp = pks;
        end
        roi_list(roi_idx).event_widths = widths;
        roi_list(roi_idx).event_prominence = proms;
%         roi_list(roi_idx).event_fall = event_fall(sort_idx,:);
        

end


fprintf(['Total loading time: ',num2str(round(toc(whole_tic),2)),' seconds.\n']);

end


