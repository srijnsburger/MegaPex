%% Script to plot adcp & Moorings
% Load adcp data
load('D:\sabinerijnsbur\Matlab\adcp\adcp12');
load('D:\sabinerijnsbur\Matlab\adcp\cfg12');
load('D:\sabinerijnsbur\Matlab\adcp\adcp18');
load('D:\sabinerijnsbur\Matlab\adcp\cfg18');

% Load mooring data
dirin = 'd:\sabinerijnsbur\Matlab\Moorings\';
load([dirin,'SBE1525.mat']);
load([dirin,'SBE1526.mat']);
load([dirin,'SBE1527.mat']);
load([dirin,'SBE5425.mat']);
load([dirin,'SBE5426.mat']);
load([dirin,'SBE1842.mat']);
load([dirin,'SBE4939.mat']);
load([dirin,'SBE4940.mat']);
load([dirin,'SBE19.mat']);

%% Input for figure

fig.fonts       = 8;
fig.txtfonts    = 8;
fig.clim_va     = [-1.4 1.4];
fig.ytick_va    = -1.4:0.2:1.4;
fig.clim_vc     = [-0.5 0.5];
fig.ytick_vc    = -0.5:0.1:0.5;
fig.xaxis       = [259 290];
% fig.xtick       = 259:2:290;
fig.xlabel      = 'day in year';

%% Plot ADCP12 and M12

fig.xtick       = 259:2:floor(adcp12.t(end));

figure;
AX = subplot_meshgrid(1,3,[.06 .04],[.07 .07 .07 .07],[nan],[nan nan nan]);
axes(AX(1,1))
pcolorcorcen(adcp12.t,adcp12.ranges,adcp12.va)
hold on
plot(adcp12.t,adcp12.depth,'k')
axis([fig.xaxis 0 20]);
set(gca,'XTick',fig.xtick);
caxis([fig.clim_va]);
% colormap(cbwr);
h = colorbar('fontsize',fig.fonts,'YTick',fig.ytick_va);
% freezeColors
% cbfreeze(h); 
ylabel('z (m)');
title({['Alongshore velocities at 12m (in m/s)']; '(+ is northwards)'});

axes(AX(1,2))
pcolorcorcen(adcp12.t,adcp12.ranges,adcp12.vc)
hold on
plot(adcp12.t,adcp12.depth,'k')
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis 0 20]);
set(gca,'XTick',fig.xtick);
caxis([fig.clim_vc]); 
% colormap(jet);
colorbar('fontsize',fig.fonts,'YTick',fig.ytick_vc);
ylabel('z (m)');
title({['Cross-shore velocities at 12m (in m/s)'];'(+ is offshore)'});

axes(AX(1,3))
plot(SBE1527.t,SBE1527.dens,'linewidth',fig.lwidth);
hold on
plot(SBE1526.t,SBE1526.dens,'--r','linewidth',fig.lwidth);
plot(SBE5426.t,SBE5426.dens,'-.k','linewidth',fig.lwidth);
plot(SBE5425.t,SBE5425.dens,'c','linewidth',fig.lwidth);
plot(SBE1842.t,SBE1842.dens,'g','linewidth',fig.lwidth);
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis 20 35]);
set(gca,'XTick',fig.xtick);
xlabel(fig.xlabel);
legend('MC1527 1mbs','MC1526 3mbs','MC5426 7mbs','MC5425 8mbs','MC1842 10.5mbs');
title({['Density at 12m (in kg/m^3)']});

set(AX(:,1:2),'xticklabel',[])

set(findall(gcf,'type','text'),'FontSize',fig.txtfonts)

%% Plot ADCP18 and M18

fig.xtick       = 259:2:floor(adcp18.t(end));

figure;
AX = subplot_meshgrid(1,3,[.06 .04],[.07 .07 .07 .07],[nan],[nan nan nan]);
axes(AX(1,1))








pcolorcorcen(adcp18.t,adcp18.ranges,adcp18.va)
hold on
plot(adcp18.t,adcp18.depth,'k')
set(gca,'fontsize',fig.fonts);
% axis([0 45 0 20]);
set(gca,'XTick',fig.xtick);
caxis([fig.clim_va]);
% colormap(cbwr);
h = colorbar('fontsize',fig.fonts,'YTick',fig.ytick_va);
% freezeColors
% cbfreeze(h); 
ylabel('z (m)');
title({['Alongshore velocities at 18m (in m/s)']; '(+ is northwards)'});

axes(AX(1,2))
pcolorcorcen(adcp18.t,adcp18.ranges,adcp18.vc)
hold on
plot(adcp18.t,adcp18.depth,'k')
set(gca,'fontsize',fig.fonts);
% axis([0 45 0 20]);
set(gca,'XTick',fig.xtick);
caxis([fig.clim_vc]); 
% colormap(jet);
colorbar('fontsize',fig.fonts,'YTick',fig.ytick_vc);
ylabel('z (m)');
title({['Cross-shore velocities at 18m (in m/s)'];'(+ is offshore)'});

axes(AX(1,3))
plot(SBE1525.t,SBE1525.sal,'linewidth',fig.lwidth);
hold on
plot(SBE4939.t,SBE4939.sal,'--r','linewidth',fig.lwidth);
plot(SBE4940.t,SBE4940.sal,'-.k','linewidth',fig.lwidth);
plot(SBE19.t,SBE19.sal,'c','linewidth',fig.lwidth);
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis 20 35]);
set(gca,'XTick',fig.xtick);
xlabel(fig.xlabel);
legend('MC1525 1mbs','MC4939 2.5mbs','MC4940 10mbs','MC19 15 mbs');
title({['Density at 18m (in kg/m^3)']});

set(AX(:,1:2),'xticklabel',[])

set(findall(gcf,'type','text'),'FontSize',fig.txtfonts)