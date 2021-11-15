fig = figure;
fig.Position = [437   212   655   525];
fig.Color = [1 1 1];

colvar = {''};
rowvar = {''};
col = length(rowvar);
row = length(colvar);
num = row*col;

ax = cell(row,col);
iter = 0;
for i = 1:row
    for j = 1:col
        if iter > num - 1, break, end
        iter = iter + 1;
        ax{i,j} = subplot(row,col,iter);
        lgdstr = cell(1,1);
        l = getLineSpecs(length(lgdstr));

        xdata = [];
        ydata = [];
        lp = l(1);
        plot(xdata,ydata,lp.style,'LineWidth',2,'MarkerSize',4,'Color',lp.col,'MarkerFaceColor',lp.col,'MarkerEdgeColor',lp.col)

        ax{i,j}.PlotBoxAspectRatio = [1 1 1];
        ax{i,j}.FontSize = 12;

        if i == row, xlabel('xlabel'), end
        if j == 1, ylabel('ylabel'), end
        title('title')

    end
end

lgd = legend(lgdstr);
lgd.Position = [0.6394    0.8508    0.1552    0.0500];

savename = [figdir f 'name.png'];
saveas(fig,savename)
close(fig)