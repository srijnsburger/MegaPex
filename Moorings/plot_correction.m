function plot_correction(mooring,corr)
%% load

dirin = 'd:\sabinerijnsbur\Matlab\Moorings\Mfiles\';

if strcmp(mooring,'12m');
    load([dirin,'SBE1526.mat']);
    load([dirin,'SBE1527.mat']);
    load([dirin,'SBE5425.mat']);
    load([dirin,'SBE5426.mat']);
    load([dirin,'SBE1842.mat']);
    fig.xaxis    = [259 SBE1842.t(end)];
    fig.xtick    = 259:2:SBE1842.t(end);
elseif strcmp(mooring,'18m')
    load([dirin,'SBE1525.mat']);
    load([dirin,'SBE4939.mat']);
    load([dirin,'SBE4940.mat']);
    load([dirin,'SBE19.mat']);
    fig.xaxis    = [259 SBE19.t(end)];
    fig.xtick    = 259:2:SBE19.t(end);
else
end

%% Input figure

fig.lwidth      = 1;
fig.fonts       = 8;
fig.txtfonts    = 8;
% fig.xaxis       = [259 corr.t(end)];
% fig.xtick       = 259:2:corr.t(end);
fig.ydens       = [12.5 25];% relative density range
fig.ytickdens   = 12.5:2.5:25;
fig.legendloc   = 'SouthEast';
fig.legendorien = 'horizontal';

% Plot corrected salinity 12m
if strcmp(mooring,'12m')
figure;
subplot(2,1,1)
plot(SBE1527.t,SBE1527.sal,'linewidth',fig.lwidth);
hold on
plot(SBE1526.t,SBE1526.sal,'--r','linewidth',fig.lwidth);
plot(SBE5426.t,SBE5426.sal,'-.k','linewidth',fig.lwidth);
plot(SBE5425.t,SBE5425.sal,'c','linewidth',fig.lwidth);
plot(SBE1842.t,SBE1842.sal,'g','linewidth',fig.lwidth);
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis 20 35]);
set(gca,'YTick',20:2.5:32.5);
set(gca,'XTick',fig.xtick);
ylabel('Salinity (PSU)');

subplot(2,1,2)
plot(SBE1527.t,SBE1527.sal,'linewidth',fig.lwidth);
hold on
plot(SBE1526.t,SBE1526.sal,'--r','linewidth',fig.lwidth);
plot(SBE5426.t,SBE5426.sal,'-.k','linewidth',fig.lwidth);
plot(SBE5425.t,SBE5425.sal,'c','linewidth',fig.lwidth);
plot(SBE1842.t,corr.sal,'g','linewidth',1.5);
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis 20 35]);
set(gca,'YTick',20:2.5:32.5);
set(gca,'XTick',fig.xtick);
ylabel('Corrected Salinity (PSU)');
xlabel('Day of year');
title('Corrected salinity SBE1842 12m mooring');

% Plot corrected density 12m

figure;
subplot(2,1,1)
plot(SBE1527.t,SBE1527.dens-1000,'linewidth',fig.lwidth);
hold on
plot(SBE1526.t,SBE1526.dens-1000,'--r','linewidth',fig.lwidth);
plot(SBE5426.t,SBE5426.dens-1000,'-.k','linewidth',fig.lwidth);
plot(SBE5425.t,SBE5425.dens-1000,'c','linewidth',fig.lwidth);
plot(SBE1842.t,SBE1842.dens-1000,'g','linewidth',fig.lwidth);
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis fig.ydens]);
set(gca,'YTick',fig.ytickdens);
set(gca,'XTick',fig.xtick);
ylabel('Relative density (kg/m^3)');
legend('MC1527 1mbs','MC1526 3mbs','MC5426 7mbs','MC5425 8mbs','MC1842 10.5mbs');
legend('Location',fig.legendloc,'Orientation',fig.legendorien);
title('Correction density SBE1842 12 m mooring');

subplot(2,1,2)
plot(SBE1527.t,SBE1527.dens-1000,'linewidth',fig.lwidth);
hold on
plot(SBE1526.t,SBE1526.dens-1000,'--r','linewidth',fig.lwidth);
plot(SBE5426.t,SBE5426.dens-1000,'-.k','linewidth',fig.lwidth);
plot(SBE5425.t,SBE5425.dens-1000,'c','linewidth',fig.lwidth);
plot(SBE1842.t,corr.dens-1000,'g','linewidth',1.5);
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis fig.ydens]);
set(gca,'YTick',fig.ytickdens);
set(gca,'XTick',fig.xtick);
ylabel('Corrected relative density (kg/m^3)');
xlabel('Day of year');

% time averaged
figure;
subplot(2,1,1)
plot(SBE1527.t10,SBE1527.sal10,'linewidth',fig.lwidth);
hold on
plot(SBE1526.t10,SBE1526.sal10,'--r','linewidth',fig.lwidth);
plot(SBE5426.t10,SBE5426.sal10,'-.k','linewidth',fig.lwidth);
plot(SBE5425.t10,SBE5425.sal10,'c','linewidth',fig.lwidth);
plot(SBE1842.t10,SBE1842.sal10,'g','linewidth',fig.lwidth);
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis 20 35]);
set(gca,'YTick',20:2.5:32.5);
set(gca,'XTick',fig.xtick);
ylabel('Salinity (PSU)');

subplot(2,1,2)
plot(SBE1527.t10,SBE1527.sal10,'linewidth',fig.lwidth);
hold on
plot(SBE1526.t10,SBE1526.sal10,'--r','linewidth',fig.lwidth);
plot(SBE5426.t10,SBE5426.sal10,'-.k','linewidth',fig.lwidth);
plot(SBE5425.t10,SBE5425.sal10,'c','linewidth',fig.lwidth);
plot(SBE1842.t10,corr.sal10,'g','linewidth',1.5);
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis 20 35]);
set(gca,'YTick',20:2.5:32.5);
set(gca,'XTick',fig.xtick);
ylabel('Corrected Salinity (PSU)');
xlabel('Day of year');
title('Corrected salinity SBE1842 12m mooring - time-averaged');

elseif strcmp(mooring,'18m')

    %plot corrected salinity 18m
figure;
subplot(2,1,1)
plot(SBE1525.t,SBE1525.sal,'linewidth',fig.lwidth);
hold on
plot(SBE4939.t,SBE4939.sal,'--r','linewidth',fig.lwidth);
plot(SBE4940.t,SBE4940.sal,'-.k','linewidth',fig.lwidth);
plot(SBE19.t,SBE19.sal,'c','linewidth',fig.lwidth);
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis 20 35]);
set(gca,'YTick',20:2.5:32.5);
set(gca,'XTick',fig.xtick);
legend('MC1525 1mbs','MC4939 2.5mbs','MC4940 10mbs','MC19 15 mbs');
legend('Location',fig.legendloc,'Orientation',fig.legendorien);
title('Salinity 18m mooring')

subplot(2,1,2)
plot(SBE1525.t,SBE1525.sal,'linewidth',fig.lwidth);
hold on
plot(SBE4939.t,SBE4939.sal,'--r','linewidth',fig.lwidth);
plot(SBE4940.t,SBE4940.sal,'-.k','linewidth',fig.lwidth);
plot(SBE19.t,corr.sal,'c','linewidth',1.5);
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis 20 35]);
set(gca,'YTick',20:2.5:32.5);
set(gca,'XTick',fig.xtick);
ylabel('Salinity Corrected (PSU)');
xlabel('Day of year');

% plot corrected density 18m
figure;
subplot(2,1,1)
plot(SBE1525.t,SBE1525.dens-1000,'linewidth',fig.lwidth);
hold on
plot(SBE4939.t,SBE4939.dens-1000,'--r','linewidth',fig.lwidth);
plot(SBE4940.t,SBE4940.dens-1000,'-.k','linewidth',fig.lwidth);
plot(SBE19.t,SBE19.dens-1000,'c','linewidth',fig.lwidth);
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis fig.ydens]);
set(gca,'YTick',fig.ytickdens);
set(gca,'XTick',fig.xtick);
legend('MC1525 1mbs','MC4939 2.5mbs','MC4940 10mbs','MC19 15 mbs');
legend('Location',fig.legendloc,'Orientation',fig.legendorien);
ylabel('Relative density (kg/m^3)');
title('Density 18 m mooring');

subplot(2,1,2)
plot(SBE1525.t,SBE1525.dens-1000,'linewidth',fig.lwidth);
hold on
plot(SBE4939.t,SBE4939.dens-1000,'--r','linewidth',fig.lwidth);
plot(SBE4940.t,SBE4940.dens-1000,'-.k','linewidth',fig.lwidth);
plot(SBE19.t,corr.dens-1000,'c','linewidth',1.5);
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis fig.ydens]);
set(gca,'YTick',fig.ytickdens);
set(gca,'XTick',fig.xtick);
legend('MC1525 1mbs','MC4939 2.5mbs','MC4940 10mbs','MC19 15mbs');
legend('Location',fig.legendloc,'Orientation',fig.legendorien);
ylabel('Corrected relative density (kg/m^3)');
xlabel('Day of year');

    
end

end