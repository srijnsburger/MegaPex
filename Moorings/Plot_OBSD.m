%% Plot OBS Deltares

figure;
subplot(3,1,1)
plot(mat.time,mat.TurbFTU_Avg_2,'b','linewidth',1.5);
set(gca,'Xtick',mat.time(mat.start):5:mat.time(mat.stop));
datetick('x','dd/mm','keepticks');
set(gca,'Fontsize',14);
axis([mat.time(mat.start) mat.time(mat.stop) 0 600]);
set(gca,'YTick',[0 100 200 300 400 500 600]);
ylabel('Turbidity (FTU)');
title('OBS 13309 (7.1 mbs, 12m)');

subplot(3,1,2)
plot(mat.time,mat.TurbFTU_Avg_3,'b','linewidth',1.5);
set(gca,'Xtick',mat.time(mat.start):5:mat.time(mat.stop));
datetick('x','dd/mm','keepticks');
set(gca,'Fontsize',14);
axis([mat.time(mat.start) mat.time(mat.stop) 0 600]);
set(gca,'YTick',[0 100 200 300 400 500 600]);
ylabel('Turbidity (FTU)');
title('OBS 13310 (8.3 mbs, 12m)');

subplot(3,1,3)
plot(mat.time,mat.TurbFTU_Avg_1,'b','linewidth',1.5);
set(gca,'Xtick',mat.time(mat.start):5:mat.time(mat.stop));
datetick('x','dd/mm','keepticks');
set(gca,'Fontsize',14);
axis([mat.time(mat.start) mat.time(mat.stop) 0 600]);
set(gca,'YTick',[0 100 200 300 400 500 600]);
ylabel('Turbidity (FTU)');
title('OBS 12773 (11 mbs, 12m)');

