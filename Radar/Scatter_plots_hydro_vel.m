% Scatter plots hydrodynamics and velocity

clc;clear all;close all;

%% Load data
% ADCPs
load('d:\sabinerijnsbur\Matlab\adcp\adcp12.mat');
load('d:\sabinerijnsbur\Matlab\adcp\adcp18.mat');

% ADV 0.75 mab
load('d:\sabinerijnsbur\Matlab\Mini-stable\adv355.mat');

% Frontal metrics
load('d:\sabinerijnsbur\Matlab\Moorings\Metrics_Fronts.mat');

%% Calculate surface and bottom velocities

[vel12] = surface_bottom_velocity(adcp12.va,adcp12.vc);
[vel18] = surface_bottom_velocity(adcp18.va,adcp18.vc);

%% Interpolate adv355 towards adcp

[vel12.bvc_adv] = interp1(adv355.ba.t(2:end-1),adv355.ba.vc,adcp12.t);
[vel12.bva_adv]  = interp1(adv355.ba.t(2:end-1),adv355.ba.va,adcp12.t);

%% Scatter plot of entire series

%12m
figure;
subplot(2,2,1)
plot(vel12.svc2,F12.drdt(1:4206),'.');
ylabel('d\rho/dt (kg/m^3)');
xlabel('vc surface (m/s)');
title('12m');

subplot(2,2,2)
plot(vel12.bvc_adv,F12.drdt(1:4206),'.r');
ylabel('d\rho/dt (kg/m^3)');
xlabel('vc bottom (m/s)');

subplot(2,2,3)
plot(vel12.svc2,F12.dR(1:4206),'.');
ylabel('\Delta\rho (kg/m^3)');
xlabel('vc surface (m/s)');

subplot(2,2,4)
plot(vel12.bvc_adv,F12.dR(1:4206),'.r');
ylabel('\Delta\rho (kg/m^3)');
xlabel('vc bottom (m/s)');
set(gcf,'color','w');

% 18m
figure;
subplot(2,2,1)
plot(vel18.svc2,F18.drdt(1:3042),'.');
ylabel('d\rho/dt (kg/m^3)');
xlabel('vc surface (m/s)');
title('18m');

subplot(2,2,2)
plot(vel18.bvc2,F18.drdt(1:3042),'.r');
ylabel('d\rho/dt (kg/m^3)');
xlabel('vc bottom (m/s)');

subplot(2,2,3)
plot(vel18.svc2,F18.dR(1:3042),'.');
ylabel('\Delta\rho (kg/m^3)');
xlabel('vc surface (m/s)');

subplot(2,2,4)
plot(vel18.bvc2,F18.dR(1:3042),'.r');
ylabel('\Delta\rho (kg/m^3)');
xlabel('vc bottom (m/s)');
set(gcf,'color','w');

%% Scatter plots of only the peaks found


%12m
figure;
subplot(2,2,1)
plot(vel12.svc2(F12.I),F12.drdt(F12.I),'.');
ylabel('d\rho/dt (kg/m^3)');
xlabel('vc surface (m/s)');
title('12m');

subplot(2,2,2)
plot(vel12.bvc_adv(F12.I),F12.drdt(F12.I),'.r');
ylabel('d\rho/dt (kg/m^3)');
xlabel('vc bottom (m/s)');

subplot(2,2,3)
plot(vel12.svc2(F12.I),F12.dR(F12.I),'.');
ylabel('\Delta\rho (kg/m^3)');
xlabel('vc surface (m/s)');

subplot(2,2,4)
plot(vel12.bvc_adv(F12.I),F12.dR(F12.I),'.r');
ylabel('\Delta\rho (kg/m^3)');
xlabel('vc bottom (m/s)');
set(gcf,'color','w');

% 18m
figure;
subplot(2,2,1)
plot(vel18.svc2(F18.I),F18.drdt(F18.I),'.');
ylabel('d\rho/dt (kg/m^3)');
xlabel('vc surface (m/s)');
title('18m');

subplot(2,2,2)
plot(vel18.bvc2(F18.I),F18.drdt(F18.I),'.r');
ylabel('d\rho/dt (kg/m^3)');
xlabel('vc bottom (m/s)');

subplot(2,2,3)
plot(vel18.svc2(F18.I),F18.dR(F18.I),'.');
ylabel('\Delta\rho (kg/m^3)');
xlabel('vc surface (m/s)');

subplot(2,2,4)
plot(vel18.bvc2(F18.I),F18.dR(F18.I),'.r');
ylabel('\Delta\rho (kg/m^3)');
xlabel('vc bottom (m/s)');
set(gcf,'color','w');




