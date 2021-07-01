fig = figure;
fig.Position = [490   283   540   420];
fig.Color = [1 1 1];

ax = axes();

xdata = [];
ydata = [];
zdata = [];
imagesc(xdata,ydata,zdata)

cb = colorbar;
cb.FontSize = 11;
cb.Label.String = 'Label';
ax.YDir = 'Normal';

ax.PlotBoxAspectRatio = [1 1 1];
ax.FontSize = 11;

xlabel('xlabel')
ylabel('ylabel')
title('title')
