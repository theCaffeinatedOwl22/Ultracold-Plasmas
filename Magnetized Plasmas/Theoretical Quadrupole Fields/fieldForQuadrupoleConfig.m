function [] = fieldForQuadrupoleConfig()
%% Program Notes

    % This program calculates the magnetic field produced by a series of current
    % loops in the anti-Helmholtz configuration, which describes the quadrupole
    % magnetic fields we use in the experiment.
    
    % I wrote a function to calculate the magnetic field from a current loop of given
    % radius, polarity, and position along symmetry axis. This program calls that
    % function for the relevant positions and polarities of the loops that make up
    % our anti-Helmholtz configuration. 
    
%% Define current loop configuration

% This defines the possible z-positions. The distance bewteen the inner-most current
% loops is 7 cm. The diameter of each current loop is 4 mm, and there are 9 current
% loops wrapped adjacent to each other. There are 7 layers of coil wraps. The current
% loops are wrapped around a cylindrial part of the chamber with diameter 2.8 cm.
% Thus, the radius of the inner-most current loop is 1.4 cm.

numWraps = 9;
zPos = zeros(1,numWraps);
for ii = 1:numWraps
    zPos(ii) = 35+4*(ii-.5);    % in mm
end
zPos = [-zPos zPos];

numLayers = 7;
radii = zeros(1,numLayers);
for ii = 1:length(radii)
    radii(ii) = 14+4*(ii-.5);
end

[zPos,radii] = meshgrid(zPos,radii);
zPos = zPos(:);
radii = radii(:);

pol = ones(size(zPos));
pol(logical(zPos>0)) = pol(logical(zPos>0)).*-1;

xForPlot = linspace(-5,5,1000);
yForPlot = linspace(-5,5,1000);

[xForPlot,yForPlot] = meshgrid(xForPlot,yForPlot);



%% Sum over each current loop

BzSum = zeros(length(yForPlot),length(xForPlot));
BpSum = zeros(length(yForPlot),length(xForPlot));



for ii = 1:length(radii)
    xDimUnits = xForPlot./radii(ii);
    yDimUnits = yForPlot./radii(ii);
    zPosDimUnits = zPos(ii)/radii(ii);
    
    [Bp, Bz] = fieldFromSingleCurrentLoop(xDimUnits,yDimUnits,zPosDimUnits,pol(ii));
    BpSum = BpSum+Bp;
    BzSum = BzSum+Bz;
    
end

Btot = sqrt(BpSum.^2+BzSum.^2);

figure
imagesc(Btot)
colorbar
ax = gca;
ax.CLim = [0 100];

end