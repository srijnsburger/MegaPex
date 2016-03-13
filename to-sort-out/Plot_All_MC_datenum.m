clc;
clear all;
close all;

%% Load matfiles

% adcp
mooring = '12m';
load('d:\sabinerijnsbur\Matlab\adcp\adcp12C.mat');
adcp = adcp12C;

% instruments mooring
dirin = 'd:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\';

if strcmp(mooring,'12m');
    load([dirin,'SBE1526.mat']);
    load([dirin,'SBE1527.mat']);
    load([dirin,'SBE5425.mat']);
    load([dirin,'SBE5426.mat']);
    load([dirin,'SBE1842_corrected.mat']);
%     in.fld  = {'SBE1526','SBE1527','SBE5425','SBE5426','SBE1842'};
    in.ylim = [0 15];
elseif strcmp(mooring,'18m')
    load([dirin,'SBE1525.mat']);
    load([dirin,'SBE4939.mat']);
    load([dirin,'SBE4940.mat']);
    load([dirin,'SBE19_corrected.mat']);
    load([dirin,'OBS3A578.mat']);
%     in.fld  = {'SBE1525','SBE4939','SBE4940','SBE19'};
    in.ylim = [0 20];
else
end

% conditions
load('d:\sabinerijnsbur\Matlab\MegaPex\Conditions\wave.mat');
load('d:\sabinerijnsbur\Matlab\MegaPex\Conditions\tide.mat');
load('d:\sabinerijnsbur\Matlab\MegaPex\Conditions\wind.mat');
load('d:\sabinerijnsbur\Matlab\MegaPex\Conditions\potwind.mat');

%% Save figure or not

dir_out   = 'd:\sabinerijnsbur\Matlab\Figures\';
save_plot = 'no';

%% Zero crossing for semi-diurnal tidal cycle

[zc]  = Zero_crossing(T1.t,T1.ssh);

%% 
t1 = datenum(2014,09,16,00,00,00);
t2 = datenum(2014,10,16,18,00,00);
dt = (1/24)*2;

%% Input for figure
fig.xlabel      = 'day of year';
fig.lwidth      = 1;
fig.fonts       = 13;
fig.txtfonts    = 13;
% fig.xaxis       = [datenum(2014,09,17,00,00,00) datenum(2014,09,19,00,00,00)];
fig.xlim        = [t1 t2];
fig.xaxis       = [t1 t2];
fig.xtick       = t1:dt:t2;
fig.trange      = [datestr(t1,'dd-mm') '-' datestr(t2,'dd-mm')];
fig.ylim        = in.ylim; %depth z
fig.ydens       = [9.5 25];% relative density range
fig.ytickdens   = 9.5:2.5:25;
fig.color       = 'b'; % color lines conditions
fig.legendloc   = 'SouthEast';
fig.legendorien = 'horizontal';
fig.position    =  mooring;
fig.fname       = ['AllinOne_daten_' mooring fig.trange];% figure of all information in one figure
fig.fname2      = ['Dens-and-vel_daten_' mooring fig.trange];% figure of density and velocities
fig.cvline      = '--k';

%% Figure All in One

% f = figure;
AX = subplot_meshgrid(2,8,[.06 0.01 0.05],[.03 .01 .01 .01 .01 .01 .01 .01 .03],[nan 0.02],[nan nan nan nan nan nan nan nan]);
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
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis -1.5 1.5]);
axis([fig.xaxis -1.5 1.5]);
set(gca,'YTick',-1.5:0.5:1.5);
set(gca,'XTick',fig.xtick);
datetick('x','dd/mm HH:MM','keepticks');
% legend('Water level (m)','Alongshore velocity (m/s)');
legend('Location',fig.legendloc,'Orientation',fig.legendorien);
title([fig.position '  ' datestr(t1,'dd/mm/yy') ' - ' datestr(t2,'dd/mm/yy')]);

if strcmp(mooring,'12m');
    axes(AX(1,2))
    plot(SBE1527.time10,SBE1527.dens10-1000,'linewidth',fig.lwidth);
    hold on
    grid on
    plot(SBE1526.time10,SBE1526.dens10-1000,'--r','linewidth',fig.lwidth);
    plot(SBE5426.time10,SBE5426.dens10-1000,'-.k','linewidth',fig.lwidth);
    plot(SBE5425.time10,SBE5425.dens10-1000,'c','linewidth',fig.lwidth);
    plot(SBE1842.time10,SBE1842.dens10-1000,'g','linewidth',fig.lwidth);
    h = vline(T1.time(zc),fig.cvline);
    set(gca,'Fontsize',fig.fonts);
    axis([fig.xaxis fig.ydens]);
    set(gca,'YTick',fig.ytickdens);
    set(gca,'XTick',fig.xtick);
    datetick('x','dd/mm HH:MM','keepticks');
    ylabel('Rel. Density (kg/m^3)');
    legend('MC1527 1mbs','MC1526 3mbs','MC5426 7mbs','MC5425 8mbs','MC1842 10.5mbs');
    legend('Location',fig.legendloc,'Orientation',fig.legendorien);
elseif strcmp(mooring,'18m')
    axes(AX(1,2))
    plot(SBE1525.time10,SBE1525.dens10-1000,'linewidth',fig.lwidth);
    hold on
    grid on
    plot(SBE4939.time10,SBE4939.dens10-1000,'--r','linewidth',fig.lwidth);
    plot(SBE4940.time10,SBE4940.dens10-1000,'-.k','linewidth',fig.lwidth);
    plot(SBE19.time10,SBE19.dens10-1000,'c','linewidth',fig.lwidth);
    h = vline(T1.time(zc),fig.cvline);
    set(gca,'Fontsize',fig.fonts);
    axis([fig.xaxis fig.ydens]);
    set(gca,'YTick',fig.ytickdens);
    set(gca,'XTick',fig.xtick);
    datetick('x','dd/mm HH:MM','keepticks');
    ylabel('Rel. Density (kg/m^3');
    legend('MC1525 1mbs','MC4939 2.5mbs','MC4940 10mbs','MC19 15 mbs');
    legend('Location',fig.legendloc,'Orientation',fig.legendorien);
end

axes(AX(1,3))
pcolorcorcen(adcp.time,adcp.z,adcp.va);
hold on
grid on
plot(adcp.time,adcp.h,'k');
h = vline(T1.time(zc),fig.cvline);
% ylim(fig.ylim);
% xlim(fig.xlim);
axis([fig.xaxis fig.ylim]);
set(gca,'XTick',fig.xtick);
datetick('x','dd/mm HH:MM','keepticks');
colormap(colormapbluewhitered);
clim([-1.5 1.5]);
% datetick('x');
colorbarwithvtext('v (along)','vert','position',get(AX(2,3),'position'));
set(gca,'Fontsize',fig.fonts);
ylabel('Depth (mab)','Fontsize',fig.fonts);

axes(AX(1,4))
pcolorcorcen(adcp.time,adcp.z,adcp.vc);
hold on
grid on
plot(adcp.time,adcp.h,'k');
h = vline(T1.time(zc),fig.cvline);
% ylim(fig.ylim);
% xlim(fig.xlim);
axis([fig.xaxis fig.ylim]);
set(gca,'XTick',fig.xtick);
datetick('x','dd/mm HH:MM','keepticks');
colormap(colormapbluewhitered);
clim([-0.5 0.5]);
% datetick('x');
colorbarwithvtext('u (cross)','vert','position',get(AX(2,4),'position'));
set(gca,'Fontsize',fig.fonts);
ylabel('Depth (mab)','Fontsize',fig.fonts);

axes(AX(1,5))
plot(wind.time,wind.speed,fig.color,'linewidth',fig.lwidth);
grid on
hold on
h = vline(T1.time(zc),fig.cvline);
axis([fig.xaxis 0 20]);
set(gca,'Xtick',fig.xtick);
datetick('x','dd/mm HH:MM','keepticks');
set(gca,'YTick',[0 5 10 15 20]);
set(gca,'Fontsize',fig.fonts);
ylabel('(m/s)','Fontsize',fig.fonts);

axes(AX(1,6))
plot(wind.time,wind.dir10,fig.color,'linewidth',fig.lwidth);
grid on
hold on
h = vline(T1.time(zc),fig.cvline);
axis([fig.xaxis 0 360]);
set(gca,'Xtick',fig.xtick);
datetick('x','dd/mm HH:MM','keepticks');
set(gca,'YTick',[0 90 180 270 360]);
set(gca,'Fontsize',fig.fonts);
ylabel('dir (\circ)','Fontsize',fig.fonts);

axes(AX(1,7))
plot(Hs.time,Hs.hs,fig.color,'linewidth',fig.lwidth);
grid on
hold on
h = vline(T1.time(zc),fig.cvline);
axis([fig.xaxis 0 3]);
set(gca,'Xtick',fig.xtick);
datetick('x','dd/mm HH:MM','keepticks');
set(gca,'YTick',[0 0.5 1 1.5 2 2.5 3]);
set(gca,'Fontsize',fig.fonts);
ylabel('Hs (m)','Fontsize',fig.fonts);

axes(AX(1,8))
plot(Tm0.time,Tm0.tm0,fig.color,'linewidth',fig.lwidth);
grid on
hold on
h = vline(T1.time(zc),fig.cvline);
axis([fig.xaxis 0 8]);
set(gca,'Xtick',fig.xtick);
datetick('x','dd/mm HH:MM','keepticks');
set(gca,'YTick',[0 2 4 6 8]);
set(gca,'Fontsize',fig.fonts);
ylabel('Tm0 (sec)','Fontsize',fig.fonts);
xlabel([fig.xlabel],'Fontsize',fig.fonts);

set(AX(:,1:7),'xticklabel',[])
set(AX(2,:),'yticklabel',[])
delete(AX(2,1))
delete(AX(2,2))
delete(AX(2,3))
delete(AX(2,4))
delete(AX(2,5))
delete(AX(2,6))
delete(AX(2,7))
delete(AX(2,8))

set(gcf,'Color','w');
% hand = findobj(f,'type','axes','tag','');
% linkaxes([hand],'x');

if strcmp(save_plot,'yes')
print2a4([dir_out,fig.fname],'v','w');
end

%% Plot Density & vel

figure;
AX = subplot_meshgrid(2,3,[.08 0.01 0.06],[.03 .03 .03 .06],[nan 0.03],[nan nan nan]);
if strcmp(mooring,'12m');
    axes(AX(1,1))
    plot(SBE1527.time10,SBE1527.dens10-1000,'linewidth',fig.lwidth);
    hold on
    grid on
    plot(SBE1526.time10,SBE1526.dens10-1000,'--r','linewidth',fig.lwidth);
    plot(SBE5426.time10,SBE5426.dens10-1000,'-.k','linewidth',fig.lwidth);
    plot(SBE5425.time10,SBE5425.dens10-1000,'c','linewidth',fig.lwidth);
    plot(SBE1842.time10,SBE1842.dens10-1000,'g','linewidth',fig.lwidth);
    %     h = vline(T1.time(zc),fig.cvline);
    %     axis([fig.xaxis fig.ydens]);
    %     set(gca,'YTick',fig.ytickdens);
    set(gca,'XTick',fig.xtick);
    xlim(fig.xlim);
    ylim(fig.ydens);
    datetick('x','HH:MM','keepticks');
    set(gca,'Fontsize',fig.fonts);
    ylabel('Rel. Density (kg/m^3)');
    legend('1mbs','3mbs','7mbs','8mbs','10.5mbs');
    legend('Location',fig.legendloc,'Orientation',fig.legendorien);
%     title([fig.position '  ' datestr(t1,'dd/mm/yy') ' - ' datestr(t2,'dd/mm/yy')]);
elseif strcmp(mooring,'18m')
    axes(AX(1,1))
    plot(SBE1525.time10,SBE1525.dens10-1000,'linewidth',fig.lwidth);
    hold on
    grid on
    plot(SBE4939.time10,SBE4939.dens10-1000,'--r','linewidth',fig.lwidth);
    plot(SBE4940.time10,SBE4940.dens10-1000,'-.k','linewidth',fig.lwidth);
    plot(SBE19.time10,SBE19.dens10-1000,'c','linewidth',fig.lwidth);
    %     h = vline(T1.time(zc),fig.cvline);
    %     axis([fig.xaxis fig.ydens]);
    %     set(gca,'YTick',fig.ytickdens);
    set(gca,'XTick',fig.xtick);
    xlim(fig.xlim);
    ylim(fig.ydens);
    datetick('x','HH:MM','keepticks');
    set(gca,'Fontsize',fig.fonts);
    ylabel('Rel. Density (kg/m^3');
    legend('MC1525 1mbs','MC4939 2.5mbs','MC4940 10mbs','MC19 15 mbs');
    legend('Location',fig.legendloc,'Orientation',fig.legendorien);
%     title([fig.position '  ' datestr(t1,'dd/mm/yy') ' - ' datestr(t2,'dd/mm/yy')]);
end

axes(AX(1,2))
pcolorcorcen(adcp.time,adcp.z,adcp.va);
hold on
grid on
plot(adcp.time,adcp.h,'k');
% vline(T1.time(zc),fig.cvline);
xlim(fig.xlim);
ylim(fig.ylim);
set(gca,'Fontsize',fig.fonts);
% axis([fig.xaxis fig.ylim]);
set(gca,'XTick',fig.xtick);
datetick('x','HH:MM','keepticks');
ylabel('Depth (mab)','Fontsize',fig.fonts);
clim([-1.5 1.5]);
colorbarwithvtext('v (along)','vert','position',get(AX(2,2),'position'),'Fontsize',fig.fonts);
colormap(colormapbluewhitered);


axes(AX(1,3))
pcolorcorcen(adcp.time,adcp.z,adcp.vc);
hold on
grid on
plot(adcp.time,adcp.h,'k');
% vline(T1.time(zc),fig.cvline);
% ylim(fig.ylim);
% xlim(fig.xlim);
set(gca,'Fontsize',fig.fonts);
% axis([fig.xaxis fig.ylim]);
set(gca,'XTick',fig.xtick);
xlim(fig.xlim);
ylim(fig.ylim);
datetick('x','HH:MM','keepticks');
ylabel('Depth (mab)','Fontsize',fig.fonts);
clim([-0.5 0.5]);
% datetick('x');
colorbarwithvtext('u (cross)','vert','position',get(AX(2,3),'position'),'Fontsize',fig.fonts);
colormap(colormapbluewhitered);

set(AX(:,1:2),'xticklabel',[])
set(AX(2,:),'yticklabel',[])
delete(AX(2,1))
delete(AX(2,2))
delete(AX(2,3))

set(gcf,'color','w');
set(findall(gcf,'type','text'),'FontSize',fig.fonts);

% h = findobj(f,'type','axes','tag','');
% linkaxes(h,'x');

%% 
% fhandle = figure;
% AX = subplot_meshgrid(2,4,[.06 0.01 0.05],[.03 .03 .03 .03 .03],[nan 0.02],[nan nan nan nan]);
% axes(AX(1,1))
% plot(T1.time(T1.neap1),T1.ssh(T1.neap1),'r','linewidth',fig.lwidth);
% hold on
% grid on
% plot(T1.time(T1.spr1),T1.ssh(T1.spr1),'b','linewidth',fig.lwidth);
% plot(T1.time(T1.neap2),T1.ssh(T1.neap2),'r','linewidth',fig.lwidth);
% plot(T1.time(T1.spr2),T1.ssh(T1.spr2),'b','linewidth',fig.lwidth);
% plot(T1.time(T1.neap3),T1.ssh(T1.neap3),'r','linewidth',fig.lwidth);
% plot(T1.time(T1.spr3),T1.ssh(T1.spr3),'b','linewidth',fig.lwidth);
% plot(T1.time(T1.neap4),T1.ssh(T1.neap4),'r','linewidth',fig.lwidth);
% plot(adcp.time,adcp.meanva,'--k','linewidth',fig.lwidth);
% hline(0,'k');
% h = vline(T1.time(zc),fig.cvline);
% set(gca,'Fontsize',fig.fonts);
% axis([fig.xaxis -1.5 1.5]);
% axis([fig.xaxis -1.5 1.5]);
% set(gca,'YTick',-1.5:0.5:1.5);
% set(gca,'XTick',fig.xtick);
% datetick('x','HH:MM','keepticks');
% % legend('Water level (m)','Alongshore velocity (m/s)');
% legend('Location',fig.legendloc,'Orientation',fig.legendorien);
% title([fig.position '  ' datestr(t1,'dd/mm/yy') ' - ' datestr(t2,'dd/mm/yy')]);
% 
% if strcmp(mooring,'12m');
%     axes(AX(1,2))
%     plot(SBE1527.time10,SBE1527.dens10-1000,'linewidth',fig.lwidth);
%     hold on
%     grid on
%     plot(SBE1526.time10,SBE1526.dens10-1000,'--r','linewidth',fig.lwidth);
%     plot(SBE5426.time10,SBE5426.dens10-1000,'-.k','linewidth',fig.lwidth);
%     plot(SBE5425.time10,SBE5425.dens10-1000,'c','linewidth',fig.lwidth);
%     plot(SBE1842.time10,SBE1842.dens10-1000,'g','linewidth',fig.lwidth);
%     h = vline(T1.time(zc),fig.cvline);
%     axis([fig.xaxis fig.ydens]);
%     set(gca,'YTick',fig.ytickdens);
%     set(gca,'XTick',fig.xtick);
%     datetick('x','HH:MM','keepticks');
%     set(gca,'Fontsize',fig.fonts);
%     ylabel('Rel. Density (kg/m^3)');
%     legend('MC1527 1mbs','MC1526 3mbs','MC5426 7mbs','MC5425 8mbs','MC1842 10.5mbs');
%     legend('Location',fig.legendloc,'Orientation',fig.legendorien);
% elseif strcmp(mooring,'18m')
%     axes(AX(1,2))
%     plot(SBE1525.time10,SBE1525.dens10-1000,'linewidth',fig.lwidth);
%     hold on
%     grid on
%     plot(SBE4939.time10,SBE4939.dens10-1000,'--r','linewidth',fig.lwidth);
%     plot(SBE4940.time10,SBE4940.dens10-1000,'-.k','linewidth',fig.lwidth);
%     plot(SBE19.time10,SBE19.dens10-1000,'c','linewidth',fig.lwidth);
%     h = vline(T1.time(zc),fig.cvline);
%     axis([fig.xaxis fig.ydens]);
%     set(gca,'YTick',fig.ytickdens);
%     set(gca,'XTick',fig.xtick);
%     datetick('x','HH:MM','keepticks');
%     set(gca,'Fontsize',fig.fonts);
%     ylabel('Rel. Density (kg/m^3');
%     legend('MC1525 1mbs','MC4939 2.5mbs','MC4940 10mbs','MC19 15 mbs');
%     legend('Location',fig.legendloc,'Orientation',fig.legendorien);
% end
% 
% axes(AX(1,3))
% pcolorcorcen(adcp.time,adcp.z,adcp.va);
% hold on
% grid on
% plot(adcp.time,adcp.h,'k');
% h = vline(T1.time(zc),fig.cvline);
% % ylim(fig.ylim);
% % xlim(fig.xlim);
% axis([fig.xaxis fig.ylim]);
% set(gca,'XTick',fig.xtick);
% datetick('x','HH:MM','keepticks');
% clim([-1.5 1.5]);
% % datetick('x');
% colorbarwithvtext('v (along)','vert','position',get(AX(2,3),'position'));
% set(gca,'Fontsize',fig.fonts);
% ylabel('Depth (mab)','Fontsize',fig.fonts);
% 
% axes(AX(1,4))
% pcolorcorcen(adcp.time,adcp.z,adcp.vc);
% hold on
% grid on
% plot(adcp.time,adcp.h,'k');
% h = vline(T1.time(zc),fig.cvline);
% % ylim(fig.ylim);
% % xlim(fig.xlim);
% axis([fig.xaxis fig.ylim]);
% set(gca,'XTick',fig.xtick);
% datetick('x','HH:MM','keepticks');
% clim([-0.5 0.5]);
% % datetick('x');
% colorbarwithvtext('u (cross)','vert','position',get(AX(2,4),'position'));
% set(gca,'Fontsize',fig.fonts);
% ylabel('Depth (mab)','Fontsize',fig.fonts);
% 
% set(AX(:,1:3),'xticklabel',[])
% set(AX(2,:),'yticklabel',[])
% delete(AX(2,1))
% delete(AX(2,2))
% delete(AX(2,3))
% delete(AX(2,4))
% 
% set(gcf,'Color','w');

% allh = findobj(fhandle,'type','axes','tag','');
% linkaxes(allh,'x');

%% 
figure;
h1 = subplot(4,1,1);
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
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis -1.5 1.5]);
axis([fig.xaxis -1.5 1.5]);
set(gca,'YTick',-1.5:0.5:1.5);
set(gca,'XTick',fig.xtick);
datetick('x','dd/mm HH:MM','keepticks');
title([fig.position '  ' datestr(t1,'dd/mm/yy') ' - ' datestr(t2,'dd/mm/yy')]);
colorbar

if strcmp(mooring,'12m');
    h2 = subplot(4,1,2);
    plot(SBE1527.time10,SBE1527.dens10-1000,'linewidth',fig.lwidth);
    hold on
    grid on
    plot(SBE1526.time10,SBE1526.dens10-1000,'--r','linewidth',fig.lwidth);
    plot(SBE5426.time10,SBE5426.dens10-1000,'-.k','linewidth',fig.lwidth);
    plot(SBE5425.time10,SBE5425.dens10-1000,'c','linewidth',fig.lwidth);
    plot(SBE1842.time10,SBE1842.dens10-1000,'g','linewidth',fig.lwidth);
    h = vline(T1.time(zc),fig.cvline);
    axis([fig.xaxis fig.ydens]);
    set(gca,'YTick',fig.ytickdens);
    set(gca,'XTick',fig.xtick);
    datetick('x','dd/mm HH:MM','keepticks');
    set(gca,'Fontsize',fig.fonts);
    ylabel('Rel. Density (kg/m^3)');
    legend('MC1527 1mbs','MC1526 3mbs','MC5426 7mbs','MC5425 8mbs','MC1842 10.5mbs');
    legend('Location',fig.legendloc,'Orientation',fig.legendorien);
    colorbar
elseif strcmp(mooring,'18m')
    h2 = subplot(4,1,2);
    plot(SBE1525.time10,SBE1525.dens10-1000,'linewidth',fig.lwidth);
    hold on
    grid on
    plot(SBE4939.time10,SBE4939.dens10-1000,'--r','linewidth',fig.lwidth);
    plot(OBS3A578.time10,OBS3A578.dens10-1000,':m','linewidth',fig.lwidth);
    plot(SBE4940.time10,SBE4940.dens10-1000,'-.k','linewidth',fig.lwidth);
    plot(SBE19.time10,SBE19.dens10-1000,'c','linewidth',fig.lwidth);
    h = vline(T1.time(zc),fig.cvline);
    axis([fig.xaxis fig.ydens]);
    set(gca,'YTick',fig.ytickdens);
    set(gca,'XTick',fig.xtick);
    datetick('x','dd/mm HH:MM','keepticks');
    set(gca,'Fontsize',fig.fonts);
    ylabel('Rel. Density (kg/m^3');
    legend('MC1525 1mbs','MC4939 2.5mbs','OBS3A 5mbs','MC4940 10mbs','MC19 15 mbs');
    legend('Location',fig.legendloc,'Orientation',fig.legendorien);
    colorbar
end

h3 = subplot(4,1,3);
pcolorcorcen(adcp.time,adcp.z,adcp.va);
hold on
grid on
plot(adcp.time,adcp.h,'k');
h = vline(T1.time(zc),fig.cvline);
% ylim(fig.ylim);
% xlim(fig.xlim);
axis([fig.xaxis fig.ylim]);
set(gca,'XTick',fig.xtick);
datetick('x','dd/mm HH:MM','keepticks');
colormap(colormapbluewhitered);
colorbar
clim([-1.5 1.5]);
% datetick('x');
% colorbarwithvtext('v (along)','vert','position',get(AX(2,2),'position'));
set(gca,'Fontsize',fig.fonts);
ylabel('Depth (mab)','Fontsize',fig.fonts);

h4 = subplot(4,1,4);
pcolorcorcen(adcp.time,adcp.z,adcp.vc);
hold on
grid on
plot(adcp.time,adcp.h,'k');
h = vline(T1.time(zc),fig.cvline);
% ylim(fig.ylim);
% xlim(fig.xlim);
axis([fig.xaxis fig.ylim]);
set(gca,'XTick',fig.xtick);
datetick('x','dd/mm HH:MM','keepticks');
colorbar
% colormap(colormapbluewhitered);
clim([-0.5 0.5]);
% datetick('x');
% colorbarwithvtext('u (cross)','vert','position',get(AX(2,3),'position'));
set(gca,'Fontsize',fig.fonts);
ylabel('Depth (mab)','Fontsize',fig.fonts);

linkaxes([h1,h2,h3,h4],'x');
set(gcf,'Color','w');

%% 



figure;
hh1 = subplot(5,1,1);
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
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis -1.5 1.5]);
axis([fig.xaxis -1.5 1.5]);
set(gca,'YTick',-1.5:0.5:1.5);
set(gca,'XTick',fig.xtick);
datetick('x','dd/mm HH:MM','keepticks');
title([fig.position '  ' datestr(t1,'dd/mm/yy') ' - ' datestr(t2,'dd/mm/yy')]);
colorbar

if strcmp(mooring,'12m');
    hh2 = subplot(5,1,2);
    plot(SBE1527.time10,SBE1527.dens10-1000,'linewidth',fig.lwidth);
    hold on
    grid on
    plot(SBE1526.time10,SBE1526.dens10-1000,'--r','linewidth',fig.lwidth);
    plot(SBE5426.time10,SBE5426.dens10-1000,'-.k','linewidth',fig.lwidth);
    plot(SBE5425.time10,SBE5425.dens10-1000,'c','linewidth',fig.lwidth);
    plot(SBE1842.time10,SBE1842.dens10-1000,'g','linewidth',fig.lwidth);
    h = vline(T1.time(zc),fig.cvline);
    axis([fig.xaxis fig.ydens]);
    set(gca,'YTick',fig.ytickdens);
    set(gca,'XTick',fig.xtick);
    datetick('x','dd/mm HH:MM','keepticks');
    set(gca,'Fontsize',fig.fonts);
    ylabel('Rel. Density (kg/m^3)');
    legend('MC1527 1mbs','MC1526 3mbs','MC5426 7mbs','MC5425 8mbs','MC1842 10.5mbs');
    legend('Location',fig.legendloc,'Orientation',fig.legendorien);
    colorbar
elseif strcmp(mooring,'18m')
    hh2 = subplot(5,1,2);
    plot(SBE1525.time10,SBE1525.dens10-1000,'linewidth',fig.lwidth);
    hold on
    grid on
    plot(SBE4939.time10,SBE4939.dens10-1000,'--r','linewidth',fig.lwidth);
    plot(OBS3A578.time10,OBS3A578.dens10-1000,':m','linewidth',fig.lwidth);
    plot(SBE4940.time10,SBE4940.dens10-1000,'-.k','linewidth',fig.lwidth);
    plot(SBE19.time10,SBE19.dens10-1000,'c','linewidth',fig.lwidth);
    h = vline(T1.time(zc),fig.cvline);
    axis([fig.xaxis fig.ydens]);
    set(gca,'YTick',fig.ytickdens);
    set(gca,'XTick',fig.xtick);
    datetick('x','dd/mm HH:MM','keepticks');
    set(gca,'Fontsize',fig.fonts);
    ylabel('Rel. Density (kg/m^3');
    legend('MC1525 1mbs','MC4939 2.5mbs','OBS3A 5mbs','MC4940 10mbs','MC19 15 mbs');
    legend('Location',fig.legendloc,'Orientation',fig.legendorien);
    colorbar
end

hh3 = subplot(5,1,3);
pcolorcorcen(adcp.time,adcp.z,adcp.va);
hold on
grid on
plot(adcp.time,adcp.h,'k');
h = vline(T1.time(zc),fig.cvline);
% ylim(fig.ylim);
% xlim(fig.xlim);
axis([fig.xaxis fig.ylim]);
set(gca,'XTick',fig.xtick);
datetick('x','dd/mm HH:MM','keepticks');
colormap(colormapbluewhitered);
colorbar
clim([-1.5 1.5]);
% datetick('x');
% colorbarwithvtext('v (along)','vert','position',get(AX(2,2),'position'));
set(gca,'Fontsize',fig.fonts);
ylabel('Depth (mab)','Fontsize',fig.fonts);

hh4 = subplot(5,1,4);
pcolorcorcen(adcp.time,adcp.z,adcp.vc);
hold on
grid on
plot(adcp.time,adcp.h,'k');
h = vline(T1.time(zc),fig.cvline);
% ylim(fig.ylim);
% xlim(fig.xlim);
axis([fig.xaxis fig.ylim]);
set(gca,'XTick',fig.xtick);
datetick('x','dd/mm HH:MM','keepticks');
colorbar
% colormap(colormapbluewhitered);
clim([-0.5 0.5]);
% datetick('x');
% colorbarwithvtext('u (cross)','vert','position',get(AX(2,3),'position'));
set(gca,'Fontsize',fig.fonts);
ylabel('Depth (mab)','Fontsize',fig.fonts);

hh5 = subplot(5,1,5);
quiver(wind.time,wind.time*0,-wind.speed10.*sin((wind.dir10*pi)/180),-wind.speed10.*cos((wind.dir10*pi)/180));
set(gca,'YTickLabel',[]);
grid on
hold on
h = vline(T1.time(zc),fig.cvline);
% set(h,'linewidth',fig.vline);
hline(0,'k');
axis([fig.xaxis -1 1]);
set(gca,'Xtick',fig.xtick);
datetick('x','dd/mm HH:MM','keepticks');
colorbar
set(gca,'Fontsize',fig.fonts);
ylabel('Wind','Fontsize',fig.fonts);

linkaxes([hh1,hh2,hh3,hh4,hh5],'x');
set(gcf,'Color','w');