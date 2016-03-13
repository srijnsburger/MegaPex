%Plot ADCP data
clc,clear all,close all

% load('adcp12');
% load('cfg12');

position = '12m';

% load('d:\sabinerijnsbur\Measurements\MegaPEX 2014 deployment\A18 mini-lander ADCP frame instrument data\1200KHz ADCP SN12224\adcp18');
% load('d:\sabinerijnsbur\Measurements\MegaPEX 2014 deployment\A18 mini-lander ADCP frame instrument data\1200KHz ADCP SN12224\cfg18');
% position = '18m';

%% Plot NS and EW velocities (quick and dirty)

figure;
subplot(2,1,1)
pcolor(adcp.t,cfg.ranges,adcp.north_vel)
hold on
plot(adcp.t,adcp.depth,'k')
set(gca,'XTick',259:1:floor(adcp.t(end)));
set(gca,'fontsize',8);
shading flat
colorbar('fontsize',8);
caxis([-1 1]); 
ylabel('z (m)');
title({['North velocities',' ',position,' ','(in m/s)'];'+ is northwards'});

subplot(2,1,2)
pcolor(adcp.t,cfg.ranges,adcp.east_vel)
hold on
plot(adcp.t,adcp.depth,'k')
set(gca,'XTick',259:1:floor(adcp.t(end)));
set(gca,'fontsize',8);
shading flat
colorbar('fontsize',8);
caxis([-1 1]); 
xlabel('day in year');
ylabel('z (m)');
title({['East velocities',' ',position,' ','(in m/s)'];'+ is eastward'});

set(gca,'FontSize',8)
set(findall(gcf,'type','text'),'FontSize',8)
set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperSize', [16 16]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperPosition', [0 0 16 16]);
set(gcf,'Renderer','painters');
print(gcf, '-dpdf',['A12CTD2099.pdf']);

%% TKE production

produc1

figure;
pcolor(adcp.mtime-datenum(14,9,16),cfg.ranges,log10(P))
hold on
plot(adcp.mtime-datenum(14,9,16),adcp.depth,'k')
set(gca,'fontsize',16);
shading flat
caxis([-4 1]); colorbar('fontsize',16);
xlabel('t (days)');
ylabel('z (m)');
title(['TKE production',' ',position]);

%% Reynolds stresses

figure; 
subplot(2,1,1)
pcolor(adcp.mtime-datenum(14,9,16),cfg.ranges,adcp.vw_str)
hold on
plot(adcp.mtime-datenum(14,9,16),adcp.depth,'k')
set(gca,'fontsize',16);
shading flat
caxis([-0.0006,0.0006]);colorbar('fontsize',16);
ylabel('z (m)');
title(['v`w`',' at ',position]);

subplot(2,1,2)
pcolor(adcp.mtime-datenum(14,9,16),cfg.ranges,adcp.vw_str)
hold on
plot(adcp.mtime-datenum(14,9,16),adcp.depth,'k')
set(gca,'fontsize',16);
shading flat
caxis([-0.0006,0.0006]);colorbar('fontsize',16);
xlabel('t (days)');
ylabel('z (m)');
title(['u`w`',' at ',position]);


