clc; clear all; close all;
%% Load data
load('d:\sabinerijnsbur\Matlab\Moorings\SBE1527.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\SBE1526.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\SBE5426.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\SBE5425.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\SBE1842.mat');
load('d:\sabinerijnsbur\Matlab\A12CTD2099.mat');

mooring = '12m';

dir_out = 'd:\sabinerijnsbur\Matlab\Figures\';
save_plot = 'yes';

%% Input values plots
fig.lwidth      = 1;
fig.fonts       = 8;
fig.xlabel      = 'day in year';
fig.xaxis       = [259 SBE1842.t(end)];
fig.xtick       = 259:2:SBE1842.t(end);
fig.trange      = '259-end';
fig.ydens       = [1012.5 1025];
fig.ytickdens   = 1012.5:2.5:1025;
fig.ysal        = [15 35];
fig.yticksal    = 15:4:35;
fig.ypress      = [0 15];
fig.ytickpress  = 0:5:15;
fig.position    =  mooring;
fig.legendloc   = 'SouthEast';
fig.legendorien = 'horizontal';
fig.fname       = ['A12CTD2099-vs-SBE1842' fig.trange];% figure of all information in one figure
fig.fname2      = ['A12CTD2099-vs-M12' fig.trange];% figure of density and velocities

%% Figure CTD2099 vs SBE1842 ; M12
figure;
subplot(3,1,1)
plot(A12CTD2099.t,A12CTD2099.sal,'linewidth',fig.lwidth)
hold on
plot(SBE1842.t,SBE1842.sal,'linewidth',fig.lwidth,'Color','r')
legend('CTD2099','SBE1842','Orientation','horizontal','Location','SouthEast');
axis([fig.xaxis fig.ysal]);
set(gca,'YTick',fig.yticksal);
set(gca,'XTick',fig.xtick);
ylabel('Salinity (psu)');

subplot(3,1,2)
plot(A12CTD2099.t,A12CTD2099.dens,'linewidth',fig.lwidth)
hold on
plot(SBE1842.t,SBE1842.dens,'linewidth',fig.lwidth,'Color','r')
axis([fig.xaxis fig.ydens]);
set(gca,'YTick',fig.ytickdens);
set(gca,'XTick',fig.xtick);
ylabel('Density (kg/m^3)');

subplot(3,1,3)
plot(A12CTD2099.t,A12CTD2099.press,'linewidth',fig.lwidth)
hold on
plot(SBE1842.t,SBE1842.press,'linewidth',fig.lwidth,'Color','r')
xlabel(fig.xlabel);
axis([fig.xaxis fig.ypress]);
set(gca,'YTick',fig.ytickpress);
set(gca,'XTick',fig.xtick);
ylabel('Pressure (m)');
title(['CTD2099 vs SBE1842 Mooring' mooring]);

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

%%

figure;
subplot(3,1,1)
plot(SBE1527.t,SBE1527.sal,'linewidth',fig.lwidth);
hold on
plot(SBE1526.t,SBE1526.sal,'--r','linewidth',fig.lwidth);
plot(SBE5426.t,SBE5426.sal,'-.k','linewidth',fig.lwidth);
plot(SBE5425.t(1:99746),SBE5425.sal(1:99746),'c','linewidth',fig.lwidth);% (1:99746)
plot(SBE1842.t,SBE1842.sal,'g','linewidth',fig.lwidth);
plot(A12CTD2099.t,A12CTD2099.sal,'m','linewidth',fig.lwidth);
axis([fig.xaxis fig.ysal]);
set(gca,'YTick',fig.yticksal);
set(gca,'XTick',fig.xtick);
set(gca,'Fontsize',fig.fonts);
legend('MC1527 1mbs','MC1526 3mbs','MC5426 7mbs','MC5425 7.63mbs','MC1842 10.5mbs','CTD2099 12mbs','Orientation','vertical','Location','SouthEast');
legend('Location',fig.legendloc,'Orientation',fig.legendorien);
ylabel('Salinity (PSU)');
title('12 m mooring vs A12 CTD2099');

subplot(3,1,2)
plot(SBE1527.t,SBE1527.dens,'linewidth',fig.lwidth);
hold on
plot(SBE1526.t,SBE1526.dens,'--r','linewidth',fig.lwidth);
plot(SBE5426.t,SBE5426.dens,'-.k','linewidth',fig.lwidth);
plot(SBE5425.t(1:99746),SBE5425.dens(1:99746),'c','linewidth',fig.lwidth);%(1:99746)
plot(SBE1842.t,SBE1842.dens,'g','linewidth',fig.lwidth);
plot(A12CTD2099.t,A12CTD2099.dens,'m','linewidth',fig.lwidth);
axis([fig.xaxis fig.ydens]);
set(gca,'YTick',fig.ytickdens);
set(gca,'XTick',fig.xtick);
set(gca,'Fontsize',fig.fonts);
% set(gca,'YTick',[20 22.5 25 27.5 30 32.5]);
% axis([SBE1527_v1.time(SBE1527_v1.start) SBE1527_v1.time(SBE1527_v1.stop) 20 32.5]);
ylabel('Density (kgm/m^3)');

subplot(3,1,3)
plot(SBE5426.t,SBE5426.press,'-.k','linewidth',fig.lwidth);
hold on
plot(SBE5425.t(1:99746),SBE5425.press(1:99746),'c','linewidth',fig.lwidth);%(1:99746)
plot(SBE1842.t,SBE1842.press,'g','linewidth',fig.lwidth);
plot(A12CTD2099.t,A12CTD2099.press,'m','linewidth',fig.lwidth);
axis([fig.xaxis fig.ypress]);
set(gca,'YTick',fig.ytickpress);
set(gca,'XTick',fig.xtick);
set(gca,'Fontsize',fig.fonts);
% set(gca,'YTick',[10 12.5 15 17.5 20 22.5]);
% axis([SBE1527_v1.time(SBE1527_v1.start) SBE1527_v1.time(SBE1527_v1.stop) 10 22.5]);
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
