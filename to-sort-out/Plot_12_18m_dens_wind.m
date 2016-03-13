% Plot densities of 12 and 18m
clc;clear all;close all;

load('d:\sabinerijnsbur\Matlab\adcp\adcp12.mat');
dirin = 'd:\sabinerijnsbur\Matlab\Moorings\Mfiles\';

load([dirin,'SBE1526.mat']);
load([dirin,'SBE1527.mat']);
load([dirin,'SBE5425.mat']);
load([dirin,'SBE5426.mat']);
load([dirin,'SBE1842_corrected.mat']);

load([dirin,'SBE1525.mat']);
load([dirin,'SBE4939.mat']);
load([dirin,'SBE4940.mat']);
load([dirin,'SBE19_corrected.mat']);

% conditions
load('d:\sabinerijnsbur\Matlab\Megapex\Conditions\wave.mat');
load('d:\sabinerijnsbur\Matlab\Megapex\Conditions\tide.mat');
load('d:\sabinerijnsbur\Matlab\Megapex\Conditions\wind.mat');
load('d:\sabinerijnsbur\Matlab\Megapex\Conditions\potwind.mat');

%% Input for figure
fig.xlabel      = 'day in year';
fig.lwidth      = 1;
fig.fonts       = 13;
fig.txtfonts    = 13;
fig.xlim        = [260 264];
fig.ydens       = [12.5 25];% relative density range
fig.color       = 'b'; % color lines conditions
fig.legendloc   = 'SouthEast';
fig.legendorien = 'horizontal';

%% Plot

fhandle = figure;
AX = subplot_meshgrid(2,3,[.06 0.01 0.05],[.03 .01 .01 .035],[nan 0.02],[nan nan nan]);
axes(AX(1,1))
plot(SBE1527.t10,SBE1527.dens10-1000,'linewidth',fig.lwidth);
hold on
plot(SBE1526.t10,SBE1526.dens10-1000,'--r','linewidth',fig.lwidth);
plot(SBE5426.t10,SBE5426.dens10-1000,'-.k','linewidth',fig.lwidth);
plot(SBE5425.t10,SBE5425.dens10-1000,'c','linewidth',fig.lwidth);
plot(SBE1842.t10,SBE1842.dens10-1000,'g','linewidth',fig.lwidth);
set(gca,'Fontsize',fig.fonts);
xlim(fig.xlim);
ylim([fig.ydens]);
ylabel('Rel. Density (kg/m^3)');
legend('MC1527 1mbs','MC1526 3mbs','MC5426 7mbs','MC5425 8mbs','MC1842 10.5mbs');
legend('Location',fig.legendloc,'Orientation',fig.legendorien);

axes(AX(1,2))
plot(SBE1525.t,SBE1525.dens-1000,'linewidth',fig.lwidth);
hold on
plot(SBE4939.t,SBE4939.dens-1000,'--r','linewidth',fig.lwidth);
plot(SBE4940.t,SBE4940.dens-1000,'-.k','linewidth',fig.lwidth);
plot(SBE19.t,SBE19.dens-1000,'c','linewidth',fig.lwidth);
set(gca,'Fontsize',fig.fonts);
xlim(fig.xlim);
ylim([fig.ydens]);
ylabel('Rel. Density (kg/m^3)');
legend('MC1525 1mbs','MC4939 2.5mbs','MC4940 10mbs','MC19 15 mbs');
legend('Location',fig.legendloc,'Orientation',fig.legendorien);

axes(AX(1,3))
quiver(wind.t,wind.t*0,-wind.speed10.*sin((wind.dir10*pi)/180),-wind.speed10.*cos((wind.dir10*pi)/180));
set(gca,'YTickLabel',[]);
grid on
hold on
xlim(fig.xlim);
ylim([-1 1]);
set(gca,'Fontsize',fig.fonts);
ylabel('Wind','Fontsize',fig.fonts);

set(AX(:,1:2),'xticklabel',[])
set(AX(2,:),'yticklabel',[])
delete(AX(2,1))
delete(AX(2,2))
delete(AX(2,3))

set(gcf,'color','w');
set(findall(gcf,'type','text'),'FontSize',fig.fonts);

h = findobj(fhandle,'type','axes','tag','');
linkaxes(h,'x');