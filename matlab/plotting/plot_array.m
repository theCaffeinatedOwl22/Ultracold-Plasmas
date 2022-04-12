fig = figure;
fig.Units = 'normalized';
fig.Position = [0.2902    0.3049    0.3762    0.3139];
fig.Color = [1 1 1];
fontsize = 11;

ax = axes();

xdata = [];
ydata = [];
zdata = [];
imagesc(xdata,ydata,zdata);

cb = colorbar;
cb.FontSize = fontsize;
cb.Label.FontSize = fontsize;
cb.Label.Units = 'normalized';
cb.Label.String = 'label';
cb.Label.VerticalAlignment = 'middle';
cb.Label.Rotation = -90;
cb.Label.Position = [3.4102    0.5000         0];

ax.PlotBoxAspectRatio = [1 1 1];
ax.FontSize = fontsize;
ax.YDir = 'normal';

xlabel('xlabel')
ylabel('ylabel')
title('title',FontWeight='normal',FontSize=fontsize)

savename = [figdir f 'name'];
saveas(fig,[savename '.png'])
exportgraphics(fig,[savename '.eps'],'ContentType','Vector')
close(fig)
