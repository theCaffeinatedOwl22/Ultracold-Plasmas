clc, clearvars, close all, f = filesep;
maindir = '/home/grant/git-hub/ultracold-plasmas/Magnetized Plasmas/Theoretical Quadrupole Fields/';
addpath([maindir f 'source'])

%% Get Quadrupole Magnetic Field

zRange = [-70 70];    % range of z-positions (units: mm)
pRange = [-70 70];    % range of p-positions (units: mm)
numZPts = 120;      % number of positions to calculate field for within z-range
numPPts = 120;      % number of positions to calculate field for within p-range
amps = 80;  % current flowing through each loop (units: A)

s = fieldForTwoCoilExpConfig(zRange,pRange,numZPts,numPPts,amps);

%% Test Field Line Calculation Function
dr = .01;
x0 = zRange; % starting position along x-axis in mm
y0 = linspace(-12,12,8); % starting position along y-axis in mm

iter = 0;
for j = 1:length(x0)
    for i = 1:length(y0)
        Bx = s.Bz;
        By = s.Bp;
        xvec = s.zInMM;
        yvec = s.pInMM;

        iter = iter + 1;
        [line(iter)] = calcFieldLine(x0(j),y0(i),Bx,By,xvec,yvec,dr);
    end
end

%% Plot Results

fig = figure;
fig.Position = [510   314   560   420];
hold on
for i = 1:length(line)
    xdata = line(i).x;
    ydata = line(i).y;
    plot(xdata(1:50:end),ydata(1:50:end),'m','LineWidth',2)
end
plot([s.coilZPos(1) s.coilZPos(1)],[s.coilRadii(1) -s.coilRadii(2)],'.k','MarkerSize',15)
plot([s.coilZPos(2) s.coilZPos(2)],[s.coilRadii(1) -s.coilRadii(2)],'.k','MarkerSize',15)
xlabel('x (mm)')
ylabel('y (mm)')
title('Quadrupole Magnetic Field Lines')
saveas(fig,[maindir 'field-lines-schematic.png'],'png')
saveas(fig,[maindir 'field-lines-schematic.svg'],'svg')
