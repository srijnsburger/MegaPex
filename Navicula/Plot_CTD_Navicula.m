% Plot CTD Navicula
clear all; clc;
% close all
%% Load data
% SBE profiler
load('d:\sabinerijnsbur\Matlab\Matlab-MegaPex2014-chaos\Navicula_170914\SBENav.mat');
mat = SBENav;

% Adcp 12m frame
load('d:\sabinerijnsbur\Matlab\adcp\adcp12C.mat');
adcp = adcp12C;

% Instruments Mooring 12m
dirin = 'd:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\';
load([dirin,'SBE1526.mat']);
load([dirin,'SBE1527.mat']);
load([dirin,'SBE5425.mat']);
load([dirin,'SBE5426.mat']);
load([dirin,'SBE1842_corrected.mat']);
load([dirin,'OBS3A744.mat']);
load([dirin,'OBS3A743.mat']);

% Conditions
load('d:\sabinerijnsbur\Matlab\Megapex\Conditions\wave.mat');
load('d:\sabinerijnsbur\Matlab\Megapex\Conditions\tide.mat');
load('d:\sabinerijnsbur\Matlab\Megapex\Conditions\wind.mat');
load('d:\sabinerijnsbur\Matlab\Megapex\Conditions\potwind.mat');

%% Find surface velocity

[vel] = surface_bottom_velocity(adcp.va,adcp.vc);

%% ssh

ssh = adcp.h - mean(adcp.h);

%% Save figure or not 

dir_out   = 'd:\sabinerijnsbur\Matlab\Figures\Navicula170914\';
save_plot = 'no';

%% Input for figure

fig.t           = mat.starttime;
fig.xlabel      = 'Time (h)';
fig.lwidth      = 1;
fig.line        = 'b';
fig.fonts       = 12;
fig.xaxis       = [datenum(2014,09,17,06,30,00) datenum(2014,09,17,17,40,00)];
fig.xtick       = datenum(2014,09,17,06,30,00):0.0417:datenum(2014,09,17,17,40,00);
% fig.xaxis       = [mat.starttime(1) mat.starttime(end)];
% fig.xtick       = mat.starttime(1):0.0417/2:mat.starttime(end);
fig.yaxis       = [-10 -1]; % for SBE profiler
fig.ylim        = [0 15]; % for adcp & mooring
fig.cdens       = [12 24];
fig.ctickdens   = 12:2:24;
fig.ctemp       = [18 20.5];
fig.cticktemp   = 18:0.5:20.5;
fig.csal        = [21 31];
fig.cticksal    = 21:2:31;
fig.tickvc      = -0.5:0.25:0.5;
fig.cvolt       = log10([0.05 1]);
fig.ctickvolt   = log10([0.05 0.1 0.2 0.5 0.8 1.0]);
fig.vline       = mat.starttime;
fig.legendloc   = 'SouthEast';
fig.legendorien = 'horizontal';
fig.fname       = ['Navicula_170914'];% figure of the timeseries
fig.fname2      = ['Navicula_170914_adcp12&M12'];
fig.fname3      = ['Navicula_170914_conditions'];

%% Timeseries SBE

figure;
AX = subplot_meshgrid(2,4,[.08 .02 .05],[.025 .01 .01 .01 .04],[nan 0.02],[nan nan nan nan]);
axes(AX(1,1))
pcolorcorcen(fig.t,mat.z,mat.temp)
hold on
vline(fig.vline,':k');
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis])
set(gca,'Xtick',fig.xtick);
datetick('x','HH:MM','keepticks')
caxis(fig.ctemp);
colorbarwithvtext('Temperature (deg. C)',fig.cticktemp,'vert','Fontsize',fig.fonts,'position',get(AX(2,1),'position'));
% set(h1,'YTicklabel',{'18','18.5','19','19.5','20','20.5'});
ylabel('Depth (m)','Fontsize',fig.fonts);

axes(AX(1,2))
pcolorcorcen(fig.t,mat.z,mat.sal)
hold on
vline(fig.vline,':k');
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis])
set(gca,'Xtick',fig.xtick);
datetick('x','HH:MM','keepticks')
caxis(fig.csal);
colorbarwithvtext('Salinity (psu)',fig.cticksal,'vert','Fontsize',fig.fonts,'position',get(AX(2,2),'position'));
colormap(colormapbluewhitered);
% set(h2,'yticklabel',{'21','23','25','27','29','31'});
ylabel('Depth (m)','Fontsize',fig.fonts);

axes(AX(1,3))
pcolorcorcen(fig.t,mat.z,mat.dens-1000)
hold on
vline(fig.vline,':k');
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis])
set(gca,'Xtick',fig.xtick);
datetick('x','HH:MM','keepticks')
caxis(fig.cdens);
colorbarwithvtext('Density (kg/m^3)',fig.ctickdens,'vert','Fontsize',fig.fonts,'position',get(AX(2,3),'position'));
% set(h2,'yticklabel',{'21','23','25','27','29','31'});
colormap(colormapbluewhitered);
ylabel('Depth (m)','Fontsize',fig.fonts);

axes(AX(1,4))
pcolorcorcen(fig.t,mat.z,log10(mat.volt))
hold on
vline(fig.vline,':k');
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis])
set(gca,'Xtick',fig.xtick);
datetick('x','HH:MM','keepticks')
caxis(fig.cvolt);
[h3,~] = colorbarwithvtext('Turbidity (Volt)',fig.ctickvolt,'vert','Fontsize',fig.fonts,'position',get(AX(2,4),'position'));
set(h3,'yticklabel',{'0.05','0.1','0.2','0.5','0.8','1.0'});  
ylabel('Depth (m)','Fontsize',fig.fonts);
xlabel(fig.xlabel,'Fontsize',fig.fonts);

set(AX(:,1:3),'xticklabel',[])
set(AX(2,:),'yticklabel',[])
delete(AX(2,1))
delete(AX(2,2))
delete(AX(2,3))
delete(AX(2,4))

% if strcmp(save_plot,'yes')
% print2a4([dir_out,fig.fname],'v','w');
% end

%% Timeseries SBE & ADCP12m frame & Mooring data

% ff = figure;
figure;
AX = subplot_meshgrid(2,4,[.05 .02 .05],[.025 .018 .018 .018 .04],[nan 0.02],[nan nan nan nan]);
axes(AX(1,1))
pcolorcorcen(fig.t,mat.z,mat.dens-1000)
hold on
vline(fig.vline,':k');
axis([fig.xaxis fig.yaxis])
set(gca,'Xtick',fig.xtick);
datetick('x','HH:MM','keepticks')
set(gca,'Fontsize',fig.fonts);
caxis(fig.cdens);
colorbarwithvtext('Density (kg/m^3)',fig.ctickdens,'vert','Fontsize',fig.fonts,'position',get(AX(2,1),'position'));
colormap('jet');
% set(h2,'yticklabel',{'21','23','25','27','29','31'});
ylabel('Depth (m)','Fontsize',fig.fonts);


axes(AX(1,2))
plot(SBE1527.time10,SBE1527.dens10-1000,'linewidth',fig.lwidth);
hold on
plot(SBE1526.time10,SBE1526.dens10-1000,'--r','linewidth',fig.lwidth);
plot(OBS3A744.time10,OBS3A744.dens10-1000,'m','linewidth',fig.lwidth);
plot(SBE5426.time10,SBE5426.dens10-1000,'-.k','linewidth',fig.lwidth);
plot(SBE5425.time10,SBE5425.dens10-1000,'c','linewidth',fig.lwidth);
plot(SBE1842.time10,SBE1842.dens10-1000,'g','linewidth',fig.lwidth);
set(gca,'Fontsize',fig.fonts);
vline(fig.vline,':k');
axis([fig.xaxis fig.cdens]);
set(gca,'XTick',fig.xtick);
datetick('x','HH:MM','keepticks');
set(gca,'YTick',fig.ctickdens);
ylabel('Density (kg/m^3)');
legend('MC1527 1mbs','MC1526 3mbs','OBS3A744 5mbs','MC5426 7mbs','MC5425 8mbs','MC1842 10.5mbs');
legend('Location',fig.legendloc,'Orientation',fig.legendorien);

axes(AX(1,3))
pcolorcorcen(adcp.time,adcp.z,adcp.va);
hold on
plot(adcp.time,adcp.h,'k');
vline(fig.vline,':k');
axis([fig.xaxis fig.ylim]);
set(gca,'XTick',fig.xtick);
datetick('x','HH:MM','keepticks');
set(gca,'Fontsize',fig.fonts);
clim([-1.5 1.5]);
colorbarwithvtext('v (along)','vert','position',get(AX(2,3),'position'),'Fontsize',fig.fonts);
colormap(colormapbluewhitered);
ylabel('Depth (mab)','Fontsize',fig.fonts);

axes(AX(1,4))
pcolorcorcen(adcp.time,adcp.z,adcp.vc);
hold on
plot(adcp.time,adcp.h,'k');
vline(fig.vline,':k');
axis([fig.xaxis fig.ylim]);
set(gca,'XTick',fig.xtick);
datetick('x','HH:MM','keepticks')
clim([-0.5 0.5]);
set(gca,'Fontsize',fig.fonts);
colorbarwithvtext('u (cross)',fig.tickvc,'vert','position',get(AX(2,4),'position'),'Fontsize',fig.fonts);
colormap(colormapbluewhitered);
ylabel('Depth (mab)','Fontsize',fig.fonts);
xlabel(fig.xlabel,'Fontsize',fig.fonts);

set(AX(:,1:3),'xticklabel',[])
set(AX(2,:),'yticklabel',[])
delete(AX(2,1))
delete(AX(2,2))
delete(AX(2,3))
delete(AX(2,4))

% hh = findobj(ff,'type','axes','tag','');
% linkaxes(hh,'x');

set(gcf,'color','w');
set(findall(gcf,'type','text'),'FontSize',fig.fonts);

if strcmp(save_plot,'yes')
% print2a4([dir_out,fig.fname2],'v','w');
% fig = gcf;
% fig.PaperUnits = 'inches';
% fig.PaperPosition = [0 0 6 3];
% fig.PaperPositionMode = 'manual';
% print('5by3DimensionsFigure','-dpng','-r0')

    set(gcf, 'PaperUnits', 'centimeters');
    set(gcf, 'PaperSize', [29 20]);
    set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperPosition', [0 0 29 20]);
%     set(gcf,'Renderer','opengl');
    print(gcf, '-dpng','-r0',[dir_out 'Navicula-dens-vel2.png']);
end

%% 

figure;
h1 = subplot(4,1,1);
pcolorcorcen(fig.t,mat.z,mat.dens-1000)
hold on
% plot(mat.dens(1)-1000,mat.z);
vline(fig.vline,':k');
axis([fig.xaxis fig.yaxis])
set(gca,'Xtick',fig.xtick);
datetick('x','HH:MM','keepticks')
caxis(fig.cdens);
colorbar
colormap('jet');
% set(h2,'yticklabel',{'21','23','25','27','29','31'});
ylabel('Depth (m)','Fontsize',fig.fonts);
set(gca,'Fontsize',fig.fonts);

h2 = subplot(4,1,2);
plot(SBE1527.time10,SBE1527.dens10-1000,'linewidth',fig.lwidth);
hold on
plot(SBE1526.time10,SBE1526.dens10-1000,'--r','linewidth',fig.lwidth);
plot(OBS3A744.time10,OBS3A744.dens10-1000,'m','linewidth',fig.lwidth);
plot(SBE5426.time10,SBE5426.dens10-1000,'-.k','linewidth',fig.lwidth);
plot(SBE5425.time10,SBE5425.dens10-1000,'c','linewidth',fig.lwidth);
plot(SBE1842.time10,SBE1842.dens10-1000,'g','linewidth',fig.lwidth);
vline(fig.vline,':k');
axis([fig.xaxis fig.cdens]);
set(gca,'XTick',fig.xtick);
datetick('x','HH:MM','keepticks');
set(gca,'YTick',fig.ctickdens);
ylabel('Density (kg/m^3)');
legend('MC1527 1mbs','MC1526 3mbs','OBS3A744 5mbs','MC5426 7mbs','MC5425 8mbs','MC1842 10.5mbs');
set(gca,'Fontsize',fig.fonts);
legend('Location',fig.legendloc,'Orientation',fig.legendorien);

h3 = subplot(4,1,3);
pcolorcorcen(adcp.time,adcp.z,adcp.va);
hold on
plot(adcp.time,adcp.h,'k');
vline(fig.vline,':k');
axis([fig.xaxis fig.ylim]);
set(gca,'XTick',fig.xtick);
datetick('x','HH:MM','keepticks');
clim([-1.5 1.5]);
colorbar
colormap(colormapbluewhitered);
set(gca,'Fontsize',fig.fonts);
ylabel('Depth (mab)','Fontsize',fig.fonts);

h4 = subplot(4,1,4);
pcolorcorcen(adcp.time,adcp.z,adcp.vc);
hold on
plot(adcp.time,adcp.h,'k');
vline(fig.vline,':k');
axis([fig.xaxis fig.ylim]);
set(gca,'XTick',fig.xtick);
datetick('x','HH:MM','keepticks')
clim([-0.5 0.5]);
colorbar
colormap(colormapbluewhitered);
set(gca,'Fontsize',fig.fonts);
ylabel('Depth (mab)','Fontsize',fig.fonts);
xlabel(fig.xlabel,'Fontsize',fig.fonts);

linkaxes([h1,h2,h3,h4],'x');


%% Dens, Mooring, surf & bottom vel

fhandle = figure;
AX = subplot_meshgrid(2,4,[.1 .02 .05],[.025 .01 .01 .01 .04],[nan 0.02],[nan nan nan nan]);
axes(AX(1,1))
pcolorcorcen(fig.t,mat.z,mat.dens-1000)
hold on
vline(fig.vline,':k');
axis([fig.xaxis fig.yaxis])
set(gca,'Xtick',fig.xtick);
datetick('x','HH:MM','keepticks')
title('Data 17/09/2014');
caxis(fig.cdens);
colorbarwithvtext('Density (kg/m^3)',fig.ctickdens,'vert','Fontsize',fig.fonts,'position',get(AX(2,1),'position'));
% set(h2,'yticklabel',{'21','23','25','27','29','31'});
ylabel('Depth (m)','Fontsize',fig.fonts);
set(gca,'Fontsize',fig.fonts);


axes(AX(1,2))
plot(SBE1527.time10,SBE1527.dens10-1000,'linewidth',fig.lwidth);
hold on
plot(SBE1526.time10,SBE1526.dens10-1000,'--r','linewidth',fig.lwidth);
plot(OBS3A744.time10,OBS3A744.dens10-1000,'m','linewidth',fig.lwidth);
plot(SBE5426.time10,SBE5426.dens10-1000,'-.k','linewidth',fig.lwidth);
plot(SBE5425.time10,SBE5425.dens10-1000,'c','linewidth',fig.lwidth);
plot(SBE1842.time10,SBE1842.dens10-1000,'g','linewidth',fig.lwidth);
vline(fig.vline,':k');
axis([fig.xaxis fig.cdens]);
set(gca,'XTick',fig.xtick);
datetick('x','HH:MM','keepticks');
set(gca,'YTick',fig.ctickdens);
ylabel('Density (kg/m^3)');
legend('MC1527 1mbs','MC1526 3mbs','OBS3A744 5mbs','MC5426 7mbs','MC5425 8mbs','MC1842 10.5mbs');
legend('Location',fig.legendloc,'Orientation',fig.legendorien);
set(gca,'Fontsize',fig.fonts);

axes(AX(1,3))
plot(adcp.time,vel.sva);
hold on
plot(adcp.time,vel.svc);
vline(fig.vline,':k');
hline(0);
axis([fig.xaxis -1 1]);
set(gca,'XTick',fig.xtick);
datetick('x','HH:MM','keepticks');
set(gca,'Fontsize',fig.fonts);
ylabel('surface velocity (m/s)','Fontsize',fig.fonts);
legend('va','vc');

axes(AX(1,4))
plot(adcp.time,adcp.va(3,:));
hold on
plot(adcp.time,adcp.vc(3,:));
vline(fig.vline,':k');
hline(0);
axis([fig.xaxis -0.5 0.5]);
set(gca,'XTick',fig.xtick);
datetick('x','HH:MM','keepticks')
set(gca,'Fontsize',fig.fonts);
ylabel('bottom velocity (m/s)','Fontsize',fig.fonts);
xlabel(fig.xlabel,'Fontsize',fig.fonts);
legend('va','vc');

set(AX(:,1:3),'xticklabel',[])
set(AX(2,:),'yticklabel',[])
delete(AX(2,1))
delete(AX(2,2))
delete(AX(2,3))
delete(AX(2,4))

% hh = findobj(fhandle,'type','axes','tag','');
% linkaxes(hh,'x');

if strcmp(save_plot,'yes')
print2a4([dir_out,'Navicula_bv&sv.png'],'v','w');
end

%% Plot with conditions

figure;
AX = subplot_meshgrid(2,8,[.09 0.01 0.06],[.03 .01 .01 .01 .01 .01 .01 .01 .03],[nan 0.025],[nan nan nan nan nan nan nan nan]);
axes(AX(1,1))
pcolorcorcen(fig.t,mat.z,mat.dens-1000)
hold on
vline(fig.vline,':k');
axis([fig.xaxis fig.yaxis])
set(gca,'Xtick',fig.xtick);
datetick('x','HH:MM','keepticks')
caxis(fig.cdens);
colorbarwithvtext('Density (kg/m^3)',fig.ctickdens,'vert','Fontsize',fig.fonts,'position',get(AX(2,1),'position'));
% set(h2,'yticklabel',{'21','23','25','27','29','31'});
ylabel('Depth (m)','Fontsize',fig.fonts);
set(gca,'Fontsize',fig.fonts);

axes(AX(1,2))
plot(SBE1527.time10,SBE1527.dens10-1000,'linewidth',fig.lwidth);
hold on
plot(SBE1526.time10,SBE1526.dens10-1000,'--r','linewidth',fig.lwidth);
plot(SBE5426.time10,SBE5426.dens10-1000,'-.k','linewidth',fig.lwidth);
plot(SBE5425.time10,SBE5425.dens10-1000,'c','linewidth',fig.lwidth);
plot(SBE1842.time10,SBE1842.dens10-1000,'g','linewidth',fig.lwidth);
vline(fig.vline,':k');
axis([fig.xaxis fig.cdens]);
set(gca,'XTick',fig.xtick);
datetick('x','HH:MM','keepticks');
set(gca,'YTick',fig.ctickdens);
ylabel('Density (kg/m^3)');
legend('MC1527 1mbs','MC1526 3mbs','MC5426 7mbs','MC5425 8mbs','MC1842 10.5mbs');
set(gca,'Fontsize',fig.fonts);
legend('Location',fig.legendloc,'Orientation',fig.legendorien);

axes(AX(1,3))
pcolorcorcen(adcp.time,adcp.z,adcp.va);
hold on
plot(adcp.time,adcp.h,'k');
vline(fig.vline,':k');
axis([fig.xaxis fig.ylim]);
set(gca,'XTick',fig.xtick);
datetick('x','HH:MM','keepticks');
clim([-1.5 1.5]);
colorbarwithvtext('v (along)','vert','position',get(AX(2,3),'position'));
colormap(colormapbluewhitered);
ylabel('Depth (mab)','Fontsize',fig.fonts);
set(gca,'Fontsize',fig.fonts);

axes(AX(1,4))
pcolorcorcen(adcp.time,adcp.z,adcp.vc);
hold on
plot(adcp.time,adcp.h,'k');
vline(fig.vline,':k');
axis([fig.xaxis fig.ylim]);
set(gca,'XTick',fig.xtick);
datetick('x','HH:MM','keepticks')
clim([-0.5 0.5]);
colorbarwithvtext('u (cross)',fig.tickvc,'vert','position',get(AX(2,4),'position'));
colormap(colormapbluewhitered);
set(gca,'Fontsize',fig.fonts);
ylabel('Depth (mab)','Fontsize',fig.fonts);
xlabel(fig.xlabel,'Fontsize',fig.fonts);

axes(AX(1,5))
plot(wind.time,wind.speed,fig.line,'linewidth',fig.lwidth);
% grid on
hold on
vline(fig.vline,':k');
axis([fig.xaxis 0 10]);
set(gca,'Xtick',fig.xtick);
datetick('x','HH:MM','keepticks')
set(gca,'YTick',[0 2.5 5 7.5 10]);
set(gca,'Fontsize',fig.fonts);
ylabel('(m/s)','Fontsize',fig.fonts);

axes(AX(1,6))
plot(wind.time,wind.dir10,fig.line,'linewidth',fig.lwidth);
% grid on
hold on
vline(fig.vline,':k');
axis([fig.xaxis 0 360]);
set(gca,'Xtick',fig.xtick);
datetick('x','HH:MM','keepticks')
set(gca,'YTick',[0 90 180 270 360]);
set(gca,'Fontsize',fig.fonts);
ylabel('dir (\circ)','Fontsize',fig.fonts);

axes(AX(1,7))
plot(Hs.time,Hs.hs,fig.line,'linewidth',fig.lwidth);
% grid on
hold on
vline(fig.vline,':k');
axis([fig.xaxis 0 1]);
set(gca,'Xtick',fig.xtick);
datetick('x','HH:MM','keepticks')
set(gca,'YTick',[0 0.25 0.5 0.75 1]);
set(gca,'Fontsize',fig.fonts);
ylabel('Hs (m)','Fontsize',fig.fonts);

axes(AX(1,8))
plot(Tm0.time,Tm0.tm0,fig.line,'linewidth',fig.lwidth);
% grid on
hold on
vline(fig.vline,':k');
axis([fig.xaxis 0 6]);
set(gca,'Xtick',fig.xtick);
datetick('x','HH:MM','keepticks')
set(gca,'YTick',[0 2 4 6]);
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

% if strcmp(save_plot,'yes')
% print2a4([dir_out,fig.fname3],'v','w');
% end

%% Plot with tidal elevation
figure;
% f2 = figure;
AX = subplot_meshgrid(2,5,[.09 0.01 0.06],[.03 .01 .01 .01 .01 .03],[nan 0.025],[nan nan nan nan nan]);
axes(AX(1,1))
plot(T1.time,T1.ssh,'b','linewidth',fig.lwidth);
hold on
plot(adcp.time(1:266),ssh(1:266),'r');
plot(adcp.time,adcp.meanva,'--k','linewidth',fig.lwidth);
hline(0,'k');
vline(fig.vline,':k');
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis -1.5 1.5]);
set(gca,'XTick',fig.xtick);
datetick('x','dd HH:MM','keepticks');
legend('Water level (m)','Alongshore velocity (m/s)');
legend('Location',fig.legendloc,'Orientation',fig.legendorien);

axes(AX(1,2))
pcolorcorcen(fig.t,mat.z,mat.dens-1000)
hold on
vline(fig.vline,':k');
axis([fig.xaxis fig.yaxis])
set(gca,'Xtick',fig.xtick);
datetick('x','HH:MM','keepticks')
caxis(fig.cdens);
colormap('jet');
[c,~] = colorbarwithvtext('Density (kg/m^3)',fig.ctickdens,'vert','Fontsize',fig.fonts,'position',get(AX(2,2),'position'));
% set(h2,'yticklabel',{'21','23','25','27','29','31'});
ylabel('Depth (m)','Fontsize',fig.fonts);
set(gca,'Fontsize',fig.fonts);

axes(AX(1,3))
plot(SBE1527.time10,SBE1527.dens10-1000,'linewidth',fig.lwidth);
hold on
plot(SBE1526.time10,SBE1526.dens10-1000,'--r','linewidth',fig.lwidth);
plot(OBS3A744.time10,OBS3A744.dens10-1000,'m','linewidth',fig.lwidth);
plot(SBE5426.time10,SBE5426.dens10-1000,'-.k','linewidth',fig.lwidth);
plot(SBE5425.time10,SBE5425.dens10-1000,'c','linewidth',fig.lwidth);
plot(SBE1842.time10,SBE1842.dens10-1000,'g','linewidth',fig.lwidth);
vline(fig.vline,':k');
axis([fig.xaxis fig.cdens]);
set(gca,'XTick',fig.xtick);
datetick('x','HH:MM','keepticks');
set(gca,'YTick',fig.ctickdens);
ylabel('Density (kg/m^3)');
legend('MC1527 1mbs','MC1526 3mbs','OBS3A744 5mbs','MC5426 7mbs','MC5425 8mbs','MC1842 10.5mbs');
set(gca,'Fontsize',fig.fonts);
legend('Location',fig.legendloc,'Orientation',fig.legendorien);

axes(AX(1,4))
pcolorcorcen(adcp.time,adcp.z,adcp.va);
hold on
plot(adcp.time,adcp.h,'k');
vline(fig.vline,':k');
axis([fig.xaxis fig.ylim]);
set(gca,'XTick',fig.xtick);
datetick('x','HH:MM','keepticks');
caxis([-1.5 1.5]);
colormap(colormapbluewhitered);
[h,~]=colorbarwithvtext('v (along)','vert','position',get(AX(2,4),'position')); 
ylabel('Depth (mab)','Fontsize',fig.fonts);
set(gca,'Fontsize',fig.fonts);

axes(AX(1,5))
pcolorcorcen(adcp.time,adcp.z,adcp.vc);
hold on
plot(adcp.time,adcp.h,'k');
vline(fig.vline,':k');
axis([fig.xaxis fig.ylim]);
set(gca,'XTick',fig.xtick);
datetick('x','HH:MM','keepticks')
caxis([-0.5 0.5]);
colormap(colormapbluewhitered);
[b,~]=colorbarwithvtext('u (cross)',fig.tickvc,'vert','position',get(AX(2,5),'position'));
set(gca,'Fontsize',fig.fonts);
ylabel('Depth (mab)','Fontsize',fig.fonts);
xlabel(fig.xlabel,'Fontsize',fig.fonts);

set(AX(:,1:4),'xticklabel',[])
set(AX(2,:),'yticklabel',[])
delete(AX(2,1))
delete(AX(2,2))
delete(AX(2,3))
delete(AX(2,4))
delete(AX(2,5))

% h2 = findobj(f2,'type','axes','tag','');
% linkaxes(h2,'x');
if strcmp(save_plot,'yes')
print2a4([dir_out,'Navicula_tidal_elevation.png'],'v','w');
end

%% 
figure;
AX = subplot_meshgrid(2,5,[.09 0.01 0.06],[.03 .01 .01 .01 .01 .03],[nan 0.025],[nan nan nan nan nan]);
axes(AX(1,1))
plot(T1.time,T1.ssh,'b','linewidth',fig.lwidth);
hold on
plot(adcp.time,adcp.meanva,'--k','linewidth',fig.lwidth);
hline(0,'k');
vline(fig.vline,':k');
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis -1.5 1.5]);
set(gca,'XTick',fig.xtick);
datetick('x','dd HH:MM','keepticks');
legend('Water level (m)','Alongshore velocity (m/s)');
legend('Location',fig.legendloc,'Orientation',fig.legendorien);

axes(AX(1,2))
pcolorcorcen(fig.t,mat.z,mat.dens-1000)
hold on
vline(fig.vline,':k');
axis([fig.xaxis fig.yaxis])
set(gca,'Xtick',fig.xtick);
datetick('x','HH:MM','keepticks')
caxis(fig.cdens);
colormap('jet');
[c,~] = colorbarwithvtext('Density (kg/m^3)',fig.ctickdens,'vert','Fontsize',fig.fonts,'position',get(AX(2,2),'position'));
% set(h2,'yticklabel',{'21','23','25','27','29','31'});
ylabel('Depth (m)','Fontsize',fig.fonts);
set(gca,'Fontsize',fig.fonts);

axes(AX(1,3))
plot(SBE1527.time10,SBE1527.dens10-1000,'linewidth',fig.lwidth);
hold on
plot(SBE1526.time10,SBE1526.dens10-1000,'--r','linewidth',fig.lwidth);
plot(OBS3A744.time10,OBS3A744.dens10-1000,'m','linewidth',fig.lwidth);
plot(SBE5426.time10,SBE5426.dens10-1000,'-.k','linewidth',fig.lwidth);
plot(SBE5425.time10,SBE5425.dens10-1000,'c','linewidth',fig.lwidth);
plot(SBE1842.time10,SBE1842.dens10-1000,'g','linewidth',fig.lwidth);
vline(fig.vline,':k');
axis([fig.xaxis fig.cdens]);
set(gca,'XTick',fig.xtick);
datetick('x','HH:MM','keepticks');
set(gca,'YTick',fig.ctickdens);
ylabel('Density (kg/m^3)');
legend('MC1527 1mbs','MC1526 3mbs','OBS3A744 5mbs','MC5426 7mbs','MC5425 8mbs','MC1842 10.5mbs');
set(gca,'Fontsize',fig.fonts);
legend('Location',fig.legendloc,'Orientation',fig.legendorien);

axes(AX(1,4))
pcolorcorcen(adcp.time,adcp.z,adcp.va);
hold on
plot(adcp.time,adcp.h,'k');
vline(fig.vline,':k');
axis([fig.xaxis fig.ylim]);
set(gca,'XTick',fig.xtick);
datetick('x','HH:MM','keepticks');
caxis([-1.5 1.5]);
% colormap(colormapbluewhitered);
[h,~]=colorbarwithvtext('v (along)','vert','position',get(AX(2,4),'position')); 
ylabel('Depth (mab)','Fontsize',fig.fonts);
set(gca,'Fontsize',fig.fonts);

axes(AX(1,5))
pcolorcorcen(adcp.time,adcp.z,adcp.vc);
hold on
plot(adcp.time,adcp.h,'k');
vline(fig.vline,':k');
axis([fig.xaxis fig.ylim]);
set(gca,'XTick',fig.xtick);
datetick('x','HH:MM','keepticks')
caxis([-0.5 0.5]);
% colormap(colormapbluewhitered);
[b,~]=colorbarwithvtext('u (cross)',fig.tickvc,'vert','position',get(AX(2,5),'position'));
set(gca,'Fontsize',fig.fonts);
ylabel('Depth (mab)','Fontsize',fig.fonts);
xlabel(fig.xlabel,'Fontsize',fig.fonts);

set(AX(:,1:4),'xticklabel',[])
set(AX(2,:),'yticklabel',[])
delete(AX(2,1))
delete(AX(2,2))
delete(AX(2,3))
delete(AX(2,4))
delete(AX(2,5))

%% Wind arrows

figure;
AX = subplot_meshgrid(2,4,[.09 0.01 0.06],[.03 .01 .01 .01 .03],[nan 0.025],[nan nan nan nan]);
axes(AX(1,1))
plot(T1.time,T1.ssh,'b','linewidth',fig.lwidth);
hold on
plot(adcp.time,adcp.meanva,'--k','linewidth',fig.lwidth);
hline(0,'k');
vline(fig.vline,':k');
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis -1.5 1.5]);
set(gca,'XTick',fig.xtick);
datetick('x','dd HH:MM','keepticks');
legend('Water level (m)','Alongshore velocity (m/s)');
legend('Location',fig.legendloc,'Orientation',fig.legendorien);

axes(AX(1,2))
pcolorcorcen(fig.t,mat.z,mat.dens-1000)
hold on
vline(fig.vline,':k');
axis([fig.xaxis fig.yaxis])
set(gca,'Xtick',fig.xtick);
datetick('x','HH:MM','keepticks')
caxis(fig.cdens);
colormap('jet');
[c,~] = colorbarwithvtext('Density (kg/m^3)',fig.ctickdens,'vert','Fontsize',fig.fonts,'position',get(AX(2,2),'position'));
% set(h2,'yticklabel',{'21','23','25','27','29','31'});
ylabel('Depth (m)','Fontsize',fig.fonts);
set(gca,'Fontsize',fig.fonts);

axes(AX(1,3))
plot(SBE1527.time10,SBE1527.dens10-1000,'linewidth',fig.lwidth);
hold on
plot(SBE1526.time10,SBE1526.dens10-1000,'--r','linewidth',fig.lwidth);
plot(OBS3A744.time10,OBS3A744.dens10-1000,'m','linewidth',fig.lwidth);
plot(SBE5426.time10,SBE5426.dens10-1000,'-.k','linewidth',fig.lwidth);
plot(SBE5425.time10,SBE5425.dens10-1000,'c','linewidth',fig.lwidth);
plot(SBE1842.time10,SBE1842.dens10-1000,'g','linewidth',fig.lwidth);
vline(fig.vline,':k');
axis([fig.xaxis fig.cdens]);
set(gca,'XTick',fig.xtick);
datetick('x','HH:MM','keepticks');
set(gca,'YTick',fig.ctickdens);
ylabel('Density (kg/m^3)');
legend('MC1527 1mbs','MC1526 3mbs','OBS3A744 5mbs','MC5426 7mbs','MC5425 8mbs','MC1842 10.5mbs');
set(gca,'Fontsize',fig.fonts);
legend('Location',fig.legendloc,'Orientation',fig.legendorien);

axes(AX(1,4))
quiver(wind.time,wind.time*0,-wind.speed10.*sin((wind.dir10*pi)/180),-wind.speed10.*cos((wind.dir10*pi)/180));
set(gca,'YTickLabel',[]);
grid on
hold on
vline(fig.vline,':k');
hline(0,'k');
axis([fig.xaxis -1 1]);
set(gca,'Xtick',fig.xtick);
datetick('x','dd HH:MM','keepticks');
set(gca,'Fontsize',fig.fonts);
ylabel('Wind','Fontsize',fig.fonts);

set(AX(:,1:3),'xticklabel',[])
set(AX(2,:),'yticklabel',[])
delete(AX(2,1))
delete(AX(2,2))
delete(AX(2,3))
delete(AX(2,4))

%% Plot PEA

figure;
AX = subplot_meshgrid(2,5,[.09 0.01 0.06],[.03 .01 .01 .01 .01 .03],[nan 0.025],[nan nan nan nan nan]);
axes(AX(1,1))
pcolorcorcen(fig.t,mat.z,mat.dens-1000)
hold on
vline(fig.vline,':k');
axis([fig.xaxis fig.yaxis])
set(gca,'Xtick',fig.xtick);
datetick('x','HH:MM','keepticks')
caxis(fig.cdens);
colormap('jet');
[c,~] = colorbarwithvtext('Density (kg/m^3)',fig.ctickdens,'vert','Fontsize',fig.fonts,'position',get(AX(2,1),'position'));
% set(h2,'yticklabel',{'21','23','25','27','29','31'});
ylabel('Depth (m)');
set(gca,'Fontsize',fig.fonts);

axes(AX(1,2))
plot(SBE1527.time10,SBE1527.dens10-1000,'linewidth',fig.lwidth);
hold on
plot(SBE1526.time10,SBE1526.dens10-1000,'--r','linewidth',fig.lwidth);
plot(OBS3A744.time10,OBS3A744.dens10-1000,'m','linewidth',fig.lwidth);
plot(SBE5426.time10,SBE5426.dens10-1000,'-.k','linewidth',fig.lwidth);
plot(SBE5425.time10,SBE5425.dens10-1000,'c','linewidth',fig.lwidth);
plot(SBE1842.time10,SBE1842.dens10-1000,'g','linewidth',fig.lwidth);
vline(fig.vline,':k');
axis([fig.xaxis fig.cdens]);
set(gca,'XTick',fig.xtick);
datetick('x','HH:MM','keepticks');
set(gca,'YTick',fig.ctickdens);
ylabel('Density (kg/m^3)');
legend('MC1527 1mbs','MC1526 3mbs','OBS3A744 5mbs','MC5426 7mbs','MC5425 8mbs','MC1842 10.5mbs');
set(gca,'Fontsize',fig.fonts);
legend('Location',fig.legendloc,'Orientation',fig.legendorien);


axes(AX(1,3))
pcolorcorcen(adcp.time,adcp.z,adcp.va);
hold on
plot(adcp.time,adcp.h,'k');
vline(fig.vline,':k');
axis([fig.xaxis fig.ylim]);
set(gca,'XTick',fig.xtick);
datetick('x','HH:MM','keepticks');
caxis([-1.5 1.5]);
colormap(colormapbluewhitered);
[h,~]=colorbarwithvtext('v (along)','vert','position',get(AX(2,3),'position')); 
ylabel('Depth (mab)');
set(gca,'Fontsize',fig.fonts);

axes(AX(1,4))
pcolorcorcen(adcp.time,adcp.z,adcp.vc);
hold on
plot(adcp.time,adcp.h,'k');
vline(fig.vline,':k');
axis([fig.xaxis fig.ylim]);
set(gca,'XTick',fig.xtick);
datetick('x','HH:MM','keepticks')
caxis([-0.5 0.5]);
colormap(colormapbluewhitered);
[b,~]=colorbarwithvtext('u (cross)',fig.tickvc,'vert','position',get(AX(2,4),'position'));
ylabel('Depth (mab)');
set(gca,'Fontsize',fig.fonts);

axes(AX(1,5))
plot(fig.t,mat.PEA)
hold on
vline(fig.vline,':k');
axis([fig.xaxis 0 40]);
set(gca,'XTick',fig.xtick);
datetick('x','HH:MM','keepticks')
ylabel('PEA (J/m^3)');
xlabel(fig.xlabel);
set(gca,'Fontsize',fig.fonts);

set(AX(:,1:4),'xticklabel',[])
set(AX(2,:),'yticklabel',[])
delete(AX(2,1))
delete(AX(2,2))
delete(AX(2,3))
delete(AX(2,4))
delete(AX(2,5))