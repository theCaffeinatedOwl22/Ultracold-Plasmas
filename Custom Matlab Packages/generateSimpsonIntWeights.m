function [w] = generateSimpsonIntWeights(x)
%% 
w = ones(length(x),1);
w(2:2:end) = 2;
w(3:2:end) = 4;
w(end) = 1;
w = w.*(x(2)-x(1))./3;



end