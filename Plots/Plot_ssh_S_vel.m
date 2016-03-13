%% Figure ssh, sal, vel
clc;clear all;close all;

% Load data
Loc       = '12'; %Location
dir_out   = 'd:\sabinerijnsbur\Figures-Matlab\Figures-MegaPex-2014\Presentation_OS2016\';
flag_print= 1;

eval(['load(''d:\sabinerijnsbur\Matlab_files\Megapex_data\Moorings\Mfiles_adcp\Mooring' Loc '_adcp_corr.mat'');']);
eval(['M = M' Loc ''';']);

if find(strcmp(Loc,'12')==1)
    load('d:\sabinerijnsbur\Matlab_files\Megapex_data\adcp\adcp12C');
    adcp = adcp12C;
else
   eval(['load(''d:\sabinerijnsbur\Matlab_files\Megapex_data\adcp\adcp' Loc ''');']);
   eval(['adcp = adcp' Loc ''';']);
end

%% Determine ssh

ssh = adcp.h - mean(adcp.h);

% Determine spring-neap
[period] = determine_spring_neap(adcp.t);

%% Surface & bottom vel

[out] = surface_bottom_velocity(adcp.va,adcp.vc);

%% Input figure
fig.lwidth      = 1.2;
fig.fonts       = 16;
fig.xlim        = [260 273];
fig.legendloc   = 'SouthEast';
fig.legendorien = 'horizontal';
cmp             = get(groot,'DefaultAxesColorOrder');
cwbr            = colormapbluewhitered;
close;

%% Plot
fh = figure;
AX = subplot_meshgrid(2,3,[.07 0.01 0.055],[.03 .04 .04 .081],[nan 0.023],[nan nan nan]);
axes(AX(1,1))
plot(M.t(period.p1),M.ssh(period.p1),'Color',cmp(1,:),'Linewidth',fig.lwidth);
hold on
plot(M.t(period.p2),M.ssh(period.p2),'Color',cmp(2,:),'Linewidth',fig.lwidth);
legend('Neap','Spring');
legend('Location',fig.legendloc,'Orientation',fig.legendorien);
leg = legend('Boxoff');
set(leg,'FontSize',fig.fonts);
plot(M.t(period.p3),M.ssh(period.p3),'Color',cmp(1,:),'Linewidth',fig.lwidth);
plot(M.t(period.p4),M.ssh(period.p4),'Color',cmp(2,:),'Linewidth',fig.lwidth);
plot(M.t(period.p5),M.ssh(period.p5),'Color',cmp(1,:),'Linewidth',fig.lwidth);
hline(0,'-k');
xlim(fig.xlim);
ylim([-1.5 1.5]);
ylabel('\eta (m)');
set(gca,'Fontsize',fig.fonts);

axes(AX(1,2))
plot(M.t,M.S,'linewidth',fig.lwidth);
hold on
legend('1m','3m','7m','8m','10.5m');
legend('Location',fig.legendloc,'Orientation',fig.legendorien);
leg = legend('Boxoff');
set(leg,'FontSize',fig.fonts);
xlim(fig.xlim);
ylim([18 32]);
ylabel('S (PSU)');
set(gca,'Fontsize',fig.fonts);

% axes(AX(1,3))
% pcolorcorcen(adcp.t,adcp.z,adcp.va);
% hold on
% plot(adcp.t,adcp.h,'k','Linewidth',fig.lwidth);
% ylabel('z (m)');
% colormap(cwbr);
% clim([-1 1]);
% [ax,h] = colorbarwithvtext('va (m/s)','position',get(AX(2,3),'position'));
% % cb1 = colorbar('position',get(AX(2,2),'position'));
% title(ax,{'+ NE'},'Fontsize',fig.fonts);
% xlim(fig.xlim);
% ylim([0 15]);
% set(gca,'Fontsize',fig.fonts);
% % text(274.5,16,'+ NE','Fontsize',fig.fonts);

axes(AX(1,3))
pcolorcorcen(adcp.t,adcp.z,adcp.vc);
hold on
plot(adcp.t,adcp.h,'k','Linewidth',fig.lwidth);
ylabel('z (m)');
xlabel('Day of year');
colormap(cwbr);
clim([-0.5 0.5]);
[ax,h] = colorbarwithvtext('vc (m/s)','position',get(AX(2,3),'position'));
set(ax,'YTick',-0.5:0.25:0.5);
title(ax,{'+ off'},'Fontsize',fig.fonts);
xlim(fig.xlim);
ylim([0 15]);
set(gca,'Fontsize',fig.fonts);
% text(274.2,16.5,'+ offshore','Fontsize',fig.fonts);

set(AX(:,1:2),'xticklabel',[])
set(AX(2,:),'yticklabel',[])
delete(AX(2,1))
delete(AX(2,2))
delete(AX(2,3))
% delete(AX(2,4))

set(gcf,'color','w');
set(findall(gcf,'type','text'),'FontSize',fig.fonts);
% set([cb1 cb2],'Fontsize',fig.fonts);
h = findobj(fh,'type','axes','tag','');
linkaxes(h,'x');

% save figure 
fs  = fig.fonts;
opts = struct('format','png','Preview','tiff',...
        'width',33,'height',22,'Bounds','loose',...
        'color','cmyk','Renderer','painters','Resolution',300,...
        'LockAxes','loose',...
        'FontMode','scaled','DefaultFixedFontSize',fs,'FontSizeMin',fs-2,'FontSizeMax',fs+2,'LineMode','scaled');


    applytofig(gcf,opts);
    if flag_print
        set(gcf,'PaperUnits','centimeters');
        exportfig(gcf,[dir_out 'SSH-Sal-vel-' Loc '.png'],opts);
    end