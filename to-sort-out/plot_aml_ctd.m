% Plot conductivity

subplot(3,1,1)
plot(MS_CTs.time-datenum(2014,09,16),MS_CTs.cond7216,'linewidth',1.5);
set(gca,'fontsize',16);
axis([0 45 -0.2 0.2]);
ylabel('Conductivity');
title('CT7216, upper');

subplot(3,1,2)
plot(MS_CTs.time-datenum(2014,09,16),MS_CTs.cond7217,'linewidth',1.5);
set(gca,'fontsize',16);
axis([0 45 -0.2 0.2]);
ylabel('Conductivity');
title('CT7217, middle');

subplot(3,1,3)
plot(MS_CTs.time-datenum(2014,09,16),MS_CTs.cond7218,'linewidth',1.5);
set(gca,'fontsize',16);
axis([0 45 -0.2 0.2]);
ylabel('Conductivity');
xlabel('days (start 16/09/14)');
title('CT7218, lower');


% Plot salinity

subplot(3,1,1)
plot(MS_CTs.time-datenum(2014,09,16),MS_CTs.sal7216,'linewidth',1.5);
set(gca,'fontsize',16);
axis([0 45 25 35]);
ylabel('Salinity (psu)');
title('CT7216, upper');

subplot(3,1,2)
plot(MS_CTs.time-datenum(2014,09,16),MS_CTs.sal7217,'linewidth',1.5);
set(gca,'fontsize',16);
axis([0 45 25 35]);
ylabel('Salinity (psu)');
title('CT7217, middle');

subplot(3,1,3)
plot(MS_CTs.time-datenum(2014,09,16),MS_CTs.sal7218,'linewidth',1.5);
set(gca,'fontsize',16);
axis([0 45 25 35]);
ylabel('Salinity (psu)');
xlabel('days (start 16/09/14)');
title('CT7218, lower');

% Plot temperature

subplot(3,1,1)
plot(MS_CTs.time-datenum(2014,09,16),MS_CTs.temp7216,'linewidth',1.5);
set(gca,'fontsize',16);
set(gca,'fontsize',16);
axis([0 45 0 20]);
ylabel('Temperature');
title('CT7216, upper');

subplot(3,1,2)
plot(MS_CTs.time-datenum(2014,09,16),MS_CTs.temp7217,'linewidth',1.5);
set(gca,'fontsize',16);
axis([0 45 0 20]);
ylabel('Temperature');
title('CT7217, middle');

subplot(3,1,3)
plot(MS_CTs.time-datenum(2014,09,16),MS_CTs.temp7218,'linewidth',1.5);
set(gca,'fontsize',16);
axis([0 45 0 20]);
ylabel('Temperature');
xlabel('days (start 16/09/14)');
title('CT7218, lower');

