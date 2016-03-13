function plot_fittedvelocities(adcp,T,fig,save_plot)
%% Input 

fig.title = ['Position' fig.position ' tstep:' num2str(T.tstep)];
fig.fname = ['FittedVelocities' fig.position 'm_tstep_' num2str(T.tstep) '.png'];

%% PLot
figure;
AX = subplot_meshgrid(2,8,[.06 0.01 0.05],[.03 .01 .01 .01 .01 .01 .01 .01 .03],[nan 0.02],[nan nan nan nan nan nan nan nan]);
axes(AX(1,1))
plot(adcp.t,adcp.meanva,'b','Linewidth',fig.lwidth)
hold on
plot(adcp.t,T.meanva,'r','Linewidth',fig.lwidth)
plot(adcp.t,(adcp.meanva-T.meanva),':k','Linewidth',fig.lwidth);
hline(0,'k');
ylim([-1 1.5]);
xlim(fig.xlim);
set(gca,'Fontsize',fig.fonts);
ylabel('Depth mean Us [m/s]');
legend('Measured velocity',[T.comp],'Velocity residual');
legend('Location',fig.legendloc,'Orientation',fig.legendorien);
% legend('Boxoff');
% text(adcp.t(10),1.7,'Depth mean alongshore velocity');
text(fig.txtX,(max(adcp.meanva)+0.1*max(adcp.meanva)),'Depth mean alongshore velocity');
title(fig.title);

axes(AX(1,2))
plot(adcp.t,adcp.meanvc,'b','Linewidth',fig.lwidth)
hold on
plot(adcp.t,T.meanvc,'r','Linewidth',fig.lwidth)
plot(adcp.t,(adcp.meanvc - T.meanvc),':k','Linewidth',fig.lwidth);
hline(0,'k');
xlim(fig.xlim);
set(gca,'Fontsize',fig.fonts);
ylabel('Depth mean Un [m/s]');
text(fig.txtX,(max(adcp.meanvc)+0.1*max(adcp.meanvc)),'Depth mean cross-shore velocity');

axes(AX(1,3))
pcolorcorcen(adcp.t,adcp.z,adcp.va);
hold on
plot(adcp.t,adcp.h,'k');
ylim(fig.ylim);
xlim(fig.xlim);
clim([-1.5 1.5]);
% datetick('x');
colorbarwithvtext('u','vert','position',get(AX(2,3),'position'));
set(gca,'Fontsize',fig.fonts);
ylabel('Depth (mab)','Fontsize',fig.fonts);
text(fig.txtX,fig.txtY,'Alongshore measured velocity');

axes(AX(1,4))
pcolorcorcen(adcp.t,adcp.z,T.va);
hold on
plot(adcp.t,adcp.h,'k');
ylim(fig.ylim);
xlim(fig.xlim);
clim([-1.5 1.5]);
% datetick('x');
colorbarwithvtext('u fitted','vert','position',get(AX(2,4),'position'));
set(gca,'Fontsize',fig.fonts);
ylabel('Depth (mab)','Fontsize',fig.fonts);
text(fig.txtX,fig.txtY,['Alongshore fitted velocity ',T.comp]);

axes(AX(1,5))
pcolorcorcen(adcp.t,adcp.z,(adcp.va-T.va));
hold on
plot(adcp.t,adcp.h,'k');
ylim(fig.ylim);
xlim(fig.xlim);
clim([-1 1]);
% datetick('x');
colorbarwithvtext('difference','vert','position',get(AX(2,5),'position'));
set(gca,'Fontsize',fig.fonts);
ylabel('Depth (mab)','Fontsize',fig.fonts);
text(fig.txtX,fig.txtY,'Difference alongshore measured and fitted velocity');

axes(AX(1,6))
pcolorcorcen(adcp.t,adcp.z,adcp.vc);
hold on
plot(adcp.t,adcp.h,'k');
ylim(fig.ylim);
xlim(fig.xlim);
clim([-0.5 0.5]);
% datetick('x');
colorbarwithvtext('v','vert','position',get(AX(2,6),'position'));
set(gca,'Fontsize',fig.fonts);
ylabel('Depth (mab)','Fontsize',fig.fonts);
text(fig.txtX,fig.txtY,'Cross-shore measured velocity');

axes(AX(1,7))
pcolorcorcen(adcp.t,adcp.z,T.vc);
hold on
plot(adcp.t,adcp.h,'k');
ylim(fig.ylim);
xlim(fig.xlim);
clim([-0.5 0.5]);
% datetick('x');
colorbarwithvtext('v fitted','vert','position',get(AX(2,7),'position'));
set(gca,'Fontsize',fig.fonts);
ylabel('Depth (mab)','Fontsize',fig.fonts);
text(fig.txtX,fig.txtY,['Cross-shore fitted velocity ',T.comp]);

axes(AX(1,8))
pcolorcorcen(adcp.t,adcp.z,(adcp.vc-T.vc));
hold on
plot(adcp.t,adcp.h,'k');
ylim(fig.ylim);
xlim(fig.xlim);
clim([-0.5 0.5]);
% datetick('x');
colorbarwithvtext('difference','vert','position',get(AX(2,8),'position'));
set(gca,'Fontsize',fig.fonts);
ylabel('Depth (mab)','Fontsize',fig.fonts);
% xlabel('Day in year');
xlabel('time');
text(fig.txtX,fig.txtY,'Difference cross-shore measured and fitted velocity');

set(AX(:,1:7),'xticklabel',[])
set(AX(2,:),'yticklabel',[])
delete(AX(2,1))
delete(AX(2,2))
delete(AX(2,3))
delete(AX(2,4))
delete(AX(2,5))
delete(AX(2,6))
delete(AX(2,7))
delete(AX(2,8))

% Save
if strcmp(save_plot,'yes')
print2a4(fig.fname,'v','w');
end
end
