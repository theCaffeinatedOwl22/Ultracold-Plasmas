clc
clear
close all


% define magnetic field equations
u = 9.274e-24; %J/T
b = .766; %T/m
h = 1.5;
B = @(x,y) b.*sqrt((h.*x).^2+y.^2);

% defind lande g factors for all four transitions
gFac = @(j,l,s) 1+(j*(j+1)+s*(s+1)-l*(l+1))/(2*j*(j+1));
gFacSPlus = gFac(1/2,0,1/2);
gFacPPlus = gFac(1/2,1,1/2);
gFacSMinus = gFac(1/2,0,1/2);
gFacPMinus = gFac(1/2,1,1/2);

% calculate dGM = g mj - g' mj' for all transitions
dgmPiPlus = 1/2*(gFacPPlus - gFacSPlus);
dgmPiMinus = 1/2*(-gFacPMinus + gFacSMinus);
dgmSigPlus = 1/2*(gFacPPlus + gFacSMinus);
dgmSigMinus = 1/2*(-gFacPMinus - gFacSPlus);

% calculate zeeman shift functions
convertJtoHz = 1/6.626e-34;
shiftPiPlus = @(x,y) u*B(x,y)*dgmPiPlus*convertJtoHz;
shiftPiMinus = @(x,y) u*B(x,y)*dgmPiMinus*convertJtoHz;
shiftSigPlus = @(x,y) u*B(x,y)*dgmSigPlus*convertJtoHz;
shiftSigMinus = @(x,y) u*B(x,y)*dgmSigMinus*convertJtoHz;

% plot level shifts vs space
x = 0:.1:5;
y = 0:.1:5;
figure
plot(x,shiftPiPlus(.0025,y/1000)/1e6)
hold on
plot(x,shiftPiMinus(.0025,y/1000)/1e6)
plot(x,shiftSigMinus(.0025,y/1000)/1e6)
plot(x,shiftSigPlus(.0025,y/1000)/1e6)
title('Zeeman Shifts At X = 2.5 mm')
xlabel('x (mm)')
ylabel('\DeltaE (MHz)')
legend({'PiPlus','PiMinus','SigMinus','SigPlus'})