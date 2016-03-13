clc,clear all,close all

load('adcpMS');
load('cfgMS');
position = 'Mini Stable 12m';

%% Make new struct --> to run general scripts

adcp = adcpMS;
cfg  = cfgMS;

%% Remove "artificial" data (above sea surface)

backs
adcpsoundlevelclean

%% Remove peaks by hand

% threshold = 11.5;
% 
% adcp.uw_str(find(cfg.ranges>threshold),i)=NaN;
% adcp.vw_str(find(cfg.ranges>threshold),i)=NaN;
% adcp.north_vel(find(cfg.ranges>threshold),i)=NaN;
% adcp.east_vel(find(cfg.ranges>threshold),i)=NaN;
% adcp.vert_vel(find(cfg.ranges>threshold),i)=NaN;
% adcp.error_vel(find(cfg.ranges>threshold),i)=NaN;
% Sv(find(cfg.ranges>threshold),i)=NaN;

%% Plot velocities

figure
subplot(2,1,1)
pcolor(adcp.mtime-datenum(14,9,0),cfg.ranges,adcp.north_vel)
shading flat
colorbar
caxis([-1 1]); colorbar
ylabel('z (m)');
title(['NS velocities',' ',position]);

subplot(2,1,2)
pcolor(adcp.mtime-datenum(14,9,0),cfg.ranges,adcp.east_vel)
shading flat
colorbar
caxis([-1 1]); colorbar
xlabel('t (days)');
ylabel('z (m)');
title(['EW velocities',' ',position]);

%% Plot tke production (based on mean)

produc1

figure;
pcolor(adcp.mtime-datenum(14,9,0),cfg.ranges,log10(P))
% hold on
% plot(adcp.mtime-datenum(14,9,0),adcp.depth,'k')
shading flat
colorbar
caxis([-4 1]); colorbar
xlabel('t (days)');
ylabel('z (m)');
title(['TKE production',' ',position]);

%% Plot Reynolds stresses

figure; 
subplot(2,1,1)
pcolor(adcp.mtime-datenum(14,9,0),cfg.ranges,adcp.vw_str)
% hold on
% plot(adcp.mtime-datenum(14,9,0),adcp.depth,'k')
shading flat
caxis([-0.0006,0.0006]);colorbar
ylabel('z (m)');
title(['v`w`',' at ',position]);

subplot(2,1,2)
pcolor(adcp.mtime-datenum(14,9,0),cfg.ranges,adcp.vw_str)
% hold on
% plot(adcp.mtime-datenum(14,9,0),adcp.depth,'k')
shading flat
caxis([-0.0006,0.0006]);colorbar
xlabel('t (days)');
ylabel('z (m)');
title(['u`w`',' at ',position]);
