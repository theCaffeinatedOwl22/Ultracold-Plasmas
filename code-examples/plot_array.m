fig = figure;
fig.Position = [490   283   540   420];
fig.Color = [1 1 1];

ax = axes();

xdata = [];
ydata = [];
zdata = [];
zdatafilt = imgaussfilt(zdata,0.5);
imagesc(xdata,ydata,zdata)

cb = colorbar;
cb.FontSize = 11;
cb.Label.String = 'Label';
ax.YDir = 'Normal';
ax.CLim = [min(zdatafilt,[],'all') max(zdatafilt,[],'all')];

ax.PlotBoxAspectRatio = [1 1 1];
ax.FontSize = 11;

xlabel('xlabel')
ylabel('ylabel')
title('title')
