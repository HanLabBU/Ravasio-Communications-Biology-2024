function [roi_list] = runDetrendNormalize(roi_list)

for c = 1:size(roi_list,2)
    traceDetrend = detrend(roi_list(c).trace);
    traceRange = max(traceDetrend)-min(traceDetrend);
    roi_list(c).trace = (traceDetrend - min(traceDetrend))/traceRange; 
end

end 