% Plot Frontal strength metrics
clc;clear all;
%% Load data
load('d:\sabinerijnsbur\Matlab\Megapex\Conditions\tide.mat');

% 12m mooring
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\SBE1527.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\SBE1526.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\OBS3A744.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\SBE5425.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\SBE5426.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\SBE1842_corrected.mat');

% 18m mooring
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\SBE1525.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\SBE4939.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\OBS3A744.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\SBE4940.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\SBE19_corrected.mat');

% ADCPs
load('d:\sabinerijnsbur\Matlab\adcp\adcp12.mat');
load('d:\sabinerijnsbur\Matlab\adcp\adcp18.mat');

% Frontal metrics
load('d:\sabinerijnsbur\Matlab\Moorings\Metrics_Fronts.mat');

%% Input figure

fig.xlim   = [259 289];
fig.lwidth = 0.8;

%% Plot tidal elevation/depth mean velocity 12m
figure;
h1 = subplot(4,1,1);
plot(T1.t(T1.neap1),T1.ssh(T1.neap1),'r');
hold on
plot(T1.t(T1.spr1),T1.ssh(T1.spr1),'b');
plot(T1.t(T1.neap2),T1.ssh(T1.neap2),'r');
plot(T1.t(T1.spr2),T1.ssh(T1.spr2),'b');
plot(T1.t(T1.neap3),T1.ssh(T1.neap3),'r');
plot(T1.t(T1.spr3),T1.ssh(T1.spr3),'b');
plot(T1.t(T1.neap4),T1.ssh(T1.neap4),'r');
plot(adcp12.t,adcp12.meanva,'--k');
hline(0,'k');
ylim([-1 1.5]);
xlim(fig.xlim);
ylabel('\eta (m)');
% legend('\eta (m)','depth mean va (m/s)');
% legend('Orientation','horizontal','Location','SouthEast');
title('12m 10min-averaged');

h2 = subplot(4,1,2);
plot(SBE1527.t10,SBE1527.dens10-1000,'linewidth',fig.lwidth);
hold on
grid on
plot(SBE1526.t10,SBE1526.dens10-1000,'--r','linewidth',fig.lwidth);
plot(SBE5426.t10,SBE5426.dens10-1000,'-.k','linewidth',fig.lwidth);
plot(SBE5425.t10,SBE5425.dens10-1000,'c','linewidth',fig.lwidth);
plot(SBE1842.t10,SBE1842.dens10-1000,'g','linewidth',fig.lwidth);
xlim(fig.xlim);
ylim([11 24]);
legend('1mbs','3mbs','7mbs','8mbs','10.5mbs');
legend('Orientation','horizontal','Location','SouthEast');

h3 = subplot(4,1,3);
plot(SBE1527.t10,F12.dR,'linewidth',fig.lwidth);
hold on
plot(SBE1527.t10,F12.dR2,'linewidth',fig.lwidth,'Linestyle','--');
hline(0,'k');
xlim(fig.xlim);
ylim([-0.5 10]);
ylabel('\Delta \rho (kg/m^3)');
legend('bot-surf','av.bot - surf');

h4 = subplot(4,1,4);
plot(SBE1527.t10,F12.drdt10,'linewidth',fig.lwidth);
hline(0,'k');
xlim(fig.xlim);
% ylim([-0.3 0.2]);
ylabel('d\rho /dt (kg/m^3)');

set(gcf,'color','w');
linkaxes([h1,h2,h3,h4],'x');

%% Plot tidal elevation/depth mean velocity 18m

figure;
h5 = subplot(4,1,1);
plot(T1.t(T1.neap1),T1.ssh(T1.neap1),'r');
hold on
plot(T1.t(T1.spr1),T1.ssh(T1.spr1),'b');
plot(T1.t(T1.neap2),T1.ssh(T1.neap2),'r');
plot(T1.t(T1.spr2),T1.ssh(T1.spr2),'b');
plot(T1.t(T1.neap3),T1.ssh(T1.neap3),'r');
plot(T1.t(T1.spr3),T1.ssh(T1.spr3),'b');
plot(T1.t(T1.neap4),T1.ssh(T1.neap4),'r');
plot(adcp18.t,adcp18.meanva,'--k');
hline(0,'k');
ylim([-1 1.5]);
xlim(fig.xlim);
ylabel('\eta (m)');
% legend('\eta (m)','depth mean va (m/s)');
% legend('Orientation','horizontal','Location','SouthEast');
title('18m 10min-averaged');

h6 = subplot(4,1,2);
plot(SBE1525.t10,SBE1525.dens10-1000,'linewidth',fig.lwidth);
hold on
grid on
plot(SBE4939.t10,SBE4939.dens10-1000,'--r','linewidth',fig.lwidth);
plot(SBE4940.t10,SBE4940.dens10-1000,'-.k','linewidth',fig.lwidth);
plot(SBE19.t10,SBE19.dens10-1000,'c','linewidth',fig.lwidth);
xlim(fig.xlim);
ylim([11 24]);
legend('1mbs','2.5mbs','10mbs','15mbs');
legend('Orientation','horizontal','Location','SouthEast');

h7 = subplot(4,1,3);
plot(SBE1525.t10,F18.dR,'linewidth',fig.lwidth);
hold on
plot(SBE1525.t10,F18.dR2,'linewidth',fig.lwidth,'Linestyle','--');
hline(0,'k');
xlim(fig.xlim);
ylim([-0.5 10]);
ylabel('\Delta \rho (kg/m^3)');
legend('bot-surf','av.bot - surf');

h8 = subplot(4,1,4);
plot(SBE1525.t10,F18.drdt10,'linewidth',fig.lwidth);
hline(0,'k');
xlim(fig.xlim);
% ylim([-0.3 0.2]);
ylabel('d\rho /dt (kg/m^3)');


set(gcf,'color','w');
linkaxes([h5,h6,h7,h8],'x');

%% Plot tidal elevation, density and metrics 12m

t12 = day_of_year(F12.time);

figure;
h9 = subplot(5,1,1);
plot(T1.t(T1.neap1),T1.ssh(T1.neap1),'r');
hold on
plot(T1.t(T1.spr1),T1.ssh(T1.spr1),'b');
plot(T1.t(T1.neap2),T1.ssh(T1.neap2),'r');
plot(T1.t(T1.spr2),T1.ssh(T1.spr2),'b');
plot(T1.t(T1.neap3),T1.ssh(T1.neap3),'r');
plot(T1.t(T1.spr3),T1.ssh(T1.spr3),'b');
plot(T1.t(T1.neap4),T1.ssh(T1.neap4),'r');
plot(adcp12.t,adcp12.meanva,'--k');
hline(0,'k');
vline(t12,':k');
ylim([-1 1.5]);
xlim(fig.xlim);
ylabel('\eta (m)');
% legend('\eta (m)','depth mean va (m/s)');
% legend('Orientation','horizontal','Location','SouthEast');
title('12m 10min-averaged');

h10 = subplot(5,1,2);
plot(SBE1527.t10,SBE1527.dens10-1000,'linewidth',fig.lwidth);
hold on
grid on
plot(SBE1526.t10,SBE1526.dens10-1000,'--r','linewidth',fig.lwidth);
plot(SBE5426.t10,SBE5426.dens10-1000,'-.k','linewidth',fig.lwidth);
plot(SBE5425.t10,SBE5425.dens10-1000,'c','linewidth',fig.lwidth);
plot(SBE1842.t10,SBE1842.dens10-1000,'g','linewidth',fig.lwidth);
vline(t12,':k');
xlim(fig.xlim);
ylim([11 24]);
legend('1mbs','3mbs','7mbs','8mbs','10.5mbs');
legend('Orientation','horizontal','Location','SouthEast');

h11 = subplot(5,1,3);
plot(SBE1527.t10,F12.dR,'linewidth',fig.lwidth);
hold on
plot(SBE1527.t10,F12.dR2,'linewidth',fig.lwidth,'Linestyle','--');
hline(0,'k');
vline(t12,':k');
xlim(fig.xlim);
ylim([-0.5 10]);
ylabel('\Delta \rho (kg/m^3)');
legend('bot-surf','av.bot - surf');

h12 = subplot(5,1,4);
plot(SBE1527.t10,F12.drdt10,'linewidth',fig.lwidth);
hline(0,'k');
vline(t12,':k');
xlim(fig.xlim);
% ylim([-0.3 0.2]);
ylabel('d\rho /dt (kg/m^3)');

h13 = subplot(5,1,5);
plot(t12,F12.Fr,'o');
hline(1,'r');
vline(t12,':k');
xlim(fig.xlim);
ylim([0 3]);
ylabel('Fr');

set(gcf,'color','w');
linkaxes([h9,h10,h11,h12,h13],'x');

%% Plot tidal elevation, density and metrics 18m

t18 = day_of_year(F18.time);

figure;
h14 = subplot(5,1,1);
plot(T1.t(T1.neap1),T1.ssh(T1.neap1),'r');
hold on
plot(T1.t(T1.spr1),T1.ssh(T1.spr1),'b');
plot(T1.t(T1.neap2),T1.ssh(T1.neap2),'r');
plot(T1.t(T1.spr2),T1.ssh(T1.spr2),'b');
plot(T1.t(T1.neap3),T1.ssh(T1.neap3),'r');
plot(T1.t(T1.spr3),T1.ssh(T1.spr3),'b');
plot(T1.t(T1.neap4),T1.ssh(T1.neap4),'r');
plot(adcp18.t,adcp18.meanva,'--k');
hline(0,'k');
vline(t18,':k');
ylim([-1 1.5]);
xlim(fig.xlim);
ylabel('\eta (m)');
% legend('\eta (m)','depth mean va (m/s)');
% legend('Orientation','horizontal','Location','SouthEast');
title('18m 10min-averaged');

h15 = subplot(5,1,2);
plot(SBE1525.t10,SBE1525.dens10-1000,'linewidth',fig.lwidth);
hold on
grid on
plot(SBE4939.t10,SBE4939.dens10-1000,'--r','linewidth',fig.lwidth);
plot(SBE4940.t10,SBE4940.dens10-1000,'-.k','linewidth',fig.lwidth);
plot(SBE19.t10,SBE19.dens10-1000,'c','linewidth',fig.lwidth);
xlim(fig.xlim);
vline(t18,':k');
ylim([11 24]);
legend('1mbs','2.5mbs','10mbs','15mbs');
legend('Orientation','horizontal','Location','SouthEast');

h16 = subplot(5,1,3);
plot(SBE1525.t10,F18.dR,'linewidth',fig.lwidth);
hold on
plot(SBE1525.t10,F18.dR2,'linewidth',fig.lwidth,'Linestyle','--');
hline(0,'k');
vline(t18,':k');
xlim(fig.xlim);
ylim([-0.5 10]);
ylabel('\Delta \rho (kg/m^3)');
legend('bot-surf','av.bot - surf');

h17 = subplot(5,1,4);
plot(SBE1525.t10,F18.drdt10,'linewidth',fig.lwidth);
hline(0,'k');
vline(t18,':k');
xlim(fig.xlim);
% ylim([-0.3 0.2]);
ylabel('d\rho /dt (kg/m^3)');

h18 = subplot(5,1,5);
plot(t18,F18.Fr,'o');
hline(1,'r');
vline(t18,':k');
xlim(fig.xlim);
ylim([0 3]);
ylabel('Fr');

set(gcf,'color','w');
linkaxes([h14,h15,h16,h17,h18],'x');
