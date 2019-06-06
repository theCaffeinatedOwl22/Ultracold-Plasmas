function [gL] = calcLandeGFac(j,l,s)
%% Program Notes
% This program calculates the Lande g-factor for a given total angular
% momentum (j), orbital angular momentum (l), and spin angular momentum (s)
% quantum number.

%% Calculate g-factor
gL = 1+(j.*(j+1)+s.*(s+1)-l.*(l+1))/(2.*j.*(j+1));

end

