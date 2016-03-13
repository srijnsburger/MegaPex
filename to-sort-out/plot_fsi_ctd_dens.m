function plot_fsi_ctd_dens(ctd,name,fig)

figure;
subplot(4,1,1)
plot(ctd.t,ctd.press,'linewidth',fig.lwidth);
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.pressaxis]);
% set(gca,'XTick',fig.xtick);
% set(gca,'YTick',10:4:28);
ylabel('Pressure (dbar)');
title(['Data of',' ',name]);  

subplot(4,1,2)
plot(ctd.t,ctd.temp,'linewidth',fig.lwidth);
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis 14 20]);
% set(gca,'XTick',fig.xtick);
set(gca,'YTick',14:2:20);
ylabel('Temperature (\circ C)');

subplot(4,1,3)
plot(ctd.t,ctd.sal,'linewidth',fig.lwidth);
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis 25 35]);
% set(gca,'XTick',fig.xtick);
set(gca,'YTick',25:2.5:35);
ylabel('Salinity (psu)');

subplot(4,1,4)
plot(ctd.t,ctd.dens,'linewidth',fig.lwidth);
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.densaxis]);
% set(gca,'XTick',fig.xtick);
ylabel('Density (kg/m^3)');
xlabel(fig.xlabel);

end