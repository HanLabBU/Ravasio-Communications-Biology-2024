
cd('E:\NEXMIF\fullDataAll\analyzed from Athif\event_detection_improved_thresLower6')
fdmat = dir('*platform.mat');

for i = 1:numel(fdmat)
    load(fdmat(i).name)
    if isfield(fullData, 'goodIdx')
        if size(fullData.goodIdx,2) >= 40
            trace_event_plot(fullData.roi_list_minusBG_new, fullData.goodIdx(1:40))
        else
            trace_event_plot(fullData.roi_list_minusBG_new, fullData.goodIdx)
        end

    end
    
    clear fullData
end 












