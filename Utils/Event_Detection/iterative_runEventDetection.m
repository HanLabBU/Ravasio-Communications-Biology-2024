function [roi_list,empty_idx] = iterative_runEventDetection(roi_list)%, save_keyword)
% run the four event detection scripts together

roi_list = iterative_trace_event_detection_ext2(roi_list);
roi_list = trace_event_remove_overlap(roi_list);
roi_list = detect_event_fall(roi_list,4);
roi_list = trace_waveform(roi_list);
[roi_list,empty_idx] = trace_waveform_return_empty(roi_list);

end