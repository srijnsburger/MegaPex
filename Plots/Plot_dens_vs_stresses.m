% Plot bed shear stresses 12m 
clc,clear all;
%close all;

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
    load('d:\sabinerijnsbur\Matlab\Mini-stable\Stress');
    in.ylim = [0 15];
elseif strcmp(mooring,'18m')
    load([dirin,'SBE1525.mat']);
    load([dirin,'SBE4939.mat']);
    load([dirin,'SBE4940.mat']);
    load([dirin,'SBE19_corrected.mat']);
    in.ylim = [0 20];
else
end

% conditions
load('d:\sabinerijnsbur\Matlab\Megapex\Conditions\wave.mat');
load('d:\sabinerijnsbur\Matlab\Megapex\Conditions\tide.mat');
load('d:\sabinerijnsbur\Matlab\Megapex\Conditions\wind.mat');
load('d:\sabinerijnsbur\Matlab\Megapex\Conditions\potwind.mat');

%% sea surface height

ssh = adcp.h - mean(adcp.h);

neap1   = find(adcp.t>=adcp.t(1) & adcp.t<266);
spr1    = find(adcp.t>266 & adcp.t<273);
neap2   = find(adcp.t>273 & adcp.t<280);
spr2    = find(adcp.t>280 & adcp.t<287);
neap3   = find(adcp.t>287 & adcp.t<294);

%% zero-crossing

[zc]  = Zero_crossing(adcp.t,ssh);

%% bed stress

bstress = sqrt(Stress.wave(:,1).^2+Stress.wave(:,2).^2)*1025;

%% Input

fig.xlim = [260 289];

%% Plot

fhandle = figure;
AX = subplot_meshgrid(2,6,[.06 0.01 0.05],[.03 .01 .01 .01 .01 .01 .03],[nan 0.02],[nan nan nan nan nan nan]);
axes(AX(1,1))
plot(adcp.t(neap1),ssh(neap1),'r');
hold on
plot(adcp.t(spr1),ssh(spr1),'b');
plot(adcp.t(neap2),ssh(neap2),'r');
plot(adcp.t(spr2),ssh(spr2),'b');
plot(adcp.t(neap3),ssh(neap3),'r');
hline(0,'k');
plot(adcp.t,adcp.meanva,'--k');
vline(adcp.t(zc),'--k');
xlim([fig.xlim]);
title([mooring]);

if strcmp(mooring,'12m')
    axes(AX(1,2))
    plot(SBE1527.t10,SBE1527.dens10-1000);
    hold on
    plot(SBE1526.t10,SBE1526.dens10-1000,'--r');
    plot(SBE5426.t10,SBE5426.dens10-1000,'-.k');
    plot(SBE5425.t10,SBE5425.dens10-1000,'c');
    plot(SBE1842.t10,SBE1842.dens10-1000,'g');
    vline(adcp.t(zc),'--k');
    xlim([fig.xlim]);
    legend('1mbs','3mbs','7mbs','8mbs','10.5mbs');
    legend('orientation','horizontal');
elseif strcmp(mooring,'18m')
    axes(AX(1,2))
    plot(SBE1525.t,SBE1525.dens-1000);
    hold on
    plot(SBE4939.t,SBE4939.dens-1000,'--r');
    plot(SBE4940.t,SBE4940.dens-1000,'-.k');
    plot(SBE19.t,SBE19.dens-1000,'c');
    vline(adcp.t(zc),'--k');
    xlim([fig.xlim]);
    legend('1mb2','2.5mbs','10mbs','15mbs');
    legend('orientation','horizontal');
end

axes(AX(1,3))
pcolorcorcen(adcp.t,adcp.z,adcp.va);
hold on
plot(adcp.t,adcp.h,'k');
vline(adcp.t(zc),'--k');
colorbar('position',get(AX(2,3),'position'));
colormap(colormapbluewhitered);
xlim([fig.xlim]);

axes(AX(1,4))
pcolorcorcen(adcp.t,adcp.z,adcp.vc);
hold on
plot(adcp.t,adcp.h,'k');
vline(adcp.t(zc),'--k');
colorbar('position',get(AX(2,3),'position'));
colormap(colormapbluewhitered);
xlim([fig.xlim]);

axes(AX(1,5))
plot(Stress.time,bstress);
hline(0,'k');
vline(adcp.t(zc),'--k');
xlim([fig.xlim]);
ylim([0 1]);

axes(AX(1,6))
quiver(wind.t,wind.t*0,-wind.speed10.*sin((wind.dir10*pi)/180),-wind.speed10.*cos((wind.dir10*pi)/180));
set(gca,'YTickLabel',[]);
grid on
vline(adcp.t(zc),'--k');
xlim([fig.xlim]);
ylim([-1 1]);

set(AX(:,1:5),'xticklabel',[])
set(AX(2,:),'yticklabel',[])
delete(AX(2,1))
delete(AX(2,2))
delete(AX(2,3))
delete(AX(2,4))
delete(AX(2,5))
delete(AX(2,6))

set(gcf,'color','w');
h = findobj(fhandle,'type','axes','tag','');
linkaxes(h,'x');


