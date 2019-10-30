clc
clear
close all

%% Get field calculations

zRange = [-4 4];    % in mm
pRange = [-4 4];    % in mm
numZPts = 1000;
numPPts = 1000;

s = fieldForQuadrupoleConfig(zRange,pRange,numZPts,numPPts);

%% Plot coil dimensions

left.zPos = repmat(s.coilZPos(1:round(end/2)),2,1);
left.coilRadii = [s.coilRadii(1:round(end/2)); -s.coilRadii(1:round(end/2))];

right.zPos = repmat(s.coilZPos(round(end/2)+1:end),2,1);
right.coilRadii = [s.coilRadii(round(end/2)+1:end); -s.coilRadii(round(end/2)+1:end)];

close all
fig = figure;
plot(left.zPos,left.coilRadii,'.','MarkerSize',15)
hold on
plot(right.zPos,right.coilRadii,'.','MarkerSize',15)

plot([-5 5],[5 5],'k')
plot([5 5],[-5 5],'k')
plot([-5 -5],[-5 5],'k')
plot([-5 5],[-5 -5],'k')

ax = gca;
ax.FontSize = 12;
xlabel('Z Position (mm)')
ylabel('Coil Radii (mm)')
title('Schematic of Coil Loops')
ax.Title.FontSize = 11;
ylim([-50 50])

%% Plot calculated magnetic fields

close all
clear fig ax

fig = figure;
imagesc(s.zInMM,s.pInMM,s.Bmag)
c = colorbar;
ax = gca;
ax.YDir = 'normal';
xlabel('Z Position (mm)')
ylabel('\rho Position (mm)')
c.Title.String = 'B (G)';
title('|B| for Experimentally-Relevant Regions')

% open empirical model results - came from model that was constrianed but not completely fixed
newFig = openfig('C:\Projects\magneticBottling\10.21.19 Update emprical quadrupole magnetic field model\measuredMagneticField.fig');

xForPlot = newFig.Children(8).Children.XData;   % get data from the opened figure
yForPlot = newFig.Children(8).Children.YData;
BForPlot = newFig.Children(8).Children.CData;

residual = zeros(size(BForPlot));

for ii = 1:size(residual,1) % rows
    for jj = 1:size(residual,2) % columns
        [~,zMinInd] = min(abs(xForPlot(jj) - s.zInMM));
        [~,pMinInd] = min(abs(yForPlot(ii) - s.pInMM));
        
        residual(ii,jj) = (BForPlot(ii,jj)-s.Bmag(pMinInd,zMinInd))./BForPlot(ii,jj)*100;
    end
end

figure
imagesc(residual)
c = colorbar;
c.Title.String = '\DeltaB (%)';
ax = gca;
ax.FontSize = 12;
ax.YDir = 'normal';
xlabel('z (mm)')
ylabel('\rho (mm)')
title('(B_e_m_p-B_t_h)/B_e_m_p')