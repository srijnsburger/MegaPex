%% SBE1842 correction
% clc;clear all;close all;

% Load data
dirin = 'd:\sabinerijnsbur\Matlab\Moorings\';
dir_out = 'd:\sabinerijnsbur\Matlab\Figures\Moorings\';
mooring = '12m';
save_plot = 'yes';

load([dirin,'SBE1526.mat']);
load([dirin,'SBE1527.mat']);
load([dirin,'SBE5425.mat']);
load([dirin,'SBE5426.mat']);
load([dirin,'SBE1842.mat']);

%% Make figure Point 1
% load figure with good date, mixed period 1
% Time period
[fig.x1,fig.id1]   = min(abs(SBE1842.time-datenum(2014,09,22,00,00,00))); 
[fig.x11,fig.id11] = min(abs(SBE1842.time-datenum(2014,09,23,00,00,00)));
fig.tstep = 0.5;

% Make figure
Plot_moorings_date(fig,mooring);

%% Point 1
[C.x1,C.y1] = ginput(2);
C.dy1 = C.y1(1)-C.y1(2);
C.dx1 = mean(C.x1);

%% Make figure Point 2
% load figure with good date, mixed period 2
% Time period
[fig.x1,fig.id1]   = min(abs(SBE1842.time-datenum(2014,10,7,00,00,00))); 
[fig.x11,fig.id11] = min(abs(SBE1842.time-datenum(2014,10,8,00,00,00)));
fig.tstep = 0.5;

% Make figure
Plot_moorings_date(fig,mooring);

%% Point 2
[C.x2,C.y2] = ginput(2);
C.dy2 = C.y2(1)-C.y2(2);
C.dx2 = mean(C.x2);

%% Make figure Point 3
% load figure with good date, mixed period 3
% Time period
[fig.x1,fig.id1]   = min(abs(SBE1842.time-datenum(2014,10,7,00,00,00))); 
[fig.x11,fig.id11] = min(abs(SBE1842.time-datenum(2014,10,9,00,00,00)));
fig.tstep = 0.5;

% Make figure
Plot_moorings_date(fig,mooring);

%% Point 3
[C.x3,C.y3] = ginput(2);
C.dy3 = C.y3(1)-C.y3(2);
C.dx3 = mean(C.x3);

%% Point 4
% load figure with good date, mixed period 3
% Time period
[fig.x1,fig.id1]   = min(abs(SBE1842.time-datenum(2014,10,21,00,00,00))); 
[fig.x11,fig.id11] = min(abs(SBE1842.time-datenum(2014,10,23,00,00,00)));
fig.tstep = 0.5;

% Make figure
Plot_moorings_date(fig,mooring);

[C.x4,C.y4] = ginput(2);
C.dy4 = C.y4(1)-C.y4(2);
C.dx4 = mean(C.x4);

%% Point 5
%load figure with good date, mixed period 3
% Time period
[fig.x1,fig.id1]   = min(abs(SBE1842.time-datenum(2014,10,21,00,00,00))); 
[fig.x11,fig.id11] = min(abs(SBE1842.time-datenum(2014,10,23,00,00,00)));
fig.tstep = 0.5;

% Make figure
Plot_moorings_date(fig,mooring);

[C.x5,C.y5] = ginput(2);
C.dy5 = C.y5(1)-C.y5(2);
C.dx5 = mean(C.x5);

%% Save

save([dirin,'CorrectionSBE1842.mat'],'C');

%% Fit

% Make array
C.dx = [C.dx1 C.dx2 C.dx4]';
C.dy = [C.dy1 C.dy2 C.dy4]';

% Fit
C.f         = fit(C.dx,C.dy,'poly1');
[C.p,C.err] = polyfit(C.dx,C.dy,1);
C.pf        = polyval(C.p,C.dx,C.err);
C.fitlm     = fitlm(C.dx,C.dy);

%% Plot fit & check

figure;
plot(C.dx,C.dy,'.b');
hold on
plot(C.dx,C.pf,'-r');
axis([SBE1842.time(1) SBE1842.time(end) 0 0.6]);
set(gca,'YTick',0:0.1:0.6);
set(gca,'XTick',SBE1842.time(1):5:SBE1842.time(end));
datetick('x','dd/mm','keepticks');
text(datenum(2014,09,16,12,00,00),0.47,['R^2 = ' num2str(C.fitlm.Rsquared.Ordinary)]);
text(datenum(2014,09,16,12,00,00),0.44,['Fit: ' num2str(C.p(1)) ' * x - ' num2str(abs(C.p(2)))]);

if strcmp(save_plot,'yes');
set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperSize', [16 10]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperPosition', [0 0 16 10]);
set(gcf,'Renderer','painters');
print(gcf, '-dpdf',[dir_out 'Correction_SBE1842_t124.pdf']);
end


%% Apply fit

% See Apply_correction_SBE
% See plot_correction --> for the corrected plots

%% Old
% SBE1842C          = SBE1842;
% SBE1842C.C        = SBE1842.time*C.p(1)+ C.p(2);
% SBE1842C.sal      = SBE1842.sal + SBE1842C.C;
% SBE1842C.dens     = waterdensity0(SBE1842C.sal,SBE1842.temp); 
% 
% load('d:\sabinerijnsbur\Matlab\adcp\adcp12');
% [SBE1842C] = time_averaging_reft(SBE1842C,adcp12.time,600);
% 
% % Check fit
% C.dS = SBE1842C.sal10-SBE5425.sal10;
% id   = find(C.dS<0); % id where SBE19C is lower than SBE1842
% v    = C.dS(id); % values
% C.drho = SBE1842C.dens10 - SBE5425.dens10;
% id2  = find(C.drho<0);
% v2   = C.drho(id2);
% 
% %% Plot 
% 
% fig.lwidth      = 1;
% fig.fonts       = 8;
% fig.txtfonts    = 8;
% fig.xaxis       = [259 SBE1842.t(end)];
% fig.xtick       = 259:2:SBE1842.t(end);
% fig.ydens       = [12.5 25];% relative density range
% fig.ytickdens   = 12.5:2.5:25;
% fig.legendloc   = 'SouthEast';
% fig.legendorien = 'horizontal';
% 
% figure;
% subplot(2,1,1)
% plot(SBE1527.t,SBE1527.sal,'linewidth',fig.lwidth);
% hold on
% plot(SBE1526.t,SBE1526.sal,'--r','linewidth',fig.lwidth);
% plot(SBE5426.t,SBE5426.sal,'-.k','linewidth',fig.lwidth);
% plot(SBE5425.t,SBE5425.sal,'c','linewidth',fig.lwidth);
% plot(SBE1842.t,SBE1842.sal,'g','linewidth',fig.lwidth);
% set(gca,'Fontsize',fig.fonts);
% axis([fig.xaxis 20 35]);
% set(gca,'YTick',20:2.5:32.5);
% set(gca,'XTick',fig.xtick);
% ylabel('Salinity (PSU)');
% 
% subplot(2,1,2)
% plot(SBE1527.t,SBE1527.sal,'linewidth',fig.lwidth);
% hold on
% plot(SBE1526.t,SBE1526.sal,'--r','linewidth',fig.lwidth);
% plot(SBE5426.t,SBE5426.sal,'-.k','linewidth',fig.lwidth);
% plot(SBE5425.t,SBE5425.sal,'c','linewidth',fig.lwidth);
% plot(SBE1842.t,SBE1842C.sal,'g','linewidth',1.5);
% set(gca,'Fontsize',fig.fonts);
% axis([fig.xaxis 20 35]);
% set(gca,'YTick',20:2.5:32.5);
% set(gca,'XTick',fig.xtick);
% ylabel('Corrected Salinity (PSU)');
% xlabel('Day of year');
% title('Corrected salinity SBE1842 12m mooring');
% 
% if strcmp(save_plot,'yes');
% set(gcf, 'PaperUnits', 'centimeters');
% set(gcf, 'PaperSize', [16 10]);
% set(gcf, 'PaperPositionMode', 'manual');
% set(gcf, 'PaperPosition', [0 0 16 10]);
% set(gcf,'Renderer','painters');
% print(gcf, '-dpdf',[dir_out 'Correction_Salinity_SBE1842_t124.pdf']);
% end
% 
% % density
% figure;
% subplot(2,1,1)
% plot(SBE1527.t,SBE1527.dens-1000,'linewidth',fig.lwidth);
% hold on
% plot(SBE1526.t,SBE1526.dens-1000,'--r','linewidth',fig.lwidth);
% plot(SBE5426.t,SBE5426.dens-1000,'-.k','linewidth',fig.lwidth);
% plot(SBE5425.t,SBE5425.dens-1000,'c','linewidth',fig.lwidth);
% plot(SBE1842.t,SBE1842.dens-1000,'g','linewidth',fig.lwidth);
% set(gca,'Fontsize',fig.fonts);
% axis([fig.xaxis fig.ydens]);
% set(gca,'YTick',fig.ytickdens);
% set(gca,'XTick',fig.xtick);
% ylabel('Relative density (kg/m^3)');
% legend('MC1527 1mbs','MC1526 3mbs','MC5426 7mbs','MC5425 8mbs','MC1842 10.5mbs');
% legend('Location',fig.legendloc,'Orientation',fig.legendorien);
% title('Correction density SBE1842 12 m mooring');
% 
% subplot(2,1,2)
% plot(SBE1527.t,SBE1527.dens-1000,'linewidth',fig.lwidth);
% hold on
% plot(SBE1526.t,SBE1526.dens-1000,'--r','linewidth',fig.lwidth);
% plot(SBE5426.t,SBE5426.dens-1000,'-.k','linewidth',fig.lwidth);
% plot(SBE5425.t,SBE5425.dens-1000,'c','linewidth',fig.lwidth);
% plot(SBE1842.t,SBE1842C.dens-1000,'g','linewidth',1.5);
% set(gca,'Fontsize',fig.fonts);
% axis([fig.xaxis fig.ydens]);
% set(gca,'YTick',fig.ytickdens);
% set(gca,'XTick',fig.xtick);
% ylabel('Corrected relative density (kg/m^3)');
% xlabel('Day of year');
% 
% if strcmp(save_plot,'yes');
% set(gcf, 'PaperUnits', 'centimeters');
% set(gcf, 'PaperSize', [16 10]);
% set(gcf, 'PaperPositionMode', 'manual');
% set(gcf, 'PaperPosition', [0 0 16 10]);
% set(gcf,'Renderer','painters');
% print(gcf, '-dpdf',[dir_out 'Correction_Density_SBE1842_t124.pdf']);
% end