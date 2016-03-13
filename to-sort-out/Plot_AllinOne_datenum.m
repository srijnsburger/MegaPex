% PLOT ALL INFORMATION - DATENUM

clc;clear all; close all;

%% Load data

mooring = '12';
dirin   = 'd:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\';

% load CTDs
load([dirin,'Mooring',mooring,'_adcp_corr.mat']);

% load ADCP
if strcmp(mooring,'12')
    load('d:\sabinerijnsbur\Matlab\adcp\adcp12C.mat');
    adcp = adcp12C;
    M    = M12;
    dD   = M.D(5,:)-M.D(1,:);
    leg  = {'1mbs','3mbs','7mbs','8mbs','10.5mbs'};
    leg2 = {'1mbs','10.5mbs'};
else
    load('d:\sabinerijnsbur\Matlab\adcp\adcp18.mat');
    adcp = adcp18;
    M    = M18;
    dD   = M.D(4,:)-M.D(1,:);
    leg  = {'1mbs','2.5mbs','10mbs','15mbs'};
    leg2 = {'1mbs','15mbs'};
end

% conditions
load('d:\sabinerijnsbur\Matlab\MegaPex\Conditions\wave.mat'); % needs to be improved
load('d:\sabinerijnsbur\Matlab\MegaPex\Conditions\tide.mat');
load('d:\sabinerijnsbur\Matlab\MegaPex\Conditions\wind.mat');
% load('d:\sabinerijnsbur\Matlab\MegaPex\Conditions\potwind.mat');

%% Calculate spring-neap periods

np1    = find(adcp.t>=adcp.t(1) & adcp.t<266);
spr1   = find(adcp.t>266 & adcp.t<273);
np2    = find(adcp.t>273 & adcp.t<280);
spr2   = find(adcp.t>280 & adcp.t<287);
np3    = find(adcp.t>287 & adcp.t<294);

%% Input figure

t1 = datenum(2014,09,16);
t2 = datenum(2014,10,16);
dt = (1/24)*24;
fig.xtick = t1:dt:t2;
fig.format = 'dd/mm';
fig.xlim  = [t1 t2];
fig.fonts = 10;

%% Ssh, T, S, va, vc, (wind arrows ?)

f1 = figure;
AX = subplot_meshgrid(2,5,[.06 0.01 0.05],[.03 .01 .01 .01 .01 .03],[nan 0.02],[nan nan nan nan nan]);
axes(AX(1,1))
plot(adcp.time(np1),M.ssh(np1),'r');
hold on
plot(adcp.time(spr1),M.ssh(spr1),'b');
plot(adcp.time(np2),M.ssh(np2),'r');
plot(adcp.time(spr2),M.ssh(spr2),'b');
plot(adcp.time(np3),M.ssh(np3),'r');
hline(0,'k');
set(gca,'Fontsize',fig.fonts);
set(gca,'Xtick',fig.xtick);
datetick('x',fig.format,'keepticks');
xlim(fig.xlim);
ylim([-1.5 1.5]);
ylabel('\eta (m)');

axes(AX(1,2))
plot(M.time,M.T);
set(gca,'Fontsize',fig.fonts);
set(gca,'Xtick',fig.xtick);
datetick('x',fig.format,'keepticks');
xlim(fig.xlim);
ylabel('T (\circ)');
legend(leg,'Orientation','horizontal','Location','South');

axes(AX(1,3))
plot(M.time,M.S);
set(gca,'Fontsize',fig.fonts);
set(gca,'Xtick',fig.xtick);
datetick('x',fig.format,'keepticks');
xlim(fig.xlim);
ylabel('S (psu)');

axes(AX(1,4))
pcolorcorcen(adcp.time,adcp.z,adcp.va);
hold on
plot(adcp.time,adcp.h);
set(gca,'Fontsize',fig.fonts);
set(gca,'Xtick',fig.xtick);
datetick('x',fig.format,'keepticks');
xlim(fig.xlim);
ylabel('z (m)');
clim([-1.0 1.0]);
colorbarwithvtext('va','vert','position',get(AX(2,4),'position'));
colormap(colormapbluewhitered);

axes(AX(1,5))
pcolorcorcen(adcp.time,adcp.z,adcp.vc);
hold on
plot(adcp.time,adcp.h);
set(gca,'Fontsize',fig.fonts);
set(gca,'Xtick',fig.xtick);
datetick('x',fig.format,'keepticks');
xlim(fig.xlim);
ylabel('z (m)');
clim([-0.5 0.5]);
colorbarwithvtext('vc','vert','position',get(AX(2,5),'position'));
colormap(colormapbluewhitered);

set(AX(:,1:4),'xticklabel',[])
set(AX(2,:),'yticklabel',[])
delete(AX(2,1))
delete(AX(2,2))
delete(AX(2,3))
delete(AX(2,4))
delete(AX(2,5))

set(gcf,'color','w');
% set(findall(gcf,'type','text'),'FontSize',fig.fonts);
% h1 = findobj(f1,'type','axes','tag','');
linkaxes(AX(1,:),'x');

%% Ssh, D, va,vc,cond

f2 = figure;
AX = subplot_meshgrid(2,7,[.06 0.01 0.05],[.03 .01 .01 .01 .01 .01 .01 .03],[nan 0.02],[nan nan nan nan nan nan nan]);
axes(AX(1,1))
plot(adcp.time(np1),M.ssh(np1),'r');
hold on
plot(adcp.time(spr1),M.ssh(spr1),'b');
plot(adcp.time(np2),M.ssh(np2),'r');
plot(adcp.time(spr2),M.ssh(spr2),'b');
plot(adcp.time(np3),M.ssh(np3),'r');
hline(0,'k');
set(gca,'Fontsize',fig.fonts);
set(gca,'Xtick',fig.xtick);
datetick('x',fig.format,'keepticks');
xlim(fig.xlim);
ylim([-1.5 1.5]);
ylabel('\eta (m)');

axes(AX(1,2))
plot(M.time,M.D);
set(gca,'Fontsize',fig.fonts);
set(gca,'Xtick',fig.xtick);
datetick('x',fig.format,'keepticks');
xlim(fig.xlim);
ylabel('\rho (kg/m^3)');
legend(leg,'Orientation','horizontal','Location','South');

axes(AX(1,3))
pcolorcorcen(adcp.time,adcp.z,adcp.va);
hold on
plot(adcp.time,adcp.h);
set(gca,'Fontsize',fig.fonts);
set(gca,'Xtick',fig.xtick);
datetick('x',fig.format,'keepticks');
xlim(fig.xlim);
ylabel('z (m)');
clim([-1.0 1.0]);
colorbarwithvtext('va','vert','position',get(AX(2,3),'position'));
colormap(colormapbluewhitered);

axes(AX(1,4))
pcolorcorcen(adcp.time,adcp.z,adcp.vc);
hold on
plot(adcp.time,adcp.h);
set(gca,'Fontsize',fig.fonts);
set(gca,'Xtick',fig.xtick);
datetick('x',fig.format,'keepticks');
xlim(fig.xlim);
ylabel('z (m)');
clim([-0.5 0.5]);
colorbarwithvtext('vc','vert','position',get(AX(2,4),'position'));
colormap(colormapbluewhitered);

axes(AX(1,5))
plot(wind.time,wind.speed);
grid on
% axis([fig.xaxis 0 20]);
set(gca,'Xtick',fig.xtick);
datetick('x',fig.format,'keepticks');
xlim(fig.xlim);
% set(gca,'YTick',[0 5 10 15 20]);
set(gca,'Fontsize',fig.fonts);
ylabel('(m/s)','Fontsize',fig.fonts);

axes(AX(1,6))
plot(wind.time,wind.dir10);
grid on
ylim([0 360]);
set(gca,'Xtick',fig.xtick);
datetick('x',fig.format,'keepticks');
xlim(fig.xlim);
% set(gca,'YTick',[0 90 180 270 360]);
set(gca,'Fontsize',fig.fonts);
ylabel('dir (\circ)','Fontsize',fig.fonts);

axes(AX(1,7))
plot(Hs.time,Hs.hs);
grid on
% axis([fig.xaxis 0 3]);
set(gca,'Xtick',fig.xtick);
datetick('x',fig.format,'keepticks');
xlim(fig.xlim);
% set(gca,'YTick',[0 0.5 1 1.5 2 2.5 3]);
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

set(gcf,'color','w');
% set(findall(gcf,'type','text'),'FontSize',fig.fonts);
h2 = findobj(f2,'type','axes','tag','');
linkaxes(h2,'x');

%% Ssh, D, va, vc, wind arrows

f3 = figure;
AX = subplot_meshgrid(2,5,[.06 0.01 0.05],[.03 .01 .01 .01 .01 .03],[nan 0.02],[nan nan nan nan nan]);
axes(AX(1,1))
plot(adcp.time(np1),M.ssh(np1),'r');
hold on
plot(adcp.time(spr1),M.ssh(spr1),'b');
plot(adcp.time(np2),M.ssh(np2),'r');
plot(adcp.time(spr2),M.ssh(spr2),'b');
plot(adcp.time(np3),M.ssh(np3),'r');
hline(0,'k');
set(gca,'Fontsize',fig.fonts);
set(gca,'Xtick',fig.xtick);
datetick('x',fig.format,'keepticks');
xlim(fig.xlim);
ylim([-1.5 1.5]);
ylabel('\eta (m)');

axes(AX(1,2))
plot(M.time,M.D);
set(gca,'Fontsize',fig.fonts);
set(gca,'Xtick',fig.xtick);
datetick('x',fig.format,'keepticks');
xlim(fig.xlim);
ylabel('\rho (kg/m^3)');
legend(leg,'Orientation','horizontal','Location','South');

axes(AX(1,3))
pcolorcorcen(adcp.time,adcp.z,adcp.va);
hold on
plot(adcp.time,adcp.h);
set(gca,'Fontsize',fig.fonts);
set(gca,'Xtick',fig.xtick);
datetick('x',fig.format,'keepticks');
xlim(fig.xlim);
ylabel('z (m)');
clim([-1.0 1.0]);
colorbarwithvtext('va','vert','position',get(AX(2,3),'position'));
colormap(colormapbluewhitered);

axes(AX(1,4))
pcolorcorcen(adcp.time,adcp.z,adcp.vc);
hold on
plot(adcp.time,adcp.h);
set(gca,'Fontsize',fig.fonts);
set(gca,'Xtick',fig.xtick);
datetick('x',fig.format,'keepticks');
xlim(fig.xlim);
ylabel('z (m)');
clim([-0.5 0.5]);
colorbarwithvtext('vc','vert','position',get(AX(2,4),'position'));
colormap(colormapbluewhitered);

axes(AX(1,5))
quiver(wind.time,wind.time*0,-wind.speed10.*sin((wind.dir10*pi)/180),-wind.speed10.*cos((wind.dir10*pi)/180));
grid on
hold on
hline(0,'k');
set(gca,'YTickLabel',[]);
set(gca,'Xtick',fig.xtick);
datetick('x',fig.format,'keepticks');
xlim(fig.xlim);
ylim([-1 1]);
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
set(findall(gcf,'type','text'),'FontSize',fig.fonts);
h3 = findobj(f3,'type','axes','tag','');
linkaxes(h3,'x');

%% Ssh, D, dD, va,vc, (dX?)

figure;
AX = subplot_meshgrid(1,5,[.06 0.05],[.03 .01 .01 .01 .01 .03],[nan],[nan nan nan nan nan]);
axes(AX(1,1))
plot(adcp.time(np1),M.ssh(np1),'r');
hold on
plot(adcp.time(spr1),M.ssh(spr1),'b');
plot(adcp.time(np2),M.ssh(np2),'r');
plot(adcp.time(spr2),M.ssh(spr2),'b');
plot(adcp.time(np3),M.ssh(np3),'r');
hline(0,'k');
set(gca,'Fontsize',fig.fonts);
set(gca,'Xtick',fig.xtick);
datetick('x',fig.format,'keepticks');
xlim(fig.xlim);
ylim([-1.5 1.5]);
ylabel('\eta (m)');

axes(AX(1,2))
plot(M.time,M.D);
set(gca,'Fontsize',fig.fonts);
set(gca,'Xtick',fig.xtick);
datetick('x',fig.format,'keepticks');
xlim(fig.xlim);
ylabel('\rho (kg/m^3)');
legend(leg,'Orientation','horizontal','Location','South');

axes(AX(1,3))
plot(M.time,dD);
set(gca,'Fontsize',fig.fonts);
ylim([0 10]);
set(gca,'Xtick',fig.xtick);
datetick('x',fig.format,'keepticks');
xlim(fig.xlim);
ylabel('\Delta \rho (kg/m^3)');

axes(AX(1,4))
plot(M.time,M.va(1,:))
hold on
plot(M.time,M.va(end,:))
hline(0,'k');
set(gca,'Fontsize',fig.fonts);
ylim([-1 1]);
set(gca,'Xtick',fig.xtick);
datetick('x',fig.format,'keepticks');
xlim(fig.xlim);
ylabel('va (m/s)');
legend(leg2,'Orientation','horizontal','Location','South');

axes(AX(1,5))
plot(M.time,M.vc(1,:))
hold on
plot(M.time,M.vc(end,:))
hline(0,'k');
set(gca,'Fontsize',fig.fonts);
ylim([-0.5 0.5]);
set(gca,'Xtick',fig.xtick);
datetick('x',fig.format,'keepticks');
xlim(fig.xlim);
ylabel('vc (m/s)');

set(AX(:,1:4),'xticklabel',[])

set(gcf,'color','w');
% set(findall(gcf,'type','text'),'FontSize',fig.fonts);
linkaxes(AX(1,:),'x');
