

%% 2.0 Load data...

% either Axon Diameter vs Conduction Velocity
data = readtable('Hursh1936.csv');

% or log-Body Weight vs log-Brain Weight
data = readtable('BodyBrain.csv');

data = table2array(data);

%% 2.1 Bootstrap to estimate the mean and sem of the x-variable

nboot = 10000;
xdata=data(:,1);
ydata=data(:,2);
bootstat = bootstrp(nboot,'mean',xdata);
histogram(bootstat)

%% 2.2 Plot the data
plot(data(:,1),data(:,2), "o") %scatter plot


%% 2.3 Linear regression

% linear regression
b = polyfit(xdata,ydata,1);


%% 2.4 Plot the data and fit
polyfit(data(:,1), data(:,... (in the code)

%% 2.5 Bootstrap to find error-bars for the model parameters

nboot = 1000;
[bootstat,bootsam] = bootstrp(nboot,'',???);
for i=1:nboot
    bboot(i,:) = polyfit(???); (bootsam!!!)
end




