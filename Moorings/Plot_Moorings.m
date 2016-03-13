%% Load matfiles

dirin = 'd:\sabinerijnsbur\Matlab\Moorings\Mfiles\';

load([dirin,'SBE1525.mat']);
load([dirin,'SBE1526.mat']);
load([dirin,'SBE1527.mat']);
load([dirin,'SBE5425.mat']);
load([dirin,'SBE5426.mat']);
load([dirin,'SBE1842_corrected.mat']);
load([dirin,'SBE4939.mat']);
load([dirin,'SBE4940.mat']);
load([dirin,'SBE19_corrected.mat']);
load([dirin,'OBS3A750.mat']);
load([dirin,'OBS3A744.mat']);
load([dirin,'OBS3A743.mat']);
load([dirin,'OBS3A578.mat']);

%% Save figure or not

dir_out   = 'd:\sabinerijnsbur\Matlab\Figures\Moorings\';
save_plot = 'no';

%% Input for figure
fig.xlabel      = 'day in year';
fig.lwidth      = 1;
fig.fonts       = 8;
fig.txtfonts    = 8;
fig.xaxis       = [259 SBE1842.t(end)];
fig.xtick       = 259:2:SBE1842.t(end);
fig.trange      = '259-end';
fig.ytemp       = [10 21];
fig.yticktemp   = 10:2:21;
fig.ydens       = [12.5 25];% relative density range
fig.ytickdens   = 12.5:2.5:25;
fig.legendloc   = 'SouthEast';
fig.legendorien = 'horizontal';
fig.fname1      = ['M12_' fig.trange];% Mooring 12m
fig.fname1a     = ['M12_dens_' fig.trange];
fig.fname2      = ['M18_' fig.trange];% Mooring 18m
fig.fname2a     = ['M18_dens_' fig.trange];

%% Figure Mooring 12m 

figure;
AX = subplot_meshgrid(1,2,[.09 .04],[.07 .04 .07],[nan],[nan nan]);
axes(AX(1,1))
plot(SBE1527.t,SBE1527.temp,'linewidth',fig.lwidth);
hold on
plot(SBE1526.t,SBE1526.temp,'--r','linewidth',fig.lwidth);
plot(SBE5426.t,SBE5426.temp,'-.k','linewidth',fig.lwidth);
plot(SBE5425.t,SBE5425.temp,'c','linewidth',fig.lwidth);
plot(SBE1842.t,SBE1842.temp,'g','linewidth',fig.lwidth);
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis fig.ytemp]);
set(gca,'YTick',fig.yticktemp);
set(gca,'XTick',fig.xtick);
ylabel('Temperature (\circ C)');
legend('MC1527 1mbs','MC1526 3mbs','MC5426 7mbs','MC5425 8mbs','MC1842 10.5mbs');
legend('Location',fig.legendloc,'Orientation',fig.legendorien);
title('12 m mooring');

axes(AX(1,2))
plot(SBE1527.t,SBE1527.sal,'linewidth',fig.lwidth);
hold on
plot(SBE1526.t,SBE1526.sal,'--r','linewidth',fig.lwidth);
plot(SBE5426.t,SBE5426.sal,'-.k','linewidth',fig.lwidth);
plot(SBE5425.t,SBE5425.sal,'c','linewidth',fig.lwidth);
plot(SBE1842.t,SBE1842.sal,'g','linewidth',fig.lwidth);
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis 20 35]);
set(gca,'YTick',20:2.5:32.5);
set(gca,'XTick',fig.xtick);
ylabel('Salinity (PSU)');
xlabel(fig.xlabel);

set(AX(:,1),'xticklabel',[])
set(findall(gcf,'type','text'),'FontSize',fig.txtfonts)

if strcmp(save_plot,'yes')
    set(gcf, 'PaperUnits', 'centimeters');
    set(gcf, 'PaperSize', [18 14]);
    set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperPosition', [0 0 18 14]);
    set(gcf,'Renderer','painters');
    print(gcf, '-dpdf',[dir_out fig.fname1 '.pdf']);
end

%% Figure Mooring 12m density

figure;
plot(SBE1527.t,SBE1527.dens-1000,'linewidth',fig.lwidth);
hold on
plot(SBE1526.t,SBE1526.dens-1000,'--r','linewidth',fig.lwidth);
plot(OBS3A744.t,OBS3A.dens-1000,'m','linewidth',fig.lwidth);
plot(SBE5426.t,SBE5426.dens-1000,'-.k','linewidth',fig.lwidth);
plot(SBE5425.t,SBE5425.dens-1000,'c','linewidth',fig.lwidth);
plot(SBE1842.t,SBE1842.dens-1000,'g','linewidth',fig.lwidth);
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis fig.ydens]);
set(gca,'YTick',fig.ytickdens);
set(gca,'XTick',fig.xtick);
ylabel('Relative density (kg/m^3)');
legend('MC1527 1mbs','MC1526 3mbs','OBS3A 5mbs','MC5426 7mbs','MC5425 8mbs','MC1842 10.5mbs');
legend('Location',fig.legendloc,'Orientation',fig.legendorien);
title('12 m mooring');
xlabel(fig.xlabel);

set(findall(gcf,'type','text'),'FontSize',fig.txtfonts)

if strcmp(save_plot,'yes')
    set(gcf, 'PaperUnits', 'centimeters');
    set(gcf, 'PaperSize', [20 12]);
    set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperPosition', [0 0 20 12]);
    set(gcf,'Renderer','painters');
    print(gcf, '-dpdf',[dir_out fig.fname1a '.pdf']);
end

%% Figure Mooring 18m

figure;
AX = subplot_meshgrid(1,2,[.09 .04],[.07 .04 .07],[nan],[nan nan]);
axes(AX(1,1))
plot(SBE1525.t,SBE1525.temp,'linewidth',fig.lwidth);
hold on
plot(SBE4939.t,SBE4939.temp,'--r','linewidth',fig.lwidth);
plot(SBE4940.t,SBE4940.temp,'-.k','linewidth',fig.lwidth);
plot(SBE19.t,SBE19.temp,'c','linewidth',fig.lwidth);
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis fig.ytemp]);
set(gca,'YTick',fig.yticktemp);
set(gca,'XTick',fig.xtick);
legend('MC1525 1mbs','MC4939 2.5mbs','MC4940 10mbs','MC19 15 mbs');
legend('Location',fig.legendloc,'Orientation',fig.legendorien);
ylabel('Temperature (\circ C)');
title('18 m mooring');

axes(AX(1,2))
plot(SBE1525.t,SBE1525.sal,'linewidth',fig.lwidth);
hold on
plot(SBE4939.t,SBE4939.sal,'--r','linewidth',fig.lwidth);
plot(SBE4940.t,SBE4940.sal,'-.k','linewidth',fig.lwidth);
plot(SBE19.t,SBE19.sal,'c','linewidth',fig.lwidth);
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis 20 35]);
set(gca,'YTick',20:2.5:32.5);
set(gca,'XTick',fig.xtick);
ylabel('Salinity (PSU)');
% legend('MC1525 1mbs','MC4939 2.5mbs','MC4940 10mbs','MC19 15 mbs');
% legend('Location',fig.legendloc,'Orientation',fig.legendorien);
xlabel(fig.xlabel);

set(AX(:,1),'xticklabel',[])
set(findall(gcf,'type','text'),'FontSize',fig.txtfonts)

if strcmp(save_plot,'yes')
    set(gcf, 'PaperUnits', 'centimeters');
    set(gcf, 'PaperSize', [18 14]);
    set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperPosition', [0 0 18 14]);
    set(gcf,'Renderer','painters');
    print(gcf, '-dpdf',[dir_out fig.fname2 '.pdf']);  
end

%% Figure Mooring 18m

figure;
plot(SBE1525.t,SBE1525.dens-1000,'linewidth',fig.lwidth);
hold on
plot(SBE4939.t,SBE4939.dens-1000,'--r','linewidth',fig.lwidth);
plot(SBE4940.t,SBE4940.dens-1000,'-.k','linewidth',fig.lwidth);
plot(SBE19.t,SBE19.dens-1000,'c','linewidth',fig.lwidth);
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis fig.ydens]);
set(gca,'YTick',fig.ytickdens);
set(gca,'XTick',fig.xtick);
legend('MC1525 1mbs','MC4939 2.5mbs','MC4940 10mbs','MC19 15 mbs');
legend('Location',fig.legendloc,'Orientation',fig.legendorien);
ylabel('Relative ensity (kg/m^3)');
title('18 m mooring');
xlabel(fig.xlabel);

set(findall(gcf,'type','text'),'FontSize',fig.txtfonts)

if strcmp(save_plot,'yes')
    set(gcf, 'PaperUnits', 'centimeters');
    set(gcf, 'PaperSize', [20 12]);
    set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperPosition', [0 0 20 12]);
    set(gcf,'Renderer','painters');
    print(gcf, '-dpdf',[dir_out fig.fname2a '.pdf']);  
end