fig = figure;
fig.Position = [490   283   540   420];
fig.Color = [1 1 1];

ax = axes();
lgdstr = {};

xdata = [];
ydata = [];
zdata = [];
zdatafilt = imgaussfilt(zdata,10);
imagesc(xdata,ydata,zdata)

cb = colorbar;
cb.FontSize = 11;
cb.Label.String = 'Label';
ax.YDir = 'Normal';
ax.CLim = [min(zdatafilt,[],'all') max(zdatafilt,[],'all')];

xlabel('xlabel')
ylabel('ylabel')
title('title')

ax.PlotBoxAspectRatio = [1 1 1];
ax.FontSize = 11;

an = annotation('textbox');
an.Position = [0.0058    0.8762    0.9919    0.1143];
an.HorizontalAlignment = 'center';
an.VerticalAlignment = 'middle';
an.LineStyle = 'none';
an.FontSize = 12;
