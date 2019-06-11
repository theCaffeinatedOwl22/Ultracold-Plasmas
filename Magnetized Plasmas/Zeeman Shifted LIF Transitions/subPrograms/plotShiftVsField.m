function [f,ax] = plotShiftVsField(t)
%% Program Notes
% This program plots the Zeeman shifts of the Pi and Sigma transitions for
% our LIF imaging on the D1 line of the Strontium ion (2S_1/2 - 2P_1/2) as
% a function of magnetic field. 
%
% Inputs
%   - t: (1xk structure) contains LIF transition information for k
%         transitions
%       t(k).name: (string) name of transition, used for legend
%       t(k).upper: (1x5 double) |n l s j mj> quantum numbers for
%                    upper level of transition
%       t(k).lower: (1x5 double) |n l s j mj> quantum numbers for lower
%                    level of transition
%       t(k).color: (1x3 double) rgb triplet that defines color of line in
%                    for the plot
%
% Outputs:
%   - f: (figure object) figure object for plot of Zeeman shifts vs
%         magnetic field
%   - ax: (axes object) axes object for plot of Zeeman shifts vs magnetic
%          field

%%
% Define transition Zeeman shifts as a function of magnetic field
dEz = cell(size(t));
for i = 1:size(t,2)
    dEz{i} = @(bField) calcAnomalousZeemanShift(t(i).upper,bField)-calcAnomalousZeemanShift(t(i).lower,bField);
end
% Define range of magnetic field for which shift will be plotted
bField = 0:.02/100:.01;
% Plot the shift vs field

%% Plot Zeeman shifts vs magnetic field
% Open new figure
f = figure;
% Set figure window size
f.Units = 'inches';
f.Position = [2 2 6 5];
% Plot Zeeman shift for each transition within the same figure
for i = 1:length(dEz)
    plot(bField*1e4,dEz{i}(bField)*1e-6,'LineWidth',2,'Color',t(i).color);
    hold on
end
% Set default font size for figure
ax = gca;
ax.FontSize = 14;
% Add legend to plot
legendStr = cell(size(t));
for i = 1:size(t,2)
    legendStr{i} = t(i).name;
end
lgd = legend(legendStr);
lgd.Location = 'northwest';
% Add other labels
xlabel('B (G)');
ylabel('\DeltaE_z (MHz)');
title('Zeeman Shifts of Sr^+ LIF Transition');
end

