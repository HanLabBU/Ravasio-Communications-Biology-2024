% find_pkht_Ca_events.m
% Author: Cara
% Date: 11/09/23
% Purpose: Find the peak height of an identified trace. This
% is intended to be used on individually identified calcium events which
% have already been identified by event detection and chopped into a
% smaller window. Thus, the window is centered around the particular event
% of interest and we use that for peak height calculation.

function pkht = find_pkht_Ca_events(trace, center)

% Identify max for trace, either with center or via max function
if ~exist('center')
    maximum = max(trace);
else
    maximum = trace(center);
end

if isnan(maximum)
    pkht = NaN;  
else
    pkht = maximum;
end

end