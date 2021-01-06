maindir = '/home/grant/git-hub/ultracold-plasmas/Magnetized Plasmas/Theoretical Quadrupole Fields'; 
f = filesep;
addpath([maindir f 'source'])

zR = [-13 13];
pR = [-13 13];
numZPts = 100;
numPPts = 100;
amps = 80;

[B] = fieldForExpConfig(zR,pR,numZPts,numPPts,amps);

dr = .005;
x0 = zR; % starting position along x-axis in mm
y0 = linspace(-5,5,14); % starting position along y-axis in mm

iter = 0;
for j = 1:length(x0)
    for i = 1:length(y0)
        Bx = B.Bz;
        By = B.Bp;
        xvec = B.zInMM;
        yvec = B.pInMM;

        iter = iter + 1;
        [line(iter)] = calcFieldLine(x0(j),y0(i),Bx,By,xvec,yvec,dr);
    end
end

fig = figure;
fig.Position = [403   158   873   694];

ax = subplot(2,2,1);
hold on
for i = 1:length(line)
    plot(line(i).x,line(i).y,'m','LineWidth',1.5)
end
xlabel('x (mm)')
ylabel('y (mm)')
title('Field Lines')
xlim(zR)
ylim(pR)

ax = subplot(2,2,2);
ax.PlotBoxAspectRatio = [1 1 1];
imagesc([B.zInMM],[B.pInMM],B.Bmag)
xlabel('x (mm)')
ylabel('y (mm)')
cb = colorbar;
cb.Label.String = '|B| (G)';
title('Field Amplitude')

ax = subplot(2,2,3);
imagesc([B.zInMM],[B.pInMM],B.Bp)
ax.PlotBoxAspectRatio = [1 1 1];
ax.YDir = 'normal';
xlabel('x (mm)')
ylabel('y (mm)')
cb = colorbar;
cb.Label.String = 'B_p (G)';
title('y-component of B')

ax = subplot(2,2,4);
imagesc([B.zInMM],[B.pInMM],B.Bz)
ax.PlotBoxAspectRatio = [1 1 1];
ax.YDir = 'normal';
xlabel('x (mm)')
ylabel('y (mm)')
cb = colorbar;
cb.Label.String = 'B_z (G)';
title('x-component of B')

saveas(fig,[maindir f 'fields-at-plasma.png'],'png')
