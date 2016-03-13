%% Plot tide in GMT

load('d:\sabinerijnsbur\Measurements\Measurements2014\Matlab\Script_conditions\Tide_GMT.mat');

%% Plot during campaign in GMT

figure;
plot(T1.datenumGMT(T1.n16:T1.n30)-datenum(2014,09,16),T1.sea_surface_height(T1.n16:T1.n30),'b','Linewidth',2)
hold on
hline(0,'--k');
plot(T2.datenumGMT(T2.n16:T2.n30)-datenum(2014,09,16),T2.sea_surface_height(T2.n16:T2.n30),'--r','Linewidth',2)
% set(gca,'Xtick',datenum(2014,09,16,00,00,00):5:datenum(2014,10,29,23,50,00));
% datetick('x','dd/mm','keepticks');
% datetick('x','dd/mm','keepticks');
set(gca,'Fontsize',16);
% title('Tide in October at along the Dutch coast','Fontsize',16);
xlabel('Days (Start 16/09/14, in GMT)','Fontsize',16);
ylabel('Tidal height [m]','Fontsize',16);
legend('Scheveningen','Hoek van Holland');

set(gcf,'Color',[1 1 1]);
set(gcf,'Position',get(0,'ScreenSize'));
export_fig('Tide_GMT_160914-300914','-png')

%%

figure;
plot(T1.datenumGMT(T1.n16:T1.n30),T1.sea_surface_height(T1.n16:T1.n30),'b','Linewidth',2)
hold on
hline(0,'--k');
plot(T2.datenumGMT(T2.n16:T2.n30),T2.sea_surface_height(T2.n16:T2.n30),'--r','Linewidth',2)
set(gca,'Xtick',datenum(2014,09,16,00,00,00):5:datenum(2014,10,29,23,50,00));
datetick('x','dd/mm','keepticks');
datetick('x','dd/mm','keepticks');
set(gca,'Fontsize',16);
% title('Tide in October at along the Dutch coast','Fontsize',16);
xlabel('Days (Start 16/09/14, in GMT)','Fontsize',16);
ylabel('Tidal height [m]','Fontsize',16);
legend('Scheveningen','Hoek van Holland');

set(gcf,'Color',[1 1 1]);
set(gcf,'Position',get(0,'ScreenSize'));
export_fig('Tide_GMT_160914-300914_dates','-png')