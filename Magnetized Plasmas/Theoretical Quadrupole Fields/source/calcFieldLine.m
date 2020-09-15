function [line] = calcFieldLine(x0,y0,Bx,By,xvec,yvec,dr)
%% Parameters
% x0 (1x1 double): starting x-pos (mm) for field line
% y0 (1x1 double): starting y-pos (mm) for field line
% Bx (mxn double): matrix of magnetic field on x-axis (G) corresponding to xvec(n) and yvec(m)
% By (mxn double): matrix of magnetic field on y-axis (G) corresponding to xvec(n) and yvec(m)
% xvec (1xn double): x-positions (mm)
% yvec (1xm double): y-positions (mm)

%% Function Notes

% This function computes a magnetic field line corresponding to starting pos. The magnetic field
% units don't matter. Only the field direction is used by this function.

%% Function
linex = x0;
liney = y0;

[X,Y] = meshgrid(xvec,yvec);

test = true;
iter = 0;
while test
    iter = iter + 1; % loop counter
    
    currBx = interp2(X,Y,Bx,linex(iter),liney(iter)); % get local x-comp of B
    currBy = interp2(X,Y,By,linex(iter),liney(iter)); % get local y-comp of B
    
    B = [currBx currBy]; % local magnetic field (units don't matter, just need for direction)
    b = B./norm(B); % get unit direction of magnetic field
    
    dx = b(1)*dr; % change in x-pos for this iteration (mm)
    dy = b(2)*dr; % change in y-pos for this iteration (mm)
    
    linex(iter+1) = linex(iter) + dx; % increment positions based on local field direction
    liney(iter+1) = liney(iter) + dy;
    
    % check whether updated position is still within range xvec and yvec
    if linex(iter+1) > max(xvec) || linex(iter+1) < min(xvec) || liney(iter+1) > max(yvec) || liney(iter+1) < min(yvec)
        test = false; % stop iteration if outside range that fields are defined for
    end
end

line.x = linex;
line.y = liney;

end