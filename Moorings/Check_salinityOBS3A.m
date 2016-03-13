% Script to compare the conductivity sensor accuracy of OBS3A

load('SBE1527_v1');
load('SBE1525_v1');
load('SBE1526_v1');
load('SBE5426_v1');
load('SBE4939_v1');
load('SBE4940_v1');
load('OBS3A743');
load('OBS3A750');
load('OBS3A744');
load('OBS3A578');

%% Salinity comparison OBS3A - MC at buoy

figure;
subplot(2,1,1)
plot(SBE1527_v1.time,SBE1527_v1.sal)
hold on
plot(OBS3A743.time,OBS3A743.sal,'g')
set(gca,'Xtick',datenum(2014,09,15,00,00,00):5:datenum(2014,10,30,00,00,00));
datetick('x','dd/mm/yy','keepticks');
axis([datenum(2014,09,15,00,00,00) datenum(2014,10,30,00,00,00) 15 35]);
set(gca,'Fontsize',14);
set(gca,'YTick',[15 20 25 30 35]);
ylabel('Salinity (psu)');
legend('MC 1527','OBS3A 743');
title('Salinity 12m 1mbs');

subplot(2,1,2)
plot(SBE1525_v1.time,SBE1525_v1.sal)
hold on
plot(OBS3A750.time,OBS3A750.sal,'g')
set(gca,'Xtick',datenum(2014,09,15,00,00,00):5:datenum(2014,10,30,00,00,00));
datetick('x','dd/mm/yy','keepticks');
axis([datenum(2014,09,15,00,00,00) datenum(2014,10,30,00,00,00) 15 35]);
set(gca,'Fontsize',14);
set(gca,'YTick',[15 20 25 30 35]);
ylabel('Salinity (psu)');
xlabel('Date');
legend('MC 1525','OBS3A 750');
title('Salinity 18m 1mbs');

%% Salinity comparison OBS3A - MC middle

figure;
subplot(2,1,1)
plot(SBE1526_v1.time,SBE1526_v1.sal)
hold on
plot(OBS3A744.time,OBS3A744.sal,'g')
plot(SBE5426_v1.time,SBE5426_v1.sal,'r')
set(gca,'Xtick',datenum(2014,09,15,00,00,00):5:datenum(2014,10,30,00,00,00));
datetick('x','dd/mm/yy','keepticks');
axis([datenum(2014,09,15,00,00,00) datenum(2014,10,30,00,00,00) 15 35]);
set(gca,'Fontsize',14);
set(gca,'YTick',[15 20 25 30 35]);
ylabel('Salinity (psu)');
legend('MC 1526 (3mbs)','OBS3A 744 (5mbs)','MC 5426 (7mbs)');
title('Salinity 12m - checking OBS3A 744');

subplot(2,1,2)
plot(SBE1525_v1.time,SBE1525_v1.sal,'m')
hold on
plot(SBE4939_v1.time,SBE4939_v1.sal)
plot(OBS3A750.time,OBS3A750.sal,'g')
plot(SBE4940_v1.time,SBE4940_v1.sal,'r')
set(gca,'Xtick',datenum(2014,09,15,00,00,00):5:datenum(2014,10,30,00,00,00));
datetick('x','dd/mm/yy','keepticks');
axis([datenum(2014,09,15,00,00,00) datenum(2014,10,30,00,00,00) 15 35]);
set(gca,'Fontsize',14);
set(gca,'YTick',[15 20 25 30 35]);
ylabel('Salinity (psu)');
xlabel('Date');
legend('MC 1525 (1mbs)','MC 4939 (2.5mbs)','OBS3A 578 (5mbs)','MC 4940 (10mbs)');
title('Salinity 18m - checking OBS3A 578');

%% Temperature comparion OBS3A - MC

figure;
subplot(2,1,1)
plot(SBE1527_v1.time,SBE1527_v1.temp)
hold on
plot(OBS3A743.time,OBS3A743.temp,'g')
set(gca,'Xtick',datenum(2014,09,15,00,00,00):5:datenum(2014,10,30,00,00,00));
datetick('x','dd/mm/yy','keepticks');
axis([datenum(2014,09,15,00,00,00) datenum(2014,10,30,00,00,00) 10 25]);
set(gca,'Fontsize',14);
set(gca,'YTick',[10 15 20 25]);
ylabel('Temperature (deg. C)');
legend('MC 1527','OBS3A 743');
title('Temperature 12m 1mbs');

subplot(2,1,2)
plot(SBE1525_v1.time,SBE1525_v1.temp)
hold on
plot(OBS3A750.time,OBS3A750.temp,'g')
set(gca,'Xtick',datenum(2014,09,15,00,00,00):5:datenum(2014,10,30,00,00,00));
datetick('x','dd/mm/yy','keepticks');
axis([datenum(2014,09,15,00,00,00) datenum(2014,10,30,00,00,00) 10 25]);
set(gca,'Fontsize',14);
set(gca,'YTick',[10 15 20 25]);
ylabel('Temperature (^{\circ} C)');
xlabel('Date');
legend('MC 1525','OBS3A 750');
title('Temperature 18m 1mbs');

%% Temperature comparion OBS3A - MC middle

figure;
subplot(2,1,1)
plot(SBE1526_v1.time,SBE1526_v1.temp)
hold on
plot(OBS3A744.time,OBS3A744.temp,'g')
plot(SBE5426_v1.time,SBE5426_v1.temp,'r')
set(gca,'Xtick',datenum(2014,09,15,00,00,00):5:datenum(2014,10,30,00,00,00));
datetick('x','dd/mm/yy','keepticks');
axis([datenum(2014,09,15,00,00,00) datenum(2014,10,30,00,00,00) 10 25]);
set(gca,'Fontsize',14);
set(gca,'YTick',[10 15 20 25]);
ylabel('Temperature (^{\circ} C)');
legend('MC 1526 (3mbs)','OBS3A 744 (5mbs)','MC 5426 (7mbs)');
title('Temperature 12m - checking OBS3A 744');

subplot(2,1,2)
plot(SBE1525_v1.time,SBE1525_v1.temp,'m')
hold on
plot(SBE4939_v1.time,SBE4939_v1.temp)
plot(OBS3A750.time,OBS3A750.temp,'g')
plot(SBE4940_v1.time,SBE4940_v1.temp,'r')
set(gca,'Xtick',datenum(2014,09,15,00,00,00):5:datenum(2014,10,30,00,00,00));
datetick('x','dd/mm/yy','keepticks');
axis([datenum(2014,09,15,00,00,00) datenum(2014,10,30,00,00,00) 10 25]);
set(gca,'Fontsize',14);
set(gca,'YTick',[10 15 20 25]);
ylabel('Temperature (^{\circ} C)');
xlabel('Date');
legend('MC 1525 (1mbs)','MC 4939 (2.5mbs)','OBS3A 578 (5mbs)','MC 4940 (10mbs)');
title('Temperature 18m - checking OBS3A 578');
