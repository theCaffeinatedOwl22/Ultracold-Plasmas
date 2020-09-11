clc, clearvars, close all

%% Get Quadrupole Magnetic Field

zRange = [-5 5];    % range of z-positions (units: mm)
pRange = [-5 5];    % range of p-positions (units: mm)
numZPts = 125;      % number of positions to calculate field for within z-range
numPPts = 125;      % number of positions to calculate field for within p-range
amps = 80;  % current flowing through each loop (units: A)

for i = 1:length(numZPts)
    [s(i)] = fieldForQuadrupoleConfig(zRange,pRange,numZPts(i),numPPts(i),amps);
end

%% Test Field Line Calculation Function
dr = .005;
x0 = [-5 5]; % starting position along x-axis in mm
y0 = linspace(-4.5,4.5,20); % starting position along y-axis in mm

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
    plot(line(i).x,line(i).y,'m','LineWidth',1.5)
end
xlabel('x (mm)')
ylabel('y (mm)')
xlim(zRange)
ylim(pRange)
title('Quadrupole Magnetic Field Lines')
saveas(fig,'field-lines.png','png')