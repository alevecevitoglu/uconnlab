%vonMises function depending on x - direction!
%and the prediction (b)
%frequency; 2 cycles to start with - example

function f = vonMises(b,x)
f = exp(b(1)+b(2)*cos(2*(x-b(3))));
end
