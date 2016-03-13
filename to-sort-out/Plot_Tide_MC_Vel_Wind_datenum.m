%% Plot tide, MC, vel and wind

clc; clear all; 

%% Load data
% adcp
mooring = '12m';
load('d:\sabinerijnsbur\Matlab\adcp\adcp12.mat');
adcp = adcp12;
tframe = 'datenum';

% instruments mooring
dirin = 'd:\sabinerijnsbur\Matlab\Moorings\Mfiles\';

if strcmp(mooring,'12m');
    load([dirin,'SBE1526.mat']);
    load([dirin,'SBE1527.mat']);
    load([dirin,'SBE5425.mat']);
    load([dirin,'SBE5426.mat']);
    load([dirin,'SBE1842_corrected.mat']);
    in.dR   = SBE1842.dens10 - SBE1527.dens10;
    in.dRs   = SBE1526.dens10 - SBE1527.dens10;
    in.dRb   = SBE1842.dens10 - SBE5425.dens10;
    in.dR2  = SBE1842.dens10 - SBE1526.dens10;
    in.t10  = SBE1527.t10;
    in.fld  = {'SBE1526','SBE1527','SBE5425','SBE5426','SBE1842'};
    in.ylim = [0 15];
elseif strcmp(mooring,'18m')
    load([dirin,'SBE1525.mat']);
    load([dirin,'SBE4939.mat']);
    load([dirin,'SBE4940.mat']);
    load([dirin,'SBE19_corrected.mat']);
    in.dR   = SBE19.dens10 - SBE1525.dens10;
    in.dRs   = SBE4939.dens10 - SBE1525.dens10;
    in.dRb   = SBE19.dens10 - SBE4940.dens10;
    in.dR2  = SBE19.dens10 - SBE4939.dens10;
    in.t10  = SBE1525.t10;
    in.fld  = {'SBE1525','SBE4939','SBE4940','SBE19'};
    in.ylim = [0 20];
else
end

% conditions
load('d:\sabinerijnsbur\Matlab\MegaPex\Conditions\wave.mat');
load('d:\sabinerijnsbur\Matlab\MegaPex\Conditions\tide.mat');
load('d:\sabinerijnsbur\Matlab\MegaPex\Conditions\wind.mat');
load('d:\sabinerijnsbur\Matlab\MegaPex\Conditions\potwind.mat');

%% Input time

    t1 = datenum(2014,09,17,00,00,00);
    t2 = datenum(2014,09,19,00,00,00);
    dt = (1/24)*4;

%% Input figure

fig.xlabel      = 'day in year';
fig.lwidth      = 1;
fig.fonts       = 8;
fig.txtfonts    = 8;
% fig.xlim        = [t1 t2];
fig.xaxis       = [259.5 in.t10(end)];
% fig.xtick       = 259.5:0.25:adcp.t(end);
% fig.trange      = '259-end';
fig.ylim        = in.ylim; %depth z
fig.ydens       = [12.5 25];% relative density range
fig.ytickdens   = 12.5:2.5:25;
fig.color       = 'b'; % color lines conditions
fig.legendloc   = 'SouthEast';
fig.legendorien = 'horizontal';
fig.position    =  mooring;

%% Figure

fhandle = figure;
AX = subplot_meshgrid(2,5,[.06 0.01 0.05],[.03 .01 .01 .01 .01 .03],[nan 0.02],[nan nan nan nan nan]);
axes(AX(1,1))
plot(T1.t,T1.ssh,'b','linewidth',fig.lwidth);
hold on
plot(adcp.t,adcp.meanva,'--k','linewidth',fig.lwidth);
hline(0,'k');
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis -1 1.5]);
axis([fig.xaxis -1 1.5]);
% xlim(fig.xlim);
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
    set(gca,'YTick',fig.ytickdens);
%     set(gca,'XTick',fig.xtick);
%     xlim(fig.xlim);
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
    set(gca,'YTick',fig.ytickdens);
%     set(gca,'XTick',fig.xtick);
%     xlim(fig.xlim);
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
axis([fig.xaxis fig.ylim]);
% set(gca,'XTick',fig.xtick);
% xlim(fig.xlim);
clim([-1.5 1.5]);
% datetick('x');
colorbarwithvtext('v (along)','vert','position',get(AX(2,3),'position'));
set(gca,'Fontsize',fig.fonts);
ylabel('Depth (mab)','Fontsize',fig.fonts);

axes(AX(1,4))
pcolorcorcen(adcp.t,adcp.z,adcp.vc);
hold on
plot(adcp.t,adcp.h,'k');
% ylim(fig.ylim);
% xlim(fig.xlim);
axis([fig.xaxis fig.ylim]);
% set(gca,'XTick',fig.xtick);
% xlim(fig.xlim);
clim([-0.5 0.5]);
% datetick('x');
colorbarwithvtext('u (cross)','vert','position',get(AX(2,4),'position'));
set(gca,'Fontsize',fig.fonts);
ylabel('Depth (mab)','Fontsize',fig.fonts);

axes(AX(1,5))
quiver(wind.t,wind.t*0,-wind.speed10.*sin((wind.dir10*pi)/180),-wind.speed10.*cos((wind.dir10*pi)/180));
set(gca,'YTickLabel',[]);
grid on
hold on
axis([fig.xaxis -1 1]);
% set(gca,'Xtick',fig.xtick);
% set(gca,'YTick',[0 5 10 15 20]);
% xlim(fig.xlim);
set(gca,'Fontsize',fig.fonts);
ylabel('Wind','Fontsize',fig.fonts);

set(AX(:,1:4),'xticklabel',[])
set(AX(2,:),'yticklabel',[])
delete(AX(2,1))
delete(AX(2,2))
delete(AX(2,3))
delete(AX(2,4))
delete(AX(2,5))

set(gcf,'color','w');

h = findobj(fhandle,'type','axes','tag','');
linkaxes(h,'x');

