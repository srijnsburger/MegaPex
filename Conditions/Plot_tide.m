%% Plot_tide in GMT+1

clear all; close all; clc;
load('d:\sabinerijnsbur\Matlab_files\Megapex_data\Conditions\tide.mat');

%% Find end time based on adcp

% load('d:\sabinerijnsbur\Matlab_files\Megapex_data\adcp\adcp12');
% tend = adcp12.t(end);

tend = T1.t(end);
%% Input figure

dir_out = 'd:\sabinerijnsbur\Matlab\Figures\Conditions\';

fig.lwidth    = 1;
fig.fonts     = 12;
fig.txtfonts  = 12;
fig.color     = 'b';
fig.tend      = tend;
fig.xtick     = 260:5:fig.tend;
fig.name      = [dir_out 'Tide_autumn2014.pdf'];

%% Plot tide

figure;
plot(T1.t,T1.ssh,'b','Linewidth',fig.lwidth)
hold on
hline(0,'--k');
% plot(T2.t,T2.ssh,'--r','Linewidth',fig.lwidth)
axis([T1.t(1) fig.tend -1.5 2]);
set(gca,'Xtick',fig.xtick);
set(gca,'Fontsize',fig.fonts);
xlabel('Day of year','Fontsize',fig.fonts);
ylabel('\eta (m)','Fontsize',fig.fonts);
legend('Hoek van Holland');
title('Tide');

% set(gcf,'Color',[1 1 1]);
% set(gcf,'Position',get(0,'ScreenSize'));
% export_fig(fig.name,'-pdf')
% export_fig('Tide','-pdf')
%print2a4('Tide.png','v','t');

 %% Plot tide during 13 hrs campaign Claire (17th of Feb.)
% 
% % look for dates
% T1.n17  = find(T1.datenum == datenum('17-Sep-2014 00:00:00','dd-mmm-yyyy HH:MM:SS'));% Hoek van Holland
% T1.n18  = find(T1.datenum == datenum('18-Sep-2014 00:00:00','dd-mmm-yyyy HH:MM:SS'));
% 
% T2.n17  = find(T2.datenum == datenum('17-Sep-2014 00:00:00','dd-mmm-yyyy HH:MM:SS'));% Scheveningen
% T2.n18  = find(T2.datenum == datenum('18-Sep-2014 00:00:00','dd-mmm-yyyy HH:MM:SS'));
% 
% % plot
% figure;
% plot(T1.datenum(T1.n17:T1.n18),T1.sea_surface_height(T1.n17:T1.n18),'b','Linewidth',2)
% hold on
% hline(0,'--k');
% plot(T2.datenum(T2.n17:T2.n18),T2.sea_surface_height(T2.n17:T2.n18),'--r','Linewidth',2)
% set(gca,'Xtick',datenum(2014,09,17,00,00,00):0.0834:datenum(2014,09,18,00,00,00));
% datetick('x','HH:MM','keepticks');
% datetick('x','HH:MM','keepticks');
% set(gca,'Fontsize',16);
% title('Tide at the 17th of September 2014 along Dutch coast','Fontsize',16);
% xlabel('Time [GMT+1]','Fontsize',16);
% ylabel('Tidal height [m]','Fontsize',16);
% legend('Scheveningen','Hoek van Holland');
% 
% set(gcf,'Color',[1 1 1]);
% set(gcf,'Position',get(0,'ScreenSize'));
% export_fig('Tide_170914','-png')
% % export_fig('Tide','-pdf')
% %print2a4('Tide.png','v','t');