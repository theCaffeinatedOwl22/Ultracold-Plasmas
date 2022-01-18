%% Initiate Program
clc, clearvars -except inp, close all, f = filesep;
f = filesep;
filepath = mfilename('fullpath');
maindir = extractBefore(filepath,[f mfilename]);
figdir = [maindir f 'figs-1'];
mkdir(figdir)