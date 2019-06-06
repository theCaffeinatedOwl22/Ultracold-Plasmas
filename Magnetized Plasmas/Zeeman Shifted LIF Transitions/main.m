%% Program Notes
% This program calculates the Zeeman shifts of the imaging transition for
% the Sr ion. A write-up has been documented in the OneNote on 06/05/19

%% Initiate Program
clc
clear
close all

%% User Inputs
% Specify path location for sub programs
addpath('C:\Users\grant\Documents\GitHub\Ultracold-Plasmas\Magnetized Plasmas\Zeeman Shifted LIF Transitions\subPrograms');
% Define Sr+ imaging transitions
[t] = defineTransitions();
% Define magnetic field
[B] = defineMagneticField();

%% Plot Zeeman shifts as a function of magnetic field
plotShiftVsField(t)

%% Plot how we expect spectra to look