% clear workspace
clc, clearvars, close all

% set up directory structure
f = filesep;
filepath = mfilename('fullpath');
maindir = extractBefore(filepath,[f mfilename]);
figdir = [maindir f 'figs-1'];
mkdir(figdir)

% load data
datadir = '';