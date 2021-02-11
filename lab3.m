%% 3.1 Load the data and preview...
close all
load('data_v1_binned_moving.mat')

dataset_number = 1;
neuron_number = 1;

S = data{dataset_number}.spikes(neuron_number,:,:,:);
S = squeeze(S); % make data cube from the original 4d data 
% (only look at 1 neuron for now)

figure(1)
imagesc(mean(S,3)); % show the average spike response over time, 3D data
xlabel('Time'); ylabel('Orientation')

% Sum spike counts over time so that we have a single tuning function
spike_counts = sum(S(:,25:80,:),2);   % only take the data from time bins 25-80
spike_counts = squeeze(spike_counts); % make data cube into a matrix [orientations x trials]
%spikecounts=# of firings of 1 neuron for a specific orientation in a given time

%% 3.2 Plot spike counts as a function of orientation

figure(2)
stim_orientation = linspace(0,2*pi-2*pi/16,16);
plot(stim_orientation, spike_counts, 'o') 
xlabel('Orientation'); ylabel('Spike Counts')

%% 3.3 Make a function vonMises.m and Plot it using the following...

figure(3)
x = linspace(0,2*pi,256);  % Orientations to plot a smooth curve
b = [1 .5 pi];              % arbitrary parameters to test things out
plot(x,vonMises(b,x))
xlabel('Orientation [rad]'); ylabel('Von Mises');


%% 3.4 Use fminsearch to find the parameters (b) that minimize the sum squared error
%spikecounts size = 16x13
%orientation size = 1x16 (x13 trials)
x_matrix = repmat(stim_orientation',1,13); % first we need to make sure 'x' and 'y' are the right sizes and lined up
options=[]; % for now just use default options (see help fminsearch for more)

%fmin (function, start point, options)
% VonMisesCost (b, x, y) 
%bmse has the min error parameters
b_mse = fminsearch('vonMisesCost',[1 0.1 pi], options, x_matrix(:),spike_counts(:)); % do the optimization

%% 3.5 Plot your model fit with the data
figure(4)

x_matrix_deg = x_matrix*(180/pi); %Deg = Rad * (180 / π)

hold on
scatter(x_matrix_deg(:), spike_counts(:), 'bo') %as 3.4, we need to select rows for the matrices!
xlabel('Orientation [deg]'); ylabel('Spike Rate (counts)')

x0 = x*(180/pi);
plot(x0,vonMises(b_mse,x)) %By default the trig functions in matlab all assume radians.
hold off
