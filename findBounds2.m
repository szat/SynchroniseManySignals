function [ bounds ] = findBounds2( t1, t2 )
% Uses Matlab's finddelay (xcorr) to find the matching bounds of two signals, i.e.:
%   bounds(i,1) = start point for signal i, bounds(i,2) = end point for signal i
%   bounds(i,2) - bounds(i,1) = c, for some c > 0, for any i, and
%   t1(bounds(1,1)+j) corresponds to t2(bounds(2,1)+j).

% Usage: [ bounds ] = findBounds2( t1, t2 )
%
% Arguments:  
%               t1  - First signal, should be m x 1
%               t2  - Second signal, should be n x 1    
%
% Returns: 
%            bounds - matrix 2 x 2, where 
%                       bounds(1,1) = start of t1, bounds(1,2) = end of t1
%                       bounds(2,1) = start of t2, bounds(2,2) = end of t2

% Example:
% S = load('laughter');
% S = S.y;
% nb = 2;
% signals = cell(nb,1);
% rand_bounds = randi([1 5000], nb, 2);
% for i = 1:nb
%    noise = 0.1*rand(length(S) - rand_bounds(i,2) - rand_bounds(i,1) + 1, 1);
%    signals{i} = S(rand_bounds(i,1): end - rand_bounds(i,2)) + noise; 
% end
% [bounds] = findBounds2(signals);

% Copyright (c) Adrian Szatmari
% Author: Adrian Szatmari
% Date: 2017-11-30
% License: MIT, patent permitting
%
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in 
% all copies or substantial portions of the Software.
%
% The Software is provided "as is", without warranty of any kind.

bounds = zeros(2,2);

d12 = finddelay(t1,t2);
if(d12 < 1)
    start1  = -d12+1;
    start2  = 1;
    len1    = min(length(t1) - start1, length(t2) - start2);
    len2    = min(length(t1) - start1, length(t2) - start2);
    end1    = start1 + len1;
    end2    = start2 + len2;
    %note the suffling of +/- 1
else
    start1  = 1;
    start2  = d12+1;
    len1    = min(length(t1) - start1, length(t2) - start2);
    len2    = min(length(t1) - start1, length(t2) - start2);
    end1    = start1 + len1;
    end2    = start2 + len2;
    %note the suffling of +/- 1
end
bounds(1,1) = start1;
bounds(2,1) = start2;
bounds(1,2) = end1;
bounds(2,2) = end2;
end

