function plot_OBS3A_raw(mat, name)
%% Make time selection, start at 15/09/2014 

%% Plot 

subplot(4,1,1)
plot(mat.time,mat.temp,'Linewidth',2)
datetick('x','dd/mm/yy','keepticks');
set(gca,'Fontsize',14);
ylim([0,30]);
xlabel('Time');
ylabel('Temperature (degree C)');

subplot(4,1,2)
plot(mat.time,mat.salinity,'Linewidth',2)
datetick('x','dd/mm/yy','keepticks');
set(gca,'Fontsize',14);
ylim([0,40]);
xlabel('Time');
ylabel('Salinity (PSU)');

subplot(4,1,3)
plot(mat.time,mat.obs,'Linewidth',2)
datetick('x','dd/mm/yy','keepticks');
set(gca,'Fontsize',14);
ylim([0,100]);
xlabel('Time');
ylabel('Turbidity (NTU)');

subplot(4,1,4)
plot(mat.time,mat.depth,'Linewidth',2)
datetick('x','dd/mm/yy','keepticks');
set(gca,'Fontsize',14);
xlabel('Time');
ylabel('Depth (m)');

set(gcf,'Color',[1 1 1]);
set(gcf,'Position',get(0,'ScreenSize'));
% print2screensize(name,'.png');
export_fig(name,'-pdf')
export_fig(name,'-png')
end
