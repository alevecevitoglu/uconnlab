% Plot a raster along with the psth...
close all
load('nsa2009_1.mat')
x = input('Enter neuron number: ');

%% Plot the spike raster
subplot(2,1,1); 
for i=1:length(data(x).spks) %this is the trial number
	spikeinfo = data(x).spks{1,i}; %this refers to the ith trial = spike #

	trial_temp = zeros (1, length(spikeinfo)); %bcs x and y should be the same lenght
	trial = trial_temp +i;

	scatter(spikeinfo, trial, 5, 'b', 'filled');
	hold on %to keep adding
end

title (data(x).name)
ylabel('Trials')

%% Plot the PSTH
binsize = 5; %to chunk the data

subplot(2,1,2); 
bin_edges = linspace(0,2000,2000/binsize+1); %+1 for define the edge
spikeinfo_temp = zeros (1, length(bin_edges)-1); %-1 to remove the articial 1
for i=1:length(data(x).spks)
    spikeinfo = data(x).spks{1,i};
    n = histcounts(spikeinfo,bin_edges); %gives vector that shows how many spikes in each bin
    spikeinfo_temp = spikeinfo_temp+n; 
end

bin_centers = bin_edges(1:end-1)+mean(diff(bin_edges))/2;
bar(bin_centers,spikeinfo_temp,binsize) %draws the bars at the locations specified by x.

xlabel('time[ms]') 
ylabel('Counts')
