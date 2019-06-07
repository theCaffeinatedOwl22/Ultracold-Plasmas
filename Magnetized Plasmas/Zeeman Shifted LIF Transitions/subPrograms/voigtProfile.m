function [] = voigtProfile()
%%
clear
clc
close all
% Define Lorentzian broadening due to natural linewidth, laser broadening,
% and power broadening
gamN = 1.278e8/2/pi; % natural linewidth in units of Hz
gamL = 5; % laser linewidth in units of Hz
s0 = .1; % saturation parameter
gam = gamN*sqrt(1+s0)+gamL; % effective Lorentzian linewidth in units Hz
L = @(f) (gam/2/pi)./(gam^2/4+f.^2);

% Define Gaussian Doppler-broadened profile - note that this Gaussian does
% not have a center velocity because we're only interested in modeling what
% happens relative to the expansion velocity
kB = 1.38e-23; % Boltzmann constant in SI units
Ti = .05; % ion temperature in units K
m = 1.45e-25; % Sr+ mass in kg
lam = 422e-9; % imaging wavelength in m
k = 2*pi/lam; % wavevector in units m^-1
sig = k*sqrt(kB*Ti/m)/2/pi; % Doppler width in units of Hz
fc = 100e6; % center frequency of Gaussian
G = @(f) (1/sqrt(2*pi)/sig).*exp(-(f-fc).^2./(2*sig^2));

% Define frequencies to use for Simpson's Integration
dfForInt = gam/1000;
numPoints = ceil(10*sig/dfForInt/2)*2+1; % make sure number is round
fForInt = linspace(-75*sig,75*sig,numPoints);
dfForInt = mean(diff(fForInt));

% Set up weights for Simpson's Integration
w = ones(size(fForInt));
w(2:2:end) = 2;
w(3:2:end) = 4;
w(end) = 1;
w = w.*dfForInt./3;
w = w';


% Plot voigt
clear X Y
freq = linspace(-500e6,500e6,1000);
[X,Y] = meshgrid(fForInt,freq);
f1 = X;
V = @(a) G(f1).*L(a-f1)*w;

figure
plot(freq,V(Y)','r')
hold on
plot(freq,G(freq),'k')
hold on
plot(freq,L(freq),'b')
legend({'voigt','gaussian','lorentzian'})
end

