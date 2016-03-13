load('SBE1842_raw.mat')
load('SBE5425_raw.mat')
load('SBE5426_raw.mat')
load('SBE1526_raw.mat')
load('SBE1527_raw.mat')

SBE1842t = SBE1842_raw;
SBE5425t = SBE5425_raw;
SBE5426t = SBE5425_raw;
SBE1526t = SBE1526_raw;
SBE1527t = SBE1527_raw;

[SBE1842t] = calculate_sal_dens(SBE1842t);
[SBE5425t] = calculate_sal_dens(SBE5425t);
[SBE5426t] = calculate_sal_dens(SBE5426t);
[SBE1526t] = calculate_sal_dens(SBE1526t);
[SBE1527t] = calculate_sal_dens(SBE1527t);

%test plot
%% Input for figure
fig.xlabel   = 'day in year';
fig.lwidth   = 1;
fig.fonts    = 8;
fig.txtfonts = 8;
fig.xaxis    = [259 290];
fig.xtick    = 259:2:290;
%% Figure Mooring 12m

figure;
AX = subplot_meshgrid(1,2,[.09 .04],[.07 .04 .07],[nan],[nan nan]);
axes(AX(1,1))
plot(SBE1527t.t,SBE1527t.temp,'linewidth',fig.lwidth);
hold on
plot(SBE1526t.t,SBE1526t.temp,'--r','linewidth',fig.lwidth);
plot(SBE5426t.t,SBE5426t.temp,'-.k','linewidth',2);
plot(SBE5425t.t,SBE5425t.temp,'c','linewidth',fig.lwidth);
plot(SBE1842t.t,SBE1842t.temp,'g','linewidth',fig.lwidth);
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis 15 21]);
set(gca,'YTick',15:1:21);
set(gca,'XTick',fig.xtick);
ylabel('Temperature (\circ C)');
legend('MC1527 1mbs','MC1526 3mbs','MC5426 7mbs','MC5425 8mbs','MC1842 10.5mbs');
title('12 m mooring');

axes(AX(1,2))
plot(SBE1527t.t,SBE1527t.sal,'linewidth',fig.lwidth);
hold on
plot(SBE1526t.t,SBE1526t.sal,'--r','linewidth',fig.lwidth);
plot(SBE5426t.t,SBE5426t.sal,'-.k','linewidth',2);
plot(SBE5425t.t,SBE5425t.sal,'c','linewidth',fig.lwidth);
plot(SBE1842t.t,SBE1842t.sal,'g','linewidth',fig.lwidth);
set(gca,'Fontsize',fig.fonts);
axis([fig.xaxis 20 35]);
set(gca,'YTick',20:2.5:32.5);
set(gca,'XTick',fig.xtick);
ylabel('Salinity (PSU)');
xlabel(fig.xlabel);

set(AX(:,1),'xticklabel',[])
set(findall(gcf,'type','text'),'FontSize',fig.txtfonts)

