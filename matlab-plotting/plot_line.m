fig = figure;
fig.Position = [490   283   506   420];
fig.Color = [1 1 1];

ax = axes();
hold on
lgdstr = cell(1,1);
l = getLineSpecs(length(lgdstr));

xdata = [];
ydata = [];
lp = l(1);
plot(xdata,ydata,lp.style,'LineWidth',2,'MarkerSize',4,'Color',lp.col,'MarkerFaceColor',lp.col,'MarkerEdgeColor',lp.col)

ax.PlotBoxAspectRatio = [1 1 1];
ax.FontSize = 11;

xlabel('xlabel')
ylabel('ylabel')
title('title')

lgd = legend(lgdstr);
lgd.Position = [0.6394    0.8508    0.1552    0.0500];