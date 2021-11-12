fig = figure;
fig.Position = [490   283   540   420];
fig.Color = [1 1 1];

ax = axes();

surf = pcolor(xdata,ydata,zdata);
surf.EdgeColor = 'interp';
colorbar

ax.PlotBoxAspectRatio = [1 1 1];
ax.FontSize = 12;

xlabel('xlabel')
ylabel('ylabel')
title('title')
