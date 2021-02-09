%% 2.0 Load data...

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
regressionfit = polyfit(xdata,ydata,1); %x,y,n n is the degree

%%make prediction line
%The polyval function takes x values
% and parameters as input and returns estimated y values.
%polyval you can find standard errors for your predictions of y.
predictionY = polyval(regressionfit, xdata) %polyval(p,x) evaluates the polynomial p at each point in x. 


%% 2.4 Plot the data and fit
f3 = figure;
plot(xdata,ydata,'o',xdata,predictionY) %hold on
legend('data', 'linear fit')


%% 2.5 Bootstrap to find error-bars for the model parameters
nboot = 1000;
%y = linspace(a,b,n) generates a row vector y of n points 
%linearly spaced between and including a and b

[bootstat,bootsam] = bootstrp(nboot,'mean',ydata); %neden ydata

x = linspace(min(xdata), max(xdata),100); 
for i=1:nboot
    bboot(i,:) = polyfit(data(bootsam(:,1), 
                            data(bootsam(:,i),2),1)
    bpred(i,:) = polyval(bboot(1,:),x);
end



%%
nboot = 1000;
%y = linspace(a,b,n) generates a row vector y of n points 
%linearly spaced between and including a and b
 
[bootstat,bootsam] = bootstrp(nboot,'mean',ydata); %neden ydata
 
x = linspace(min(xdata), max(xdata),100); 
for i=1:nboot
    bboot(i,:) = polyfit(data(bootsam(:,i),1), data(bootsam(:,i),2),1);
    bpred(i,:) = polyval(bboot(1,:),x);
end
 

bpred = bpred(1,:)';
plot(x,bpred,'k');

%%

nboot = 1000;
%y = linspace(a,b,n) generates a row vector y of n points 
%linearly spaced between and including a and b
 
[bootstat,bootsam] = bootstrp(nboot,'mean',ydata);
 
x = linspace(min(xdata), max(xdata),100); 
for i=1:nboot
    bboot(i,:) = polyfit(data(bootsam(:,i),1), data(bootsam(:,i),2),2);
    bpred(i,:) = polyval(bboot(i,:),x);
end
 
f4 = figure;
plot(x,bpred,'--');
hold off




