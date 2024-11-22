% detrend_Cara.m
% Author: Cara R
% Date: 08/04/22
% Purpose: Adapted from matlab's standard detrend.m function. To be used
% when a general trend from DBS could affect the overall detrending of the
% data and introduce an unintentional artifact.
% Changes: Use baseline activity to detrend, but apply the detrending shift
% to full trace.

function y = detrend(x,entire_trace,o,bp) %added entire_trace argin
%Notes from original matlab function =====================================%
%DETREND Remove a linear trend from a vector, usually for FFT processing.
%   Y = DETREND(X) removes the best straight-line fit linear trend from the
%   data in vector X and returns the residual in vector Y.  If X is a
%   matrix, DETREND removes the trend from each column of the matrix.
%
%   Y = DETREND(X,'constant') removes just the mean value from the vector X,
%   or the mean value from each column, if X is a matrix.
%
%   Y = DETREND(X,'linear',BP) removes a continuous, piecewise linear trend.
%   Breakpoint indices for the linear trend are contained in the vector BP.
%   The default is no breakpoints, such that one single straight line is
%   removed from each column of X.
%
%   Class support for inputs X,BP:
%      float: double, single
%
%   See also MEAN

%   Copyright 1984-2015 The MathWorks, Inc.
% ========================================================================%

if nargin < 3 %changed from 2 becuase a new argin was added
    o  = "linear";
else
    if ( (~isscalar(o) && ~ischar(o)) || ~(isstring(o) || ischar(o) || isnumeric(o) || islogical(o)) )
        error(message('MATLAB:detrend:InvalidTrendInputType'));
    end
end
if nargin < 4 %changed from 3 because a new argin was added
    bp = 1;
end
isrowx = isrow(x);
if isrowx
    x = x(:);   % If a row, turn into column vector
    entire_trace = entire_trace(:); % included so that all usual math structure from the function works.
end

if isnumeric(o) || islogical(o)
    j = o == [0 1];
else
    if (((isstring(o) && isscalar(o)) || (ischar(o) && isrow(o))) && (strlength(o) > 0))
        j = strncmpi(o, ["constant" "linear"], strlength(o));
    else
        j = false(1, 2);
    end
end

if ~any(j)
    if isstring(o)
        o = char(o);
    end
    % This should eventually become an error.
    warning(message('MATLAB:detrend:InvalidTrendType', o));
    y = detrend(x,'linear',bp);
else
    if j(1)
        y = entire_trace - mean(x,1);   % Remove just mean from each column %changed 'x' to 'entire_trace'
    else
        N = size(x,1);
        bp = unique([1; double(bp(:)); N]);   % Include both endpoints
        bp = bp(bp >= 1 & bp <=N);   % Should error in the future
        lbp = length(bp);
        % Build regressor with linear pieces + DC
        a = zeros(N,lbp,class(x));
        a(1:N,1) = (1:N)./N;
        for k = 2:(lbp-1)
            M = N - bp(k);
            a((bp(k)+1):end,k) = (1:M)./M;
        end
        a(1:N,end) = 1; 
        best_fit = a*(a\x);
        slope = (best_fit(end)-best_fit(1))/(size(x,1)-1); %Find linear slope from the baseline period...
        %y = entire_trace - [best_fit(1):best_fit(2)-best_fit(1):slope*size(entire_trace,1)+best_fit(1)-slope]';   % now extrapolate and apply over the entire trace.
        y = entire_trace-[0:slope:slope*(size(entire_trace,1)-1)]'+ ones(size(entire_trace)).*best_fit(1);
    end
end

if isrowx
    y = y.';
end
