addpath('/home/grant/git-hub/ultracold-plasmas/Magnetized Plasmas/Theoretical Quadrupole Fields/source')

zR = [-5 5];
pR = [-5 5];
numZPts = 100;
numPPts = 100;
amps = 80;

[B] = fieldForTwoCoilExpConfig(zR,pR,numZPts,numPPts,amps);

fig = figure;
fig.Position = [403   158   873   694];

ax = subplot(2,2,1);
hold on
plot([B.coilZPos ; B.coilZPos],[B.coilRadii; -B.coilRadii],'.')
plot([zR(1) zR(1)],[pR(1) pR(2)],'k')
plot([zR(2) zR(2)],[pR(1) pR(2)],'k')
plot([zR(1) zR(2)],[pR(1) pR(1)],'k')
plot([zR(1) zR(2)],[pR(2) pR(2)],'k')
xlabel('z (mm)')
ylabel('p (mm)')
title('Coil Locations on z-axis')

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
title('x-component of B')

ax = subplot(2,2,4);
imagesc([B.zInMM],[B.pInMM],B.Bz)
ax.PlotBoxAspectRatio = [1 1 1];
ax.YDir = 'normal';
xlabel('x (mm)')
ylabel('y (mm)')
cb = colorbar;
cb.Label.String = 'B_z (G)';
title('y-component of B')