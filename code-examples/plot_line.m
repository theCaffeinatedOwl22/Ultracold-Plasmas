fig = figure;
fig.Position = [490   283   506   420];
fig.Color = [1 1 1];

ax = axes();
lgdstr = {};

xdata = [];
ydata = [];
plot(xdata,ydata,'.-','LineWidth',1.5,'MarkerSize',15)

xlabel('xlabel')
ylabel('ylabel')
title('title')

lgd = legend(lgdstr);
lgd.Position = [0.6394    0.8508    0.1552    0.0500];

ax.PlotBoxAspectRatio = [1 1 1];
ax.FontSize = 11;

an = annotation('textbox');
an.Position = [0.0058    0.8762    0.9919    0.1143];
an.HorizontalAlignment = 'center';
an.VerticalAlignment = 'middle';
an.LineStyle = 'none';
an.FontSize = 12;