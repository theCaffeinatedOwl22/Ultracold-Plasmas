function [Bp,Bz] = fieldFromSingleCurrentLoop(z,p,z0,pol)
%% Function Notes

    % This function calculates the magnetic field that results from the induction
    % caused by a current I flowing through a circular current with loop radius a.
    % Please see the OneNote entry on 10/30/19 for more information. 
    
    % This code uses cylindrical coordinates. 'z' represents the symmetry axis and
    % 'p' represents the radial component in the plane perpendicular to the symmetry 
    % axis. Note that the fields do not depend on the polar angle, so these two variables are sufficient to describe the
    % entire system.
    
    % This code uses dimensionless units. The natural unit for magnetic field for
    % this system is u0*I/a, where u0 is the magnetic permeability constant, I is the
    % current through the loop, and a is the radius of the loop. The natural unit for
    % legnth is a.
    
    % Inputs:
        % z: position along symmetry axis in units of loop radius a. Must be a double
        % that is the same size as p. Note that the fields are calculated for position z with a coil centered on the
        % symmetry axis at z0. z represents absolute position, and is not relative to z0. Below, I calculate the
        % relative position that is to be used in the equations.
        
        % p: radial distance from symmetry axis in units of loop radius a
        
        % z0: location of current loop on symmetry axis. Note that the fields
        % outputted by this function are in abosolute z-position (e.g. z is not
        % relative to z0).
        
        % pol: This is an optional parameter effectively sets the current direction 
        % in the loop. By default, this program assumes that Bz(z>z0) is positive. 
        % Setting pol = -1 will flip this convention (e.g. flip current direction).
    
    % Outputs:
        % Bz: symmetry-axis-component of magnetic field with units u*I/a
        % Bp: radial-component of magnetic field with units u0*I/a
    

%% Define variables for calculation
zRel = z-z0;    % z-position relative to z0 (center of current loop)

A = sqrt(1+p.^2+zRel.^2-2.*p);  % calculate dimensionless parameters relevant for field calculation
B = sqrt(1+p.^2+zRel.^2+2.*p);
k = abs(1-A.^2./B.^2);

%% Evaluate elliptic integrals

[K,E] = ellipke(k); % calculate complete elliptic integrals of the first (K) and second (E) kind.

%% Calculate field com

Bp = abs(zRel./(2.*pi.*A.^2.*B.*p).*((1+p.^2+zRel.^2).*E-A.^2.*K)); % radial component of field
Bz = 1./(2.*pi.*A.^2.*B).*((1-p.^2-zRel.^2).*E+A.^2.*K);    % z-component of field

if nargin == 4  % flip direction of current flow if necessary
    if pol == -1
        Bz = -Bz;
    end
end

end