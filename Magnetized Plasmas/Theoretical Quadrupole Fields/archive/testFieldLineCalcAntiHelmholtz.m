clc, clearvars, close all

%% Get Quadrupole Magnetic Field

zRange = [-15 15];    % range of z-positions (units: mm)
pRange = [-6 6];    % range of p-positions (units: mm)
numZPts = 250;      % number of positions to calculate field for within z-range
numPPts = 250;      % number of positions to calculate field for within p-range
amps = 80;  % current flowing through each loop (units: A)

s = fieldForTwoCoilAntiHelmholtz(zRange,pRange,numZPts,numPPts,amps);

%% Test Field Line Calculation Function
dr = .01;
x0 = [-15 15]; % starting position along x-axis in mm
y0 = [0.5 1.5 2.5 3.5];
y0 = [y0 -y0];

iter = 0;
tic
for l = 1:length(s)
    for k = 1:length(dr)
        for j = 1:length(x0)
            for i = 1:length(y0)
                Bx = s(l).Bz;
                By = s(l).Bp;
                xvec = s(l).zInMM;
                yvec = s(l).pInMM;

                iter = iter + 1;
                [line(iter)] = calcFieldLine(x0(j),y0(i),Bx,By,xvec,yvec,dr(k));
            end
        end
    end
end
toc

%% Plot Results

fig = figure;
fig.Position = [510   314   560   420];
hold on
for i = 1:length(line)
    plot(line(i).x,line(i).y,'.m','LineWidth',1.5)
end
xlabel('x (mm)')
ylabel('y (mm)')
xlim(zRange)
ylim(pRange)
title('Quadrupole Magnetic Field Lines')
saveas(fig,'field-lines.png','png')