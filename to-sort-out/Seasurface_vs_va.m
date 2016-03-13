clc;clear all;close all;

% adcp
load('D:\sabinerijnsbur\Matlab\adcp\adcp12.mat');
adcp = adcp12;
% h = (adcp.depth-17.2);% move surface pressure down to compare phase with tidal data
h = (adcp.depth-11.5);

% conditions
load('d:\sabinerijnsbur\Matlab\Measurements\Conditions\wave.mat');
load('d:\sabinerijnsbur\Matlab\Measurements\Conditions\Tide.mat');
load('d:\sabinerijnsbur\Matlab\Measurements\Conditions\wind.mat');
load('d:\sabinerijnsbur\Matlab\Measurements\Conditions\potwind.mat');

%% Input for figure
fig.xlabel      = 'day in year';
fig.lwidth      = 1;
fig.fonts       = 8;
fig.txtfonts    = 8;
fig.xaxis       = [adcp.t(1) adcp.t(255)];
fig.xtick       = round(adcp.t(1)):2:round(adcp.t(255));
fig.ylim        = [0 20]; %depth z
fig.color       = 'b'; % color lines conditions
fig.legendloc   = 'SouthEast';
fig.legendorien = 'horizontal';
fig.position    = '12m';
fig.title       = ['Tide vs velocity' fig.position];

%% Plot
figure;
% subplot(2,1,1)
plot(T1.t,T1.ssh,'b','linewidth',fig.lwidth);
hold on
plot(T2.t,T2.ssh,'r','linewidth',fig.lwidth);
plot(adcp.t,adcp.meanva,'--k','linewidth',fig.lwidth);
plot(adcp.t,h,'m','linewidth',fig.lwidth);
hline(0,'k');
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis -1 1.5]);
legend('Water level HvH (m)','Water level Scheveningen (m)','Alongshore velocity (m/s)','water level measured');
legend('Location',fig.legendloc,'Orientation',fig.legendorien);
title(fig.title);

set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperSize', [26 16]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperPosition', [0 0 26 16]);
set(gcf,'Renderer','painters');
print(gcf, '-dpdf',['Tide_vs_vel_' fig.position '.pdf']);


% subplot(2,1,2)
% plot(T1.t-(1/24),T1.ssh,'r','linewidth',fig.lwidth);
% hold on
% plot(adcp.t,adcp.meanva,'--k','linewidth',fig.lwidth);
% hline(0,'k');
% set(gca,'Fontsize',fig.fonts);
% axis([fig.xaxis -1 1.5]);
% legend('Water level (m) -1h','Alongshore velocity (m/s)');
% legend('Location',fig.legendloc,'Orientation',fig.legendorien);

%% Plot
figure;
% subplot(2,1,1)
plot(T1.time,T1.ssh,'b','linewidth',fig.lwidth);
hold on
plot(T2.time,T2.ssh,'r','linewidth',fig.lwidth);
plot(adcp.time,adcp.meanva,'--k','linewidth',fig.lwidth);
plot(adcp.time,h,'m','linewidth',fig.lwidth);
hline(0,'k');
set(gca,'Fontsize',fig.fonts);
axis([adcp.time(1) adcp.time(255) -1 1.5]);
legend('Water level HvH (m)','Water level Scheveningen (m)','Alongshore velocity (m/s)','water level measured');
legend('Location',fig.legendloc,'Orientation',fig.legendorien);
title(fig.title);

set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperSize', [26 16]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperPosition', [0 0 26 16]);
set(gcf,'Renderer','painters');
print(gcf, '-dpdf',['Tide_vs_vel2_' fig.position '.pdf']);