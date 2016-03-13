%Calculate mixing energy
clc;clear all;
% close all;
%% Coefficients

delta        = 0.039; % Tijmen --> Simpson et al 1991
AirDensity   = 1.293; % check!!
ks           = 0.000064; % Check
epsilon      = 0.0065;% Tijmen --> check
k            = 0.0025;%check --> Simpson et al
gamma        = 0.0333;% Simpson et al 1990


%% Wind mixing

load('d:\sabinerijnsbur\Matlab\MegaPex\Conditions\wind.mat');
load('d:\sabinerijnsbur\Matlab\adcp\adcp12C.mat');

K12.windspeed    = interp1(wind.t,wind.speed,adcp12C.t);
K12.windst       = delta.*ks.*AirDensity.*(K12.windspeed.^3./adcp12C.h');

load('d:\sabinerijnsbur\Matlab\adcp\adcp18.mat');

K18.windspeed    = interp1(wind.t,wind.speed,adcp18.t);
K18.windst       = delta.*ks.*AirDensity.*(K18.windspeed.^3./adcp18.h');

%% Tidal mixing

%12 m
load('d:\sabinerijnsbur\Matlab\adcp\Tidal_analysis\T12.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\SBE1526.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\SBE1527.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\SBE5425.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\SBE5426.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\SBE1842_corrected.mat');

Waterdensity     = (SBE1526.dens10+SBE1527.dens10+SBE5425.dens10+SBE5426.dens10+SBE1842.dens10)./5;
K12.tide           = epsilon.*k.*Waterdensity.*(abs(nanmean(adcp12C.va)).^3)./adcp12C.h;
K12.tideM2         = epsilon.*k.*Waterdensity.*(abs(nanmean(T12.va)).^3)./adcp12C.h;

%18 m
load('d:\sabinerijnsbur\Matlab\adcp\Tidal_analysis\T18.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\SBE1525.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\SBE4939.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\SBE4940.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\SBE19_corrected.mat');

Waterdensity     = (SBE1525.dens10+SBE4939.dens10+SBE4940.dens10+SBE19.dens10)./5;
K18.tide           = epsilon.*k.*Waterdensity.*(abs(nanmean(adcp18.va)).^3)./adcp18.h;
K18.tideM2         = epsilon.*k.*Waterdensity.*(abs(nanmean(T18.va)).^3)./adcp18.h;

%% Wave mixing


%% ssh

mooring = '12m';
adcp    = adcp12C;
K       = K12;

% mooring = '18m';
% adcp    = adcp18;
% K       = K18;

ssh     = adcp.h-mean(adcp.h);
neap1   = find(adcp.t>=adcp.t(1) & adcp.t<266);
spr1    = find(adcp.t>266 & adcp.t<273);
neap2   = find(adcp.t>273 & adcp.t<280);
spr2    = find(adcp.t>280 & adcp.t<287);
neap3   = find(adcp.t>287 & adcp.t<294);
% spr3    = find(adcp.t>294 & adcp.t<301); no vel data
% neap4   = find(adcp.t>301 & adcp.t<303); no vel data


%% Plot
% 12m
figure;
h1=subplot(5,1,1);
plot(adcp.t(neap1),ssh(neap1),'r');
hold on
plot(adcp.t(spr1),ssh(spr1),'b');
plot(adcp.t(neap2),ssh(neap2),'r');
plot(adcp.t(spr2),ssh(spr2),'b');
plot(adcp.t(neap3),ssh(neap3),'r');
hline(0,'k');
xlim([259 289]);
title([mooring]);

h2 = subplot(5,1,2);
if strcmp(mooring,'12m')
    plot(SBE1527.t10,SBE1527.dens10-1000);
    hold on
    plot(SBE1526.t10,SBE1526.dens10-1000,'--r');
    plot(SBE5426.t10,SBE5426.dens10-1000,'-.k');
    plot(SBE5425.t10,SBE5425.dens10-1000,'c');
    plot(SBE1842.t10,SBE1842.dens10-1000,'g');
elseif strcmp(mooring,'18m')
    plot(SBE1525.t,SBE1525.dens-1000);
    hold on
    plot(SBE4939.t,SBE4939.dens-1000,'--r');
    plot(SBE4940.t,SBE4940.dens-1000,'-.k');
    plot(SBE19.t,SBE19.dens-1000,'c');
end
xlim([259 289]);

h3=subplot(5,1,3);
pcolorcorcen(adcp.t,adcp.z,adcp.va);
hold on
plot(adcp.t,adcp.h,'k');
colormap(colormapbluewhitered);
xlim([259 289]);

h4=subplot(5,1,4);
pcolorcorcen(adcp.t,adcp.z,adcp.vc);
hold on
plot(adcp.t,adcp.h,'k');
colormap(colormapbluewhitered);
xlim([259 289]);

h5=subplot(5,1,5);
% plot(adcp12C.t,K.tide);
plot(adcp.t,K.tideM2,'b');
hold on
grid on
plot(adcp.t,K.windst,'--r');
plot(adcp.t,K.windst'+K.tideM2,'k');
legend('tide M2','wind','total');
legend('Orientation','horizontal');
xlim([259 289]);

linkaxes([h1,h2,h3,h4,h5],'x');


    
    