fig = figure;
fig.Units = 'normalized';
fig.Position = [0.2902    0.3049    0.3762    0.3139];
fig.Color = [1 1 1];
fontsize = 11;

colvar = {''};
rowvar = {''};
col = length(colvar);
row = length(rowvar);
num = row*col;

ax = cell(row,col);
iter = 0;
for i = 1:row
    for j = 1:col
        if iter > num - 1, break, end
        iter = iter + 1;
        ax{i,j} = subplot(row,col,iter);
        hold on
        lgdstr = cell(1,1);
        l = getLineSpecs(length(lgdstr));

        xdata = [];
        ydata = [];
        lp = l(1);
        plot(xdata,ydata,lp.style,'LineWidth',2,'MarkerSize',4,'Color',lp.col,'MarkerFaceColor',lp.col,'MarkerEdgeColor',lp.col)

        ax{i,j}.PlotBoxAspectRatio = [1 1 1];
        ax{i,j}.FontSize = fontsize;

        if i == row, xlabel('xlabel'), end
        if j == 1, ylabel('ylabel'), end
        title('title',FontWeight='normal',FontSize=fontsize)

    end
end

lgd = legend(lgdstr);
lgd.Position = [0.6394    0.8508    0.1552    0.0500];

figname = 'figname';
export_fig([figdir f figname],'-png')
export_fig([figdir f figname],'-eps')