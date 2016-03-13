clc;clear all;close all

%% Load matfiles

% adcp
mooring = '12m';
load('d:\sabinerijnsbur\Matlab\adcp\adcp12.mat');
adcp = adcp12;

% instruments mooring
dirin = 'd:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\';

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

%% Save figure or not

dir_out   = 'd:\sabinerijnsbur\Matlab\Figures\';
save_plot = 'yes';

%% Surface and bottom velocity

in.bva = nanmean(adcp.va(2:8,:));
in.bvc = nanmean(adcp.vc(2:8,:));

in.bva2 = adcp.va(3,:);
in.bvc2 = adcp.vc(3,:);

for i = 1:length(adcp.va)
    id(i)  = find(~isnan(adcp.va(:,i)),1,'last');
    in.sva(i)  = nanmean(adcp.va((id(i)-7:id(i)-1),i));
    in.sva2(i) = adcp.va((id(i)-2),i);
    %     id2(i)  = find(~isnan(adcp.vc(:,i)),1,'last');
    in.svc(i)  = nanmean(adcp.vc((id(i)-7:id(i)-1),i));
    in.svc2(i) = adcp.vc((id(i)-2),i);
end

%% Find zero crossing tide

[zc] = Zero_crossing(T1.t,T1.ssh);

%% Input for figure

fig.xlabel      = 'day in year';
fig.lwidth      = 1;
fig.fonts       = 8;
fig.txtfonts    = 8;
fig.xaxis       = [259 269];
fig.xtick       = 259:1:269;
fig.trange      = '259-269';
fig.ylim        = in.ylim; %depth z
fig.ydens       = [12.5 25];% relative density range
fig.ydr         = [-0.5 10];
fig.ytickdens   = 12.5:2.5:25;
fig.color       = 'b'; % color lines conditions
fig.legendloc   = 'SouthEast';
fig.legendorien = 'horizontal';
fig.position    =  mooring;
fig.fname       = ['AllinOne_dR_tide_' mooring fig.trange];% figure of all information in one figure
fig.fname2      = ['Dens_dR_Vel_tide' mooring fig.trange];% figure of density and velocities
fig.vline       = 1; %line width vertical lines
fig.cvline      = '--k';

%% Figure All in One

figure;
AX = subplot_meshgrid(2,7,[.06 0.01 0.05],[.03 .01 .01 .01 .01 .01 .01 .03],[nan 0.02],[nan nan nan nan nan nan nan]);
axes(AX(1,1))
plot(T1.t,T1.ssh,'b','linewidth',fig.lwidth);
hold on
plot(adcp.t,adcp.meanva,'--k','linewidth',fig.lwidth);
hline(0,'k');
% h = vline(adcp.t(in.idsa),fig.cvline);
% h = vline(adcp.t(in.idma),fig.cvline);
h = vline(T1.t(zc),fig.cvline);
set(h,'linewidth',fig.vline);
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis -1.5 1.5]);
% axis([fig.xaxis -1 1.5]);
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
    h = vline(T1.t(zc),fig.cvline);
%     h = vline(adcp.t(in.idsa),fig.cvline);
%     h = vline(adcp.t(in.idma),fig.cvline);
    set(h,'linewidth',fig.vline);
    set(gca,'Fontsize',fig.fonts);
    axis([fig.xaxis fig.ydens]);
    set(gca,'YTick',fig.ytickdens);
    set(gca,'XTick',fig.xtick);
    ylabel('Rel. Density (kg/m^3)');
    legend('MC1527 1mbs','MC1526 3mbs','MC5426 7mbs','MC5425 8mbs','MC1842 10.5mbs');
    legend('Location',fig.legendloc,'Orientation',fig.legendorien);
elseif strcmp(mooring,'18m')
    axes(AX(1,2))
    plot(SBE1525.t10,SBE1525.dens10-1000,'linewidth',fig.lwidth);
    hold on
    plot(SBE4939.t10,SBE4939.dens10-1000,'--r','linewidth',fig.lwidth);
    plot(SBE4940.t10,SBE4940.dens10-1000,'-.k','linewidth',fig.lwidth);
    plot(SBE19.t10,SBE19.dens10-1000,'c','linewidth',fig.lwidth);
    h = vline(T1.t(zc),fig.cvline);
%     h = vline(adcp.t(in.idsa),fig.cvline);
%     h = vline(adcp.t(in.idma),fig.cvline);
    set(h,'linewidth',fig.vline);
    set(gca,'Fontsize',fig.fonts);
    axis([fig.xaxis fig.ydens]);
    set(gca,'YTick',fig.ytickdens);
    set(gca,'XTick',fig.xtick);
    ylabel('Rel. Density (kg/m^3');
    legend('MC1525 1mbs','MC4939 2.5mbs','MC4940 10mbs','MC19 15 mbs');
    legend('Location',fig.legendloc,'Orientation',fig.legendorien);
end

axes(AX(1,3))
plot(in.t10,in.dR,'Linewidth',fig.lwidth)
hold on
% grid on
% plot(in.t10,in.dRs,'r','Linewidth',fig.lwidth)
plot(in.t10,in.dRb,'Color',[0 0 0],'Linewidth',fig.lwidth)
plot(in.t10,in.dR2,'r','Linewidth',fig.lwidth)
hline(0,'k');
h = vline(T1.t(zc),fig.cvline);
% h = vline(adcp.t(in.idsa),fig.cvline);
% h = vline(adcp.t(in.idma),fig.cvline);
set(h,'linewidth',fig.vline);
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis fig.ydr]);
% set(gca,'YTick',fig.ytickds);
set(gca,'XTick',fig.xtick);
ylabel('\Delta \rho (kg/m^3)');
legend('bottom-surface','bottom layer','bottom-3mbs');
legend('Location','NorthEast','Orientation',fig.legendorien);

axes(AX(1,4))
plot(adcp.t,in.sva,'Linewidth',fig.lwidth)
hold on
% grid on
plot(adcp.t,in.svc,'m','Linewidth',fig.lwidth)
hline(0,'k');
h = vline(T1.t(zc),fig.cvline);
% h = vline(adcp.t(in.idsa),fig.cvline);
% h = vline(adcp.t(in.idma),fig.cvline);
set(h,'linewidth',fig.vline);
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis -1 1.8]);
% set(gca,'YTick',fig.ytickds);
set(gca,'XTick',fig.xtick);
legend('Along','Cross');
legend('Location','NorthEast','Orientation','horizontal');
ylabel('surface vel (m/s)');

axes(AX(1,5))
plot(adcp.t,in.bva,'Linewidth',fig.lwidth)
hold on
% grid on
plot(adcp.t,in.bvc,'m','Linewidth',fig.lwidth)
hline(0,'k');
h = vline(T1.t(zc),fig.cvline);
% h = vline(adcp.t(in.idsa),fig.cvline);
% h = vline(adcp.t(in.idma),fig.cvline);
set(h,'linewidth',fig.vline);
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis -1 1]);
% set(gca,'YTick',fig.ytickds);
set(gca,'XTick',fig.xtick);
legend('Along','Cross');
legend('Location','NorthEast','Orientation','horizontal');
ylabel('bottom vel (m/s)');

axes(AX(1,6))
plot(wind.t,wind.speed,fig.color,'linewidth',fig.lwidth);
% grid on
hold on
h = vline(T1.t(zc),fig.cvline);
% h = vline(adcp.t(in.idsa),fig.cvline);
% h = vline(adcp.t(in.idma),fig.cvline);
set(h,'linewidth',fig.vline);
axis([fig.xaxis 0 20]);
set(gca,'Xtick',fig.xtick);
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
plot(Hs.t,Hs.hs,fig.color,'linewidth',fig.lwidth);
% grid on
hold on
h = vline(T1.t(zc),fig.cvline);
% h = vline(adcp.t(in.idsa),fig.cvline);
% h = vline(adcp.t(in.idma),fig.cvline);
set(h,'linewidth',fig.vline);
axis([fig.xaxis 0 3]);
set(gca,'Xtick',fig.xtick);
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

if strcmp(save_plot,'yes')
    print2a4([dir_out,fig.fname],'v','w');
end

%% Plot Density & vel

figure;
AX = subplot_meshgrid(2,4,[.06 0.01 0.05],[.03 .01 .01 .01 .03],[nan 0.02],[nan nan nan nan]);
if strcmp(mooring,'12m');
    axes(AX(1,1))
    plot(SBE1527.t10,SBE1527.dens10-1000,'linewidth',fig.lwidth);
    hold on
    plot(SBE1526.t10,SBE1526.dens10-1000,'--r','linewidth',fig.lwidth);
    plot(SBE5426.t10,SBE5426.dens10-1000,'-.k','linewidth',fig.lwidth);
    plot(SBE5425.t10,SBE5425.dens10-1000,'c','linewidth',fig.lwidth);
    plot(SBE1842.t10,SBE1842.dens10-1000,'g','linewidth',fig.lwidth);
    h = vline(T1.t(zc),fig.cvline);
    set(h,'linewidth',fig.vline);
    set(gca,'Fontsize',fig.fonts);
    axis([fig.xaxis fig.ydens]);
    set(gca,'YTick',fig.ytickdens);
    set(gca,'XTick',fig.xtick);
    ylabel('Rel. Density (kg/m^3)');
    legend('MC1527 1mbs','MC1526 3mbs','MC5426 7mbs','MC5425 8mbs','MC1842 10.5mbs');
    legend('Location',fig.legendloc,'Orientation',fig.legendorien);
    title([fig.position]);
elseif strcmp(mooring,'18m')
    axes(AX(1,1))
    plot(SBE1525.t,SBE1525.dens-1000,'linewidth',fig.lwidth);
    hold on
    plot(SBE4939.t,SBE4939.dens-1000,'--r','linewidth',fig.lwidth);
    plot(SBE4940.t,SBE4940.dens-1000,'-.k','linewidth',fig.lwidth);
    plot(SBE19.t,SBE19.dens-1000,'c','linewidth',fig.lwidth);
    h = vline(T1.t(zc),fig.cvline);
    set(h,'linewidth',fig.vline);
    set(gca,'Fontsize',fig.fonts);
    axis([fig.xaxis fig.ydens]);
    set(gca,'YTick',fig.ytickdens);
    set(gca,'XTick',fig.xtick);
    ylabel('Rel. Density (kg/m^3)');
    legend('MC1525 1mbs','MC4939 2.5mbs','MC4940 10mbs','MC19 15 mbs');
    legend('Location',fig.legendloc,'Orientation',fig.legendorien);
    title([fig.position]);
end

axes(AX(1,2))
plot(in.t10,in.dR,'Linewidth',fig.lwidth)
hold on
grid on
% plot(in.t10,in.dRs,'r','Linewidth',fig.lwidth)
plot(in.t10,in.dRb,'Color',[0 0 0],'Linewidth',fig.lwidth)
plot(in.t10,in.dR2,'r','Linewidth',fig.lwidth)
hline(0,'k');
h = vline(T1.t(zc),fig.cvline);
set(h,'linewidth',fig.vline);
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis fig.ydr]);
% set(gca,'YTick',fig.ytickds);
set(gca,'XTick',fig.xtick);
ylabel('\Delta \rho (kg/m^3)');
legend('bottom-surface','bottom layer','bottom-3mbs');
legend('Location','NorthEast','Orientation',fig.legendorien);

axes(AX(1,3))
plot(adcp.t,in.sva,'Linewidth',fig.lwidth)
hold on
grid on
plot(adcp.t,in.svc,'m','Linewidth',fig.lwidth)
hline(0,'k');
h = vline(T1.t(zc),fig.cvline);
set(h,'linewidth',fig.vline);
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis -1 1.8]);
% set(gca,'YTick',fig.ytickds);
set(gca,'XTick',fig.xtick);
legend('Along','Cross');
legend('Location','NorthEast','Orientation','horizontal');
ylabel('surface vel (m/s)');

axes(AX(1,4))
plot(adcp.t,in.bva,'Linewidth',fig.lwidth)
hold on
grid on
plot(adcp.t,in.bvc,'m','Linewidth',fig.lwidth)
hline(0,'k');
h = vline(T1.t(zc),fig.cvline);
set(h,'linewidth',fig.vline);
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis -1 1]);
% set(gca,'YTick',fig.ytickds);
set(gca,'XTick',fig.xtick);
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

if strcmp(save_plot,'yes')
    print2a4([dir_out,fig.fname2],'v','w');
end
