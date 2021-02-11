% vonmisesCost
% sum squared error = sum((y-yhat)^2)
% b-parameter and x-direction are given, y is the data

function f = vonMisesCost(b,x,y)
    y_predicted = vonMises(b,x); %get the prediction, from our vM fn
    f = sum((y-y_predicted).^2); % . to indicate element-wise, not array!!
end