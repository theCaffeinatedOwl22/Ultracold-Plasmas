function [] = plotSpectraVsLocation(t,B,loc,Ti)
%% Obtain Zeeman shifts for each transition at each location


%% Calculate spectra for each position and place in data structure
% Initialize data cell, define which frequencies to plot spectra for
data = cell(4,2);
freqForPlot = linspace(-250e6,250e6,1000);
ind = 1;
% Loop over each subplot entry
for i = 1:size(data,2) % column loop
    for j = 1:size(data,1) % row loop
        % Stop looping number of locations less than subplot entries
        if ind>length(loc.x)
            break
        end
        % Calculate the local magnetic field
        currB = B(loc.x(ind)*1e-3,loc.y(ind)*1e-3);
        % Initialize structure for each subplot entry
        s = [];
        s.locx = loc.x(ind);
        s.locy = loc.y(ind);
        % Loop over each requested transition
        for k = 1:size(t,2)
            % Calculate the shift for each transition in the local field
            s.t(k).shift = calcAnomalousZeemanShift(t(k).upper,currB) - calcAnomalousZeemanShift(t(k).lower,currB);
            % Generate Voigt profile based on Zeeman shift
            s.t(k).spec = voigtProfile(freqForPlot,Ti,s.t(k).shift);
        end
        % Place frequencies to plot within data structure
        s.xData = freqForPlot;
        % Calculate combined spectra (and renormalize them)
        s.combSpec = zeros(size(freqForPlot));
        for k = 1:size(t,2)
            s.combSpec = s.combSpec+s.t(k).spec;
        end
        % Place completed structure within data for this location
        data{j,i} = s;
        ind = ind+1;
    end
end

%% Generate Figure
close all
fig = figure;
% Set overall figure size
fig.Units = 'inches';
fig.Position = [1 1 11*7/8 7];
% Generate Spectra Subplots
ind = [2,3;5,6;8,9;11,12];
ind2 = 1;
for i = 1:2
    for j = 1:4
        if ind2>length(loc.x)
            break
        end
        axSpec{j,i} = subplot(4,3,ind(j,i));
        axSpec{j,i}.PlotBoxAspectRatio = [1,0.35,0.35];
        plot(data{j,i}.xData.*1e-6,data{j,i}.combSpec,'Linewidth',1)
        hold on
        for k = 1:size(data{j,i}.t,2)
            plot(data{j,i}.xData.*1e-6,data{j,i}.t(k).spec,'--','Linewidth',.75)
        end
        axSpec{j,i}.FontSize = 10;
        title(['Location ' num2str(ind2) ': (' num2str(data{j,i}.locx) ',' num2str(data{j,i}.locy) ')'],'FontSize',9)
        axSpec{j,i}.XTick = round(linspace(min(-freqForPlot.*1e-6),max(freqForPlot.*1e-6),7),0);
        axSpec{j,i}.TickLength = [0.025,0.5];
        ind2 = ind2+1;
    end
end
% Add plot showing locations of image being analyzed
ax = subplot('Position',[0.066017316017316,0.110654761904762,0.304155844155844,0.386369047619048]);
plot(loc.x,loc.y,'x','MarkerSize',.001)
xlim([-6 6])
ylim([-6 6])
xlabel('X Position (mm)')
ylabel('Y Position (mm)')
ax.FontSize = 12;
% Label each location with a number
for i = 1:length(loc.x)
    locLabel{i} = text(loc.x(i),loc.y(i),num2str(i),'EdgeColor',[0.00,0.00,0.00]);
    locLabel{i}.HorizontalAlignment = 'center';
end

% Add x and y labels for spectra subplots
anX = annotation('textbox');
anX.Units = 'inches';
anX.Position = [5.619791666666662,0.062500009778886,1.286458298098297,0.43229165688778];
anX.FontSize = 14;
anX.String = '\Delta_4_2_2 (MHz)';
anX.FitBoxToText = 'on';
anX.EdgeColor = 'none';

% Add legend to only one figure
lgdStr{1} = 'Sum';
for i = 1:size(t,2)
    lgdStr{i+1} = t(i).name;
end
axes(axSpec{2,1});
lgd = legend(lgdStr);
lgd.Units = 'inches';
lgd.Position = [2.678638682261318,3.696668532411394,0.87499998975545,0.838541643228383];
lgd.FontSize = 12;

% Figure title text
anTitle = annotation('textbox');
anTitle.Units = 'inches';
anTitle.Position = [0.579947916666666,3.739583333333333,2.951302083333334,2.994791666666667];
anTitle.FontSize = 14;
txt{1} = 'Normalized Spectra from Zeeman-Shifted LIF Spectra:';
txt{2} = ['    Ti = ' num2str(Ti) ' (K)'];
anTitle.String = sprintf([txt{1} '\n\n' txt{2}]);
anTitle.EdgeColor = 'none';

end

