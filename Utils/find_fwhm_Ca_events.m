% find_fwhm_Ca_events.m
% Author: Cara
% Date: 06/06/23
% Purpose: Find the full width at half maximum of an identified trace. This
% is intended to be used on individually identified calcium events which
% have already been identified by event detection and chopped into a
% smaller window. Thus, the window is centered around the particular event
% of interest and we use that for FWHM calculation.

function fwhm = find_fwhm_Ca_events(trace, center)

% Identify max for trace, either with center or via max function
if ~exist('center')
    maximum = max(trace);
else
    maximum = trace(center);
end

if isnan(maximum)
    fwhm = NaN;
else
    % Find the half max value
    halfMax = (min(trace) + maximum) / 2;
        
    % Find where the data last rises above half the max
    index1 = find(~(trace(1:center) >= halfMax), 1, 'last');

    % Find where the data first drops below half the max
    index2 = find(~(trace(center:end) >= halfMax), 1, 'first');

    if isempty(index1) || isempty(index2) %If the half-maximum is/cannot be found
        fwhm = NaN;
    else
        fwhm = (index2+center-1)-index1;
    end

end