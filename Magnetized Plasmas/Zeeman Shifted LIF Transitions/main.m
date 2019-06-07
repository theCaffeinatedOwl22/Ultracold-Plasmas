%% Program Notes
% This program calculates the Zeeman shifts of the imaging transition for
% the Sr ion. A write-up has been documented in the OneNote on 06/05/19

%% Initiate Program
clc
clear
close all

%% User Inputs
%%%   Program Options %%%
flag.plotShiftVsField = 0;
flag.plotSpectraVsLocation = 1;
% Specify path location for sub programs
addpath('C:\Users\grant\Documents\GitHub\Ultracold-Plasmas\Magnetized Plasmas\Zeeman Shifted LIF Transitions\subPrograms');
% Define Sr+ imaging transitions
[t] = defineTransitions();
% Define magnetic field
[B] = defineMagneticField();
% Specify which transitions to plot
trans = [3 4]; % [PiMinus, PiPlus, SigPlus, SigMinus] specify indices
% Specify locations for which spectra are plotted
loc.x = round(linspace(-5,5,7),2); % units = mm
loc.y = zeros(size(loc.x)); % units = mm
% Specify ion temperature
Ti = 1; % units = K

%% Plot Zeeman shifts as a function of magnetic field
if flag.plotShiftVsField == 1
    plotShiftVsField(t)
end

%% Plot how we expect spectra to look
if flag.plotSpectraVsLocation == 1
    plotSpectraVsLocation(t(trans),B,loc,Ti)
end

