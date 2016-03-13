%% Plot ssh - delta S - bottom and surface vel 
clc;clear all; close all;

% Load data
Loc       = '12'; %Location
dir_out   = 'd:\sabinerijnsbur\Figures-Matlab\Figures-MegaPex-2014\Presentation_OS2016\';
flag_print= 0;

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
fig.fonts       = 19;
fig.xlim        = [260 290];
% fig.xlim        = [260.2 262.2];
fig.legendloc   = 'SouthEast';
fig.legendorien = 'horizontal';
cmp             = get(groot,'DefaultAxesColorOrder');

%% Plot ssh - dS - along - cross

fh = figure;
AX = subplot_meshgrid(1,4,[.05 0.025],[.02 .02 .02 .02 .067],[nan],[nan nan nan nan]);
axes(AX(1,1))
plot(M.t(period.p1),M.ssh(period.p1),'Color',cmp(1,:),'Linewidth',fig.lwidth);
hold on
plot(M.t(period.p2),M.ssh(period.p2),'Color',cmp(2,:),'Linewidth',fig.lwidth);
% legend('Neap','Spring');
% legend('Location',fig.legendloc,'Orientation',fig.legendorien);
% leg = legend('Boxoff');
% set(leg,'FontSize',fig.fonts);
plot(M.t(period.p3),M.ssh(period.p3),'Color',cmp(1,:),'Linewidth',fig.lwidth);
plot(M.t(period.p4),M.ssh(period.p4),'Color',cmp(2,:),'Linewidth',fig.lwidth);
plot(M.t(period.p5),M.ssh(period.p5),'Color',cmp(1,:),'Linewidth',fig.lwidth);
hline(0,'-k');
xlim(fig.xlim);
ylim([-1.5 1.5]);
ylabel('\eta (m)');
set(gca,'Fontsize',fig.fonts);

axes(AX(1,2))
plot(M.t,(M.S(end,:)-M.S(1,:)),'Linewidth',fig.lwidth);
hold on
xlim(fig.xlim);
ylim([0 10]);
ylabel('\Delta S (PSU)');
set(gca,'Fontsize',fig.fonts);

axes(AX(1,3))
plot(adcp.t,out.sva,'Linewidth',fig.lwidth);
hold on
plot(adcp.t,out.bva,'Linewidth',fig.lwidth);
legend('Surface','Bottom');
legend('Location',fig.legendloc,'Orientation',fig.legendorien);
leg = legend('Boxoff');
set(leg,'FontSize',fig.fonts);
hline(0,'-k');
xlim(fig.xlim);
ylim([-1.5 1.5]);
ylabel('va (m)');
set(gca,'Fontsize',fig.fonts);

axes(AX(1,4))
plot(adcp.t,out.svc,'Linewidth',fig.lwidth);
hold on
plot(adcp.t,out.bvc,'Linewidth',fig.lwidth);
legend('Surface','Bottom');
legend('Location',fig.legendloc,'Orientation',fig.legendorien);
leg = legend('Boxoff');
set(leg,'FontSize',fig.fonts);
hline(0,'-k');
xlim(fig.xlim);
ylim([-0.5 0.5]);
ylabel('vc (m)');
xlabel('Day of year');
set(gca,'Fontsize',fig.fonts);

set(AX(:,1:3),'xticklabel',[])

set(gcf,'color','w');
set(findall(gcf,'type','text'),'FontSize',fig.fonts);
h = findobj(fh,'type','axes','tag','');
linkaxes(h,'x');

%% Plot ssh - along - dS - cross-vel

fh = figure;
AX = subplot_meshgrid(1,4,[.067 0.03],[.02 .026 .026 .026 .10],[nan],[nan nan nan nan]);
axes(AX(1,1))
% plot(M.t(period.p1),M.ssh(period.p1),'Color',cmp(1,:),'Linewidth',fig.lwidth);
% hold on
% plot(M.t(period.p2),M.ssh(period.p2),'Color',cmp(2,:),'Linewidth',fig.lwidth);
% % legend('Neap','Spring');
% % legend('Location',fig.legendloc,'Orientation',fig.legendorien);
% % leg = legend('Boxoff');
% % set(leg,'FontSize',fig.fonts);
% plot(M.t(period.p3),M.ssh(period.p3),'Color',cmp(1,:),'Linewidth',fig.lwidth);
% plot(M.t(period.p4),M.ssh(period.p4),'Color',cmp(2,:),'Linewidth',fig.lwidth);
% plot(M.t(period.p5),M.ssh(period.p5),'Color',cmp(1,:),'Linewidth',fig.lwidth);
plot(M.t,M.ssh,'Color',[0 0 0],'Linewidth',fig.lwidth);
hline(0,'-k');
xlim(fig.xlim);
ylim([-1.5 1.5]);
% ylabel('\eta (m)');
% text(261.5,1.6,'Tidal elevation (m)');
set(gca,'Fontsize',fig.fonts);

axes(AX(1,2))
plot(adcp.t,out.sva,'Linewidth',fig.lwidth);
hold on
plot(adcp.t,out.bva,'Linewidth',fig.lwidth);
legend('Surface','Bottom');
legend('Location','SouthWest','Orientation',fig.legendorien);
leg = legend('Boxoff');
set(leg,'FontSize',fig.fonts);
hline(0,'-k');
xlim(fig.xlim);
ylim([-1.5 1.5]);
% ylabel('va (m)');
% text(261.5,1.6,'Alongshore velocity (m/s)');
set(gca,'Fontsize',fig.fonts);

axes(AX(1,3))
plot(M.t,(M.S(end,:)-M.S(1,:)),'Color',[0 0 0],'Linewidth',fig.lwidth);
hold on
xlim(fig.xlim);
ylim([0 10]);
% ylabel('\Delta S (PSU)');
% text(261.5,9,'Salinity difference (psu)');
% text(261.5,7.5,'(stratification)');
set(gca,'Fontsize',fig.fonts);

axes(AX(1,4))
plot(adcp.t,out.svc,'Linewidth',fig.lwidth);
hold on
plot(adcp.t,out.bvc,'Linewidth',fig.lwidth);
% ylabel('vc (m)');
legend('Surface','Bottom');
legend('Location','NorthWest','Orientation',fig.legendorien);
leg = legend('Boxoff');
set(leg,'FontSize',fig.fonts);
hline(0,'-k');
xlim(fig.xlim);
ylim([-0.5 0.5]);
% set(gca,'YTick',-0.5:0.25:0.5);
xlabel('Day of year');
% text(261.5,0.85,'Cross-shore velocity (m/s)');
set(gca,'Fontsize',fig.fonts);

set(AX(:,1:3),'xticklabel',[])

set(gcf,'color','w');
set(findall(gcf,'type','text'),'FontSize',fig.fonts);
h = findobj(fh,'type','axes','tag','');
linkaxes(h,'x');

% save figure 
fs  = fig.fonts;
opts = struct('format','png','Preview','tiff',...
        'width',28,'height',24,'Bounds','loose',...
        'color','cmyk','Renderer','painters','Resolution',300,...
        'LockAxes','loose',...
        'FontMode','scaled','DefaultFixedFontSize',fs,'FontSizeMin',fs-2,'FontSizeMax',fs+2,'LineMode','scaled');


    applytofig(gcf,opts);
    if flag_print
        set(gcf,'PaperUnits','centimeters');
        exportfig(gcf,[dir_out 'ssh-va-vc-ds' Loc 'v3.png'],opts);
    end
    
%% SSH - va - dx - dS

% fh = figure;
% AX = subplot_meshgrid(1,4,[.067 0.03],[.02 .022 .022 .022 .078],[nan],[nan nan nan nan]);
% axes(AX(1,1))
% plot(M.t(period.p1),M.ssh(period.p1),'Color',cmp(1,:),'Linewidth',fig.lwidth);
% hold on
% plot(M.t(period.p2),M.ssh(period.p2),'Color',cmp(2,:),'Linewidth',fig.lwidth);
% % legend('Neap','Spring');
% % legend('Location',fig.legendloc,'Orientation',fig.legendorien);
% % leg = legend('Boxoff');
% % set(leg,'FontSize',fig.fonts);
% plot(M.t(period.p3),M.ssh(period.p3),'Color',cmp(1,:),'Linewidth',fig.lwidth);
% plot(M.t(period.p4),M.ssh(period.p4),'Color',cmp(2,:),'Linewidth',fig.lwidth);
% plot(M.t(period.p5),M.ssh(period.p5),'Color',cmp(1,:),'Linewidth',fig.lwidth);
% hline(0,'-k');
% xlim(fig.xlim);
% ylim([-1.5 1.5]);
% ylabel('\eta (m)');
% set(gca,'Fontsize',fig.fonts);
% 
% axes(AX(1,2))
% plot(adcp.t,out.sva,'Linewidth',fig.lwidth);
% hold on
% plot(adcp.t,out.bva,'Linewidth',fig.lwidth);
% legend('Surface','Bottom');
% legend('Location',fig.legendloc,'Orientation',fig.legendorien);
% leg = legend('Boxoff');
% set(leg,'FontSize',fig.fonts);
% hline(0,'-k');
% xlim(fig.xlim);
% ylim([-1.5 1.5]);
% ylabel('va (m)');
% set(gca,'Fontsize',fig.fonts);
% 
% axes(AX(1,3))
% 
% 
% axes(AX(1,4))
% plot(M.t,(M.S(5,:)-M.S(1,:)),'Linewidth',fig.lwidth);
% hold on
% xlim(fig.xlim);
% ylim([0 10]);
% ylabel('\Delta S (PSU)');
% xlabel('Day of year');
% set(gca,'Fontsize',fig.fonts);
% 
% set(AX(:,1:3),'xticklabel',[])
% 
% set(gcf,'color','w');
% set(findall(gcf,'type','text'),'FontSize',fig.fonts);
% h = findobj(fh,'type','axes','tag','');
% linkaxes(h,'x');
% 
% % save figure 
% fs  = fig.fonts;
% opts = struct('format','png','Preview','tiff',...
%         'width',28,'height',22,'Bounds','loose',...
%         'color','cmyk','Renderer','painters','Resolution',300,...
%         'LockAxes','loose',...
%         'FontMode','scaled','DefaultFixedFontSize',fs,'FontSizeMin',fs-2,'FontSizeMax',fs+2,'LineMode','scaled');
% 
% 
%     applytofig(gcf,opts);
%     if flag_print
%         set(gcf,'PaperUnits','centimeters');
%         exportfig(gcf,[dir_out 'ssh-va-dx-ds' Loc '.png'],opts);
%     end
% 
% 
