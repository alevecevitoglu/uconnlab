% Plot a raster along with the psth...

load('nsa2009_1.mat')
x = input('Enter neuron number: ');

% Plot the spike raster
subplot(2,1,1); 
for i=1:length(data(x).spks)
	spikeinfo = data(x).spks{1,i};

	trial_temp = zeros (1, length(spikeinfo));
	trial = trial_temp +i;

	scatter(spikeinfo, trial, 5, 'b', 'filled');
	hold on
end

title (data(x).name)
ylabel('Trials')

% Plot the PSTH
binsize = 5;
maxTime = 2000;

subplot(2,1,2); 
bin_edges = linspace(0,2000,2000/binsize+1);
spikeinfo_temp = zeros (1, length(bin_edges)-1);
for i=1:length(data(x).spks)
    spikeinfo = data(x).spks{1,i};
    n = histcounts(spikeinfo,bin_edges);
    spikeinfo_temp = spikeinfo_temp+n;
end
bar(spikeinfo_temp,1) 

bin_centers = bin_edges(1:end-1)+mean(diff(bin_edges))/2;
bar(bin_centers,spikeinfo_temp,1) %draws the bars at the locations specified by x.
xlim([0 2000])

xlabel('time[ms]') 
ylabel('Counts')



