%% 2.0 Load data...
close all
% either Axon Diameter vs Conduction Velocity
%data = readtable('Hursh1936.csv');

% or log-Body Weight vs log-Brain Weight
data = readtable('BodyBrain.csv');
data = table2array(data);

%% 2.1 Bootstrap to estimate the mean and sem of the x-variable
nboot = 10000;
xdata=data(:,1);
ydata=data(:,2);

M = mean(xdata);
SD = std(xdata);

bootstat = bootstrp(nboot, @mean ,xdata);
stderror = std(bootstat);

f1=figure;
histogram(bootstat)


%% 2.2 Plot the data
f2 = figure;
plot(xdata,ydata, "o") %scatter plot


%% 2.3 Linear regression
% linear regression (linear:1st degree!)
% returns the coefficients for a polynomial p(x) of degree n that is a best fit
p_coef = polyfit(xdata,ydata,1); %x,y,n n is the degree

%% 2.4 Plot the data and fit
f3 = figure;
hold on
x = linspace(min(xdata), max(xdata),100); %all xdata points, devided to 100
predictionY = polyval(p_coef, x); %polyval(p,x) evaluates the polynomial p at each point in x. 
plot(xdata,ydata,'o',x,predictionY,'-') 
legend('data', 'linear fit')


%% 2.5 Bootstrap to find error-bars for the model parameters
nboot = 1000;
[bootstat,bootsam] = bootstrp(nboot,'mean',ydata); %ydata is bootstrapped, bootsam gives all the possibilities
 
for i=1:nboot
    bboot(i,:) = polyfit(data(bootsam(:,i),1), data(bootsam(:,i),2),1); 
    %returns all 1000 bootstrap samples and make a matrix for each p_coef
    bpred(i,:) = polyval(bboot(i,:),x); %returns the y-values for each coef
end
 
err = 1.96.*std(bpred); %of predicted ydata

plot(x,predictionY+err,'k--') %CI calculation
plot(x,predictionY-err,'k--') %CI calculation
hold off


