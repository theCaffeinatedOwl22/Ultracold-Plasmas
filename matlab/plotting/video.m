% open video
v = VideoWriter(file_path,'MPEG-4');
duration = 10;
v.FrameRate = length([data.grids.vars.time])/duration;
open(vid)

% open figure
fig = figure;
fig.Position = [463.6667  307.0000  970.0000  672.0000];
fig.Color = [1 1 1];

% create axes
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
    end
end

% create annotation
an = annotation('textbox');
an.Position = [-0.0073    0.9417    0.9919    0.0686];
an.HorizontalAlignment = 'center';
an.VerticalAlignment = 'middle';
an.LineStyle = 'none';

% update axes and write frame to video
for k = 1:length()
    hold([ax{:}],'off')
    iter = 0;
    for i = 1:row
        for j = 1:col
            if iter > num - 1, break, end
            iter = iter + 1;
            set(fig,'CurrentAxes',ax{i,j})

            xdata = [];
            ydata = [];
            zdata = [];
            imagesc(xdata,ydata,zdata)
            colorbar

            ax{i,j}.YDir = 'Normal';
            ax{i,j}.PlotBoxAspectRatio = [1 1 1];
            ax{i,j}.FontSize = 12;

            if i == row, xlabel('label'), end
            if j == 1, ylabel('label'), end
            title(gridstr{iter},'FontWeight','normal')

        end
    end

    an.String = [''];
    frame = getframe(fig);
    writeVideo(vid,frame);
end
close(vid)