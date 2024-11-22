% session_avg.m
% Author: Cara Ravasio
% Date: 12/08/22
% Purpose: To find the session average trace for a modulation's .mat file
function data_mod = session_avg(data_mod)
    session_avg_trace = [];
    used_sessions = [];
    for i=1:max(data_mod.neurons(:,1))
        idx = find(data_mod.neurons(:,1)==i);
        if numel(idx)>= 1 %3 %if there are 3 or more neurons present
            avg_temp = mean(data_mod.traces(idx,:),1);
            session_avg_trace = [session_avg_trace;avg_temp];
            used_sessions = [used_sessions,i];
        end
    end
    data_mod.session_avg_traces = session_avg_trace;
    data_mod.used_sessions = used_sessions;
end