function [f,axSpec,ax,anX,anTitle,axLvlDiagram] = plotSpectraVsLocation(t,B,loc,Ti)
%% Program Notes
% This program creates a figure of subplots containing Zeeman-shifted Voigt
% profiles for each location contained within 'loc' and whose width is 
% determined by user-specified ion temperature (Ti).

% Inputs:
%   - t: (1xk structure) contains LIF transition information for k
%         transitions
%       t(k).name: (string) name of transition, used for legend
%       t(k).upper: (1x5 double) |n l s j mj> quantum numbers for
%                    upper level of transition
%       t(k).lower: (1x5 double) |n l s j mj> quantum numbers for lower
%                    level of transition
%       t(k).color: (1x3 double) rgb triplet that defines color of line in
%                    for the plot
%   - B(x): (function handle) magnetic field in units of Tesla with
%            position (units of mm) as only input parameter
%   - loc: (1x1 struct) contains (x,y) locations in mm for where the Voigt
%           profiles should be plotted
%       loc.x: (1xn double) x-positions in mm
%       loc.y: (1xn double) y-positions in mm

% Outputs:
%   - 

%% Calculate spectra for each position and place in data structure
% Define frequency range for plotting Voigt profiles
freqForPlot = linspace(-250e6,250e6,1000);
% Place plot information within data structure
%   - Note that this program creates a 4x2 grid of subplots. The following
%     set of nested for loops iterates over each set of axes within the
%     figure and places information there for each user-specified location.
data = cell(4,2);
ind = 1;
for i = 1:size(data,2) % column loop
    for j = 1:size(data,1) % row loop
        % Only pull date for requested locations, stop looping if not
        % enough locations are specified or if too many locations are
        % specified.
        if ind>length(loc.x) || ind>8
            break
        end
        % Calculate the local magnetic field - note distance conversion
        % from mm to m
        currB = B(loc.x(ind)*1e-3,loc.y(ind)*1e-3);
        % Initialize structure for current location
        s = [];
        s.locx = loc.x(ind);
        s.locy = loc.y(ind);
        % Loop over each requested transition
        for k = 1:size(t,2)
            % Calculate the shift for each transition in the local field
            s.t(k).shift = calcAnomalousZeemanShift(t(k).upper,currB) - calcAnomalousZeemanShift(t(k).lower,currB);
            % Generate Voigt profile based on Zeeman shift
            s.t(k).spec = voigtProfile(freqForPlot,Ti,s.t(k).shift);
            % Place color for each polarization
            s.t(k).color = t(k).color;
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

%% Generate Figure - Plot Voigt Profiles
% Open new figure
f = figure;
% Set overall figure size - length:width ratio is 11/8.5
f.Units = 'inches';
f.Position = [1 1 11*7/8 7];
% Generate spectra subplots in a 4x2 grid
%   - Note that to do this I had to set up a 4x3 grid because I wanted to
%   use the first column for other stuff, so the following 'ind' vector
%   contains 8 subplot indices for which the spectra will be plotted.
ind = [2,3;5,6;8,9;11,12];
ind2 = 1;
for i = 1:2 % loop over column of 4x2 subplot grid
    for j = 1:4 % loop over rows of 4x2 subplot grid
        % Stop adding plot information if less than 8 Voigt locations are
        % specified
        if ind2>length(loc.x)
            break
        end
        % Generate axes for 4x2 subplot grid, set the size of the plot box
        axSpec{j,i} = subplot(4,3,ind(j,i));
        axSpec{j,i}.PlotBoxAspectRatio = [1,0.35,0.35];
        % Plot sum of spectra, then plot the spectra for each requested
        % transition
        plot(data{j,i}.xData.*1e-6,data{j,i}.combSpec,'Linewidth',1)
        hold on
        for k = 1:size(data{j,i}.t,2)
            plot(data{j,i}.xData.*1e-6,data{j,i}.t(k).spec,'--','Linewidth',.75,'Color',data{j,i}.t(k).color)
        end
        % Set various parameters of the subplot axes
        axSpec{j,i}.FontSize = 10;
        title(['Location ' num2str(ind2) ': (' num2str(data{j,i}.locx) ',' num2str(data{j,i}.locy) ')'],'FontSize',9)
        axSpec{j,i}.XTick = round(linspace(min(-freqForPlot.*1e-6),max(freqForPlot.*1e-6),7),0);
        axSpec{j,i}.TickLength = [0.025,0.5];
        ind2 = ind2+1;
    end
end
%% Add plot showing schematic of locations that Voigt profiles were plotted for
% The locations are numbered corresponding to numbers in plot titles
ax = subplot('Position',[0.066017316017316,0.110654761904762,0.304155844155844,0.386369047619048]);
plot(loc.x,loc.y,'x','MarkerSize',.001)
xlim([-6 6])
ylim([-6 6])
xlabel('X Position (mm)')
ylabel('Y Position (mm)')
ax.FontSize = 12;
for i = 1:length(loc.x)
    locLabel{i} = text(loc.x(i),loc.y(i),num2str(i),'EdgeColor',[0.00,0.00,0.00]);
    locLabel{i}.HorizontalAlignment = 'center';
end
% Add x label for spectral subplots
anX = annotation('textbox');
anX.Units = 'inches';
anX.Position = [5.619791666666662,0.062500009778886,1.286458298098297,0.43229165688778];
anX.FontSize = 14;
anX.String = '\Delta_4_2_2 (MHz)';
anX.FitBoxToText = 'on';
anX.EdgeColor = 'none';

%% Add legend for plots of Voigt profiles - only do this once!
lgdStr{1} = 'Sum';
for i = 1:size(t,2)
    lgdStr{i+1} = t(i).name;
end
axes(axSpec{2,1});
lgd = legend(lgdStr);
lgd.Units = 'inches';
lgd.Position = [2.788013682261318,4.498751874281848,0.87499998975545,1.421874959487468];
lgd.FontSize = 12;

%% Add title to the figure
anTitle = annotation('textbox');
anTitle.Units = 'inches';
anTitle.Position = [0.184114583333333,6.026041666666666,3.33671875,0.744791666666667];
anTitle.FontSize = 14;
txt{1} = 'Normalized Spectra from Zeeman-Shifted LIF Spectra:';
txt{2} = ['    Ti = ' num2str(Ti) ' (K)'];
anTitle.String = sprintf([txt{1}]);
anTitle.EdgeColor = 'none';

%% Add LIF transition level diagram to figure 
axLvlDiagram = subplot('Position',[0.026515151515152,0.534970238095237,0.247294372294372,0.336309523809524]);
image(imread('C:\Users\grant\Documents\GitHub\Ultracold-Plasmas\Magnetized Plasmas\Zeeman Shifted LIF Transitions\subPrograms\levelDiagram.PNG'));
axLvlDiagram.XTick = [];
axLvlDiagram.YTick = [];

end

