clc;clear all;
%close all

%% Load matfiles

% adcp
mooring = '12m';
load('d:\sabinerijnsbur\Matlab\adcp\adcp18.mat');
load('d:\sabinerijnsbur\Matlab\adcp\Tidal_analysis\TC18.mat');
adcp = adcp18;
TC   = TC18;

% instruments mooring
dirin = 'd:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\';

if strcmp(mooring,'12m');
    load([dirin,'SBE1526.mat']);
    load([dirin,'SBE1527.mat']);
    load([dirin,'SBE5425.mat']);
    load([dirin,'SBE5426.mat']);
    load([dirin,'SBE1842_corrected.mat']);
    in.fld  = {'SBE1526','SBE1527','SBE5425','SBE5426','SBE1842'};
    in.ylim = [0 15];
elseif strcmp(mooring,'18m')
    load([dirin,'SBE1525.mat']);
    load([dirin,'SBE4939.mat']);
    load([dirin,'SBE4940.mat']);
    load([dirin,'SBE19_corrected.mat']);
    in.fld  = {'SBE1525','SBE4939','SBE4940','SBE19'};
    in.ylim = [0 20];
else
end

% dirin = 'd:\sabinerijnsbur\Matlab\Moorings\';
% 
% load([dirin,'SBE1525.mat']);
% load([dirin,'SBE1526.mat']);
% load([dirin,'SBE1527.mat']);
% load([dirin,'SBE5425.mat']);
% load([dirin,'SBE5426.mat']);
% load([dirin,'SBE1842.mat']);
% load([dirin,'SBE4939.mat']);
% load([dirin,'SBE4940.mat']);
% load([dirin,'SBE19.mat']);

% conditions
load('d:\sabinerijnsbur\Matlab\MegaPex\Conditions\wave.mat');
load('d:\sabinerijnsbur\Matlab\MegaPex\Conditions\tide.mat');
load('d:\sabinerijnsbur\Matlab\MegaPex\Conditions\wind.mat');
load('d:\sabinerijnsbur\Matlab\MegaPex\Conditions\potwind.mat');

%% Save figure or not

dir_out   = 'd:\sabinerijnsbur\Matlab\Figures\';
save_plot = 'no';

%% Input for figure
fig.xlabel      = 'day in year';
fig.lwidth      = 1;
fig.fonts       = 8;
fig.txtfonts    = 8;
fig.xaxis       = [259 adcp.t(end)];
fig.xtick       = 259:1:adcp.t(end);
fig.trange      = '259-end';
fig.xlim        = [259 adcp.t(end)];
fig.ylim        = in.ylim; %depth z
fig.ydens       = [11 24];
fig.ytickdens   = 11:2:24;
fig.color       = 'b'; % color lines conditions
fig.legendloc   = 'SouthEast';
fig.legendorien = 'horizontal';
fig.position    =  mooring;
fig.fname       = ['AllinOneEllipticity' mooring fig.trange];% figure of all information in one figure
fig.fname2      = ['Dens-vel-ellipticity-' mooring fig.trange];% figure of density and velocities

%% Plot AllinOne with ellipticity
fig_handle1 = figure;
AX = subplot_meshgrid(2,7,[.08 0.01 0.08],[.05 .015 .015 .015 .015 .015 .015 .05],[nan 0.02],[nan nan nan nan nan nan nan]);
axes(AX(1,1))
plot(T1.t,T1.ssh,'b','linewidth',fig.lwidth);
hold on
plot(adcp.t,adcp.meanva,'--k','linewidth',fig.lwidth);
hline(0,'k');
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis -1 1.5]);
axis([fig.xaxis -1 1.5]);
xlim(fig.xlim);
legend('Water level (m)','Alongshore velocity (m/s)');
legend('Location',fig.legendloc,'Orientation',fig.legendorien);
title([fig.position]);

if strcmp(mooring,'12m');
    axes(AX(1,2))
    plot(SBE1527.t10,SBE1527.dens10-1000,'linewidth',fig.lwidth);
    hold on
    plot(SBE1526.t10,SBE1526.dens10-1000,'--r','linewidth',fig.lwidth);
    plot(SBE5426.t10,SBE5426.dens10-1000,'-.k','linewidth',fig.lwidth);
    plot(SBE5425.t10,SBE5425.dens10-1000,'c','linewidth',fig.lwidth);
    plot(SBE1842.t10,SBE1842.dens10-1000,'g','linewidth',fig.lwidth);
    set(gca,'Fontsize',fig.fonts);
    axis([fig.xaxis fig.ydens]);
    xlim(fig.xlim);
    set(gca,'YTick',fig.ytickdens);
    set(gca,'XTick',fig.xtick);
    ylabel('Rel. Density (kg/m^3)');
    legend('MC1527 1mbs','MC1526 3mbs','MC5426 7mbs','MC5425 8mbs','MC1842 10.5mbs');
    legend('Location',fig.legendloc,'Orientation',fig.legendorien);
elseif strcmp(mooring,'18m')
    axes(AX(1,2))
    plot(SBE1525.t,SBE1525.dens-1000,'linewidth',fig.lwidth);
    hold on
    plot(SBE4939.t,SBE4939.dens-1000,'--r','linewidth',fig.lwidth);
    plot(SBE4940.t,SBE4940.dens-1000,'-.k','linewidth',fig.lwidth);
    plot(SBE19.t,SBE19.dens-1000,'c','linewidth',fig.lwidth);
    set(gca,'Fontsize',fig.fonts);
    axis([fig.xaxis fig.ydens]);
    xlim(fig.xlim);
    set(gca,'YTick',fig.ytickdens);
    set(gca,'XTick',fig.xtick);
    ylabel('Rel. Density (kg/m^3');
    legend('MC1525 1mbs','MC4939 2.5mbs','MC4940 10mbs','MC19 15 mbs');
    legend('Location',fig.legendloc,'Orientation',fig.legendorien);
end

axes(AX(1,3))
pcolorcorcen(adcp.t,adcp.z,adcp.va);
hold on
plot(adcp.t,adcp.h,'k');
set(gca,'Fontsize',fig.fonts);
% ylim(fig.ylim);
% xlim(fig.xlim);
axis([fig.xaxis fig.ylim]);
xlim(fig.xlim);
set(gca,'XTick',fig.xtick);
clim([-1.5 1.5]);
% datetick('x');
colorbarwithvtext('v (along)','vert','position',get(AX(2,3),'position'));
colormap(colormapbluewhitered);
ylabel('Depth (mab)','Fontsize',fig.fonts);

axes(AX(1,4))
pcolorcorcen(adcp.t,adcp.z,adcp.vc);
hold on
plot(adcp.t,adcp.h,'k');
set(gca,'Fontsize',fig.fonts);
% ylim(fig.ylim);
% xlim(fig.xlim);
axis([fig.xaxis fig.ylim]);
xlim(fig.xlim);
set(gca,'XTick',fig.xtick);
clim([-0.5 0.5]);
% datetick('x');
colorbarwithvtext('u (cross)','vert','position',get(AX(2,4),'position'));
colormap(colormapbluewhitered);
set(gca,'Fontsize',fig.fonts);
ylabel('Depth (mab)','Fontsize',fig.fonts);

axes(AX(1,5))
pcolorcorcen(adcp.t(TC.times),adcp.z,TC.minor./TC.major)
hold on
plot(adcp.t,adcp.h)
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis fig.ylim]);
set(gca,'XTick',fig.xtick);
xlim(fig.xlim);
clim([-0.6 0.6]);
colorbarwithvtext('ecc','vert','position',get(AX(2,5),'position'));
colormap(colormapbluewhitered);
ylabel('Depth (mab)','Fontsize',fig.fonts);
% title({[T.comp,', position ', fig.position, ' tstep =', num2str(T.tstep)]})

% axes(AX(1,6))
% plot(wind.t,wind.speed,fig.color,'linewidth',fig.lwidth);
% grid on
% hold on
% axis([fig.xaxis 0 20]);
% set(gca,'Xtick',fig.xtick);
% xlim(fig.xlim);
% set(gca,'YTick',[0 5 10 15 20]);
% set(gca,'Fontsize',fig.fonts);
% ylabel('(m/s)','Fontsize',fig.fonts);
% 
% axes(AX(1,7))
% plot(wind.t,wind.dir10,fig.color,'linewidth',fig.lwidth);
% grid on
% hold on
% axis([fig.xaxis 0 360]);
% set(gca,'Xtick',fig.xtick);
% xlim(fig.xlim);
% set(gca,'YTick',[0 90 180 270 360]);
% set(gca,'Fontsize',fig.fonts);
% ylabel('dir (\circ)','Fontsize',fig.fonts);

axes(AX(1,6))
h1 = quiver(wind.t,wind.t*0,-wind.speed10.*sin((wind.dir10*pi)/180),-wind.speed10.*cos((wind.dir10*pi)/180));
set(gca,'YTickLabel',[]);
grid on
hold on
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis -1 1]);
set(gca,'Xtick',fig.xtick);
% set(gca,'YTick',[0 5 10 15 20]);
xlim(fig.xlim);
set(gca,'Fontsize',fig.fonts);
ylabel('Wind','Fontsize',fig.fonts);

axes(AX(1,7))
plot(Hs.t,Hs.hs,fig.color,'linewidth',fig.lwidth);
grid on
hold on
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis 0 3]);
set(gca,'Xtick',fig.xtick);
xlim(fig.xlim);
set(gca,'YTick',[0 0.5 1 1.5 2 2.5 3]);
ylabel('Hs (m)','Fontsize',fig.fonts);
xlabel('Day of year');

% axes(AX(1,8))
% plot(Tm0.t,Tm0.tm0,fig.color,'linewidth',fig.lwidth);
% grid on
% hold on
% axis([fig.xaxis 0 8]);
% set(gca,'Xtick',fig.xtick);
% set(gca,'YTick',[0 2 4 6 8]);
% set(gca,'Fontsize',fig.fonts);
% ylabel('Tm0 (sec)','Fontsize',fig.fonts);
% xlabel([fig.xlabel],'Fontsize',fig.fonts);

set(AX(:,1:6),'xticklabel',[])
set(AX(2,:),'yticklabel',[])
delete(AX(2,1))
delete(AX(2,2))
delete(AX(2,3))
delete(AX(2,4))
delete(AX(2,5))
delete(AX(2,6))
delete(AX(2,7))
% delete(AX(2,8))

all_ha1 = findobj(fig_handle1,'type','axes','tag','');
linkaxes(all_ha1,'x');

if strcmp(save_plot,'yes')
print2a4([dir_out,fig.fname],'v','w');
end

%% 
fhandle = figure;
AX = subplot_meshgrid(2,4,[.08 0.01 0.08],[.05 .01 .01 .01 .05],[nan 0.02],[nan nan nan nan]);
if strcmp(mooring,'12m');
    axes(AX(1,1))
    plot(SBE1527.t10,SBE1527.dens10-1000,'linewidth',fig.lwidth);
    hold on
    plot(SBE1526.t10,SBE1526.dens10-1000,'--r','linewidth',fig.lwidth);
    plot(SBE5426.t10,SBE5426.dens10-1000,'-.k','linewidth',fig.lwidth);
    plot(SBE5425.t10,SBE5425.dens10-1000,'c','linewidth',fig.lwidth);
    plot(SBE1842.t10,SBE1842.dens10-1000,'g','linewidth',fig.lwidth);
    set(gca,'Fontsize',fig.fonts);
    axis([fig.xaxis fig.ydens]);
    xlim(fig.xlim);
    set(gca,'YTick',fig.ytickdens);
    set(gca,'XTick',fig.xtick);
    ylabel('Rel. Density (kg/m^3)');
    legend('MC1527 1mbs','MC1526 3mbs','MC5426 7mbs','MC5425 8mbs','MC1842 10.5mbs');
    legend('Location',fig.legendloc,'Orientation',fig.legendorien);
elseif strcmp(mooring,'18m')
    axes(AX(1,1))
    plot(SBE1525.t,SBE1525.dens-1000,'linewidth',fig.lwidth);
    hold on
    plot(SBE4939.t,SBE4939.dens-1000,'--r','linewidth',fig.lwidth);
    plot(SBE4940.t,SBE4940.dens-1000,'-.k','linewidth',fig.lwidth);
    plot(SBE19.t,SBE19.dens-1000,'c','linewidth',fig.lwidth);
    set(gca,'Fontsize',fig.fonts);
    axis([fig.xaxis fig.ydens]);
    xlim(fig.xlim);
    set(gca,'YTick',fig.ytickdens);
    set(gca,'XTick',fig.xtick);
    ylabel('Rel. Density (kg/m^3');
    legend('MC1525 1mbs','MC4939 2.5mbs','MC4940 10mbs','MC19 15 mbs');
    legend('Location',fig.legendloc,'Orientation',fig.legendorien);
end

axes(AX(1,2))
pcolorcorcen(adcp.t,adcp.z,adcp.va);
hold on
plot(adcp.t,adcp.h,'k');
set(gca,'Fontsize',fig.fonts);
% ylim(fig.ylim);
% xlim(fig.xlim);
axis([fig.xaxis fig.ylim]);
xlim(fig.xlim);
set(gca,'XTick',fig.xtick);
clim([-1.5 1.5]);
% datetick('x');
colorbarwithvtext('v (along)','vert','position',get(AX(2,2),'position'));
ylabel('Depth (mab)','Fontsize',fig.fonts);

axes(AX(1,3))
pcolorcorcen(adcp.t,adcp.z,adcp.vc);
hold on
plot(adcp.t,adcp.h,'k');
set(gca,'Fontsize',fig.fonts);
% ylim(fig.ylim);
% xlim(fig.xlim);
axis([fig.xaxis fig.ylim]);
xlim(fig.xlim);
set(gca,'XTick',fig.xtick);
clim([-0.5 0.5]);
% datetick('x');
colorbarwithvtext('u (cross)','vert','position',get(AX(2,3),'position'));

axes(AX(1,4))
pcolorcorcen(adcp.t(TC.times),adcp.z,TC.minor./TC.major)
hold on
plot(adcp.t,adcp.h)
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis fig.ylim]);
set(gca,'XTick',fig.xtick);
xlim(fig.xlim);
clim([-0.4 0.6]);
colorbarwithvtext('ecc','vert','position',get(AX(2,4),'position'));
ylabel('Depth (mab)','Fontsize',fig.fonts);

set(AX(:,1:3),'xticklabel',[])
set(AX(2,:),'yticklabel',[])
delete(AX(2,1))
delete(AX(2,2))
delete(AX(2,3))
delete(AX(2,4))

% all_ha = findobj(fhandle,'type','axes','tag','');
% linkaxes(all_ha,'x');

%% Plot density, ellipticity and velocities
fhandle2 = figure;
AX = subplot_meshgrid(2,4,[.08 0.01 0.08],[.05 .01 .01 .01 .05],[nan 0.02],[nan nan nan nan]);
if strcmp(mooring,'12m');
    axes(AX(1,1));
    plot(SBE1527.t10,SBE1527.dens10-1000,'linewidth',fig.lwidth);
    hold on
    plot(SBE1526.t10,SBE1526.dens10-1000,'--r','linewidth',fig.lwidth);
    plot(SBE5426.t10,SBE5426.dens10-1000,'-.k','linewidth',fig.lwidth);
    plot(SBE5425.t10,SBE5425.dens10-1000,'c','linewidth',fig.lwidth);
    plot(SBE1842.t10,SBE1842.dens10-1000,'g','linewidth',fig.lwidth);
    axis([fig.xaxis fig.ydens]);
    set(gca,'YTick',fig.ytickdens);
    set(gca,'XTick',fig.xtick);
    xlim(fig.xlim);
    ylabel('Rel. Density (kg/m^3)');
    legend('MC1527 1mbs','MC1526 3mbs','MC5426 7mbs','MC5425 8mbs','MC1842 10.5mbs');
    legend('Location',fig.legendloc,'Orientation',fig.legendorien);
    title([fig.position]);
    set(gca,'Fontsize',fig.fonts);
elseif strcmp(mooring,'18m')
    axes(AX(1,1));
    plot(SBE1525.t,SBE1525.dens-1000,'linewidth',fig.lwidth);
    hold on
    plot(SBE4939.t,SBE4939.dens-1000,'--r','linewidth',fig.lwidth);
    plot(SBE4940.t,SBE4940.dens-1000,'-.k','linewidth',fig.lwidth);
    plot(SBE19.t,SBE19.dens-1000,'c','linewidth',fig.lwidth);
    set(gca,'Fontsize',fig.fonts);
    axis([fig.xaxis fig.ydens]);
    set(gca,'YTick',fig.ytickdens);
    set(gca,'XTick',fig.xtick);
    xlim(fig.xlim);
    ylabel('Rel. Density (kg/m^3');
    legend('MC1525 1mbs','MC4939 2.5mbs','MC4940 10mbs','MC19 15 mbs');
    legend('Location',fig.legendloc,'Orientation',fig.legendorien);
    title([fig.position]);
end

axes(AX(1,2));
pcolorcorcen(adcp.t(TC.times),adcp.z,TC.minor./TC.major)
hold on
plot(adcp.t,adcp.h)
axis([fig.xaxis fig.ylim]);
set(gca,'XTick',fig.xtick);
xlim(fig.xlim);
clim([-0.4 0.6]);
colorbarwithvtext('ecc','vert','position',get(AX(2,2),'position'));
set(gca,'fontsize',fig.fonts);
ylabel('Depth (mab)','Fontsize',fig.fonts);
% title({[T.comp,', position ', fig.position, ' tstep =', num2str(T.tstep)]});

axes(AX(1,3));
pcolorcorcen(adcp.t,adcp.z,adcp.va);
hold on
plot(adcp.t,adcp.h,'k');
% ylim(fig.ylim);
% xlim(fig.xlim);
axis([fig.xaxis fig.ylim]);
set(gca,'XTick',fig.xtick);
xlim(fig.xlim);
clim([-1.5 1.5]);
% datetick('x');
colorbarwithvtext('v (along)','vert','position',get(AX(2,3),'position'));
set(gca,'Fontsize',fig.fonts);
ylabel('Depth (mab)','Fontsize',fig.fonts);

axes(AX(1,4));
pcolorcorcen(adcp.t,adcp.z,adcp.vc);
hold on
plot(adcp.t,adcp.h,'k');
% ylim(fig.ylim);
% xlim(fig.xlim);
axis([fig.xaxis fig.ylim]);
set(gca,'XTick',fig.xtick);
xlim(fig.xlim);
clim([-0.5 0.5]);
% datetick('x');
colorbarwithvtext('u (cross)','vert','position',get(AX(2,4),'position'));
set(gca,'Fontsize',fig.fonts);
ylabel('Depth (mab)','Fontsize',fig.fonts);
xlabel('Day of year');

set(AX(:,1:3),'xticklabel',[])
set(AX(2,:),'yticklabel',[])
delete(AX(2,1))
delete(AX(2,2))
delete(AX(2,3))
delete(AX(2,4))

% all_ha2 = findobj(fhandle2,'type','axes','tag','');
% linkaxes(all_ha2, 'x' );

if strcmp(save_plot,'yes')
print2a4([dir_out,fig.fname2],'v','w');
end


