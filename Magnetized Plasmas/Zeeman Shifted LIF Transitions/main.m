 %% Program Notes
% This program has several different features that calculate important
% quantities related to using LIF imaging on a magnetized UNP. 

% Options
%   - Plot Zeeman shifts of LIF magnetic sublevels as a function of
%   magnetic field
%
%   - Plot Zeeman-shifted Voigt profiles for user-specified locations from
%   plasma center.


% See OneNote entry for 06/05/19 for detailed discussion of imaging
% magnetized plasmas.

%% Initiate Program
% Clear workspace
clc
clear
close all
% Specify path location for sub programs
addpath('C:\Users\Grant Gorman\Documents\GitHub\Ultracold-Plasmas\Magnetized Plasmas\Zeeman Shifted LIF Transitions\subPrograms');

%% User Inputs
%%%   General Options   %%%
flag.plotShiftVsField = 0;
flag.plotSpectraVsLocation = 1;

% Define Sr+ imaging transitions
[t] = defineTransitions();

% Define magnetic field
[B] = defineMagneticField();

%%%   Options for plotting Zeeman-shifted Voigt profiles   %%%
% Specify which transitions to plot
trans = [1 2 3 4]; % [PiMinus, PiPlus, SigPlus, SigMinus] specify indices

% Specify locations/frequencies for which spectra are plotted
loc.x = round(linspace(-5,5,7),2); % units = mm
loc.y = -round(linspace(-5,5,7),2); % units = mm
freqForPlot = linspace(-500e6,500e6,1000);

% Specify ion temperature
Ti = 1; % units = K

%% Plot Zeeman shifts as a function of magnetic field
if flag.plotShiftVsField == 1
    [f,ax] = plotShiftVsField(t);
end

%% Plot how we expect spectra to look
if flag.plotSpectraVsLocation == 1
    [f,axSpec,ax,anX,anTitle,axLvlDiagram] = plotSpectraVsLocation(t(trans),B,loc,Ti,freqForPlot);
end

