fig = figure;
fig.Position = [437   212   655   525];
fig.Color = [1 1 1];

row = 2;
col = 2;
num = 4;

iter = 0;
for i = 1:row
    for j = 1:col
        iter = iter + 1;
        if iter > num, break, end
        ax = subplot(row,col,iter);
        
        lgdstr = {};

        xdata = [];
        ydata = [];
        plot(xdata,ydata,'.-','LineWidth',1.5,'MarkerSize',15)

        if i == row, xlabel('xlabel'), end
        if j == col, ylabel('ylabel'), end
        title('title')

        lgd = legend(lgdstr);
        lgd.Position = [0.6394    0.8508    0.1552    0.0500];

        ax.PlotBoxAspectRatio = [1 1 1];
        ax.FontSize = 11;
        
    end
end

an = annotation('textbox');
an.Position = [0.0058    0.8762    0.9919    0.1143];
an.HorizontalAlignment = 'center';
an.VerticalAlignment = 'middle';
an.LineStyle = 'none';
an.FontSize = 12;
an.String = '';