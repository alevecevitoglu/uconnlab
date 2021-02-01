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
spikeinfo_temp = zeros (1, 2000);
for i=1:length(data(x).spks)
    spikeinfo = data(x).spks{1,i};
    for  j =1:length(spikeinfo) %#ok<ALIGN>
        somenumber= spikeinfo(j);
        spikeinfo_temp(somenumber) = spikeinfo_temp(somenumber)+1; 
	end
end
bar(spikeinfo_temp)

xlabel('time[ms]') 
ylabel('Counts')



