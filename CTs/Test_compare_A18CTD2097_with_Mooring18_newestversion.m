clc; clear all; close all;

%% Load data
load('d:\sabinerijnsbur\Matlab\Moorings\SBE4940.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\SBE1525.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\SBE4939.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\SBE19.mat');
load('d:\sabinerijnsbur\Matlab\A18CTD2097.mat');

mooring = '18m';

dir_out = 'd:\sabinerijnsbur\Matlab\Figures\';
save_plot = 'yes';

%% Input values plots
fig.lwidth      = 1;
fig.fonts       = 8;
fig.xlabel      = 'day in year';
fig.xaxis       = [271 273];
fig.xtick       = 271:0.5:273;
fig.trange      = '271-273';
fig.ydens       = [1012.5 1025];
fig.ytickdens   = 1012.5:2.5:1025;
fig.ysal        = [15 35];
fig.yticksal    = 15:4:35;
fig.ypress      = [0 30];
fig.ytickpress  = 0:5:30;
fig.position    =  mooring;
fig.legendloc   = 'SouthEast';
fig.legendorien = 'horizontal';
fig.fname       = ['A18CTD2097-vs-SBE19' fig.trange];% figure of all information in one figure
fig.fname2      = ['A18CTD2097-vs-M18' fig.trange];% figure of density and velocities

%% Figure CTD2097 vs SBE19 ; M12
figure;
subplot(3,1,1)
plot(A18CTD2097.t,A18CTD2097.sal,'linewidth',fig.lwidth)
hold on
plot(SBE19.t,SBE19.sal,'linewidth',fig.lwidth,'Color','r')
legend('CTD2097','SBE19','Orientation','horizontal','Location','SouthEast');
axis([fig.xaxis fig.ysal]);
set(gca,'YTick',fig.yticksal);
set(gca,'XTick',fig.xtick);
% ylabel('Salinity (psu)');

subplot(3,1,2)
plot(A18CTD2097.t,A18CTD2097.dens,'linewidth',fig.lwidth)
hold on
plot(SBE19.t,SBE19.dens,'linewidth',fig.lwidth,'Color','r')
axis([fig.xaxis fig.ydens]);
set(gca,'YTick',fig.ytickdens);
set(gca,'XTick',fig.xtick);
ylabel('Density (kg/m^3)');

subplot(3,1,3)
plot(A18CTD2097.t,A18CTD2097.press,'linewidth',fig.lwidth)
hold on
plot(SBE19.t,SBE19.press,'linewidth',fig.lwidth,'Color','r')
xlabel(fig.xlabel);
axis([fig.xaxis fig.ypress]);
set(gca,'YTick',fig.ytickpress);
set(gca,'XTick',fig.xtick);
ylabel('Pressure (m)');
title(['CTD2097 vs SBE19 Mooring' mooring]);

if strcmp(save_plot,'yes')
set(gca,'FontSize',fig.fonts)
set(findall(gcf,'type','text'),'FontSize',fig.fonts)
set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperSize', [16 16]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperPosition', [0 0 16 16]);
set(gcf,'Renderer','painters');
print(gcf, '-dpdf',[dir_out fig.fname '.pdf']);
end

%% CTD2097 vs M18

figure;
subplot(3,1,1)
plot(SBE1525.t,SBE1525.sal,'linewidth',fig.lwidth);
hold on
plot(SBE4939.t,SBE4939.sal,'--r','linewidth',fig.lwidth);
plot(SBE4940.t,SBE4940.sal,'-.k','linewidth',fig.lwidth);
plot(SBE19.t,SBE19.sal,'g','linewidth',fig.lwidth);
plot(A18CTD2097.t,A18CTD2097.sal,'m','linewidth',fig.lwidth);
axis([fig.xaxis fig.ysal]);
set(gca,'YTick',fig.yticksal);
set(gca,'XTick',fig.xtick);
set(gca,'Fontsize',fig.fonts);
legend('MC1525 1mbs','MC4939 2.5mbs','MC4940 10mbs','SBE19 15mbs','CTD2097 18mbs','Orientation','vertical','Location','SouthEast');
legend('Location',fig.legendloc,'Orientation',fig.legendorien);
ylabel('Salinity (PSU)');
title('18 m mooring vs A18 CTD2097');

subplot(3,1,2)
plot(SBE1525.t,SBE1525.dens,'linewidth',fig.lwidth);
hold on
plot(SBE4939.t,SBE4939.dens,'--r','linewidth',fig.lwidth);
plot(SBE4940.t,SBE4940.dens,'-.k','linewidth',fig.lwidth);
plot(SBE19.t,SBE19.dens,'g','linewidth',fig.lwidth);
plot(A18CTD2097.t,A18CTD2097.dens,'m','linewidth',fig.lwidth);
axis([fig.xaxis fig.ydens]);
set(gca,'YTick',fig.ytickdens);
set(gca,'XTick',fig.xtick);
set(gca,'Fontsize',fig.fonts);
% set(gca,'YTick',[20 22.5 25 27.5 30 32.5]);
% axis([SBE1527_v1.time(SBE1527_v1.start) SBE1527_v1.time(SBE1527_v1.stop) 20 32.5]);
ylabel('Density (kgm/m^3)');

subplot(3,1,3)
plot(SBE4939.t,SBE4939.press,'-.k','linewidth',fig.lwidth);
hold on
plot(SBE4940.t,SBE4940.press,'c','linewidth',fig.lwidth);%(1:99746)
plot(SBE19.t,SBE19.press,'g','linewidth',fig.lwidth);
plot(A18CTD2097.t,A18CTD2097.press,'m','linewidth',fig.lwidth);
axis([fig.xaxis fig.ypress]);
set(gca,'YTick',fig.ytickpress);
set(gca,'XTick',fig.xtick);
set(gca,'Fontsize',fig.fonts);
ylabel('Pressure (dbar)');
xlabel(fig.xlabel);

if strcmp(save_plot,'yes')
set(gca,'FontSize',fig.fonts)
set(findall(gcf,'type','text'),'FontSize',fig.fonts)
set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperSize', [16 16]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperPosition', [0 0 16 16]);
set(gcf,'Renderer','painters');
% print(gcf, '-dpdf',['Mooring12_vs_A12CTD2099.pdf']);
print(gcf, '-dpdf',[dir_out fig.fname2 '.pdf']);
end