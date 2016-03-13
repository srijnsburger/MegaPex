clc;clear all;close all;

load('d:\sabinerijnsbur\Matlab_files\Megapex_data\Moorings\Mfiles_adcp\Mooring18_adcp_corr.mat');
load('d:\sabinerijnsbur\Matlab_files\Megapex_data\adcp\adcp18');
load('d:\sabinerijnsbur\Matlab\Megapex\Conditions\wind.mat');

%% Input for figure
fig.xlabel      = 'day in year';
fig.lwidth      = 1;
fig.fonts       = 13;
fig.txtfonts    = 13;
fig.xlim        = [268 273];
fig.ydens       = [12.5 25];% relative density range
fig.color       = 'b'; % color lines conditions
fig.legendloc   = 'SouthEast';
fig.legendorien = 'horizontal';

%% 

fhandle = figure;
AX = subplot_meshgrid(1,2,[.06 0.05],[.03 .01 .08],[nan],[nan nan]);

axes(AX(1,1))
plot(M18.t,M18.D-1000,'Linewidth',fig.lwidth);
legend('1m','2.5m','10m','15m');
legend('Location',fig.legendloc,'Orientation',fig.legendorien);
legend('boxoff');
xlim(fig.xlim);
ylim(fig.ydens);
ylabel('Rel. density (kg/m^3)');

axes(AX(1,2))
quiver(wind.t,wind.t*0,-wind.speed10.*sin((wind.dir10*pi)/180),-wind.speed10.*cos((wind.dir10*pi)/180),'Linewidth',fig.lwidth);
set(gca,'YTickLabel',[]);
grid on
hold on
xlim(fig.xlim);
ylim([-1 1]);
set(gca,'Fontsize',fig.fonts);
ylabel('Wind','Fontsize',fig.fonts);
xlabel('Day of year');

set(AX(:,1),'xticklabel',[])
set(gcf,'color','w');
set(findall(gcf,'type','text'),'FontSize',fig.fonts);

h = findobj(fhandle,'type','axes','tag','');
linkaxes(h,'x');

%% 

fhandle = figure;
AX = subplot_meshgrid(2,4,[.06 0.01 0.05],[.03 .01 0.01 0.01 .08],[nan 0.02],[nan nan nan nan]);

axes(AX(1,1))
plot(M18.t,M18.D-1000,'Linewidth',fig.lwidth);
legend('1m','2.5m','10m','15m');
legend('Location',fig.legendloc,'Orientation',fig.legendorien);
legend('boxoff');
xlim(fig.xlim);
ylim(fig.ydens);
ylabel('Rel. density (kg/m^3)');

axes(AX(1,2))
pcolorcorcen(adcp18.t,adcp18.z,adcp18.va);
hold on
plot(adcp18.t,adcp18.h,'Linewidth',fig.lwidth,'Color','k');
set(gca,'Fontsize',fig.fonts);
ylabel('z (m)');
xlim(fig.xlim);
clim([-1.0 1.0]);
colorbarwithvtext('v (along)','vert','position',get(AX(2,2),'position'));
colormap(colormapbluewhitered);

axes(AX(1,3))
pcolorcorcen(adcp18.t,adcp18.z,adcp18.vc);
hold on
plot(adcp18.t,adcp18.h,'Linewidth',fig.lwidth,'Color','k');
set(gca,'Fontsize',fig.fonts);
xlim(fig.xlim);
clim([-0.5 0.5]);
ylabel('z (m)');
colorbarwithvtext('u (cross)','vert','position',get(AX(2,3),'position'));
colormap(colormapbluewhitered);

axes(AX(1,4))
quiver(wind.t,wind.t*0,-wind.speed10.*sin((wind.dir10*pi)/180),-wind.speed10.*cos((wind.dir10*pi)/180),'Linewidth',fig.lwidth);
set(gca,'YTickLabel',[]);
grid on
hold on
xlim(fig.xlim);
ylim([-1 1]);
set(gca,'Fontsize',fig.fonts);
ylabel('Wind','Fontsize',fig.fonts);
xlabel('Day of year');

set(AX(:,1:3),'xticklabel',[]);
set(AX(2,:),'yticklabel',[])
delete(AX(2,1))
delete(AX(2,2))
delete(AX(2,3))
delete(AX(2,4))

set(gcf,'color','w');
set(findall(gcf,'type','text'),'FontSize',fig.fonts);

h = findobj(fhandle,'type','axes','tag','');
linkaxes(h,'x');

%% 12m

load('d:\sabinerijnsbur\Matlab_files\Megapex_data\Moorings\Mfiles_adcp\Mooring12_adcp_corr.mat');
load('d:\sabinerijnsbur\Matlab_files\Megapex_data\adcp\adcp12C');
load('d:\sabinerijnsbur\Matlab\Megapex\Conditions\wind.mat');

%% Input for figure
fig.xlabel      = 'day in year';
fig.lwidth      = 1;
fig.fonts       = 13;
fig.txtfonts    = 13;
fig.xlim        = [268 273];
fig.ydens       = [12.5 25];% relative density range
fig.color       = 'b'; % color lines conditions
fig.legendloc   = 'SouthEast';
fig.legendorien = 'horizontal';

%% 

fhandle = figure;
AX = subplot_meshgrid(1,2,[.06 0.05],[.03 .01 .08],[nan],[nan nan]);

axes(AX(1,1))
plot(M12.t,M12.D-1000,'Linewidth',fig.lwidth);
legend('1m','3m','7m','8m','10.5m');
legend('Location',fig.legendloc,'Orientation',fig.legendorien);
legend('boxoff');
xlim(fig.xlim);
ylim(fig.ydens);
ylabel('Rel. density (kg/m^3)');

axes(AX(1,2))
quiver(wind.t,wind.t*0,-wind.speed10.*sin((wind.dir10*pi)/180),-wind.speed10.*cos((wind.dir10*pi)/180),'Linewidth',fig.lwidth);
set(gca,'YTickLabel',[]);
grid on
hold on
xlim(fig.xlim);
ylim([-1 1]);
set(gca,'Fontsize',fig.fonts);
ylabel('Wind','Fontsize',fig.fonts);
xlabel('Day of year');

set(AX(:,1),'xticklabel',[])
set(gcf,'color','w');
set(findall(gcf,'type','text'),'FontSize',fig.fonts);

h = findobj(fhandle,'type','axes','tag','');
linkaxes(h,'x');

%% 

fhandle = figure;
AX = subplot_meshgrid(2,4,[.06 0.01 0.05],[.03 .01 0.01 0.01 .08],[nan 0.02],[nan nan nan nan]);

axes(AX(1,1))
plot(M12.t,M12.D-1000,'Linewidth',fig.lwidth);
legend('1m','3m','7m','8m','10.5m');
legend('Location',fig.legendloc,'Orientation',fig.legendorien);
legend('boxoff');
xlim(fig.xlim);
ylim(fig.ydens);
ylabel('Rel. density (kg/m^3)');

axes(AX(1,2))
pcolorcorcen(adcp12C.t,adcp12C.z,adcp12C.va);
hold on
plot(adcp12C.t,adcp12C.h,'Linewidth',fig.lwidth,'Color','k');
set(gca,'Fontsize',fig.fonts);
ylabel('z (m)');
xlim(fig.xlim);
clim([-1.0 1.0]);
colorbarwithvtext('v (along)','vert','position',get(AX(2,2),'position'));
colormap(colormapbluewhitered);

axes(AX(1,3))
pcolorcorcen(adcp12C.t,adcp12C.z,adcp12C.vc);
hold on
plot(adcp12C.t,adcp12C.h,'Linewidth',fig.lwidth,'Color','k');
set(gca,'Fontsize',fig.fonts);
xlim(fig.xlim);
clim([-0.5 0.5]);
ylabel('z (m)');
colorbarwithvtext('u (cross)','vert','position',get(AX(2,3),'position'));
colormap(colormapbluewhitered);

axes(AX(1,4))
quiver(wind.t,wind.t*0,-wind.speed10.*sin((wind.dir10*pi)/180),-wind.speed10.*cos((wind.dir10*pi)/180),'Linewidth',fig.lwidth);
set(gca,'YTickLabel',[]);
grid on
hold on
xlim(fig.xlim);
ylim([-1 1]);
set(gca,'Fontsize',fig.fonts);
ylabel('Wind','Fontsize',fig.fonts);
xlabel('Day of year');

set(AX(:,1:3),'xticklabel',[]);
set(AX(2,:),'yticklabel',[])
delete(AX(2,1))
delete(AX(2,2))
delete(AX(2,3))
delete(AX(2,4))

set(gcf,'color','w');
set(findall(gcf,'type','text'),'FontSize',fig.fonts);

h = findobj(fhandle,'type','axes','tag','');
linkaxes(h,'x');