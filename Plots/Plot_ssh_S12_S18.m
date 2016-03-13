%% Plot salinity both locations (PRESENTATION OS2016)
clc;clear all;close all;

% Load
load('d:\sabinerijnsbur\Matlab_files\Megapex_data\Moorings\Mfiles_adcp\Mooring12_adcp_corr.mat');
load('d:\sabinerijnsbur\Matlab_files\Megapex_data\Moorings\Mfiles_adcp\Mooring18_adcp_corr.mat');
load('d:\sabinerijnsbur\Matlab_files\Megapex_data\adcp\adcp12C');

% SSH
ssh = adcp12C.h - mean(adcp12C.h);

% Determine spring-neap
[period] = determine_spring_neap(adcp12C.t);

% Input figure
fig.lwidth      = 1.2;
fig.fonts       = 15;
fig.xlim        = [260 273];
fig.legendloc   = 'SouthEast';
fig.legendorien = 'horizontal';
cmp             = get(groot,'DefaultAxesColorOrder');

%% Plot

fh = figure;
AX = subplot_meshgrid(1,3,[.05 0.025],[.02 .035 .035 .067],[nan],[nan nan nan]);
axes(AX(1,1))
plot(M12.t(period.p1),M12.ssh(period.p1),'Color',cmp(1,:),'Linewidth',fig.lwidth);
hold on
plot(M12.t(period.p2),M12.ssh(period.p2),'Color',cmp(2,:),'Linewidth',fig.lwidth);
legend('Neap','Spring');
legend('Location',fig.legendloc,'Orientation',fig.legendorien);
leg = legend('Boxoff');
set(leg,'FontSize',fig.fonts);
plot(M12.t(period.p3),M12.ssh(period.p3),'Color',cmp(1,:),'Linewidth',fig.lwidth);
plot(M12.t(period.p4),M12.ssh(period.p4),'Color',cmp(2,:),'Linewidth',fig.lwidth);
plot(M12.t(period.p5),M12.ssh(period.p5),'Color',cmp(1,:),'Linewidth',fig.lwidth);
hline(0,'-k');
xlim(fig.xlim);
ylim([-1 1.5]);
ylabel('\eta (m)');
set(gca,'Fontsize',fig.fonts);

axes(AX(1,2))
plot(M12.t,M12.S,'Linewidth',fig.lwidth);
legend('1m','3m','7m','8m','10.5m');
legend('Location',fig.legendloc,'Orientation',fig.legendorien);
leg = legend('Boxoff');
set(leg,'FontSize',fig.fonts);
xlim(fig.xlim);
ylim([18 32]);
ylabel('S (PSU)');
title(AX(1,2),'Location 12m depth');
set(gca,'Fontsize',fig.fonts);

axes(AX(1,3))
plot(M18.t,M18.S,'Linewidth',fig.lwidth);
legend('1m','2.5m','8m','15m');
legend('Location',fig.legendloc,'Orientation',fig.legendorien);
leg = legend('Boxoff');
set(leg,'FontSize',fig.fonts);
xlim(fig.xlim);
ylim([18 32]);
ylabel('S (PSU)');
xlabel('Day of year');
title(AX(1,3),'Location 18m depth');
set(gca,'Fontsize',fig.fonts);

set(AX(:,1:2),'xticklabel',[])

set(gcf,'color','w');
set(findall(gcf,'type','text'),'FontSize',fig.fonts);
h = findobj(fh,'type','axes','tag','');
linkaxes(h,'x');