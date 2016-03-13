figure;
ax(1)= subplot(4,1,1);
if strcmp(mooring,'12m');
    plot(SBE1527.t10,SBE1527.dens10-1000,'linewidth',fig.lwidth);
    hold on
    plot(SBE1526.t10,SBE1526.dens10-1000,'--r','linewidth',fig.lwidth);
    plot(SBE5426.t10,SBE5426.dens10-1000,'-.k','linewidth',fig.lwidth);
    plot(SBE5425.t10,SBE5425.dens10-1000,'c','linewidth',fig.lwidth);
    plot(SBE1842.t10,SBE1842.dens10-1000,'g','linewidth',fig.lwidth);
    set(gca,'Fontsize',fig.fonts);
    axis([fig.xaxis fig.ydens]);
    xlim(fig.xlim);
    set(gca,'YTick',fig.ytickdens);
    set(gca,'XTick',fig.xtick);
    ylabel('Rel. Density (kg/m^3)');
    legend('MC1527 1mbs','MC1526 3mbs','MC5426 7mbs','MC5425 8mbs','MC1842 10.5mbs');
    legend('Location',fig.legendloc,'Orientation',fig.legendorien);
    colorbar;
elseif strcmp(mooring,'18m')
    plot(SBE1525.t,SBE1525.dens-1000,'linewidth',fig.lwidth);
    hold on
    plot(SBE4939.t,SBE4939.dens-1000,'--r','linewidth',fig.lwidth);
    plot(SBE4940.t,SBE4940.dens-1000,'-.k','linewidth',fig.lwidth);
    plot(SBE19.t,SBE19.dens-1000,'c','linewidth',fig.lwidth);
    set(gca,'Fontsize',fig.fonts);
    axis([fig.xaxis fig.ydens]);
    xlim(fig.xlim);
    set(gca,'YTick',fig.ytickdens);
    set(gca,'XTick',fig.xtick);
    ylabel('Rel. Density (kg/m^3');
    legend('MC1525 1mbs','MC4939 2.5mbs','MC4940 10mbs','MC19 15 mbs');
    legend('Location',fig.legendloc,'Orientation',fig.legendorien);
    colorbar;
end

ax(2) = subplot(4,1,2);
pcolorcorcen(adcp.t,adcp.z,adcp.va);
hold on
plot(adcp.t,adcp.h,'k');
set(gca,'Fontsize',fig.fonts);
% ylim(fig.ylim);
% xlim(fig.xlim);
axis([fig.xaxis fig.ylim]);
xlim(fig.xlim);
set(gca,'XTick',fig.xtick);
clim([-1.5 1.5]);
% datetick('x');
colorbar;
ylabel('Depth (mab)','Fontsize',fig.fonts);

ax(3) = subplot(4,1,3);
pcolorcorcen(adcp.t,adcp.z,adcp.vc);
hold on
plot(adcp.t,adcp.h,'k');
set(gca,'Fontsize',fig.fonts);
% ylim(fig.ylim);
% xlim(fig.xlim);
axis([fig.xaxis fig.ylim]);
xlim(fig.xlim);
set(gca,'XTick',fig.xtick);
clim([-0.5 0.5]);
% datetick('x');
colorbar;

ax(4) = subplot(4,1,4);
pcolorcorcen(adcp.t(T.times),adcp.z,T.minor./T.major)
hold on
plot(adcp.t,adcp.h)
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis fig.ylim]);
set(gca,'XTick',fig.xtick);
xlim(fig.xlim);
clim([-0.4 0.6]);
colorbar;
ylabel('Depth (mab)','Fontsize',fig.fonts);

% all_ha = findobj(fhandle,'type','axes','tag','');
linkaxes(ax, 'x' );
