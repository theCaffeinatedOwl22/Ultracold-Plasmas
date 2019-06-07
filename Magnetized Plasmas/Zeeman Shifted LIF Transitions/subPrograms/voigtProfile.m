function [voigt] = voigtProfile(freqToPlot,Ti,fc)
%% Program Notes
%%%   Description   %%%
% The purpose of this program is to output a Voigt lineshape for given
% conditions that mimic our LIF imaging scheme for the Sr+ ions. The
% spectral lineshape that we measure is broadened homogenously by natural
% linewidth, laser linewidth, and power broadening (resulting in a
% Lorentzian lineshape) and inhomogenously by the Doppler effect (resulting
%in a Guassian broadening).

% The lineshape we ultimately measure is a convolution of the Lorentzian
% and Gaussian broadening mechanisms, which results in what is called a
% Voigt profile. The width is a combination of the Lorentzian and Gaussian
% widths, and the center of the Voigt profile is shifted by the average ion
% velocity and Zeeman shifts imparted by external magnetic fields.

% See Thomas' PhD thesis for the derivation and more in depth discussion of
% how the Voigt profile arises in our LIF imaging.

%%%   Inputs and Outputs   %%%
% Inputs
%   - freqToPlot: (1xn double) frequencies desired for Voigt profile
%   - Ti: (1x1 double) ion temperature in K
%   - fc: (1x1 double) center frequency for Voigt profile

% Outputs
%   - voigt: (1xn) voigt profile at each frequency specified in freqToPlot

%% Define Lorentzian Lineshape
% Define width of natural, laser, and power broadened Lorentzian
gamN = 1.278e8/2/pi; % natural linewidth in units of Hz
gamL = 5; % laser linewidth in units of Hz
s0 = .1; % saturation parameter
gam = gamN*sqrt(1+s0)+gamL; % effective Lorentzian linewidth in units Hz

% Create function handle for Lorentzian
L = @(f) (gam/2/pi)./(gam^2/4+f.^2);

% Note that in my convolution calculation the Lorentzian function is the
% one rastered across the Gaussian, so the center of this lineshape is
% irrelevant, and is set to zero.

%% Define Gaussian Doppler-broadened profile
% Define Gaussian characteristics
kB = 1.38e-23; % Boltzmann constant in SI units
% Ti = .05; % ion temperature in units K
m = 1.45e-25; % Sr+ mass in kg
lambda = 422e-9; % imaging wavelength in m
k = 2*pi/lambda; % wavevector in units m^-1
sig = k*sqrt(kB*Ti/m)/2/pi; % Doppler width in units of Hz
% fc = 100e6; % center frequency of Gaussian

% Create Gaussian function handle
G = @(f) (1/sqrt(2*pi)/sig).*exp(-(f-fc).^2./(2*sig^2));

% Note that the center frequency of this function is currently an input,
% but in principle it should depend on the average ion velocity and the any
% Zeeman shifts

%% Define frequencies to use for Simpson's Integration
% Simpson's integration is a discrete integration (look up online for more
% details). It's important that the frequency spacing of each discrete
% point of integration is smaller than the length scales of the functions
% you're integrating over - essentially you don't want the lineshape to
% change too much between one discrete point to the next. Here, I choose
% the spacing between frequency points to be some factor smaller than
% whichever lineshape has the smallest width
if sig <= gam
    dFreq = sig/1000;
elseif gam < sig
    dFreq = gam/1000;
end

% Here I define the frequencies that I'll integrate over during the
% convolution. I choose a window of frequencies of width 14sigma centered
% around the Gaussian lineshape.
fac = 7*sig;
numPoints = ceil(2*fac/dFreq/2)*2+1;
freqForInt = linspace(-fac+fc,fac+fc,numPoints);

%% Define weights for Simpson's Integration
% This will make sense if you look up the details of Simpson's integration
w = ones(size(freqForInt));
w(2:2:end) = 2;
w(3:2:end) = 4;
w(end) = 1;
w = w.*dFreq./3;
w = w';

%% Set up frequency mesh grid
% Because this is a discrete integration it can be done by matrix
% multiplication. Here I set up the frequencies for integration in matrix
% form

% freqToPlot = linspace(-500e6,500e6,1000);
freqForIntGrid = meshgrid(freqForInt,freqToPlot);

%% Do convolution
% Set up the convolution function handle for the Voigt profile
V = @(f) G(freqForIntGrid).*L(f-freqForIntGrid)*w;
% Calculate the Voigt Profile
voigt = V(freqToPlot');
% Normalize peak of Voigt profile to one
voigt = voigt'/max(voigt);

end

