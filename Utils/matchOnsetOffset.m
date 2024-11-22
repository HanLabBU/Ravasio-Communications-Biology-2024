function[paired_onsets,paired_offsets,lone_onsets,lone_offsets] = matchOnsetOffset(idx_onset,idx_offset)
Fs = 20;
time_onset = idx_onset/Fs;
time_offset = idx_offset/Fs;

paired_onsets = [];
paired_offsets = [];
lone_onsets = [];
lone_offsets = [];
n_onset = numel(time_onset);
for tt = 1:n_onset
    onset_curr =  time_onset(tt);
    onset_next = time_onset(min(n_onset,tt+1));
    offset_all =  time_offset > onset_curr & time_offset < onset_next;
    offset_matched_idx = find(offset_all,1,'first');
    offset_unmatched = offset_all;
    offset_unmatched(offset_matched_idx) = [];
    offset_unmatched_idx = find( offset_unmatched);
    
    paired_offsets = [paired_offsets,offset_matched_idx];
    lone_offsets = [lone_offsets,offset_unmatched_idx];
    
    if ~isempty(offset_matched_idx)
        paired_onsets  = [paired_onsets, tt];
    else
        lone_onsets  = [lone_onsets, tt];
    end
end
end
