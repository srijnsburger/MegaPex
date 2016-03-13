
load('d:\sabinerijnsbur\Matlab\Measurements\Conditions\wave.mat');

% input figure
fig.fonts     = 12;
fig.linewidth = 1;
fig.txtfonts  = 12;
fig.color     = 'b';
fig.name      = 'wave_autumn2014.png';

%% Plot wave characteristics during September - October 2014

figure;
AX = subplot_meshgrid(1,3,[.08 .03],[.04 .03 .03 .07]);
axes(AX(1,1))
plot(Hs.t,Hs.hs,fig.color,'Linewidth',fig.linewidth);
grid on
hold on
% vline(Hs.t(Hs.n16),'-k');
% vline(Hs.t(Hs.n30),'-k');
axis([Hs.t(1) Hs.t(end) 0 6]);
set(gca,'Xtick',Hs.t(1):5:Hs.t(end));
set(gca,'YTick',[0 1 2 3 4 5 6]);
set(gca,'Fontsize',fig.fonts);
ylabel('Hs (m)','Fontsize',fig.fonts);
% text(datenum(2014,09,16)+0.001,3.5,'16/09','Color','b','rotation',90,'VerticalAlignment','bottom','Fontsize',fig.txtfonts);
% text(datenum(2014,10,01)+0.001,3.5,'01/10','Color','b','rotation',90,'VerticalAlignment','bottom','Fontsize',fig.txtfonts);
% text(datenum(2014,10,15)+0.001,3.5,'15/10','Color','b','rotation',90,'VerticalAlignment','bottom','Fontsize',fig.txtfonts);

axes(AX(1,2))
plot(Wd.t,Wd.dir,fig.color,'Linewidth',fig.linewidth);
grid on
hold on
% vline(Wd.t(Wd.n16),'-k');
% vline(Wd.t(Wd.n30),'-k');
axis([Wd.t(1) Wd.t(end) 0 360]);
set(gca,'Fontsize',fig.fonts);
set(gca,'Xtick',Wd.t(1):5:Wd.t(end));
set(gca,'YTick',[0 90 180 270 360]);
% xlabel('Time [h]','Fontsize',fig.fonts);
ylabel('Wave direction (\circ)','Fontsize',fig.fonts);
% text(datenum(2014,09,16)+0.001,3.5,'16/09','Color','b','rotation',90,'VerticalAlignment','bottom','Fontsize',fig.txtfonts);
% text(datenum(2014,10,01)+0.001,120,'01/10','Color','b','rotation',90,'VerticalAlignment','bottom','Fontsize',fig.txtfonts);
% text(datenum(2014,10,15)+0.001,120,'15/10','Color','b','rotation',90,'VerticalAlignment','bottom','Fontsize',fig.txtfonts);

axes(AX(1,3))
plot(Tm0.t,Tm0.tm0,fig.color,'Linewidth',fig.linewidth);
grid on
hold on
% vline(Tm0.t(Tm0.n16),'-k');
% vline(Tm0.t(Tm0.n30),'-k');
axis([Tm0.t(1) Tm0.t(end) 0 8]);
set(gca,'Xtick',Tm0.t(1):5:Tm0.t(end));
set(gca,'YTick',[0 2 4 6 8]);
set(gca,'Fontsize',fig.fonts);
xlabel('Day of year','Fontsize',fig.fonts);
ylabel('Tm0 (sec)','Fontsize',fig.fonts);
% text(datenum(2014,09,16)+0.001,3.5,'16/09','Color','b','rotation',90,'VerticalAlignment','bottom','Fontsize',fig.txtfonts);
% text(datenum(2011,10,12)+0.001,3,'12/10','Color','b','rotation',90,'VerticalAlignment','bottom','Fontsize',fig.txtfonts);
% text(datenum(2011,10,13)+0.001,3,'13/10','Color','b','rotation',90,'VerticalAlignment','bottom','Fontsize',fig.txtfonts);

set(AX(:,1:2),'xticklabel',[])

% print2screensize('WaveOct2011')
print2a4(fig.name,'v','t')


%% Plot waves during 17-09-2014 Navicula transect
start = '17-Sep-2014 06:00:00';
stop  = '17-Sep-2014 21:00:00';

t1       = find(Hs.time == datenum(start,'dd-mmm-yyyy HH:MM:SS'));
t2       = find(Hs.time == datenum(stop,'dd-mmm-yyyy HH:MM:SS'));

fig.xtick = Hs.t(t1):0.0834:Hs.t(t2);

figure;
AX = subplot_meshgrid(1,3,[.08 .03],[.04 .03 .03 .07]);
axes(AX(1,1))
plot(Hs.t(t1:t2),Hs.hs(t1:t2),fig.color,'Linewidth',fig.linewidth);
grid on
hold on
set(gca,'Xtick',fig.xtick);
% datetick('x','HH:MM','keepticks');
set(gca,'YTick',[0 1 2 3 4 5 6]);
set(gca,'Fontsize',fig.fonts);
ylabel('Hs [m]','Fontsize',fig.fonts);

axes(AX(1,2))
plot(Wd.t(t1:t2),Wd.dir((t1:t2)),fig.color,'Linewidth',fig.linewidth);
grid on
hold on
% axis([datenum(2011,10,01) datenum(2011,11,01) 0 360]);
set(gca,'Xtick',fig.xtick);
% datetick('x','HH:MM','keepticks');
set(gca,'Fontsize',fig.fonts);
set(gca,'YTick',[0 90 180 270 360]);
% xlabel('Time [h]','Fontsize',fig.fonts);
ylabel('Wave direction [degree]','Fontsize',fig.fonts);

axes(AX(1,3))
plot(Tm0.t(t1:t2),Tm0.tm0(t1:t2),fig.color,'Linewidth',fig.linewidth);
grid on
hold on
% axis([datenum(2011,10,17) datenum(2011,11,01) 0 8]);
set(gca,'Xtick',fig.xtick);
% datetick('x','HH:MM','keepticks');
set(gca,'Fontsize',fig.fonts);
set(gca,'YTick',[0 2 4 6 8]);
xlabel('Date','Fontsize',fig.fonts);
ylabel('Tm0 [sec]','Fontsize',fig.fonts);

set(AX(:,1:2),'xticklabel',[])

% print2screensize('WaveOct2011')
print2a4('Wave17092014.png','v','t')
close