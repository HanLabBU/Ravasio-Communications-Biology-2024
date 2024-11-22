function [event_fall] =  iterative_get_event_fall(event_idx,whole_trace,max_fall)

event_fall = nan*ones(size(event_idx));
nEv = size(event_idx,1);
% figure
% plot(whole_trace)
for spike_time_idx = 1:nEv
    end_idx = event_idx(spike_time_idx,2);
    start_idx = event_idx(spike_time_idx,1);
    event_fall(spike_time_idx,1) = end_idx+1;
    eWidth = end_idx - start_idx;
    if spike_time_idx+1 <= nEv
        next_idx = event_idx(spike_time_idx+1,1); % next event start 
    else
        next_idx = numel(whole_trace)-1; % if last event then end of the trace
    end
    next_idx = min(next_idx,end_idx+1+max_fall*eWidth); % minimum of either 4*event rise time or [Above]
    
    if next_idx>end_idx+2
        trace_after = whole_trace(end_idx+2:next_idx);
        trace_during = whole_trace(start_idx:end_idx+1);
        [~,end_loc] = min(abs(trace_after-min(trace_during)),[],'omitnan');
        event_fall(spike_time_idx,2) = end_loc+end_idx+1;
    else
        event_fall(spike_time_idx,2) = end_idx+1;
    end
%     vline(event_idx(spike_time_idx,1),'g')
%     vline(event_fall(spike_time_idx,1),'m')
    
end

end