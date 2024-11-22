function[event_amp, event_time ,event_idx,pre_event_threshold] = iterative_get_spikes(event_time,whole_trace,std_threshold,pre_window,sample_freq)
x_axis = [1:numel(whole_trace)]/sample_freq;
event_idx = nan(size(event_time));
event_amp = nan(size(event_time,1),1);
pre_event_threshold = nan(size(event_time,1),1);

for spike_time_idx=1:size(event_time,1)
    start_time = event_time(spike_time_idx,1);
    [~,start_idx] = min(abs(x_axis-start_time));
    end_time = event_time(spike_time_idx,2);
    [~,end_idx] = min(abs(x_axis-end_time));
    
    current_trace = whole_trace(end_idx:end);
    d_current_trace = diff(current_trace);
    extra_end_idx = find(d_current_trace<=0,2);
    if ~isempty(extra_end_idx) %to handle error
        try
            end_idx = end_idx+extra_end_idx(2);
        catch
            end_idx = end_idx+extra_end_idx(1);
        end
    end
    current_trace = whole_trace(start_idx:end_idx);
    ref_idx = start_idx-1;
    [max_amp,max_idx] = max(current_trace,[],'omitnan');
    end_idx = ref_idx+max_idx(1);
    [min_amp,min_idx] = min(current_trace(1:max_idx),[],'omitnan');
    start_idx = ref_idx+min_idx(1);
    
    pre_start_idx = round(max(1,start_idx-pre_window*sample_freq));
    pre_event_threshold(spike_time_idx) = std_threshold*std(whole_trace(pre_start_idx:start_idx),'omitnan');
    event_amp(spike_time_idx) = max_amp-min_amp;
    event_time(spike_time_idx,1) = x_axis(start_idx);
    event_time(spike_time_idx,2) = x_axis(end_idx);
    event_idx(spike_time_idx,1) = start_idx;
    event_idx(spike_time_idx,2) = end_idx;
    
    whole_trace(start_idx:min(end_idx+3,numel(whole_trace))) = nan;
end
end