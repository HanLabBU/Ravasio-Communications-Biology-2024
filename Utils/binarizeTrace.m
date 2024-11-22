function[binTraces] = binarizeTrace(fullData_struct)
binTraces = zeros(size(fullData_struct,2),size(fullData_struct(1).trace,2));
for roi_idx=1:size(fullData_struct,2)
    event_idx = fullData_struct(roi_idx).event_idx;
    for event = 1:size(event_idx,1)
        binTraces(roi_idx,[event_idx(event,1):event_idx(event,2)]) = 1;
    end
end
end

% figure
% plot(traces(5,:))
% hold on
% plot(max(traces(5,:))*binTraces(5,:))
