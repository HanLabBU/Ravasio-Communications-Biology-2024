% fwhm_and_pk.m
% Date: 12/06/22
% This function is to find the fwhm and peak of a single trace or a matrix
% of traces for the transient DBS GCaMP analysis.
function [pks, locs, FWHM, LHS, RHS] = fwhm_and_pk(smooth_trace,Fs,reb_flag)
pks=[];locs=[]; FWHM=[]; LHS=[]; RHS=[];
for i=1:size(smooth_trace,1)
    if ~reb_flag
        [pks_temp,locs_temp,~]=findpeaks(smooth_trace(i,5*Fs:13*Fs),'WidthReference','halfheight','SortStr','descend','NPeaks',1); %the fwhm given from this will be wrong because it cuts off at the adjacent peaks
        try
            transition = smooth_trace(i,:) < pks_temp/2; %ones when less than half height
            LHS_temp = find(fliplr(transition(1:(locs_temp+5*Fs-1))),1,'first');  %Left Hand Skew. Flip trace so it is from peak to first frame, find the first crossing point before peak)
            RHS_temp = find(transition((locs_temp+5*Fs-1):end),1,'first'); %Right Hand Skew. Take trace from peak to end and find first crossing point after peak
            if isempty(RHS_temp)
                RHS_temp = NaN;
            end
            FWHM_temp = LHS_temp + RHS_temp;
            %locs = [locs;locs_temp+5*Fs-1];
        catch
            LHS_temp = NaN;
            RHS_temp = NaN;
            FWHM_temp = NaN;
            %locs = [locs;NaN];
        end
            
    elseif reb_flag
        [pks_temp,locs_temp,~]=findpeaks(smooth_trace(i,10*Fs:end),'WidthReference','halfheight','SortStr','descend','NPeaks',1); %the fwhm given from this will be wrong because it cuts off at the adjacent peaks
        transition = smooth_trace(i,:) < pks_temp/2; %ones when less than half height
        LHS_temp = find(fliplr(transition(1:(locs_temp+10*Fs-1))),1,'first');  %Left Hand Skew. Flip trace so it is from peak to first frame, find the first crossing point before peak)
        if isempty(RHS_temp)
            RHS_temp = NaN;
        end
        FWHM_temp = LHS_temp + RHS_temp;
        %locs = [locs;locs_temp+10*Fs-1];
    end
    [max_val,max_idx] = max(smooth_trace(i,5*Fs:13*Fs));
    locs = [locs; max_idx+5*Fs]; % add back offset frames
    %vertically concatenate for each neurons
    %pks = [pks;pks_temp]; 
    pks = [pks;max_val];
    FWHM=[FWHM;FWHM_temp];
    LHS=[LHS;LHS_temp];
    RHS=[RHS;RHS_temp];
end

end