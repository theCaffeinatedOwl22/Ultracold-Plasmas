fig = figure;
fig.Position = [437   212   655   525];
fig.Color = [1 1 1];

colvar = {''};
rowvar = {''};
row = 2;
col = 2;
num = 4;

iter = 0;
for i = 1:row
    for j = 1:col
        if iter > num - 1, break, end
        iter = iter + 1;
        ax = subplot(row,col,iter);
        lgdstr = {};

        xdata = [];
        ydata = [];
        plot(xdata,ydata,'.-','LineWidth',1.5,'MarkerSize',15)

        if i == row, xlabel('xlabel'), end
        if j == 1, ylabel('ylabel'), end
        title('title')

        ax.PlotBoxAspectRatio = [1 1 1];
        ax.FontSize = 11;
        ax.Position(1) = ax.Position(1) - 0;
        ax.Position(2) = ax.Position(2) - 0;

    end
end

an = annotation('textbox');
an.Position = [0.0058    0.8762    0.9919    0.1143];
an.HorizontalAlignment = 'center';
an.VerticalAlignment = 'middle';
an.LineStyle = 'none';
an.FontSize = 12;
an.String = '';
