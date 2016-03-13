%Plot ADCP data:
% 1. North and East velocities (m/s)
% 2. TKE production
% 3. Reynolds stresses

clc,clear all,close all

% Load data
load('D:\sabinerijnsbur\Matlab\adcp\adcp18');
load('D:\sabinerijnsbur\Matlab\adcp\cfg18');
adcp = adcp18;
cfg  = cfg18;

position  = '18m';
save_plot = 'yes';
dir_out   = 'd:\sabinerijnsbur\Matlab\Figures\ADCP_frames\';

%% Settings figure

fig.fonts       = 8;
fig.txtfonts    = 8;
fig.clim_vel    = [-1 1];
fig.clim_tke    = [-4 1];
fig.clim_rs     = [-0.0006,0.0006];
fig.xlabel      = 'day in year';
% fig.xtick       = 259:2:floor(adcp.t(end));
fig.z           = adcp.z; % height above bed
% fig.z           = adcp.ranges; % bins
fig.h           = adcp.h; % height sea surface above bed
% fig.h           = adcp.depth; % height sea surface above instrument

if strcmp(position,'12m')
    fig.xtick       = 259:2:floor(adcp.t(end));
else
    fig.xtick       = 259:1:floor(adcp.t(end));
end

%% Plot NS and EW velocities (quick and dirty)

figure;
subplot(2,1,1)
pcolor(adcp.t,fig.z,adcp.north_vel)
hold on
plot(adcp.t,fig.h,'k')
set(gca,'XTick',fig.xtick);
set(gca,'fontsize',fig.fonts);
shading flat
colorbar('fontsize',fig.fonts);
caxis(fig.clim_vel); 
ylabel('z (m)');
title({['North velocities',' ',position,' ','(in m/s)'];'+ is northwards'});

subplot(2,1,2)
pcolor(adcp.t,fig.z,adcp.east_vel)
hold on
plot(adcp.t,fig.h,'k')
set(gca,'XTick',fig.xtick);
set(gca,'fontsize',fig.fonts);
shading flat
colorbar('fontsize',fig.fonts);
caxis(fig.clim_vel); 
xlabel(fig.xlabel);
ylabel('z (m)');
title({['East velocities',' ',position,' ','(in m/s)'];'+ is eastward'});
set(findall(gcf,'type','text'),'FontSize',fig.txtfonts)

if strcmp(save_plot,'yes')
    set(gcf, 'PaperUnits', 'centimeters');
    set(gcf, 'PaperSize', [16 16]);
    set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperPosition', [0 0 16 16]);
    set(gcf,'Renderer','opengl');
    print(gcf, '-dpng','-r2000',[dir_out 'adcp' position 'nsew.png']);
end

%% TKE production

produc1

figure;
pcolor(adcp.t,fig.z,log10(P))
hold on
plot(adcp.t,fig.h,'k')
set(gca,'XTick',fig.xtick);
set(gca,'fontsize',fig.fonts);
shading flat
caxis(fig.clim_tke); colorbar('fontsize',fig.fonts);
xlabel(fig.xlabel);
ylabel('z (m)');
title(['TKE production',' ',position]);
set(findall(gcf,'type','text'),'FontSize',fig.txtfonts)

if strcmp(save_plot,'yes')
    set(gcf, 'PaperUnits', 'centimeters');
    set(gcf, 'PaperSize', [16 16]);
    set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperPosition', [0 0 16 16]);
    set(gcf,'Renderer','opengl');
    print(gcf, '-dpng','-r2000',[dir_out 'tke' position '.png']);
end

%% Reynolds stresses

figure; 
subplot(2,1,1)
pcolor(adcp.t,fig.z,adcp.vw_str)
hold on
plot(adcp.t,fig.h,'k')
set(gca,'XTick',fig.xtick);
set(gca,'fontsize',fig.fonts);
shading flat
caxis(fig.clim_rs);colorbar('fontsize',fig.fonts);
ylabel('z (m)');
title(['v`w`',' at ',position]);

subplot(2,1,2)
pcolor(adcp.t,fig.z,adcp.vw_str)
hold on
plot(adcp.t,fig.h,'k')
set(gca,'XTick',fig.xtick);
set(gca,'fontsize',fig.fonts);
shading flat
caxis(fig.clim_rs);colorbar('fontsize',fig.fonts);
xlabel(fig.xlabel);
ylabel('z (m)');
title(['u`w`',' at ',position]);

set(findall(gcf,'type','text'),'FontSize',fig.txtfonts)

if strcmp(save_plot,'yes')
    set(gcf, 'PaperUnits', 'centimeters');
    set(gcf, 'PaperSize', [16 16]);
    set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperPosition', [0 0 16 16]);
    set(gcf,'Renderer','opengl');
    print(gcf, '-dpng','-r2000',[dir_out 'Reynolsstress' position '.png']);
end
