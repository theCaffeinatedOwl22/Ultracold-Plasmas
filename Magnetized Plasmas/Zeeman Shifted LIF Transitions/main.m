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
% Specify path location for sub programs
addpath('C:\Users\grant\Documents\GitHub\Ultracold-Plasmas\Magnetized Plasmas\Zeeman Shifted LIF Transitions\subPrograms');
% Define Sr+ imaging transitions
[t] = defineTransitions();
% Define magnetic field
[B] = defineMagneticField();
% Specify which transitions to plot
trans = [3 4]; % [PiMinus, PiPlus, SigPlus, SigMinus] specify indices
% Specify locations for which spectra are plotted
loc.x = [-3 0 3]; % units = mm
loc.y = [0 0 0]; % units = mm
% Specify ion temperature
Ti = 1; % units = K

%% Plot Zeeman shifts as a function of magnetic field
if flag.plotShiftVsField == 1
    plotShiftVsField(t)
end

%% Plot how we expect spectra to look
plotSpectraVsLocation(t,B,loc,Ti,trans)

