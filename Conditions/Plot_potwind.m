%% Plot_potwind
% Script to plot the potential wind

clear all; close all; clc;

load('D:\sabinerijnsbur\Measurement_Campaigns\Measurements2014\Matlab\Script_conditions\Potwind.mat');

mat = Potwind;
name = 'Potwind';

%% Plot 

figure;
AX = subplot_meshgrid(1,2,[.08 .03],[.04 .03 .07]);
axes(AX(1,1))
plot(mat.time,mat.speed,'k', 'Linewidth',1.5)
grid on
hold on
% vline(datenum(2011,10,13),'-c','13/10');
% vline(datenum(2011,10,12),'-c','12/10');
% vline(datenum(2011,10,11),'-c','11/10');
vline(datenum(2014,09,15),'-b');
vline(datenum(2014,10,01),'-b');
vline(datenum(2014,10,26),'-b');
axis([datenum(2014,09,01) datenum(2014,11,01) 0 22]);
set(gca,'Xtick',datenum(2014,09,01,00,00,00):5:datenum(2014,11,01,00,50,00));
datetick('x','dd/mm','keepticks');
set(gca,'YTick',[0 2 4 6 8 10 12 14 16 18 20 22]);
set(gca,'Fontsize',11);
ylabel('Hourly av. windspeed [m/s]','Fontsize',11);
text(datenum(2014,09,15)+0.001,17,'15/09','Color','b','rotation',90,'VerticalAlignment','bottom','Fontsize',10);
text(datenum(2014,10,01)+0.001,17,'01/10','Color','b','rotation',90,'VerticalAlignment','bottom','Fontsize',10);
text(datenum(2014,10,26)+0.001,17,'26/10','Color','b','rotation',90,'VerticalAlignment','bottom','Fontsize',10);

axes(AX(1,2))
plot(mat.time,mat.dir,'k','Linewidth',1.5);
grid on
hold on
% vline(datenum(2011,10,13),'-c','13/10');
% vline(datenum(2011,10,12),'-c','12/10');
% vline(datenum(2011,10,11),'-c','11/10');
vline(datenum(2014,09,15),'-b');
vline(datenum(2014,10,01),'-b');
vline(datenum(2014,10,26),'-b');
axis([datenum(2014,09,01) datenum(2014,11,01) 0 360]);
set(gca,'Xtick',datenum(2014,09,01,00,00,00):5:datenum(2014,11,01,00,50,00));
datetick('x','dd/mm','keepticks');
set(gca,'Fontsize',11);
set(gca,'YTick',[0 90 135 180 225 270 315 360]);
ylabel('Wind direction [degrees]','Fontsize',11);
xlabel('Time (GMT)','Fontsize',12);
text(datenum(2014,09,15)+0.001,290,'15/09','Color','b','rotation',90,'VerticalAlignment','bottom','Fontsize',10);
text(datenum(2014,10,01)+0.001,290,'01/10','Color','b','rotation',90,'VerticalAlignment','bottom','Fontsize',10);
text(datenum(2014,10,26)+0.001,290,'26/10','Color','b','rotation',90,'VerticalAlignment','bottom','Fontsize',10);

set(AX(:,1),'xticklabel',[])
% print2screensize('Wind0ct2011')
print2a4([name,'.png'],'v','t')
% export_fig('Potwind','-pdf');
% export_fig('Potwind','-png');
close

%% Plot wind 17th of September 2014 (during 13 hrs floc measurements)

% look for dates
mat.n17  = find(mat.time == datenum('17-Sep-2014 00:00:00','dd-mmm-yyyy HH:MM:SS'));
mat.n18  = find(mat.time == datenum('18-Sep-2014 00:00:00','dd-mmm-yyyy HH:MM:SS'));

% Plot
figure;
AX = subplot_meshgrid(1,2,[.08 .03],[.04 .03 .07]);
axes(AX(1,1))
plot(mat.time(mat.n17:mat.n18),mat.speed(mat.n17:mat.n18),'k', 'Linewidth',1.5)
grid on
hold on
axis([datenum(2014,09,17,00,00,00) datenum(2014,09,18,00,00,00) 0 22]);
set(gca,'Xtick',datenum(2014,09,17,00,00,00):0.0834:datenum(2014,09,18,00,00,00));
datetick('x','HH:MM','keepticks');
set(gca,'YTick',[0 2 4 6 8 10 12 14 16 18 20 22]);
set(gca,'Fontsize',11);
ylabel('Potential windspeed [m/s]','Fontsize',11);

axes(AX(1,2))
plot(mat.time(mat.n17:mat.n18),mat.dir(mat.n17:mat.n18),'k','Linewidth',1.5);
grid on
hold on
axis([datenum(2014,09,17,00,00,00) datenum(2014,09,18,00,00,00) 0 360]);
set(gca,'Xtick',datenum(2014,09,17,00,00,00):0.0834:datenum(2014,09,18,00,00,00));
datetick('x','HH:MM','keepticks');
set(gca,'Fontsize',11);
set(gca,'YTick',[0 90 135 180 225 270 315 360]);
ylabel('Wind direction [degrees]','Fontsize',11);
xlabel('Time (GMT)','Fontsize',12);

set(AX(:,1),'xticklabel',[])
% print2screensize('Wind0ct2011')
print2a4([name,'170914','.png'],'v','t')
% export_fig('Potwind','-pdf');
% export_fig('Potwind','-png');
close
