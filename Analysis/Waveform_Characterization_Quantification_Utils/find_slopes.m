% find_slopes.m
% Author: Cara Ravasio
% Date: 12/07/22
% Purpose: to find the increasing and decreasing slopes of transient DBS
% GCaMP traces.
% locs is the location of the peak from the findpeaks function, reb_flag = 0
% for pos or neg mod and =1 for reb.

function [inc_slope,dec_slope]=find_slopes(smooth_trace,Fs,locs,reb_flag)
inc_slope=[]; dec_slope=[];
for i=1:size(smooth_trace,1)
    %increasing slope (start at stim onset for pos and neg, start at stim offset for reb)
    if ~reb_flag
        p = polyfit([5:1/Fs:7],smooth_trace(i,5*Fs:7*Fs),1); %polyfit a line
        inc_slope_temp = p(1);
    elseif reb_flag
        p = polyfit([10:1/Fs:11],smooth_trace(i,10*Fs:11*Fs),1); %polyfit a line
        inc_slope_temp = p(1);
    end
    %decreasing slope (start from the peak and define over the following 1 sec)
    p_d = polyfit([locs(i)/Fs:1/Fs:locs(i)/Fs+1],smooth_trace(locs(i):locs(i)+1*Fs),1); %polyfit a line
    dec_slope_temp = p_d(1);

    %vertically concatenate for every neuron
    inc_slope = [inc_slope;inc_slope_temp];
    dec_slope = [dec_slope;dec_slope_temp];
end

end