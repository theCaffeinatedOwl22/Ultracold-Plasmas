function [] = plotShiftVsField(t)
%%
% Define transition Zeeman shifts as a function of magnetic field
for i = 1:size(t,2)
    dEz{i} = @(bField) calcAnomalousZeemanShift(t(i).upper,bField)-calcAnomalousZeemanShift(t(i).lower,bField);
end
% Define range of magnetic field for which shift will be plotted
bField = [0:.02/100:.01];
% Plot the shift vs field
f = figure;
% Set figure position
f.Units = 'inches';
f.Position = [2 2 6 5];
for i = 1:length(dEz)
    plot(bField*1e4,dEz{i}(bField)*1e-6,'LineWidth',2);
    hold on
end
ax = gca;
ax.FontSize = 14;
% Add legend to plot
clear legendStr
for i = 1:size(t,2)
    legendStr{i} = t(i).name;
end
lgd = legend(legendStr);
lgd.Location = 'northwest';
% Add other labels
xlabel('B (G)')
ylabel('\DeltaE_z (MHz)')
title('Zeeman Shifts of Sr^+ LIF Transition')
end

