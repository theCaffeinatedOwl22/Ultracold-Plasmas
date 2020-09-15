function [Bp,Bz] = fieldFromSingleCurrentLoop(z,p,z0,pol)
%% Parameters
% Note: a = current loop radius, I = current through loop

% z (1xn double): position along the symmetry axis (with units a) to return magnetic field for
% p (1xm dobule): distance in plane normal to symmetry axis (with units a) to return magnetic field for
% z0 (1x1 double): location of current loop along symmetry axis (with units a)
% pol (1x1 double): (1 or -1) used to flip direction of current
% Bp (mxn double): magnetic field along p-axis at position z(n) and p(m) with units u0*I/a
% Bz (mxn double): magnetic field along z-axis at position z(n) and p(m) with units u0*I/a

%% Function Notes

% This function calculates the magnetic field that results from the induction
% caused by a current I flowing through a circular loop radius of radius a located at z = z0.
% Please see the OneNote entry on 10/30/19 for more information. 

% This code uses a cylindrical coordinate system. 'z' represents position along the symmetry axis and
% 'p' represents the radial position in the plane perpendicular to the symmetry 
% axis. Note that the fields do not depend on the polar angle, so these two variables are sufficient to describe the
% entire system.

% This code uses dimensionless units. The natural unit for magnetic field for
% this system is u0*I/a, where u0 is the magnetic permeability constant, I is the
% current through the loop, and a is the radius of the loop. The natural unit for
% length is a.

% In conventional cylindrical coordinates, p > 0. However, we often like to plot the field in a
% plane defined by p = [pmin pmax] and z = [zmin zmax], where pmax, zmax > 0 and pmin, zmin < 0. I
% have modified the equations for the magnetic field to account for situations where p < 0. The only
% change required for accounting for negative p is taking the absolute value of p in the elliptic
% integral equations. All other equations are fine as is. 

%% Define variables for calculation
zRel = z-z0;    % z-position relative to z0 (center of current loop)

A = sqrt(1+p.^2+zRel.^2-2.*abs(p)); % calculate dimensionless parameters relevant for field calculation
B = sqrt(1+p.^2+zRel.^2+2.*abs(p));
k = abs(1-A.^2./B.^2);

%% Evaluate elliptic integrals

[K,E] = ellipke(k); % calculate complete elliptic integrals of the first (K) and second (E) kind.

%% Calculate field com

Bp = zRel./(2.*pi.*A.^2.*B.*p).*((1+p.^2+zRel.^2).*E-A.^2.*K); % radial component of field
Bz = 1./(2.*pi.*A.^2.*B).*((1-p.^2-zRel.^2).*E+A.^2.*K);    % z-component of field

if nargin == 4  % if polarity of current flow is specified
    if pol == -1 % flip the field directions dependent on polarity
        Bz = -Bz;
        Bp = -Bp;
    end
end

end