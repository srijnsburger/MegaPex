clc;clear all;close all;
% close all

%% Load matfiles

% adcp
mooring = '12m';
load('d:\sabinerijnsbur\Matlab\adcp\adcp12.mat');
adcp = adcp12;

% instruments mooring
dirin = 'd:\sabinerijnsbur\Matlab\Moorings\Mfiles\';

if strcmp(mooring,'12m');
    load([dirin,'SBE1527.mat']);
    load([dirin,'SBE1526.mat']);
    load([dirin,'OBS3A744.mat']);
    load([dirin,'SBE5425.mat']);
    load([dirin,'SBE5426.mat']);
    load([dirin,'SBE1842_corrected.mat']);
    load('d:\sabinerijnsbur\Matlab\Mini-stable\adv355');
    in.dR   = SBE1842.dens10 - SBE1527.dens10;
    in.dRs  = SBE1526.dens10 - SBE1527.dens10;
    in.dRb  = SBE1842.dens10 - SBE5425.dens10;
    in.dR2  = SBE1842.dens10 - SBE1526.dens10;
    in.time10  = SBE1527.time10;
    in.ylim = [0 15];
elseif strcmp(mooring,'18m')
    load([dirin,'SBE1525.mat']);
    load([dirin,'SBE4939.mat']);
    load([dirin,'OBS3A578.mat']);
    load([dirin,'SBE4940.mat']);
    load([dirin,'SBE19_corrected.mat']);
    in.dR   = SBE19.dens10 - SBE1525.dens10;
    in.dRs  = SBE4939.dens10 - SBE1525.dens10;
    in.dRb  = SBE19.dens10 - SBE4940.dens10;
    in.dR2  = SBE19.dens10 - SBE4939.dens10;
    in.time10  = SBE1525.time10;
    in.ylim = [0 20];
else
end

% conditions
load('d:\sabinerijnsbur\Matlab\Megapex\Conditions\wave.mat');
load('d:\sabinerijnsbur\Matlab\Megapex\Conditions\tide.mat');
load('d:\sabinerijnsbur\Matlab\Megapex\Conditions\wind.mat');
load('d:\sabinerijnsbur\Matlab\Megapex\Conditions\potwind.mat');

%% Save figure or not

dir_out   = 'd:\sabinerijnsbur\Matlab\Figures\';
save_plot = 'no';

%% Surface and bottom velocity

[vel] = surface_bottom_velocity(adcp.va,adcp.vc);

if strcmp(mooring,'12m');
    vel.bva = adv355.ba.va;
    vel.bvc = adv355.ba.vc;
    vel.time= adv355.ba.time(2:end-1);
else
    vel.time = adcp.time;
end

%% Find zero crossing tide

% [ssh] = interp1(T1.t,T1.ssh,adcp12.t);
[zc]  = Zero_crossing(T1.t,T1.ssh);

%% Define timespan

t1 = datenum(2014,09,30,00,00,00);
t2 = datenum(2014,10,19,00,00,00);
dt = (1/24)*2;

%% Input for figure

fig.xlabel      = 'day in year';
fig.lwidth      = 1;
fig.fonts       = 8;
fig.txtfonts    = 8;
fig.xlim        = [t1 t2];
fig.xaxis       = [datenum(2014,09,16,16,00,00) datenum(2014,10,29,12,00,00)];
fig.xtick       = datenum(2014,09,16,16,00,00):dt:datenum(2014,10,29,12,00,00);
fig.trange      = [datestr(t1,'dd-mm') '-' datestr(t2,'dd-mm')];
fig.ylim        = in.ylim; %depth z
fig.ydens       = [11 24];% relative density range
fig.ydr         = [-0.5 10];
fig.ytickdens   = 11:2:24;
fig.color       = 'b'; % color lines conditions
fig.legendloc   = 'SouthEast';
fig.legendorien = 'horizontal';
fig.position    =  mooring;
fig.fname       = ['AllinOne_daten_dR_tide_' mooring fig.trange];% figure of all information in one figure
fig.fname2      = ['Dens-and-vel_daten_dR_tide' mooring fig.trange];% figure of density and velocities
fig.vline       = 1; %line width vertical lines
fig.cvline      = '--k';

%% Figure All in One

fhandle = figure;
AX = subplot_meshgrid(2,7,[.06 0.01 0.05],[.03 .01 .01 .01 .01 .01 .01 .03],[nan 0.02],[nan nan nan nan nan nan nan]);
axes(AX(1,1))
plot(T1.time(T1.neap1),T1.ssh(T1.neap1),'r','linewidth',fig.lwidth);
hold on
plot(T1.time(T1.spr1),T1.ssh(T1.spr1),'b','linewidth',fig.lwidth);
plot(T1.time(T1.neap2),T1.ssh(T1.neap2),'r','linewidth',fig.lwidth);
plot(T1.time(T1.spr2),T1.ssh(T1.spr2),'b','linewidth',fig.lwidth);
plot(T1.time(T1.neap3),T1.ssh(T1.neap3),'r','linewidth',fig.lwidth);
plot(T1.time(T1.spr3),T1.ssh(T1.spr3),'b','linewidth',fig.lwidth);
plot(T1.time(T1.neap4),T1.ssh(T1.neap4),'r','linewidth',fig.lwidth);
plot(adcp.time,adcp.meanva,'--k','linewidth',fig.lwidth);
hline(0,'k');
h = vline(T1.time(zc),fig.cvline);
set(h,'linewidth',fig.vline);
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis -1.5 1.5]);
set(gca,'XTick',fig.xtick);
datetick('x','dd HH:MM','keepticks');
xlim(fig.xlim);
% legend('Water level (m)','Alongshore velocity (m/s)');
% legend('Location',fig.legendloc,'Orientation',fig.legendorien);
title([fig.position '  ' datestr(t1,'dd/mm/yy') ' - ' datestr(t2,'dd/mm/yy')]);

if strcmp(mooring,'12m');
    axes(AX(1,2))
    plot(SBE1527.time10,SBE1527.dens10-1000,'linewidth',fig.lwidth);
    hold on
    plot(SBE1526.time10,SBE1526.dens10-1000,'--r','linewidth',fig.lwidth);
    plot(OBS3A744.time10,OBS3A744.dens10-1000,'m','linewidth',fig.lwidth);
    plot(SBE5426.time10,SBE5426.dens10-1000,'-.k','linewidth',fig.lwidth);
    plot(SBE5425.time10,SBE5425.dens10-1000,'c','linewidth',fig.lwidth);
    plot(SBE1842.time10,SBE1842.dens10-1000,'g','linewidth',fig.lwidth);
    h = vline(T1.time(zc),fig.cvline);
    set(h,'linewidth',fig.vline);
    set(gca,'Fontsize',fig.fonts);
    axis([fig.xaxis fig.ydens]);
    set(gca,'YTick',fig.ytickdens);
    set(gca,'XTick',fig.xtick);
    datetick('x','dd HH:MM','keepticks');
    xlim(fig.xlim);
    ylabel('Rel. Density (kg/m^3)');
    legend('MC1527 1mbs','MC1526 3mbs','OBS3A744 5mbs','MC5426 7mbs','MC5425 8mbs','MC1842 10.5mbs');
    legend('Location',fig.legendloc,'Orientation',fig.legendorien);
elseif strcmp(mooring,'18m')
    axes(AX(1,2))
    plot(SBE1525.time10,SBE1525.dens10-1000,'linewidth',fig.lwidth);
    hold on
    plot(SBE4939.time10,SBE4939.dens10-1000,'--r','linewidth',fig.lwidth);
    plot(OBS3A578.time10,OBS3A578.dens10-1000,'m','linewidth',fig.lwidth);
    plot(SBE4940.time10,SBE4940.dens10-1000,'-.k','linewidth',fig.lwidth);
    plot(SBE19.time10,SBE19.dens10-1000,'c','linewidth',fig.lwidth);
    h = vline(T1.time(zc),fig.cvline);
    set(h,'linewidth',fig.vline);
    set(gca,'Fontsize',fig.fonts);
    axis([fig.xaxis fig.ydens]);
    set(gca,'YTick',fig.ytickdens);
    set(gca,'XTick',fig.xtick);
    datetick('x','dd HH:MM','keepticks');
    xlim(fig.xlim);
    ylabel('Rel. Density (kg/m^3');
    legend('MC1525 1mbs','MC4939 2.5mbs','OBS3A578 5mbs','MC4940 10mbs','MC19 15 mbs');
    legend('Location',fig.legendloc,'Orientation',fig.legendorien);
end

axes(AX(1,3))
plot(in.time10,in.dR,'Linewidth',fig.lwidth)
hold on
% grid on
% plot(in.t10,in.dRs,'r','Linewidth',fig.lwidth)
% plot(in.time10,in.dRb,'Color',[0 0 0],'Linewidth',fig.lwidth)
% plot(in.time10,in.dR2,'r','Linewidth',fig.lwidth)
hline(0,'k');
h = vline(T1.time(zc),fig.cvline);
set(h,'linewidth',fig.vline);
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis fig.ydr]);
% set(gca,'YTick',fig.ytickds);
set(gca,'XTick',fig.xtick);
datetick('x','dd HH:MM','keepticks');
xlim(fig.xlim);
ylabel('\Delta \rho (kg/m^3)');
legend('bottom-surface','bottom layer','bottom-3mbs');
legend('Location','NorthEast','Orientation',fig.legendorien);

axes(AX(1,4))
plot(adcp.time,vel.sva,'Linewidth',fig.lwidth)
hold on
% grid on
plot(adcp.time,vel.svc,'m','Linewidth',fig.lwidth)
hline(0,'k');
h = vline(T1.time(zc),fig.cvline);
set(h,'linewidth',fig.vline);
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis -1 1.8]);
% set(gca,'YTick',fig.ytickds);
set(gca,'XTick',fig.xtick);
datetick('x','dd HH:MM','keepticks');
xlim(fig.xlim);
legend('Along','Cross');
legend('Location','NorthEast','Orientation','horizontal');
ylabel('surface vel (m/s)');

axes(AX(1,5))
plot(vel.time,vel.bva,'Linewidth',fig.lwidth)
hold on
% grid on
plot(vel.time,vel.bvc,'m','Linewidth',fig.lwidth)
hline(0,'k');
h = vline(T1.time(zc),fig.cvline);
set(h,'linewidth',fig.vline);
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis -1 1]);
% set(gca,'YTick',fig.ytickds);
set(gca,'XTick',fig.xtick);
datetick('x','dd HH:MM','keepticks');
xlim(fig.xlim);
legend('Along','Cross');
legend('Location','NorthEast','Orientation','horizontal');
ylabel('bottom vel (m/s)');

axes(AX(1,6))
plot(wind.time,wind.speed,fig.color,'linewidth',fig.lwidth);
% grid on
hold on
h = vline(T1.time(zc),fig.cvline);
set(h,'linewidth',fig.vline);
axis([fig.xaxis 0 20]);
set(gca,'Xtick',fig.xtick);
datetick('x','dd HH:MM','keepticks');
xlim(fig.xlim);
set(gca,'YTick',[0 5 10 15 20]);
set(gca,'Fontsize',fig.fonts);
ylabel('(m/s)','Fontsize',fig.fonts);

% axes(AX(1,7))
% plot(wind.t,wind.dir10,fig.color,'linewidth',fig.lwidth);
% grid on
% hold on
% axis([fig.xaxis 0 360]);
% set(gca,'Xtick',fig.xtick);
% set(gca,'YTick',[0 90 180 270 360]);
% set(gca,'Fontsize',fig.fonts);
% ylabel('dir (\circ)','Fontsize',fig.fonts);

axes(AX(1,7))
plot(Hs.time,Hs.hs,fig.color,'linewidth',fig.lwidth);
% grid on
hold on
h = vline(T1.time(zc),fig.cvline);
set(h,'linewidth',fig.vline);
axis([fig.xaxis 0 3]);
set(gca,'Xtick',fig.xtick);
datetick('x','dd HH:MM','keepticks');
xlim(fig.xlim);
set(gca,'YTick',[0 0.5 1 1.5 2 2.5 3]);
set(gca,'Fontsize',fig.fonts);
ylabel('Hs (m)','Fontsize',fig.fonts);

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

set(gcf,'Color','w');

all_h = findobj(fhandle,'type','axes','tag','');
linkaxes(all_h,'x');

if strcmp(save_plot,'yes')
    print2a4([dir_out,fig.fname],'v','w');
end

%% Plot tide, dens, dR, bottom and surf vel

fhandle4 = figure;
AX = subplot_meshgrid(2,5,[.06 0.01 0.05],[.03 .01 .01 .01 .01 .03],[nan 0.02],[nan nan nan nan nan]);
axes(AX(1,1))
plot(T1.time(T1.neap1),T1.ssh(T1.neap1),'r','linewidth',fig.lwidth);
hold on
grid on
plot(T1.time(T1.spr1),T1.ssh(T1.spr1),'b','linewidth',fig.lwidth);
plot(T1.time(T1.neap2),T1.ssh(T1.neap2),'r','linewidth',fig.lwidth);
plot(T1.time(T1.spr2),T1.ssh(T1.spr2),'b','linewidth',fig.lwidth);
plot(T1.time(T1.neap3),T1.ssh(T1.neap3),'r','linewidth',fig.lwidth);
plot(T1.time(T1.spr3),T1.ssh(T1.spr3),'b','linewidth',fig.lwidth);
plot(T1.time(T1.neap4),T1.ssh(T1.neap4),'r','linewidth',fig.lwidth);
plot(adcp.time,adcp.meanva,'--k','linewidth',fig.lwidth);
hline(0,'k');
h = vline(T1.time(zc),fig.cvline);
set(h,'linewidth',fig.vline);
set(gca,'Fontsize',fig.fonts);
([fig.xaxis -1.5 1.5]);
set(gca,'XTick',fig.xtick);
xlim(fig.xlim);
datetick('x','dd HH:MM','keepticks');
ylim([-1.5 1.5]);
% legend('Water level (m)','Alongshore velocity (m/s)');
% legend('Location',fig.legendloc,'Orientation',fig.legendorien);
% title([fig.position '  ' datestr(t1,'dd/mm/yy') ' - ' datestr(t2,'dd/mm/yy')]);

if strcmp(mooring,'12m');
    axes(AX(1,2))
    plot(SBE1527.time10,SBE1527.dens10-1000,'linewidth',fig.lwidth);
    hold on
    grid on
    plot(SBE1526.time10,SBE1526.dens10-1000,'--r','linewidth',fig.lwidth);
    plot(OBS3A744.time10,OBS3A744.dens10-1000,'m','linewidth',fig.lwidth);
    plot(SBE5426.time10,SBE5426.dens10-1000,'-.k','linewidth',fig.lwidth);
    plot(SBE5425.time10,SBE5425.dens10-1000,'c','linewidth',fig.lwidth);
    plot(SBE1842.time10,SBE1842.dens10-1000,'g','linewidth',fig.lwidth);
    h = vline(T1.time(zc),fig.cvline);
    set(h,'linewidth',fig.vline);
    set(gca,'Fontsize',fig.fonts);
    axis([fig.xaxis fig.ydens]);
    set(gca,'YTick',fig.ytickdens);
set(gca,'XTick',fig.xtick);
xlim(fig.xlim);
    datetick('x','dd HH:MM','keepticks');
    ylim(fig.ydens);
    ylabel('Rel. Density (kg/m^3)');
    legend('MC1527 1mbs','MC1526 3mbs','OBS3A744 5mbs','MC5426 7mbs','MC5425 8mbs','MC1842 10.5mbs');
    legend('Location',fig.legendloc,'Orientation',fig.legendorien);
elseif strcmp(mooring,'18m')
    axes(AX(1,2))
    plot(SBE1525.time10,SBE1525.dens10-1000,'linewidth',fig.lwidth);
    hold on
    grid on
    plot(SBE4939.time10,SBE4939.dens10-1000,'--r','linewidth',fig.lwidth);
        plot(OBS3A578.time10,OBS3A578.dens10-1000,'m','linewidth',fig.lwidth);
    plot(SBE4940.time10,SBE4940.dens10-1000,'-.k','linewidth',fig.lwidth);
    plot(SBE19.time10,SBE19.dens10-1000,'c','linewidth',fig.lwidth);
    h = vline(T1.time(zc),fig.cvline);
    set(h,'linewidth',fig.vline);
    set(gca,'Fontsize',fig.fonts);
    axis([fig.xaxis fig.ydens]);
    set(gca,'YTick',fig.ytickdens);
     set(gca,'XTick',fig.xtick);
xlim(fig.xlim);
    datetick('x','dd HH:MM','keepticks');
ylim(fig.ydens);
    ylabel('Rel. Density (kg/m^3');
    legend('MC1525 1mbs','MC4939 2.5mbs','OBS3A578 5mbs','MC4940 10mbs','MC19 15 mbs');
    legend('Location',fig.legendloc,'Orientation',fig.legendorien);
end

axes(AX(1,3))
plot(in.time10,in.dR,'Linewidth',fig.lwidth)
hold on
grid on
% plot(in.t10,in.dRs,'r','Linewidth',fig.lwidth)
% plot(in.time10,in.dRb,'Color',[0 0 0],'Linewidth',fig.lwidth)
% plot(in.time10,in.dR2,'r','Linewidth',fig.lwidth)
hline(0,'k');
h = vline(T1.time(zc),fig.cvline);
set(h,'linewidth',fig.vline);
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis fig.ydr]);
% set(gca,'YTick',fig.ytickds);
 set(gca,'XTick',fig.xtick);
xlim(fig.xlim);
datetick('x','dd HH:MM','keepticks');
ylim([fig.ydr]);
ylabel('\Delta \rho (kg/m^3)');
legend('bottom-surface','bottom layer','bottom-3mbs');
legend('Location','NorthEast','Orientation',fig.legendorien);

axes(AX(1,4))
plot(adcp.time,vel.sva,'Linewidth',fig.lwidth)
hold on
grid on
plot(adcp.time,vel.svc,'m','Linewidth',fig.lwidth)
hline(0,'k');
h = vline(T1.time(zc),fig.cvline);
set(h,'linewidth',fig.vline);
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis -1 1.8]);
% set(gca,'YTick',fig.ytickds);
 set(gca,'XTick',fig.xtick);
xlim(fig.xlim);
datetick('x','dd HH:MM','keepticks');
ylim([-1 1.8]);
legend('Along','Cross');
legend('Location','NorthEast','Orientation','horizontal');
ylabel('surface vel (m/s)');

axes(AX(1,5))
plot(vel.time,vel.bva,'Linewidth',fig.lwidth)
hold on
grid on
plot(vel.time,vel.bvc,'m','Linewidth',fig.lwidth)
hline(0,'k');
h = vline(T1.time(zc),fig.cvline);
set(h,'linewidth',fig.vline);
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis -1 1]);
 set(gca,'XTick',fig.xtick);
xlim(fig.xlim);
datetick('x','dd HH:MM','keepticks');
ylim([-1 1]);
legend('Along','Cross');
legend('Location','NorthEast','Orientation','horizontal');
ylabel('bottom vel (m/s)');

set(AX(:,1:4),'xticklabel',[])
set(AX(2,:),'yticklabel',[])
delete(AX(2,1))
delete(AX(2,2))
delete(AX(2,3))
delete(AX(2,4))
delete(AX(2,5))

set(gcf,'Color','w');

all_h4 = findobj(fhandle4,'type','axes','tag','');
linkaxes(all_h4,'x');

%% Plot Density & vel

fhandle2 = figure;
AX = subplot_meshgrid(2,4,[.06 0.01 0.05],[.03 .01 .01 .01 .03],[nan 0.02],[nan nan nan nan]);
if strcmp(mooring,'12m');
    axes(AX(1,1))
    plot(SBE1527.time10,SBE1527.dens10-1000,'linewidth',fig.lwidth);
    hold on
    grid on
    plot(SBE1526.time10,SBE1526.dens10-1000,'--r','linewidth',fig.lwidth);
    plot(OBS3A744.time10,OBS3A744.dens10-1000,'m','linewidth',fig.lwidth);
    plot(SBE5426.time10,SBE5426.dens10-1000,'-.k','linewidth',fig.lwidth);
    plot(SBE5425.time10,SBE5425.dens10-1000,'c','linewidth',fig.lwidth);
    plot(SBE1842.time10,SBE1842.dens10-1000,'g','linewidth',fig.lwidth);
    h = vline(T1.time(zc),fig.cvline);
    set(h,'linewidth',fig.vline);
    set(gca,'Fontsize',fig.fonts);
    axis([fig.xaxis fig.ydens]);
    set(gca,'YTick',fig.ytickdens);
    set(gca,'XTick',fig.xtick);
    datetick('x','dd HH:MM','keepticks');
    xlim(fig.xlim);
    ylabel('Rel. Density (kg/m^3)');
    legend('MC1527 1mbs','MC1526 3mbs','OBS3A744 5mbs','MC5426 7mbs','MC5425 8mbs','MC1842 10.5mbs');legend('MC1527 1mbs','MC1526 3mbs','MC5426 7mbs','MC5425 8mbs','MC1842 10.5mbs');
    legend('Location',fig.legendloc,'Orientation',fig.legendorien);
    title([fig.position '  ' datestr(t1,'dd/mm/yy') ' - ' datestr(t2,'dd/mm/yy')]);
    
elseif strcmp(mooring,'18m')
    axes(AX(1,1))
    plot(SBE1525.time10,SBE1525.dens10-1000,'linewidth',fig.lwidth);
    hold on
    grid on
    plot(SBE4939.time10,SBE4939.dens10-1000,'--r','linewidth',fig.lwidth);
        plot(OBS3A578.time10,OBS3A578.dens10-1000,'m','linewidth',fig.lwidth);
    plot(SBE4940.time10,SBE4940.dens10-1000,'-.k','linewidth',fig.lwidth);
    plot(SBE19.time10,SBE19.dens10-1000,'c','linewidth',fig.lwidth);
    h = vline(T1.t(zc),fig.cvline);
    set(h,'linewidth',fig.vline);
    set(gca,'Fontsize',fig.fonts);
    axis([fig.xaxis fig.ydens]);
    set(gca,'YTick',fig.ytickdens);
    set(gca,'XTick',fig.xtick);
    datetick('x','dd HH:MM','keepticks');
    xlim(fig.xlim);
    ylabel('Rel. Density (kg/m^3)');
    legend('MC1525 1mbs','MC4939 2.5mbs','OBS3A578 5mbs','MC4940 10mbs','MC19 15 mbs');
    legend('Location',fig.legendloc,'Orientation',fig.legendorien);
    title([fig.position]);
end

axes(AX(1,2))
plot(in.time10,in.dR,'Linewidth',fig.lwidth)
hold on
grid on
% plot(in.t10,in.dRs,'r','Linewidth',fig.lwidth)
% plot(in.time10,in.dRb,'Color',[0 0 0],'Linewidth',fig.lwidth)
% plot(in.time10,in.dR2,'r','Linewidth',fig.lwidth)
hline(0,'k');
h = vline(T1.time(zc),fig.cvline);
set(h,'linewidth',fig.vline);
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis fig.ydr]);
% set(gca,'YTick',fig.ytickds);
set(gca,'XTick',fig.xtick);
datetick('x','dd HH:MM','keepticks');
xlim(fig.xlim);
ylabel('\Delta \rho (kg/m^3)');
legend('bottom-surface','bottom layer','bottom-3mbs');
legend('Location','NorthEast','Orientation',fig.legendorien);

axes(AX(1,3))
plot(adcp.time,vel.sva,'Linewidth',fig.lwidth)
hold on
grid on
plot(adcp.time,vel.svc,'m','Linewidth',fig.lwidth)
hline(0,'k');
h = vline(T1.time(zc),fig.cvline);
set(h,'linewidth',fig.vline);
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis -1 1.8]);
% set(gca,'YTick',fig.ytickds);
set(gca,'XTick',fig.xtick);
datetick('x','dd HH:MM','keepticks');
xlim(fig.xlim);
legend('Along','Cross');
legend('Location','NorthEast','Orientation','horizontal');
ylabel('surface vel (m/s)');

axes(AX(1,4))
plot(vel.time,vel.bva,'Linewidth',fig.lwidth)
hold on
grid on
plot(vel.time,vel.bvc,'m','Linewidth',fig.lwidth)
hline(0,'k');
h = vline(T1.time(zc),fig.cvline);
set(h,'linewidth',fig.vline);
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis -1 1]);
% set(gca,'YTick',fig.ytickds);
set(gca,'XTick',fig.xtick);
datetick('x','dd HH:MM','keepticks');
xlim(fig.xlim);
legend('Along','Cross');
legend('Location','NorthEast','Orientation','horizontal');
ylabel('bottom vel (m/s)');
xlabel('Day year');

set(AX(:,1:3),'xticklabel',[])
set(AX(2,:),'yticklabel',[])
delete(AX(2,1))
delete(AX(2,2))
delete(AX(2,3))
delete(AX(2,4))

set(gcf,'Color','w');

all_h2 = findobj('type','axes','tag','');
linkaxes(all_h2,'x');

if strcmp(save_plot,'yes')
    print2a4([dir_out,fig.fname2],'v','w');
end

%% 

fhandle3 = figure;
AX = subplot_meshgrid(2,4,[.06 0.01 0.05],[.03 .01 .01 .01 .03],[nan 0.02],[nan nan nan nan]);
axes(AX(1,1))
plot(T1.time(T1.neap1),T1.ssh(T1.neap1),'r','linewidth',fig.lwidth);
hold on
grid on
plot(T1.time(T1.spr1),T1.ssh(T1.spr1),'b','linewidth',fig.lwidth);
plot(T1.time(T1.neap2),T1.ssh(T1.neap2),'r','linewidth',fig.lwidth);
plot(T1.time(T1.spr2),T1.ssh(T1.spr2),'b','linewidth',fig.lwidth);
plot(T1.time(T1.neap3),T1.ssh(T1.neap3),'r','linewidth',fig.lwidth);
plot(T1.time(T1.spr3),T1.ssh(T1.spr3),'b','linewidth',fig.lwidth);
plot(T1.time(T1.neap4),T1.ssh(T1.neap4),'r','linewidth',fig.lwidth);
plot(adcp.time,adcp.meanva,'--k','linewidth',fig.lwidth);
hline(0,'k');
h = vline(T1.time(zc),fig.cvline);
set(h,'linewidth',fig.vline);
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis -1.5 1.5]);
set(gca,'XTick',fig.xtick);
datetick('x','dd HH:MM','keepticks');
xlim(fig.xlim);
% legend('Water level (m)','Alongshore velocity (m/s)');
% legend('Location',fig.legendloc,'Orientation',fig.legendorien);
title([fig.position '  ' datestr(t1,'dd/mm/yy') ' - ' datestr(t2,'dd/mm/yy')]);

if strcmp(mooring,'12m');
    axes(AX(1,2))
    plot(SBE1527.time10,SBE1527.dens10-1000,'linewidth',fig.lwidth);
    hold on
    grid on
    plot(SBE1526.time10,SBE1526.dens10-1000,'--r','linewidth',fig.lwidth);
    plot(OBS3A744.time10,OBS3A744.dens10-1000,'m','linewidth',fig.lwidth);
    plot(SBE5426.time10,SBE5426.dens10-1000,'-.k','linewidth',fig.lwidth);
    plot(SBE5425.time10,SBE5425.dens10-1000,'c','linewidth',fig.lwidth);
    plot(SBE1842.time10,SBE1842.dens10-1000,'g','linewidth',fig.lwidth);
    h = vline(T1.time(zc),fig.cvline);
    set(h,'linewidth',fig.vline);
    set(gca,'Fontsize',fig.fonts);
    axis([fig.xaxis fig.ydens]);
    set(gca,'YTick',fig.ytickdens);
    set(gca,'XTick',fig.xtick);
    datetick('x','dd HH:MM','keepticks');
    xlim(fig.xlim);
    ylabel('Rel. Density (kg/m^3)');
    legend('MC1527 1mbs','MC1526 3mbs','OBS3A744 5mbs','MC5426 7mbs','MC5425 8mbs','MC1842 10.5mbs');
    legend('Location',fig.legendloc,'Orientation',fig.legendorien);
%     title([fig.position '  ' datestr(t1,'dd/mm/yy') ' - ' datestr(t2,'dd/mm/yy')]);
    
elseif strcmp(mooring,'18m')
    axes(AX(1,2))
    plot(SBE1525.time10,SBE1525.dens10-1000,'linewidth',fig.lwidth);
    hold on
    grid on
    plot(SBE4939.time10,SBE4939.dens10-1000,'--r','linewidth',fig.lwidth);
        plot(OBS3A578.time10,OBS3A578.dens10-1000,'m','linewidth',fig.lwidth);
    plot(SBE4940.time10,SBE4940.dens10-1000,'-.k','linewidth',fig.lwidth);
    plot(SBE19.time10,SBE19.dens10-1000,'c','linewidth',fig.lwidth);
    h = vline(T1.time(zc),fig.cvline);
    set(h,'linewidth',fig.vline);
    set(gca,'Fontsize',fig.fonts);
    axis([fig.xaxis fig.ydens]);
    set(gca,'YTick',fig.ytickdens);
    set(gca,'XTick',fig.xtick);
    datetick('x','dd HH:MM','keepticks');
    xlim(fig.xlim);
    ylabel('Rel. Density (kg/m^3)');
    legend('MC1525 1mbs','MC4939 2.5mbs','OBS3A578 5mbs','MC4940 10mbs','MC19 15 mbs');
    legend('Location',fig.legendloc,'Orientation',fig.legendorien);
end

axes(AX(1,3))
plot(in.time10,in.dR,'Linewidth',fig.lwidth)
hold on
grid on
% plot(in.t10,in.dRs,'r','Linewidth',fig.lwidth)
% plot(in.time10,in.dRb,'Color',[0 0 0],'Linewidth',fig.lwidth)
% plot(in.time10,in.dR2,'r','Linewidth',fig.lwidth)
hline(0,'k');
h = vline(T1.time(zc),fig.cvline);
set(h,'linewidth',fig.vline);
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis fig.ydr]);
% set(gca,'YTick',fig.ytickds);
set(gca,'XTick',fig.xtick);
datetick('x','dd HH:MM','keepticks');
xlim(fig.xlim);
ylabel('\Delta \rho (kg/m^3)');
legend('bottom-surface','bottom layer','bottom-3mbs');
legend('Location','NorthEast','Orientation',fig.legendorien);

axes(AX(1,4))
% quiver(wind.time,wind.time*0,-wind.speed10.*sin((wind.dir10*pi)/180),-wind.speed10.*cos((wind.dir10*pi)/180));
% set(gca,'YTickLabel',[]);
% grid on
% hold on
% h = vline(T1.time(zc),fig.cvline);
% set(h,'linewidth',fig.vline);
% hline(0,'k');
% axis([fig.xaxis -1 1]);
% set(gca,'Xtick',fig.xtick);
% datetick('x','dd HH:MM','keepticks');
% xlim(fig.xlim);
% set(gca,'Fontsize',fig.fonts);
% ylabel('Wind','Fontsize',fig.fonts);
% xlabel('Day year');


set(AX(:,1:3),'xticklabel',[])
set(AX(2,:),'yticklabel',[])
delete(AX(2,1))
delete(AX(2,2))
delete(AX(2,3))
delete(AX(2,4))

set(gcf,'Color','w');

all_h3 = findobj(fhandle3,'type','axes','tag','');
linkaxes(all_h3,'x');

%% 

fhandle4 = figure;
AX = subplot_meshgrid(2,5,[.06 0.01 0.05],[.03 .01 .01 .01 .01 .03],[nan 0.02],[nan nan nan nan nan]);
axes(AX(1,1))
plot(T1.time(T1.neap1),T1.ssh(T1.neap1),'r','linewidth',fig.lwidth);
hold on
grid on
plot(T1.time(T1.spr1),T1.ssh(T1.spr1),'b','linewidth',fig.lwidth);
plot(T1.time(T1.neap2),T1.ssh(T1.neap2),'r','linewidth',fig.lwidth);
plot(T1.time(T1.spr2),T1.ssh(T1.spr2),'b','linewidth',fig.lwidth);
plot(T1.time(T1.neap3),T1.ssh(T1.neap3),'r','linewidth',fig.lwidth);
plot(T1.time(T1.spr3),T1.ssh(T1.spr3),'b','linewidth',fig.lwidth);
plot(T1.time(T1.neap4),T1.ssh(T1.neap4),'r','linewidth',fig.lwidth);
plot(adcp.time,adcp.meanva,'--k','linewidth',fig.lwidth);
hline(0,'k');
h = vline(T1.time(zc),fig.cvline);
set(h,'linewidth',fig.vline);
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis -1.5 1.5]);
set(gca,'XTick',fig.xtick);
datetick('x','dd HH:MM','keepticks');
xlim(fig.xlim);
% legend('Water level (m)','Alongshore velocity (m/s)');
% legend('Location',fig.legendloc,'Orientation',fig.legendorien);
title([fig.position '  ' datestr(t1,'dd/mm/yy') ' - ' datestr(t2,'dd/mm/yy')]);

if strcmp(mooring,'12m');
    axes(AX(1,2))
    plot(SBE1527.time10,SBE1527.dens10-1000,'linewidth',fig.lwidth);
    hold on
    grid on
    plot(SBE1526.time10,SBE1526.dens10-1000,'--r','linewidth',fig.lwidth);
    plot(OBS3A744.time10,OBS3A744.dens10-1000,'m','linewidth',fig.lwidth);
    plot(SBE5426.time10,SBE5426.dens10-1000,'-.k','linewidth',fig.lwidth);
    plot(SBE5425.time10,SBE5425.dens10-1000,'c','linewidth',fig.lwidth);
    plot(SBE1842.time10,SBE1842.dens10-1000,'g','linewidth',fig.lwidth);
    h = vline(T1.time(zc),fig.cvline);
    set(h,'linewidth',fig.vline);
    set(gca,'Fontsize',fig.fonts);
    axis([fig.xaxis fig.ydens]);
    set(gca,'YTick',fig.ytickdens);
    set(gca,'XTick',fig.xtick);
    datetick('x','dd HH:MM','keepticks');
    xlim(fig.xlim);
    ylabel('Rel. Density (kg/m^3)');
    legend('MC1527 1mbs','MC1526 3mbs','OBS3A744 5mbs','MC5426 7mbs','MC5425 8mbs','MC1842 10.5mbs');
    legend('Location',fig.legendloc,'Orientation',fig.legendorien);
%     title([fig.position '  ' datestr(t1,'dd/mm/yy') ' - ' datestr(t2,'dd/mm/yy')]);
    
elseif strcmp(mooring,'18m')
    axes(AX(1,2))
    plot(SBE1525.time10,SBE1525.dens10-1000,'linewidth',fig.lwidth);
    hold on
    grid on
    plot(SBE4939.time10,SBE4939.dens10-1000,'--r','linewidth',fig.lwidth);
        plot(OBS3A578.time10,OBS3A578.dens10-1000,'m','linewidth',fig.lwidth);
    plot(SBE4940.time10,SBE4940.dens10-1000,'-.k','linewidth',fig.lwidth);
    plot(SBE19.time10,SBE19.dens10-1000,'c','linewidth',fig.lwidth);
    h = vline(T1.time(zc),fig.cvline);
    set(h,'linewidth',fig.vline);
    set(gca,'Fontsize',fig.fonts);
    axis([fig.xaxis fig.ydens]);
    set(gca,'YTick',fig.ytickdens);
    set(gca,'XTick',fig.xtick);
    datetick('x','dd HH:MM','keepticks');
    xlim(fig.xlim);
    ylabel('Rel. Density (kg/m^3)');
    legend('MC1525 1mbs','MC4939 2.5mbs','OBS3A578 5mbs','MC4940 10mbs','MC19 15 mbs');
    legend('Location',fig.legendloc,'Orientation',fig.legendorien);
end

axes(AX(1,3))
plot(adcp.time,vel.sva,'Linewidth',fig.lwidth)
hold on
grid on
plot(adcp.time,vel.svc,'m','Linewidth',fig.lwidth)
hline(0,'k');
h = vline(T1.time(zc),fig.cvline);
set(h,'linewidth',fig.vline);
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis -1 1.8]);
% set(gca,'YTick',fig.ytickds);
set(gca,'XTick',fig.xtick);
datetick('x','dd HH:MM','keepticks');
xlim(fig.xlim);
legend('Along','Cross');
legend('Location','NorthEast','Orientation','horizontal');
ylabel('surface vel (m/s)');

axes(AX(1,4))
plot(vel.time,vel.bva,'Linewidth',fig.lwidth)
hold on
grid on
plot(vel.time,vel.bvc,'m','Linewidth',fig.lwidth)
hline(0,'k');
h = vline(T1.time(zc),fig.cvline);
set(h,'linewidth',fig.vline);
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis -1 1]);
% set(gca,'YTick',fig.ytickds);
set(gca,'XTick',fig.xtick);
datetick('x','dd HH:MM','keepticks');
xlim(fig.xlim);
legend('Along','Cross');
legend('Location','NorthEast','Orientation','horizontal');
ylabel('bottom vel (m/s)');

axes(AX(1,5))
quiver(wind.time,wind.time*0,-wind.speed10.*sin((wind.dir10*pi)/180),-wind.speed10.*cos((wind.dir10*pi)/180));
set(gca,'YTickLabel',[]);
grid on
hold on
hline(0,'k');
h = vline(T1.time(zc),fig.cvline);
set(h,'linewidth',fig.vline);
axis([fig.xaxis -1 1]);
set(gca,'Xtick',fig.xtick);
datetick('x','dd HH:MM','keepticks');
xlim(fig.xlim);
set(gca,'Fontsize',fig.fonts);
ylabel('Wind','Fontsize',fig.fonts);
xlabel('Day year');


set(AX(:,1:4),'xticklabel',[])
set(AX(2,:),'yticklabel',[])
delete(AX(2,1))
delete(AX(2,2))
delete(AX(2,3))
delete(AX(2,4))
delete(AX(2,5))

set(gcf,'Color','w');

all_h4 = findobj(fhandle4,'type','axes','tag','');
linkaxes(all_h4,'x');
