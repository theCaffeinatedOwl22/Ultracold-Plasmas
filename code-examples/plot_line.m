fig = figure;
fig.Position = [490   283   506   420];
fig.Color = [1 1 1];

ax = axes();
lgdstr = {};

xdata = [];
ydata = [];
ydatafilt = imgaussfilt(ydata,1);
plot(xdata,ydata,'.-','LineWidth',1.5,'MarkerSize',15)

ax.PlotBoxAspectRatio = [1 1 1];
ax.FontSize = 11;

xlabel('xlabel')
ylabel('ylabel')
title('title')

lgd = legend(lgdstr);
lgd.Position = [0.6394    0.8508    0.1552    0.0500];
