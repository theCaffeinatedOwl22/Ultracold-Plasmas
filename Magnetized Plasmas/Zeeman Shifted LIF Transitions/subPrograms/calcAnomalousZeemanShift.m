function [dEz,gL] = calcAnomalousZeemanShift(q,B)
%% Program Notes
% This program calculates the anomalous Zeeman shift of a quantum level
% with orbital angular momentum (l), spin angular momentum (s), total
% angular momentum (j=l+s), and projection of total angular momentum (m),
% and magnetic field magnitude B. dEz is the Zeeman shift in units of Hz.
% All quantities within this program should be in standard units

%% Calculate Zeeman shift
% Unfold inputs
n = q(1);
l = q(2);
s = q(3);
j = q(4);
m = q(5);
% Define constants
u = 9.274e-24; % bohr magneton with units (J/T)
h = 6.626e-34; % planck's constant with units (J*s)
% Obtain lande g-factor
gL = calcLandeGFac(j,l,s);
% Calculate Zeeman shift in SI units
dEz = gL.*u.*B.*m;
% Convert Zeeman shift to Hz
dEz = dEz./h;

end

