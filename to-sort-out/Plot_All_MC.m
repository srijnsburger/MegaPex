clc;clear all;
close all

%% Load matfiles

% adcp
mooring = '12m';
load('d:\sabinerijnsbur\Matlab\adcp\adcp12C.mat');
adcp = adcp12C;

% instruments mooring
dirin = 'd:\sabinerijnsbur\Matlab\Moorings\Mfiles\';

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

% conditions
load('d:\sabinerijnsbur\Matlab\Megapex\Conditions\wave.mat');
load('d:\sabinerijnsbur\Matlab\Megapex\Conditions\tide.mat');
load('d:\sabinerijnsbur\Matlab\Megapex\Conditions\wind.mat');
load('d:\sabinerijnsbur\Matlab\Megapex\Conditions\potwind.mat');

%% tide due to pressure

ssh = adcp.h - mean(adcp.h);

%% Save figure or not

dir_out   = 'd:\sabinerijnsbur\Matlab\Figures\';
save_plot = 'no';

%% Input for figure
fig.xlabel      = 'day in year';
fig.lwidth      = 1;
fig.fonts       = 13;
fig.txtfonts    = 13;
fig.xlim        = [260.25 261.5];
fig.xtick       = 259.5:0.25:adcp.t(end);
fig.xaxis       = [259.5 adcp.t(end)];
% fig.xtick       = 259.5:0.25:adcp.t(end);
fig.trange      = '259-end';
fig.ylim        = in.ylim; %depth z
fig.ydens       = [12.5 25];% relative density range
fig.ytickdens   = 12.5:2.5:25;
fig.color       = 'b'; % color lines conditions
fig.legendloc   = 'SouthEast';
fig.legendorien = 'horizontal';
fig.position    =  mooring;
fig.fname       = ['AllinOne' mooring fig.trange];% figure of all information in one figure
fig.fname2      = ['Dens-and-vel' mooring fig.trange];% figure of density and velocities

%% Figure All in One

fhandle = figure;
AX = subplot_meshgrid(2,6,[.06 0.01 0.05],[.03 .01 .01 .01 .01 .01 .03],[nan 0.02],[nan nan nan nan nan nan]);
axes(AX(1,1))
plot(T1.t(T1.neap1),T1.ssh(T1.neap1),'r');
hold on
grid on
plot(T1.t(T1.spr1),T1.ssh(T1.spr1),'b');
plot(T1.t(T1.neap2),T1.ssh(T1.neap2),'r');
plot(T1.t(T1.spr2),T1.ssh(T1.spr2),'b');
plot(T1.t(T1.neap3),T1.ssh(T1.neap3),'r');
plot(T1.t(T1.spr3),T1.ssh(T1.spr3),'b');
plot(T1.t(T1.neap4),T1.ssh(T1.neap4),'r');
plot(adcp.t,adcp.meanva,'--k','linewidth',fig.lwidth);
plot(adcp.t,ssh,'--m');
hline(0,'k');
set(gca,'Fontsize',fig.fonts);
% axis([fig.xaxis -1 1.5]);
% axis([fig.xaxis -1 1.5]);
xlim(fig.xlim);
ylim([-1 1.5]);
% legend('Water level (m)','Alongshore velocity (m/s)');
% legend('Location',fig.legendloc,'Orientation',fig.legendorien);
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
%     axis([fig.xaxis fig.ydens]);
%     set(gca,'YTick',fig.ytickdens);
%     set(gca,'XTick',fig.xtick);
    xlim(fig.xlim);
    ylim([fig.ydens]);
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
%     axis([fig.xaxis fig.ydens]);
%     set(gca,'YTick',fig.ytickdens);
%     set(gca,'XTick',fig.xtick);
    xlim(fig.xlim);
    ylim([fig.ydens]);
    ylabel('Rel. Density (kg/m^3');
    legend('MC1525 1mbs','MC4939 2.5mbs','MC4940 10mbs','MC19 15 mbs');
    legend('Location',fig.legendloc,'Orientation',fig.legendorien);
end

axes(AX(1,3))
pcolorcorcen(adcp.t,adcp.z,adcp.va);
hold on
plot(adcp.t,adcp.h,'k');
% ylim(fig.ylim);
% xlim(fig.xlim);
% axis([fig.xaxis fig.ylim]);
% set(gca,'XTick',fig.xtick);
xlim(fig.xlim);
ylim([fig.ylim]);
clim([-1.5 1.5]);
% datetick('x');
colorbarwithvtext('v (along)','vert','position',get(AX(2,3),'position'));
colormap(colormapbluewhitered);
set(gca,'Fontsize',fig.fonts);
ylabel('Depth (mab)','Fontsize',fig.fonts);

axes(AX(1,4))
pcolorcorcen(adcp.t,adcp.z,adcp.vc);
hold on
plot(adcp.t,adcp.h,'k');
% ylim(fig.ylim);
% xlim(fig.xlim);
% axis([fig.xaxis fig.ylim]);
% set(gca,'XTick',fig.xtick);
xlim(fig.xlim);
ylim([fig.ylim]);
clim([-0.5 0.5]);
% datetick('x');
colorbarwithvtext('u (cross)','vert','position',get(AX(2,4),'position'));
colormap(colormapbluewhitered);
set(gca,'Fontsize',fig.fonts);
ylabel('Depth (mab)','Fontsize',fig.fonts);

axes(AX(1,5))
plot(wind.t,wind.speed,fig.color,'linewidth',fig.lwidth);
grid on
hold on
% axis([fig.xaxis 0 20]);
% set(gca,'Xtick',fig.xtick);
% set(gca,'YTick',[0 5 10 15 20]);
xlim(fig.xlim);
ylim([0 20]);
set(gca,'Fontsize',fig.fonts);
ylabel('(m/s)','Fontsize',fig.fonts);

axes(AX(1,6))
plot(wind.t,wind.dir10,fig.color,'linewidth',fig.lwidth);
grid on
hold on
% axis([fig.xaxis 0 360]);
% set(gca,'Xtick',fig.xtick);
% set(gca,'YTick',[0 90 180 270 360]);
xlim(fig.xlim);
ylim([0 360]);
set(gca,'YTick',[0 90 180 270 360]);
set(gca,'Fontsize',fig.fonts);
ylabel('dir (\circ)','Fontsize',fig.fonts);

% axes(AX(1,7))
% plot(Hs.t,Hs.hs,fig.color,'linewidth',fig.lwidth);
% grid on
% hold on
% axis([fig.xaxis 0 3]);
% set(gca,'Xtick',fig.xtick);
% set(gca,'YTick',[0 0.5 1 1.5 2 2.5 3]);
% xlim(fig.xlim);
% set(gca,'Fontsize',fig.fonts);
% ylabel('Hs (m)','Fontsize',fig.fonts);
% 
% axes(AX(1,8))
% plot(Tm0.t,Tm0.tm0,fig.color,'linewidth',fig.lwidth);
% grid on
% hold on
% axis([fig.xaxis 0 8]);
% set(gca,'Xtick',fig.xtick);
% set(gca,'YTick',[0 2 4 6 8]);
% xlim(fig.xlim);
% set(gca,'Fontsize',fig.fonts);
% ylabel('Tm0 (sec)','Fontsize',fig.fonts);
% xlabel([fig.xlabel],'Fontsize',fig.fonts);

set(AX(:,1:5),'xticklabel',[])
set(AX(2,:),'yticklabel',[])
delete(AX(2,1))
delete(AX(2,2))
delete(AX(2,3))
delete(AX(2,4))
delete(AX(2,5))
delete(AX(2,6))
% delete(AX(2,7))
% delete(AX(2,8))

set(gcf,'color','w');

h = findobj(fhandle,'type','axes','tag','');
linkaxes(h,'x');
% 
% if strcmp(save_plot,'yes')
% print2a4([dir_out,fig.fname],'v','w');
% end

%% Dens & vel

fhandle2 = figure;
AX = subplot_meshgrid(2,3,[.06 0.01 0.05],[.02 .014 .014 .04],[nan 0.022],[nan nan nan]);
axes(AX(1,1))
if strcmp(mooring,'12m');
    axes(AX(1,1))
    plot(SBE1527.t10,SBE1527.dens10-1000,'linewidth',fig.lwidth);
    hold on
    plot(SBE1526.t10,SBE1526.dens10-1000,'--r','linewidth',fig.lwidth);
    plot(SBE5426.t10,SBE5426.dens10-1000,'-.k','linewidth',fig.lwidth);
    plot(SBE5425.t10,SBE5425.dens10-1000,'c','linewidth',fig.lwidth);
    plot(SBE1842.t10,SBE1842.dens10-1000,'g','linewidth',fig.lwidth);
    set(gca,'Fontsize',fig.fonts);
%     axis([fig.xaxis fig.ydens]);
%     set(gca,'YTick',fig.ytickdens);
%     set(gca,'XTick',fig.xtick);
    xlim(fig.xlim);
    ylim([fig.ydens]);
    ylabel('Rel. Density (kg/m^3)','Fontsize',fig.fonts);
    legend('1mbs','3mbs','7mbs','8mbs','10.5mbs');
    legend('Location',fig.legendloc,'Orientation',fig.legendorien);
%     title('12m');
elseif strcmp(mooring,'18m')
    axes(AX(1,1))
    plot(SBE1525.t,SBE1525.dens-1000,'linewidth',fig.lwidth);
    hold on
    plot(SBE4939.t,SBE4939.dens-1000,'--r','linewidth',fig.lwidth);
    plot(SBE4940.t,SBE4940.dens-1000,'-.k','linewidth',fig.lwidth);
    plot(SBE19.t,SBE19.dens-1000,'c','linewidth',fig.lwidth);
    set(gca,'Fontsize',fig.fonts);
%     axis([fig.xaxis fig.ydens]);
%     set(gca,'YTick',fig.ytickdens);
%     set(gca,'XTick',fig.xtick);
    xlim(fig.xlim);
    ylim([fig.ydens]);
    ylabel('Rel. Density (kg/m^3)','Fontsize',fig.fonts);
    legend('1mbs','2.5mbs','10mbs','15 mbs');
    legend('Location',fig.legendloc,'Orientation',fig.legendorien);
%     title('18m');
end

axes(AX(1,2))
pcolorcorcen(adcp.t,adcp.z,adcp.va);
hold on
plot(adcp.t,adcp.h,'k');
% ylim(fig.ylim);
% xlim(fig.xlim);
set(gca,'Fontsize',fig.fonts);
% axis([fig.xaxis fig.ylim]);
% set(gca,'XTick',fig.xtick);
xlim(fig.xlim);
ylim([fig.ylim]);
ylabel('Depth (m)','Fontsize',fig.fonts);
clim([-1.5 1.5]);
% datetick('x');
colorbarwithvtext('v (along)','vert','position',get(AX(2,2),'position'),'Fontsize',fig.fonts);
colormap(colormapbluewhitered);

axes(AX(1,3))
pcolorcorcen(adcp.t,adcp.z,adcp.vc);
hold on
plot(adcp.t,adcp.h,'k');
% ylim(fig.ylim);
% xlim(fig.xlim);
set(gca,'Fontsize',fig.fonts);
% axis([fig.xaxis fig.ylim]);
% set(gca,'XTick',fig.xtick);
xlim(fig.xlim);
ylim([fig.ylim]);
ylabel('Depth (m)','Fontsize',fig.fonts);
clim([-0.5 0.5]);
% datetick('x');
colorbarwithvtext('u (cross)','vert','position',get(AX(2,3),'position'),'Fontsize',fig.fonts);
colormap(colormapbluewhitered);

% axes(AX(1,4))
% quiver(wind.t,wind.t*0,-wind.speed10.*sin((wind.dir10*pi)/180),-wind.speed10.*cos((wind.dir10*pi)/180));
% set(gca,'YTickLabel',[]);
% grid on
% hold on
% % axis([fig.xaxis -1 1]);
% % set(gca,'Xtick',fig.xtick);
% % set(gca,'YTick',[0 5 10 15 20]);
% xlim(fig.xlim);
% ylim([-0.5 0.5]);
% set(gca,'Fontsize',fig.fonts);
% ylabel('Wind','Fontsize',fig.fonts);

set(AX(:,1:2),'xticklabel',[])
set(AX(2,:),'yticklabel',[])
delete(AX(2,1))
delete(AX(2,2))
delete(AX(2,3))
% delete(AX(2,4))

set(gcf,'color','w');
set(findall(gcf,'type','text'),'FontSize',fig.fonts);

% hh = findobj(fhandle,'type','axes','tag','');
% linkaxes(hh,'x');

%% Dens - vel - wind

figure;
AX = subplot_meshgrid(2,4,[.06 0.01 0.05],[.02 .014 .014 .016 .04],[nan 0.022],[nan nan nan nan]);
axes(AX(1,1))
if strcmp(mooring,'12m');
    axes(AX(1,1))
    plot(SBE1527.t10,SBE1527.dens10-1000,'linewidth',fig.lwidth);
    hold on
    plot(SBE1526.t10,SBE1526.dens10-1000,'--r','linewidth',fig.lwidth);
    plot(SBE5426.t10,SBE5426.dens10-1000,'-.k','linewidth',fig.lwidth);
    plot(SBE5425.t10,SBE5425.dens10-1000,'c','linewidth',fig.lwidth);
    plot(SBE1842.t10,SBE1842.dens10-1000,'g','linewidth',fig.lwidth);
    set(gca,'Fontsize',fig.fonts);
%     axis([fig.xaxis fig.ydens]);
%     set(gca,'YTick',fig.ytickdens);
%     set(gca,'XTick',fig.xtick);
    xlim(fig.xlim);
    ylim([fig.ydens]);
    ylabel('Rel. Density (kg/m^3)','Fontsize',fig.fonts);
    legend('1mbs','3mbs','7mbs','8mbs','10.5mbs');
    legend('Location',fig.legendloc,'Orientation',fig.legendorien);
%     title('12m');
elseif strcmp(mooring,'18m')
    axes(AX(1,1))
    plot(SBE1525.t,SBE1525.dens-1000,'linewidth',fig.lwidth);
    hold on
    plot(SBE4939.t,SBE4939.dens-1000,'--r','linewidth',fig.lwidth);
    plot(SBE4940.t,SBE4940.dens-1000,'-.k','linewidth',fig.lwidth);
    plot(SBE19.t,SBE19.dens-1000,'c','linewidth',fig.lwidth);
    set(gca,'Fontsize',fig.fonts);
%     axis([fig.xaxis fig.ydens]);
%     set(gca,'YTick',fig.ytickdens);
%     set(gca,'XTick',fig.xtick);
    xlim(fig.xlim);
    ylim([fig.ydens]);
    ylabel('Rel. Density (kg/m^3)','Fontsize',fig.fonts);
    legend('1mbs','2.5mbs','10mbs','15 mbs');
    legend('Location',fig.legendloc,'Orientation',fig.legendorien);
%     title('18m');
end

axes(AX(1,2))
pcolorcorcen(adcp.t,adcp.z,adcp.va);
hold on
plot(adcp.t,adcp.h,'k');
% ylim(fig.ylim);
% xlim(fig.xlim);
set(gca,'Fontsize',fig.fonts);
% axis([fig.xaxis fig.ylim]);
% set(gca,'XTick',fig.xtick);
xlim(fig.xlim);
ylim([fig.ylim]);
ylabel('Depth (m)','Fontsize',fig.fonts);
clim([-1.5 1.5]);
% datetick('x');
colorbarwithvtext('v (along)','vert','position',get(AX(2,2),'position'),'Fontsize',fig.fonts);
colormap(colormapbluewhitered);

axes(AX(1,3))
pcolorcorcen(adcp.t,adcp.z,adcp.vc);
hold on
plot(adcp.t,adcp.h,'k');
% ylim(fig.ylim);
% xlim(fig.xlim);
set(gca,'Fontsize',fig.fonts);
% axis([fig.xaxis fig.ylim]);
% set(gca,'XTick',fig.xtick);
xlim(fig.xlim);
ylim([fig.ylim]);
ylabel('Depth (m)','Fontsize',fig.fonts);
clim([-0.5 0.5]);
% datetick('x');
colorbarwithvtext('u (cross)','vert','position',get(AX(2,3),'position'),'Fontsize',fig.fonts);
colormap(colormapbluewhitered);

axes(AX(1,4))
quiver(wind.t,wind.t*0,-wind.speed10.*sin((wind.dir10*pi)/180),-wind.speed10.*cos((wind.dir10*pi)/180));
set(gca,'YTickLabel',[]);
grid on
hold on
% axis([fig.xaxis -1 1]);
% set(gca,'Xtick',fig.xtick);
% set(gca,'YTick',[0 5 10 15 20]);
xlim(fig.xlim);
ylim([-0.5 0.5]);
set(gca,'Fontsize',fig.fonts);
ylabel('Wind','Fontsize',fig.fonts);

set(AX(:,1:3),'xticklabel',[])
set(AX(2,:),'yticklabel',[])
delete(AX(2,1))
delete(AX(2,2))
delete(AX(2,3))
delete(AX(2,4))

set(gcf,'color','w');
set(findall(gcf,'type','text'),'FontSize',fig.fonts);

% hh = findobj(fhandle,'type','axes','tag','');
% linkaxes(hh,'x');
