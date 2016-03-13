%% SBE19 correction
% clc;clear all;close all;

% Load data
dirin = 'd:\sabinerijnsbur\Matlab\Moorings\';
dir_out = 'd:\sabinerijnsbur\Matlab\Figures\Moorings\';
mooring = '18m';
save_plot = 'yes';

load([dirin,'SBE1525.mat']);
load([dirin,'SBE4939.mat']);
load([dirin,'SBE4940.mat']);
load([dirin,'SBE19.mat']);

%% Make figure Point 1
% load figure with good date, mixed period 1
% Time period
[fig.x1,fig.id1]   = min(abs(SBE19.time-datenum(2014,09,22,00,00,00))); 
[fig.x11,fig.id11] = min(abs(SBE19.time-datenum(2014,09,23,00,00,00)));
fig.tstep = 0.5;

% Make figure
Plot_moorings_date(fig,mooring);

%% Point 1
[D.x1,D.y1] = ginput(2);
D.dy1 = D.y1(1)-D.y1(2);
D.dx1 = mean(D.x1);

%% Make figure Point 2
% load figure with good date, mixed period 2
% Time period
[fig.x1,fig.id1]   = min(abs(SBE19.time-datenum(2014,09,25,00,00,00))); 
[fig.x11,fig.id11] = min(abs(SBE19.time-datenum(2014,09,28,00,00,00)));
fig.tstep = 0.5;

% Make figure
Plot_moorings_date(fig,mooring);

%% Point 2
[D.x2,D.y2] = ginput(2);
D.dy2 = D.y2(1)-D.y2(2);
D.dx2 = mean(D.x2);

%% Make figure Point 3
% load figure with good date, mixed period 3
% Time period
[fig.x1,fig.id1]   = min(abs(SBE19.time-datenum(2014,09,25,00,00,00))); 
[fig.x11,fig.id11] = min(abs(SBE19.time-datenum(2014,09,28,00,00,00)));
fig.tstep = 0.5;

% Make figure
Plot_moorings_date(fig,mooring);

%% Point 3
[D.x3,D.y3] = ginput(2);
D.dy3 = D.y3(1)-D.y3(2);
D.dx3 = mean(D.x3);

%% Make figure Point 4
% load figure with good date, mixed period 3
% Time period
[fig.x1,fig.id1]   = min(abs(SBE19.time-datenum(2014,10,05,00,00,00))); 
[fig.x11,fig.id11] = min(abs(SBE19.time-datenum(2014,10,15,00,00,00)));
fig.tstep = 0.5;

% Make figure
Plot_moorings_date(fig,mooring);

%% Point 4
[D.x4,D.y4] = ginput(2);
D.dy4 = D.y4(1)-D.y4(2);
D.dx4 = mean(D.x4);

%% Make figure Point 5
%load figure with good date, mixed period 3
% Time period
[fig.x1,fig.id1]   = min(abs(SBE19.time-datenum(2014,10,05,00,00,00))); 
[fig.x11,fig.id11] = min(abs(SBE19.time-datenum(2014,10,15,00,00,00)));
fig.tstep = 0.5;

% Make figure
Plot_moorings_date(fig,mooring);

%% Point 5
[D.x5,D.y5] = ginput(2);
D.dy5 = D.y5(1)-D.y5(2);
D.dx5 = mean(D.x5);

%% Make figure Point 6
%load figure with good date, mixed period 3
% Time period
[fig.x1,fig.id1]   = min(abs(SBE19.time-datenum(2014,10,05,00,00,00))); 
[fig.x11,fig.id11] = min(abs(SBE19.time-datenum(2014,10,15,00,00,00)));
fig.tstep = 0.5;

% Make figure
Plot_moorings_date(fig,mooring);
%% Figure Point 6
[D.x6,D.y6] = ginput(2);
D.dy6 = D.y6(1)-D.y6(2);
D.dx6 = mean(D.x6);

%% Make figure Point 7
%load figure with good date, mixed period 3
% Time period
[fig.x1,fig.id1]   = min(abs(SBE19.time-datenum(2014,10,05,00,00,00))); 
[fig.x11,fig.id11] = min(abs(SBE19.time-datenum(2014,10,15,00,00,00)));
fig.tstep = 0.5;

% Make figure
Plot_moorings_date(fig,mooring);
%% Figure Point 7
[D.x7,D.y7] = ginput(2);
D.dy7       = D.y7(1)-D.y7(2);
D.dx7       = mean(D.x7);

%% Make figure Point 8
%load figure with good date, mixed period 3
% Time period
[fig.x1,fig.id1]   = min(abs(SBE19.time-datenum(2014,10,05,00,00,00))); 
[fig.x11,fig.id11] = min(abs(SBE19.time-datenum(2014,10,15,00,00,00)));
fig.tstep = 0.5;

% Make figure
Plot_moorings_date(fig,mooring);

%% Figure Point 8
[D.x8,D.y8] = ginput(2);
D.dy8       = D.y8(1)-D.y8(2);
D.dx8       = mean(D.x8);

%% Make figure Point 9
%load figure with good date, mixed period 3
% Time period
[fig.x1,fig.id1]   = min(abs(SBE19.time-datenum(2014,10,18,00,00,00))); 
[fig.x11,fig.id11] = min(abs(SBE19.time-datenum(2014,10,22,00,00,00)));
fig.tstep = 0.5;

% Make figure
Plot_moorings_date(fig,mooring);

%% Figure point 9
[D.x9,D.y9] = ginput(2);
D.dy9       = D.y9(1)-D.y9(2);
D.dx9       = mean(D.x9);

%% Make figure Point 10
%load figure with good date, mixed period 3
% Time period
[fig.x1,fig.id1]   = min(abs(SBE19.time-datenum(2014,10,18,00,00,00))); 
[fig.x11,fig.id11] = min(abs(SBE19.time-datenum(2014,10,22,00,00,00)));
fig.tstep = 0.5;

% Make figure
Plot_moorings_date(fig,mooring);

%% Figure Point 10
[D.x10,D.y10] = ginput(2);
D.dy10       = D.y10(1)-D.y10(2);
D.dx10       = mean(D.x10);

%% Make figure point 11
%load figure with good date, mixed period 3
% Time period
[fig.x1,fig.id1]   = min(abs(SBE19.time-datenum(2014,10,18,00,00,00))); 
[fig.x11,fig.id11] = min(abs(SBE19.time-datenum(2014,10,23,00,00,00)));
fig.tstep = 0.5;

% Make figure
Plot_moorings_date(fig,mooring);

%% Figure point 11

[D.x11,D.y11] = ginput(2);
D.dy11       = D.y11(1)-D.y11(2);
D.dx11       = mean(D.x11);


%% Make figure point 12
%load figure with good date, mixed period 3
% Time period
[fig.x1,fig.id1]   = min(abs(SBE19.time-datenum(2014,10,24,00,00,00))); 
[fig.x11,fig.id11] = min(abs(SBE19.time-datenum(2014,10,30,00,00,00)));
fig.tstep = 0.5;

% Make figure
Plot_moorings_date(fig,mooring);

%% Figure point 12

[D.x12,D.y12] = ginput(2);
D.dy12       = D.y12(1)-D.y12(2);
D.dx12       = mean(D.x12);


%% Make figure point 13
%load figure with good date, mixed period 3
% Time period
[fig.x1,fig.id1]   = min(abs(SBE19.time-datenum(2014,10,24,00,00,00))); 
[fig.x11,fig.id11] = min(abs(SBE19.time-datenum(2014,10,30,00,00,00)));
fig.tstep = 0.5;

% Make figure
Plot_moorings_date(fig,mooring);

%% Figure point 13

[D.x13,D.y13] = ginput(2);
D.dy13       = D.y13(1)-D.y13(2);
D.dx13       = mean(D.x13);


%% Make figure point 14
%load figure with good date, mixed period 3
% Time period
[fig.x1,fig.id1]   = min(abs(SBE19.time-datenum(2014,10,24,00,00,00))); 
[fig.x11,fig.id11] = min(abs(SBE19.time-datenum(2014,10,30,00,00,00)));
fig.tstep = 0.5;

% Make figure
Plot_moorings_date(fig,mooring);

%% Figure point 14

[D.x14,D.y14] = ginput(2);
D.dy14       = D.y14(1)-D.y14(2);
D.dx14       = mean(D.x14);

%% Save

save([dirin,'CorrectionSBE19.mat'],'D');

%% Fit

% Make array
D.dx = [D.dx1 D.dx2 D.dx3 D.dx4 D.dx5 D.dx6 D.dx7 D.dx8 D.dx9 D.dx10 D.dx11 D.dx12 D.dx13 D.dx14]';
D.dy = [D.dy1 D.dy2 D.dy3 D.dy5 D.dy5 D.dy6 D.dy7 D.dy8 D.dy9 D.dy10 D.dy11 D.dy12 D.dy13 D.dy14]';

% Fit
D.f         = fit(D.dx,D.dy,'poly1');
[D.p,D.err] = polyfit(D.dx,D.dy,1);
D.pf        = polyval(D.p,D.dx,D.err);
D.fitlm     = fitlm(D.dx,D.dy);

%% Plot fit & check

figure;
plot(D.dx,D.dy,'.b');
hold on
plot(D.dx,D.pf,'-r');
axis([SBE19.time(1) SBE19.time(end) 0 1]);
set(gca,'YTick',0:0.1:1);
set(gca,'XTick',SBE19.time(1):5:SBE19.time(end));
datetick('x','dd/mm','keepticks');
text(datenum(2014,09,16,12,00,00),0.9,['R^2 = ' num2str(D.fitlm.Rsquared.Ordinary)]);
text(datenum(2014,09,16,12,00,00),0.85,['Fit: ' num2str(D.p(1)) ' * x - ' num2str(abs(D.p(2)))]);

if strcmp(save_plot,'yes');
set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperSize', [16 10]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperPosition', [0 0 16 10]);
set(gcf,'Renderer','painters');
print(gcf, '-dpdf',[dir_out 'Correction_SBE19.pdf']);
end

%% Apply fit

% See Apply_correction_SBE
% See plot_correction --> for the corrected plots

%% Old
% SBE19C          = SBE19;
% SBE19C.C        = SBE19.time*D.p(1)+ D.p(2);
% SBE19C.sal      = SBE19.sal + SBE19.C;
% SBE19C.dens     = waterdensity0(SBE19.sal_corr,SBE19.temp); 
% 
% [SBE19C] = time_averaging_reft(SBE19C,adcp18.time,600);
% 
% % Check fit
% D.dS = SBE19C.sal10-SBE4940.sal10;
% id   = find(D.dS<0); % id where SBE19C is lower than SBE1842
% v    = D.dS(id); % values
% D.drho = SBE19C.dens10 - SBE4940.dens10;
% id2  = find(D.drho<0);
% v2   = D.drho(id2);
% 
% %% Plot correction
% fig.lwidth      = 1;
% fig.fonts       = 8;
% fig.txtfonts    = 8;
% fig.xaxis       = [259 SBE19.t(end)];
% fig.xtick       = 259:2:SBE19.t(end);
% fig.ydens       = [12.5 25];% relative density range
% fig.ytickdens   = 12.5:2.5:25;
% fig.legendloc   = 'SouthEast';
% fig.legendorien = 'horizontal';
% 
% figure;
% subplot(2,1,1)
% plot(SBE1525.t,SBE1525.sal,'linewidth',fig.lwidth);
% hold on
% plot(SBE4939.t,SBE4939.sal,'--r','linewidth',fig.lwidth);
% plot(SBE4940.t,SBE4940.sal,'-.k','linewidth',fig.lwidth);
% plot(SBE19.t,SBE19.sal,'c','linewidth',fig.lwidth);
% set(gca,'Fontsize',fig.fonts);
% axis([fig.xaxis 20 35]);
% set(gca,'YTick',20:2.5:32.5);
% set(gca,'XTick',fig.xtick);
% legend('MC1525 1mbs','MC4939 2.5mbs','MC4940 10mbs','MC19 15 mbs');
% legend('Location',fig.legendloc,'Orientation',fig.legendorien);
% title('Salinity 18m mooring')
% 
% subplot(2,1,2)
% plot(SBE1525.t,SBE1525.sal,'linewidth',fig.lwidth);
% hold on
% plot(SBE4939.t,SBE4939.sal,'--r','linewidth',fig.lwidth);
% plot(SBE4940.t,SBE4940.sal,'-.k','linewidth',fig.lwidth);
% plot(SBE19.t,SBE19.sal_corr,'c','linewidth',1.5);
% set(gca,'Fontsize',fig.fonts);
% axis([fig.xaxis 20 35]);
% set(gca,'YTick',20:2.5:32.5);
% set(gca,'XTick',fig.xtick);
% ylabel('Salinity Corrected (PSU)');
% xlabel('Day of year');
% 
% figure;
% subplot(2,1,1)
% plot(SBE1525.t,SBE1525.dens-1000,'linewidth',fig.lwidth);
% hold on
% plot(SBE4939.t,SBE4939.dens-1000,'--r','linewidth',fig.lwidth);
% plot(SBE4940.t,SBE4940.dens-1000,'-.k','linewidth',fig.lwidth);
% plot(SBE19.t,SBE19.dens-1000,'c','linewidth',fig.lwidth);
% set(gca,'Fontsize',fig.fonts);
% axis([fig.xaxis fig.ydens]);
% set(gca,'YTick',fig.ytickdens);
% set(gca,'XTick',fig.xtick);
% legend('MC1525 1mbs','MC4939 2.5mbs','MC4940 10mbs','MC19 15 mbs');
% legend('Location',fig.legendloc,'Orientation',fig.legendorien);
% ylabel('Relative density (kg/m^3)');
% title('Density 18 m mooring');
% 
% subplot(2,1,2)
% plot(SBE1525.t,SBE1525.dens-1000,'linewidth',fig.lwidth);
% hold on
% plot(SBE4939.t,SBE4939.dens-1000,'--r','linewidth',fig.lwidth);
% plot(SBE4940.t,SBE4940.dens-1000,'-.k','linewidth',fig.lwidth);
% plot(SBE19.t,SBE19.dens_corr-1000,'c','linewidth',1.5);
% set(gca,'Fontsize',fig.fonts);
% axis([fig.xaxis fig.ydens]);
% set(gca,'YTick',fig.ytickdens);
% set(gca,'XTick',fig.xtick);
% legend('MC1525 1mbs','MC4939 2.5mbs','MC4940 10mbs','MC19 15mbs');
% legend('Location',fig.legendloc,'Orientation',fig.legendorien);
% ylabel('Corrected relative density (kg/m^3)');
% xlabel('Day of year');
