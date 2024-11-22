% find_fwhm_Ca_events.m
% Author: Cara
% Date: 06/06/23
% Purpose: Find the full width at half maximum of an identified trace. This
% is intended to be used on individually identified calcium events which
% have already been identified by event detection and chopped into a
% smaller window. Thus, the window is centered around the particular event
% of interest and we use that for FWHM calculation.

function fwhm = find_fwhm_CA_events(trace, center)

% Identify max for trace, either with center or via max function
if ~exist('center')
    maximum = max(trace);
else
    maximum = trace(center);
end

% Find the half max value
halfMax = (min(trace) + maximum) / 2;

% Find where the data first drops below half the max
index1 = find(trace >= halfMax, 1, 'first');

% Find where the data last rises above half the max
index2 = find(trace >= halfMax, 1, 'last');

fwhm = index2-index1;
end




















