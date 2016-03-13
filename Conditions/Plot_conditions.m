clc;clear all;close all

load('d:\sabinerijnsbur\Matlab_files\Megapex_data\Conditions\wave.mat');
load('d:\sabinerijnsbur\Matlab_files\Megapex_data\Conditions\tide.mat');
load('d:\sabinerijnsbur\Matlab_files\Megapex_data\Conditions\wind.mat');
load('d:\sabinerijnsbur\Matlab_files\Megapex_data\Conditions\potwind.mat');
load('d:\sabinerijnsbur\Data\Conditions\Sep-Oct-2014\Waverider\Measurements_Zandmotor_Monitoring_Dec_2011_till_Nov_2014.mat');

%% Find end time based on adcp

load('d:\sabinerijnsbur\Matlab\adcp\adcp12');
tend = adcp12.t(end);

%% SSH from data

% 12m
load('d:\sabinerijnsbur\Matlab\adcp\adcp12C.mat');
ssh12 = adcp12C.h - mean(adcp12C.h);

% 18m
load('d:\sabinerijnsbur\Matlab\adcp\adcp18.mat');
ssh18 = adcp18.h - mean(adcp18.h);

%% input figure

dir_out = 'd:\sabinerijnsbur\Matlab\Figures\Conditions\';

fig.fonts     = 12;
fig.linewidth = 1;
fig.txtfonts  = 12;
fig.color     = 'b';
fig.tend      = tend;
fig.xtick     = 260:5:fig.tend;
fig.name      = [dir_out 'conditions_autumn2014.pdf'];

%% Plot wave characteristics during September - October 2014

figure;
AX = subplot_meshgrid(2,3,[.08 .06 .03],[.04 .03 .03 .07],[nan nan],[nan nan nan]);
axes(AX(1,1))
plot(T1.t,T1.ssh,'Linewidth',fig.linewidth);
grid on
hold on
plot(adcp12C.t,ssh12,'Linewidth',fig.linewidth);
plot(adcp18.t,ssh18,'Linewidth',fig.linewidth);
axis([T1.t(1) fig.tend -2 2]);
set(gca,'Xtick',fig.xtick);
set(gca,'YTick',[-2 -1 0 1 2]);
set(gca,'Fontsize',fig.fonts);
ylabel('\eta (m/s)','Fontsize',fig.fonts);
legend('\eta at Hoek van Holland','12m','18m','Location','SouthEast');

axes(AX(1,2))
plot(wind.t,wind.speed,'Linewidth',fig.linewidth);
grid on
hold on
axis([wind.t(1) fig.tend 0 20]);
set(gca,'Xtick',fig.xtick);
set(gca,'YTick',[0 5 10 15 20]);
set(gca,'Fontsize',fig.fonts);
ylabel('(m/s)','Fontsize',fig.fonts);

axes(AX(2,2))
plot(wind.t,wind.dir10,'Linewidth',fig.linewidth);
grid on
hold on
axis([wind.t(1) fig.tend 0 360]);
set(gca,'Xtick',fig.xtick);
set(gca,'YTick',[0 90 180 270 360]);
set(gca,'Fontsize',fig.fonts);
ylabel('dir (\circ)','Fontsize',fig.fonts);

axes(AX(1,3))
plot(Hs.t,Hs.hs,'Linewidth',fig.linewidth);
grid on
hold on
plot(day_of_year(data.Sep2014.Hm0(:,1)),data.Sep2014.Hm0(:,3)/100,'Linewidth',fig.linewidth);
plot(day_of_year(data.Oct2014.Hm0(:,1)),data.Oct2014.Hm0(:,3)/100,'Linewidth',fig.linewidth);
% vline(Hs.t(Hs.n16),'-k');
% vline(Hs.t(Hs.n30),'-k');
axis([Hs.t(1) fig.tend 0 3]);
set(gca,'Xtick',fig.xtick);
set(gca,'YTick',[0 0.5 1 1.5 2 2.5 3]);
set(gca,'Fontsize',fig.fonts);
ylabel('Hs (m)','Fontsize',fig.fonts);
xlabel('Day of year','Fontsize',fig.fonts);
legend('Europlatform','Waverider');

axes(AX(2,3))
plot(Tm0.t,Tm0.tm0,'Linewidth',fig.linewidth);
grid on
hold on
plot(day_of_year(data.Sep2014.Tm02(:,1)),data.Sep2014.Tm02(:,3),'Linewidth',fig.linewidth);
plot(day_of_year(data.Oct2014.Tm02(:,1)),data.Oct2014.Tm02(:,3),'Linewidth',fig.linewidth);
% vline(Tm0.t(Tm0.n16),'-k');
% vline(Tm0.t(Tm0.n30),'-k');
axis([Tm0.t(1) fig.tend 0 8]);
set(gca,'Xtick',fig.xtick);
set(gca,'YTick',[0 2 4 6 8]);
set(gca,'Fontsize',fig.fonts);
ylabel('Tm02 (sec)','Fontsize',fig.fonts);
xlabel('Day of year','Fontsize',fig.fonts);
legend('Europlatform','Waverider');

set(AX(:,1:2),'xticklabel',[])
delete(AX(2,1));
% print2screensize('WaveOct2011')
% print2a4(fig.name,'v','t')
set(gcf,'Color',[1 1 1]);
set(gcf,'Position',get(0,'ScreenSize'));
% export_fig(fig.name,'-pdf')

%% Plot wave characteristics during September - October 2014; lay-out vertical

fig.name      = [dir_out 'conditions_autumn2014_1x5.pdf'];

figure;
AX = subplot_meshgrid(1,5,[.08 .03],[.04 .03 .03 .03 .03 .07],[nan],[nan nan nan nan nan]);
axes(AX(1,1))
plot(T1.t,T1.ssh,'Linewidth',fig.linewidth);
grid on
hold on
plot(adcp12C.t,ssh12,'Linewidth',fig.linewidth);
plot(adcp18.t,ssh18,'Linewidth',fig.linewidth);
axis([T1.t(1) fig.tend -2 2]);
set(gca,'Xtick',fig.xtick);
set(gca,'YTick',[-2 -1 0 1 2]);
set(gca,'Fontsize',fig.fonts);
ylabel('\eta (m/s)','Fontsize',fig.fonts);
legend('\eta at Hoek van Holland','12m','18m','Location','SouthEast');

axes(AX(1,2))
plot(wind.t,wind.speed,'Linewidth',fig.linewidth);
grid on
hold on
axis([wind.t(1) fig.tend 0 20]);
set(gca,'Xtick',fig.xtick);
set(gca,'YTick',[0 5 10 15 20]);
set(gca,'Fontsize',fig.fonts);
ylabel('wind speed (m/s)','Fontsize',fig.fonts);

axes(AX(1,3))
plot(wind.t,wind.dir10,'Linewidth',fig.linewidth);
grid on
hold on
axis([wind.t(1) fig.tend 0 360]);
set(gca,'Xtick',fig.xtick);
set(gca,'YTick',[0 90 180 270 360]);
set(gca,'Fontsize',fig.fonts);
ylabel('wind dir (\circ)','Fontsize',fig.fonts);

axes(AX(1,4))
plot(Hs.t,Hs.hs,'Linewidth',fig.linewidth);
grid on
hold on
plot(day_of_year(data.Sep2014.Hm0(:,1)),data.Sep2014.Hm0(:,3)/100,'Linewidth',fig.linewidth);
plot(day_of_year(data.Oct2014.Hm0(:,1)),data.Oct2014.Hm0(:,3)/100,'Linewidth',fig.linewidth);
% vline(Hs.t(Hs.n16),'-k');
% vline(Hs.t(Hs.n30),'-k');
axis([Hs.t(1) fig.tend 0 3]);
set(gca,'Xtick',fig.xtick);
set(gca,'YTick',[0 0.5 1 1.5 2 2.5 3]);
set(gca,'Fontsize',fig.fonts);
ylabel('Hs (m)','Fontsize',fig.fonts);
% xlabel('Day of year','Fontsize',fig.fonts);
legend('Europlatform','Waverider');

axes(AX(1,5))
plot(Tm0.t,Tm0.tm0,'Linewidth',fig.linewidth);
grid on
hold on
plot(day_of_year(data.Sep2014.Tm02(:,1)),data.Sep2014.Tm02(:,3),'Linewidth',fig.linewidth);
plot(day_of_year(data.Oct2014.Tm02(:,1)),data.Oct2014.Tm02(:,3),'Linewidth',fig.linewidth);
% vline(Tm0.t(Tm0.n16),'-k');
% vline(Tm0.t(Tm0.n30),'-k');
axis([Tm0.t(1) fig.tend 0 8]);
set(gca,'Xtick',fig.xtick);
set(gca,'YTick',[0 2 4 6 8]);
set(gca,'Fontsize',fig.fonts);
ylabel('Tm02 (sec)','Fontsize',fig.fonts);
xlabel('Day of year','Fontsize',fig.fonts);
legend('Europlatform','Waverider');

set(AX(:,1:4),'xticklabel',[])
% print2screensize('WaveOct2011')
% print2a4(fig.name,'v','t')
set(gcf,'Color',[1 1 1]);
set(gcf,'Position',get(0,'ScreenSize'));
% export_fig(fig.name,'-pdf')
