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

% Get some audio signal
S = load('laughter');
S = S.y;


% Select the number of signals to synchronize
nb = 20;
signals = cell(nb,1);

% Simulate "new" shifted signals with some noise
rand_bounds = randi([1 4000], nb, 2);
for i = 1:nb
   noise = 0.1*rand(length(S) - rand_bounds(i,2) - rand_bounds(i,1) + 1, 1);
   signals{i} = S(rand_bounds(i,1): end - rand_bounds(i,2)) + noise; 
end

% Computation, linear in the number of signals
[bounds] = findBoundsN(signals);

% Visualization
% Before synchronization
figure 
hold on
for i = 1:nb
    subplot(nb,1,i);
    plot(1:length(signals{i}), signals{i});
end
suptitle('Signals before synchronization');
hold off

% After synchronnization
figure 
hold on
for i = 1:nb
    subplot(nb,1,i);
    plot(1:(bounds(i,2)-bounds(i,1)+1), signals{i}(bounds(i,1):bounds(i,2)));
end
suptitle('Signals after synchronization');
hold off