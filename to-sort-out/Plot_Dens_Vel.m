clc;clear all; close all;

% Load data
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\Mooring12_av_corr.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\Mooring18_av_corr.mat');

% load('d:\sabinerijnsbur\Matlab\adcp\adcp12.mat');
load('d:\sabinerijnsbur\Matlab\adcp\adcp12C.mat');
load('d:\sabinerijnsbur\Matlab\adcp\adcp18.mat');

%% Calculate tidal elevation
ssh12     = adcp12C.h-mean(adcp12C.h);
np1_12    = find(adcp12C.t>=adcp12C.t(1) & adcp12C.t<266);
spr1_12   = find(adcp12C.t>266 & adcp12C.t<273);
np2_12    = find(adcp12C.t>273 & adcp12C.t<280);
spr2_12     = find(adcp12C.t>280 & adcp12C.t<287);
np3_12    = find(adcp12C.t>287 & adcp12C.t<294);

ssh18     = adcp18.h-mean(adcp18.h);
np1_18   = find(adcp18.t>=adcp18.t(1) & adcp18.t<266);
spr1_18    = find(adcp18.t>266 & adcp18.t<273);
np2_18   = find(adcp18.t>273 & adcp18.t<280);
spr2_18    = find(adcp18.t>280 & adcp18.t<287);
% neap3   = find(adcp18.t>287 & adcp18.t<294);


%% Input figure

fig.xlim = [260 289];
fig.xlim2 = [260 280];
fig.fonts = 14;

%% Plot 12m 

figure;
AX = subplot_meshgrid(2,3,[.06 0.01 0.04],[.03 .01 .015 .1],[nan 0.02],[nan nan nan]);
axes(AX(1,1))
plot(t12,D12,'Linewidth',0.8);
set(gca,'Fontsize',fig.fonts);
xlim(fig.xlim);
ylabel('\rho (kg/m^3)');
legend('1mbs','3mbs','7mbs','8mbs','10.5mbs');
legend('Orientation','horizontal','Location','SouthEast');
% title('12m site','Fontweight','normal');

axes(AX(1,2))
pcolorcorcen(adcp12C.t,adcp12C.z,adcp12C.va);
hold on
plot(adcp12C.t,adcp12C.h);
set(gca,'Fontsize',fig.fonts);
ylabel('z (m)');
xlim(fig.xlim);
clim([-1.0 1.0]);
colorbarwithvtext('v (along)','vert','position',get(AX(2,2),'position'));
colormap(colormapbluewhitered);


axes(AX(1,3))
pcolorcorcen(adcp12C.t,adcp12C.z,adcp12C.vc);
hold on
plot(adcp12C.t,adcp12C.h);
set(gca,'Fontsize',fig.fonts);
xlim(fig.xlim);
clim([-0.5 0.5]);
ylabel('z (m)');
xlabel('day of year');
colorbarwithvtext('u (cross)','vert','position',get(AX(2,3),'position'));
colormap(colormapbluewhitered);

set(AX(:,1:2),'xticklabel',[])
set(AX(2,:),'yticklabel',[])
delete(AX(2,1))
delete(AX(2,2))
delete(AX(2,3))

set(gcf,'color','w');
set(findall(gcf,'type','text'),'FontSize',fig.fonts);

% with tidal elevation

figure;
AX = subplot_meshgrid(2,4,[.06 0.01 0.04],[.03 .01 .01 .015 .1],[nan 0.02],[nan nan nan nan]);
axes(AX(1,1))
plot(adcp12C.t(np1_12 ),ssh12(np1_12 ),'r');
hold on
plot(adcp12C.t(spr1_12 ),ssh12(spr1_12 ),'b');
plot(adcp12C.t(np2_12 ),ssh12(np2_12 ),'r');
plot(adcp12C.t(spr2_12 ),ssh12(spr2_12 ),'b');
plot(adcp12C.t(np3_12 ),ssh12(np3_12 ),'r');
hline(0,'k');
set(gca,'Fontsize',fig.fonts);
xlim(fig.xlim);
ylim([-1.5 1.5]);
ylabel('\eta (m)');

axes(AX(1,2))
plot(t12,D12,'Linewidth',0.8);
set(gca,'Fontsize',fig.fonts);
xlim(fig.xlim);
ylabel('\rho (kg/m^3)');
legend('1mbs','3mbs','7mbs','8mbs','10.5mbs');
legend('Orientation','horizontal','Location','SouthEast');

axes(AX(1,3))
pcolorcorcen(adcp12C.t,adcp12C.z,adcp12C.va);
hold on
plot(adcp12C.t,adcp12C.h);
set(gca,'Fontsize',fig.fonts);
ylabel('z (m)');
xlim(fig.xlim);
clim([-1.0 1.0]);
colorbarwithvtext('v (along)','vert','position',get(AX(2,3),'position'));
colormap(colormapbluewhitered);

axes(AX(1,4))
pcolorcorcen(adcp12C.t,adcp12C.z,adcp12C.vc);
hold on
plot(adcp12C.t,adcp12C.h);
set(gca,'Fontsize',fig.fonts);
xlim(fig.xlim);
clim([-0.5 0.5]);
ylabel('z (m)');
xlabel('day of year');
colorbarwithvtext('u (cross)','vert','position',get(AX(2,4),'position'));
colormap(colormapbluewhitered);


set(AX(:,1:3),'xticklabel',[])
set(AX(2,:),'yticklabel',[])
delete(AX(2,1))
delete(AX(2,2))
delete(AX(2,3))
delete(AX(2,4))

set(gcf,'color','w');
set(findall(gcf,'type','text'),'FontSize',fig.fonts);


%% Plot 18m

figure;
AX = subplot_meshgrid(2,3,[.06 0.01 0.04],[.03 .01 .015 .1],[nan 0.02],[nan nan nan]);
axes(AX(1,1))
plot(t18,D18,'Linewidth',0.8);
set(gca,'Fontsize',fig.fonts);
xlim(fig.xlim2);
ylabel('\rho (kg/m^3)');
legend('1mbs','2.5mbs','10mbs','15mbs');
legend('Orientation','horizontal','Location','SouthEast');
% title('18m site','Fontweight','normal');

axes(AX(1,2))
pcolorcorcen(adcp18.t,adcp18.z,adcp18.va);
hold on
plot(adcp18.t,adcp18.h);
set(gca,'Fontsize',fig.fonts);
ylabel('z (m)');
xlim(fig.xlim2);
clim([-1.0 1.0]);
colorbarwithvtext('v (along)','vert','position',get(AX(2,2),'position'));
colormap(colormapbluewhitered);


axes(AX(1,3))
pcolorcorcen(adcp18.t,adcp18.z,adcp18.vc);
hold on
plot(adcp18.t,adcp18.h);
set(gca,'Fontsize',fig.fonts);
xlim(fig.xlim2);
clim([-0.5 0.5]);
ylabel('z (m)');
xlabel('day of year');
colorbarwithvtext('u (cross)','vert','position',get(AX(2,3),'position'));
colormap(colormapbluewhitered);


set(AX(:,1:2),'xticklabel',[])
set(AX(2,:),'yticklabel',[])
delete(AX(2,1))
delete(AX(2,2))
delete(AX(2,3))

set(gcf,'color','w');
set(findall(gcf,'type','text'),'FontSize',fig.fonts);

% with tidal elevation

figure;
AX = subplot_meshgrid(2,4,[.06 0.01 0.04],[.03 .01 .01 .015 .1],[nan 0.02],[nan nan nan nan]);
axes(AX(1,1))
plot(adcp18.t(np1_18),ssh18(np1_18),'r');
hold on
plot(adcp18.t(spr1_18),ssh18(spr1_18),'b');
plot(adcp18.t(np2_18),ssh18(np2_18),'r');
plot(adcp18.t(spr2_18),ssh18(spr2_18),'b');
hline(0,'k');
set(gca,'Fontsize',fig.fonts);
xlim(fig.xlim2);
ylim([-1.5 1.5]);
ylabel('\eta (m)');

axes(AX(1,2))
plot(t18,D18,'Linewidth',0.8);
set(gca,'Fontsize',fig.fonts);
xlim(fig.xlim2);
ylabel('\rho (kg/m^3)');
legend('1mbs','2.5mbs','10mbs','15mbs');
legend('Orientation','horizontal','Location','SouthEast');

axes(AX(1,3))
pcolorcorcen(adcp18.t,adcp18.z,adcp18.va);
hold on
plot(adcp18.t,adcp18.h);
set(gca,'Fontsize',fig.fonts);
ylabel('z (m)');
xlim(fig.xlim2);
clim([-1.0 1.0]);
colorbarwithvtext('v (along)','vert','position',get(AX(2,3),'position'));
colormap(colormapbluewhitered);


axes(AX(1,4))
pcolorcorcen(adcp18.t,adcp18.z,adcp18.vc);
hold on
plot(adcp18.t,adcp18.h);
set(gca,'Fontsize',fig.fonts);
xlim(fig.xlim2);
clim([-0.5 0.5]);
ylabel('z (m)');
xlabel('day of year');
colorbarwithvtext('u (cross)','vert','position',get(AX(2,4),'position'));
colormap(colormapbluewhitered);


set(AX(:,1:3),'xticklabel',[])
set(AX(2,:),'yticklabel',[])
delete(AX(2,1))
delete(AX(2,2))
delete(AX(2,3))
delete(AX(2,4))

set(gcf,'color','w');
set(findall(gcf,'type','text'),'FontSize',fig.fonts);

%% Both

figure;
AX = subplot_meshgrid(2,5,[.06 0.01 0.04],[.01 .01 .03 .021 .021 .08],[nan 0.02],[nan nan nan nan nan]);
axes(AX(1,1))
plot(t12,D12,'Linewidth',0.8);
set(gca,'Fontsize',fig.fonts);
xlim(fig.xlim);
ylabel('\rho (kg/m^3)');
% legend('1mbs','3mbs','7mbs','8mbs','10.5mbs');
% legend('Orientation','horizontal','Location','SouthEast');

axes(AX(1,2))
plot(t18,D18,'Linewidth',0.8);
set(gca,'Fontsize',fig.fonts);
xlim(fig.xlim);
ylabel('\rho (kg/m^3)');
% legend('1mbs','2.5mbs','10mbs','15mbs');
% legend('Orientation','horizontal','Location','SouthEast');

axes(AX(1,3))
plot(adcp12C.t(np1_12 ),ssh12(np1_12 ),'r');
hold on
plot(adcp12C.t(spr1_12 ),ssh12(spr1_12 ),'b');
plot(adcp12C.t(np2_12 ),ssh12(np2_12 ),'r');
plot(adcp12C.t(spr2_12 ),ssh12(spr2_12 ),'b');
plot(adcp12C.t(np3_12 ),ssh12(np3_12 ),'r');
hline(0,'k');
set(gca,'Fontsize',fig.fonts);
xlim(fig.xlim);
ylim([-1.5 1.5]);
ylabel('\eta (m)');

axes(AX(1,4))
plot(t12,D12,'Linewidth',0.8);
set(gca,'Fontsize',fig.fonts);
xlim(fig.xlim);
ylabel('\rho (kg/m^3)');
% legend('1mbs','3mbs','7mbs','8mbs','10.5mbs');
% legend('Orientation','horizontal','Location','SouthEast');

axes(AX(1,5))
plot(t18,D18,'Linewidth',0.8);
set(gca,'Fontsize',fig.fonts);
xlim(fig.xlim);
ylabel('\rho (kg/m^3)');
% legend('1mbs','2.5mbs','10mbs','15mbs');
% legend('Orientation','horizontal','Location','SouthEast');


set(AX(:,1:4),'xticklabel',[])
set(AX(2,:),'yticklabel',[])
delete(AX(2,1))
delete(AX(2,2))
delete(AX(2,3))
delete(AX(2,4))
delete(AX(2,5))

set(gcf,'color','w');
set(findall(gcf,'type','text'),'FontSize',fig.fonts);
