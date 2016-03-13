% PLOT SALINITY AND VELOCITIES (FIGURE PRESENTATION OS2016)
clc;clear all;close all;
%% Load data

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

%% Input figure

fig.lwidth      = 1.2;
fig.fonts       = 18;
fig.xlim        = [274.7083 275.0833];% Fronts
% fig.xlim        = [260 273];
fig.legendloc   = 'SouthEast';
fig.legendorien = 'horizontal';
cwbr            = colormapbluewhitered;
close;

% vline 
xin = [day_of_year(datenum(2014,10,01,20,25,00)) day_of_year(datenum(2014,10,01,20,25,00))];% front 1
% xin = [day_of_year(datenum(2014,10,01,19,10,00)) day_of_year(datenum(2014,10,01,19,10,00))];% front 2

% make z-grid
z12 = [0.9; 3; 7.2; 7.6; 10.4];

% Make new z-axis
z = adcp.z(4:end-1)-mean(adcp.h);

%% Figure

fh = figure;
AX = subplot_meshgrid(2,3,[.09 0.01 0.068],[.03 .038 .038 .02],[nan 0.023],[nan nan nan]);
axes(AX(1,1))
plot(M.t,M.S,'linewidth',fig.lwidth);
hold on
legend('-1m','-3m','-7m','-8m','-10.5m');
legend('Location',fig.legendloc,'Orientation',fig.legendorien);
leg = legend('Boxoff');
set(leg,'FontSize',fig.fonts);
plot(xin,[20 32],'--k','Linewidth',fig.lwidth);
xlim(fig.xlim);
ylim([20 32]);
% ylabel('S (PSU)');
set(gca,'Fontsize',fig.fonts);
text(275,30.5,'Salinity (psu)');
% pcolorcorcen(M12.t,z12,M12.S)
% hold on
% plot(xin,[0 15],'--k','Linewidth',fig.lwidth);
% xlim(fig.xlim);
% set(gca,'ydir','reverse');
% ylim([0 15]);
% ylabel('z (m)');
% cb = colorbar('position',get(AX(2,1),'position'));
% clim([20 32]);

axes(AX(1,2))
pcolorcorcen(adcp.t,z,adcp.va(4:end-1,:));
hold on
plot(adcp.t,(adcp.h-mean(adcp.h)),'k','Linewidth',fig.lwidth);
plot(xin,[-10 3],'--k','Linewidth',fig.lwidth);
ylabel('z (m)');
colormap(cwbr);
clim([-1 1]);
% [ax,h] = colorbarwithvtext('va (m/s)','position',get(AX(2,2),'position'));
cb1 = colorbar('position',get(AX(2,2),'position'));
% title(ax,{'+ NE'},'Fontsize',fig.fonts);
xlim(fig.xlim);
ylim([-10 3]);
set(gca,'Fontsize',fig.fonts);
text(274.93,2,'alongshore velocity (m/s)','Fontsize',fig.fonts);

axes(AX(1,3))
pcolorcorcen(adcp.t,z,adcp.vc(4:end-1,:));
hold on
plot(adcp.t,(adcp.h-mean(adcp.h)),'k','Linewidth',fig.lwidth);
plot(xin,[-10 3],'--k','Linewidth',fig.lwidth);
ylabel('z (m)');
colormap(cwbr);
clim([-0.5 0.5]);
% [ax,h] = colorbarwithvtext('vc (m/s)','position',get(AX(2,3),'position'));
cb2 = colorbar('position',get(AX(2,3),'position'));
set(cb2,'YTick',-0.5:0.25:0.5);
% title(ax,{'+ off'},'Fontsize',fig.fonts);
xlim(fig.xlim);
ylim([-10 3]);
set(gca,'Fontsize',fig.fonts);
% text(274.2,16.5,'+ offshore','Fontsize',fig.fonts);
text(274.93,2,'cross-shore velocity (m/s)','Fontsize',fig.fonts);
xlabel('Time');

set(AX(:,1:3),'xticklabel',[])
set(AX(2,:),'yticklabel',[])
delete(AX(2,1))
delete(AX(2,2))
delete(AX(2,3))

set(gcf,'color','w');
set(findall(gcf,'type','text'),'FontSize',fig.fonts);
% set([cb1 cb2],'Fontsize',fig.fonts);
h = findobj(fh,'type','axes','tag','');
linkaxes(h,'x');

% save figure 
fs   = fig.fonts;
opts = struct('format','png','Preview','tiff',...
        'width',24,'height',20,'Bounds','loose',...
        'color','cmyk','Renderer','painters','Resolution',300,...
        'LockAxes','loose',...
        'FontMode','scaled','DefaultFixedFontSize',fs,'FontSizeMin',fs-2,'FontSizeMax',fs+2,'LineMode','scaled');

cd d:\sabinerijnsbur\SurfDrive\Scripts\
    applytofig(gcf,opts);
    if flag_print
        set(gcf,'PaperUnits','centimeters');
        exportfig(gcf,[dir_out 'Sal-vel-' Loc 'fr2_z.png'],opts);
    end

