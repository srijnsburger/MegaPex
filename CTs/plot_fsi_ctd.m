function plot_fsi_ctd(ctd,name,fig)

% Input variables:
% ctd     = structure function of the fsi ctd (time, pressure, temperature,
%           salinity and turbidity)
% name    = is the title --> which instrument, which location etc.  


%% One plot with all data
figure;
subplot(5,1,1)
plot(ctd.t,ctd.press,'linewidth',fig.lwidth);
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.pressaxis]);
% set(gca,'XTick',fig.xtick);
% set(gca,'YTick',10:4:28);
ylabel('Pressure (dbar)');
title(['Data of',' ',name]);  

subplot(5,1,2)
plot(ctd.t,ctd.temp,'linewidth',fig.lwidth);
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis 14 20]);
% set(gca,'XTick',fig.xtick);
set(gca,'YTick',14:2:20);
ylabel('Temperature (\circ C)');

subplot(5,1,3)
plot(ctd.t,ctd.sal,'linewidth',fig.lwidth);
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis 25 35]);
% set(gca,'XTick',fig.xtick);
set(gca,'YTick',25:2.5:35);
ylabel('Salinity (psu)');

subplot(5,1,4)
plot(ctd.t,ctd.dens,'linewidth',fig.lwidth);
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis 1015 1030]);
% set(gca,'XTick',fig.xtick);
set(gca,'YTick',1015:5:1030);
ylabel('Density (kg/m^3)');

subplot(5,1,5)
plot(ctd.t,ctd.turb,'linewidth',fig.lwidth);
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.turbaxis]);
% set(gca,'XTick',fig.xtick);
ylabel('Turbidity (FTU)');
xlabel(fig.xlabel);


end