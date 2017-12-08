function [ bounds ] = findBoundsN(signals)
% Uses Matlab's finddelay (xcorr) to find the matching bounds of n signals, i.e.:
%   bounds(i,1) = start point for signal i, bounds(i,2) = end point for signal i
%   bounds(i,2) - bounds(i,1) = c, for some c > 0, for any i, and
%   signals{i}(bounds(i,1)+j) corresponds to signals{k}(bounds(k,1)+j).

% Usage: [ bounds ] = findBoundsN( signals )
%
% Arguments:  
%          signals  - A n x 1 cell of n signals, where a signal is an m x 1 array.    
%
% Returns: 
%            bounds - matrix n x 2, where bounds(i,1) = start of signals{i}
%                     bounds(i,2) = end of signals{i}

% Example:
% S = load('laughter');
% S = S.y;
% nb = 10;
% signals = cell(nb,1);
% rand_bounds = randi([1 5000], nb, 2);
% for i = 1:nb
%    noise = 0.1*rand(length(S) - rand_bounds(i,2) - rand_bounds(i,1) + 1, 1);
%    signals{i} = S(rand_bounds(i,1): end - rand_bounds(i,2)) + noise; 
% end
% [bounds] = findBoundsN(signals);

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

% The following code uses the following reccurrence relation:
% Suppose that B is a n-1 x 2 matrix that is already synchronized, 
% such that B(i,1) = start of signal i and B(i,2) = end of signal i. 
% Note that we have that B(:,2) - B(:,1) is a constant vector. Now add a new n-th signal.
% Note that n-th signal only needs to be computed against the (n-1)-th signal. 
% Let B_(n-1) = [a_1, b_1; ... ; a_(n-1), b_(n-1)], then compute
% findBounds2(s_(n-1)(a_(n-1),b_(n-1), s_n) = [a'_(n-1), b'_(n-1); a_n, b_n], 
% and we get the new bounds B_n = [a_1 + a'_(n-1) - 1, a_1 + b'_(n-1) - 1; ... 
% ... ; a_(n-1) + a'_(n-1) - 1, a_(n-1) + b'_(n-1) - 1; a_n, b_n];

bounds = zeros(length(signals),2);
bounds(1,:) = [1,length(signals{1})];
for i = 1:length(signals)-1
   temp = findBounds2(signals{i}(bounds(i,1):bounds(i,2)),signals{i+1});
   for j = 1:i
       temp_low_bound = bounds(j,1);
       bounds(j,1) = temp_low_bound + temp(1,1) - 1;
       bounds(j,2) = temp_low_bound + temp(1,2) - 1; 
   end
   bounds(i+1,:) = temp(2,:);
end
temp = findBounds2(signals{i}(bounds(i,1):bounds(i,2)),signals{i+1});
for j = 1:i+1
       temp_low_bound = bounds(j,1);
       bounds(j,1) = temp_low_bound + temp(1,1) - 1;
       bounds(j,2) = temp_low_bound + temp(1,2) - 1; 
end
end

