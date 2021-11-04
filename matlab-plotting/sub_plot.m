fig = figure;
fig.Position = [437   212   655   525];
fig.Color = [1 1 1];

colvar = {''};
rowvar = {''};
row = 2;
col = 2;
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

% add legend
lgd = legend(lgdstr);
lgd.Position = [0.6394    0.8508    0.1552    0.0500];

savename = [figdir f 'name.png'];
saveas(fig,savename)
close(fig)

% shift subplot positions
for i = 1:row
    for j = 1:col
        ax{i,j}.Position(1) = ax{i,j}.Position(1) - 0;
        ax{i,j}.Position(2) = ax{i,j}.Position(2) - 0;
    end
end

% ensure color bar limits are the same
climup = zeros(size(ax));
for i = 1:row
    for j = 1:col
        climup(i,j) = ax{i,j}.CLim(2);
    end
end
climup = max(climup,[],'all');
for i = 1:row
    for j = 1:col
        ax{i,j}.CLim(2) = climup;
    end
end
