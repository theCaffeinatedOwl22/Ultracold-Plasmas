function [B] = defineMagneticField()
%% Program Notes
% This sub program defines an anonymous function, B, which contains a
% spatially-dependent magnetic field.

% The magnetic field defined below is that of the quadrupole magnetic
% fields from our MOT coils defined in the (x,y) plane, where x indicates
% the direction of the imaging beam propagation, and y indicates the
% polarization direction of the imaging beam.

%% Define magnetic field
b = 1.15; % magnetic field gradient with units T/m
h = 2; % ratio between initial plasma size on the x and y axes
B = @(x,y) b.*sqrt(x.^2+(y/h).^2);

end

