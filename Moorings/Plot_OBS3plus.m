% Plot OBS data

load('d:\sabinerijnsbur\Measurement_Campaigns\Measurements2014\Matlab\SBE19_v1');
mat = SBE19_v1;

%% Plot OBS 3+

figure;
subplot(2,1,1)
plot(mat.time(mat.start:mat.stop),mat.v0(mat.start:mat.stop),'b','linewidth',1.5);
hold on
plot(mat.time(mat.start:mat.stop),mat.v1(mat.start:mat.stop),'g','linewidth',1.5);
set(gca,'Xtick',mat.time(mat.start):5:mat.time(mat.stop));
datetick('x','dd/mm','keepticks');
set(gca,'Fontsize',14);
axis([mat.time(mat.start) mat.time(mat.stop) 0 6]);
set(gca,'YTick',[0 1 2 3 4 5 6]);
ylabel('Volt (db)');
legend('Low voltage','High voltage','Location','NorthEast');
title('OBS 3+ 8150 (13.4 mbs, 18m)');

subplot(2,1,2)
plot(mat.time(mat.start:mat.stop),mat.v2(mat.start:mat.stop),'b','linewidth',1.5);
hold on
plot(mat.time(mat.start:mat.stop),mat.v3(mat.start:mat.stop),'g','linewidth',1.5);
set(gca,'Xtick',mat.time(mat.start):5:mat.time(mat.stop));
datetick('x','dd/mm','keepticks');
set(gca,'Fontsize',14);
axis([mat.time(mat.start) mat.time(mat.stop) 0 6]);
set(gca,'YTick',[0 1 2 3 4 5 6]);
ylabel('Volt (db)');
xlabel('Date');
legend('Low voltage','High voltage','Location','NorthEast');
title('OBS 3+ 8626 (16 mbs, 18m)');