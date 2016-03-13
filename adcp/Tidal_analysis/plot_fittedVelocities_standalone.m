% Plot fitted velocities
% Load data

%% Input figure

fig.fonts = 8;
fig.lwidth= 1;
fig.ylim  = [0 12];

%% Plot

figure;
AX = subplot_meshgrid(1,8,[.06 .05],[.03 .01 .01 .01 .01 .01 .01 .01 .03],[nan],[nan nan nan nan nan nan nan nan]);
axes(AX(1,1))
plot(adcp.time,adcp.meanva,'b','Linewidth',fig.lwidth)
hold on
vline(T.time,':k');
plot(T.time,T.meanva_fit,'r','Linewidth',fig.lwidth)
plot(T.time,T.meanva_res,':k','Linewidth',fig.lwidth);
hline(0,'k');
axis tight;
set(gca,'Fontsize',fig.fonts);
ylabel('Depth mean Us [m/s]');
legend(['Measured velocity',T.comp,'Velocity residual']);
legend('Location','SouthEast');
legend('Boxoff');
text(adcp.time(2),0.75,'Depth mean alongshore velocity');

axes(AX(1,2))
plot(adcp.time,adcp.meanvc,'b','Linewidth',fig.lwidth)
hold on
vline(adcp.time,':k');
plot(adcp.time,T.meanvc_fit,'r','Linewidth',fig.lwidth)
plot(adcp.time,T.meanvc_res,':k','Linewidth',fig.lwidth);
hline(0,'k');
axis tight;
set(gca,'Fontsize',fig.fonts);
ylabel('Depth mean Un [m/s]');
text(adcp.time(2),0.15,'Depth mean cross-shore velocity');

axes(AX(1,3))
pcolorcorcen(adcp.time,adcp.ranges,adcp.va);
axis tight;
ylim(fig.ylim);
clim([-1.5 1.5]);
datetick('x');
colorbarwithvtext('u','vert');
set(gca,'Fontsize',fig.fonts);
ylabel('Depth [m]','Fontsize',fig.fonts);
text(adcp.time(2),adcp.ranges(48),'Alongshore measured velocity');

axes(AX(1,4))
pcolorcorcen(adcp.time,adcp.ranges,T.va);
axis tight;
ylim(fig.ylim);
clim([-1.5 1.5]);
datetick('x');
colorbarwithvtext('u fitted','vert');
set(gca,'Fontsize',fig.fonts);
ylabel('Depth [m]','Fontsize',fig.fonts);
text(adcp.time(2),adcp.ranges(48),'Alongshore fitted velocity');

axes(AX(1,5))
pcolorcorcen(adcp.time,adcp.ranges,(adcp.va-T.va));
axis tight;
ylim(fig.ylim);
clim([-1.5 1.5]);
datetick('x');
colorbarwithvtext('difference','vert');
set(gca,'Fontsize',fig.fonts);
ylabel('Depth [m]','Fontsize',fig.fonts);
text(adcp.time(2),adcp.ranges(48),'Difference alongshore measured and fitted velocity');

axes(AX(1,6))
pcolorcorcen(adcp.time,adcp.ranges,adcp.vc);
axis tight;
ylim(fig.ylim);
clim([-1 1]);
datetick('x');
colorbarwithvtext('v','vert');
set(gca,'Fontsize',fig.fonts);
ylabel('Depth [m]','Fontsize',fig.fonts);
text(adcp.time(2),adcp.ranges(48),'Cross-shore measured velocity');

axes(AX(1,7))
pcolorcorcen(adcp.time,adcp.ranges,T.vc);
axis tight;
ylim(fig.ylim);
clim([-1 1]);
datetick('x');
colorbarwithvtext('v fitted','vert');
set(gca,'Fontsize',fig.fonts);
ylabel('Depth [m]','Fontsize',fig.fonts);
text(adcp.time(2),adcp.ranges(48),'Cross-shore fitted velocity');

axes(AX(1,8))
pcolorcorcen(adcp.time,adcp.ranges,(adcp.vc-T.vc));
axis tight;
ylim(fig.ylim);
clim([-1 1]);
datetick('x');
colorbarwithvtext('difference','vert');
set(gca,'Fontsize',fig.fonts);
ylabel('Depth [m]','Fontsize',fig.fonts);
% xlabel('Day in year');
xlabel('time');
text(adcp.time(2),adcp.ranges(48),'Difference cross-shore measured and fitted velocity');

set(AX(:,1:7),'xticklabel',[])
% set(AX(2,:),'yticklabel',[])
% delete(AX(2,1))
% delete(AX(2,2))
% delete(AX(2,3))
% delete(AX(2,4))
% delete(AX(2,5))
% delete(AX(2,6))
% delete(AX(2,7))
% delete(AX(2,8))

