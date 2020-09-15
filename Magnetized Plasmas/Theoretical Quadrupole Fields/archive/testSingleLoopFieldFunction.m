clc
clear
close all

%% Testing whether single-loop field calculations match on-axis results
% Here, I wish to test whether my function for calculating the magnetic field for a
% single current loop works in limiting cases. Here, I consider the on-axis
% calculations. Specifically, this function tests the function
% 'fieldFromSingleCurrentLoop.m' for p = 0 when the current loop's center is at the
% origin.


z = linspace(-50,50,1e4);   % calculate field using my function for a loop at z0 = 0
p = linspace(0,0,1e4);
z0 = 0;
[Bp,Bz] = fieldFromSingleCurrentLoop(z,p,z0);


fig = figure(1);
fig.Position = [210.5000  220.5000  560.0000  420.0000];
plot(z,Bz,'LineWidth',1.5)
hold on
plot(z,1./(2.*(1+(z-z0).^2).^(3/2)))
hold on
plot(z,Bp,'LineWidth',1.5)
ax = gca;
ax.FontSize = 12;
ax.YScale = 'log';
xlabel('z/a')
ylabel('B_z / (\mu_0I/a)')
title('Field Along Symmetry Axis for \rho = 0')
legend({'Exact Model','Limiting Case'})

%% Testing whether Bp behaves properly at relevant distances

z = linspace(0,0,1e4);   % calculate field using my function for a loop at z0 = 0
p = linspace(.001,.5,1e4);
z0 = 50;
[Bp,Bz] = fieldFromSingleCurrentLoop(z,p,z0);


fig = figure(2);
fig.Position = [210.5000  220.5000  560.0000  420.0000];
plot(p,Bz,'LineWidth',1.5)
hold on
plot(p,Bp,'LineWidth',1.5)
ax = gca;
ax.FontSize = 12;
ax.YScale = 'log';
xlabel('p/a')
ylabel('B / (\mu_0I/a)')
title('Field Along Symmetry Axis for z = 0')
legend({'Bz','B_p'})


%% Testing single-loop code near, but not on, symmetry axis
close all
z = linspace(0,50,1e4);   % calculate field using my function for a loop at z0 = 0
p1 = linspace(.0001,.0001,1e4);
p2 = linspace(.001,.001,1e4);
p3 = linspace(.0001,.0001,1e4);
p4 = linspace(.00001,.00001,1e4);

z0 = 50;
[Bp,Bz] = fieldFromSingleCurrentLoop(z,p1,z0);
[Bp2,Bz2] = fieldFromSingleCurrentLoop(z,p2,z0);
[Bp3,Bz3] = fieldFromSingleCurrentLoop(z,p3,z0);
[Bp4,Bz4] = fieldFromSingleCurrentLoop(z,p4,z0);

fig = figure(3);
fig.Position = [210.5000  220.5000  560.0000  420.0000];
plot(z,Bp,'LineWidth',1.5)
hold on
plot(z,3.*(z-z0).*p1./(4.*(1+(z-z0).^2).^(5/2)),'LineWidth',1.5)
hold on
% plot(z,Bp2,'LineWidth',1.5)
% plot(z,3.*z.*p2./(4.*(1+z.^2).^(5/2)),'LineWidth',1.5)
% plot(z,Bp3,'LineWidth',1.5)
% plot(z,3.*z.*p3./(4.*(1+z.^2).^(5/2)),'LineWidth',1.5)
% plot(z,Bp4,'LineWidth',1.5)
% plot(z,3.*z.*p4./(4.*(1+z.^2).^(5/2)),'LineWidth',1.5)

ax = gca;
ax.FontSize = 12;
ax.YScale = 'log';
xlabel('z/a')
ylabel('B_\rho / (\mu_0I/a)')
title('Field Near Symmetry Axis for \rho < a')
legend({'\rho = .0001','Limiting Case'})

