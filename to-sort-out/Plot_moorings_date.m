function Plot_moorings_date(fig,mooring)

dirin = 'd:\sabinerijnsbur\Matlab\Moorings\Mfiles\';

if strcmp(mooring,'12m');
    load([dirin,'SBE1526.mat']);
    load([dirin,'SBE1527.mat']);
    load([dirin,'SBE5425.mat']);
    load([dirin,'SBE5426.mat']);
    load([dirin,'SBE1842_corrected.mat']);
    fig.xaxis    = [SBE1842.time(fig.id1) SBE1842.time(fig.id11)];
    fig.xtick    = SBE1842.time(fig.id1):fig.tstep:SBE1842.time(fig.id11);
elseif strcmp(mooring,'18m')
    load([dirin,'SBE1525.mat']);
    load([dirin,'SBE4939.mat']);
    load([dirin,'SBE4940.mat']);
    load([dirin,'SBE19_corrected.mat']);
    fig.xaxis    = [SBE19.time(fig.id1) SBE19.time(fig.id11)];
    fig.xtick    = SBE19.time(fig.id1):fig.tstep:SBE19.time(fig.id11);
else
end

%% Input for figure
fig.xlabel   = 'Date (dd/mm)';
fig.lwidth   = 1;
fig.fonts    = 8;
fig.txtfonts = 8;

%% Figure Mooring 12m

if strcmp(mooring,'12m')
    figure;
    plot(SBE1527.time,SBE1527.sal,'linewidth',fig.lwidth);
    hold on
    plot(SBE1526.time,SBE1526.sal,'--r','linewidth',fig.lwidth);
    plot(SBE5426.time,SBE5426.sal,'-.k','linewidth',fig.lwidth);
    plot(SBE5425.time,SBE5425.sal,'c','linewidth',fig.lwidth);
    plot(SBE1842.time,SBE1842.sal,'g','linewidth',fig.lwidth);
    set(gca,'Fontsize',fig.fonts);
    axis([fig.xaxis 20 35]);
    set(gca,'XTick',fig.xtick);
    datetick('x','dd/mm','keepticks')
    set(gca,'YTick',20:2.5:32.5);
    ylabel('Salinity (PSU)');
    xlabel(fig.xlabel);
    legend('MC1527 1mbs','MC1526 3mbs','MC5426 7mbs','MC5425 8mbs','MC1842 10.5mbs');
    set(findall(gcf,'type','text'),'FontSize',fig.txtfonts);
elseif strcmp(mooring,'18m')
    figure;
    plot(SBE1525.time,SBE1525.sal,'linewidth',fig.lwidth);
    hold on
    plot(SBE4939.time,SBE4939.sal,'--r','linewidth',fig.lwidth);
    plot(SBE4940.time,SBE4940.sal,'-.k','linewidth',fig.lwidth);
    plot(SBE19.time,SBE19.sal,'c','linewidth',fig.lwidth);
    set(gca,'Fontsize',fig.fonts);
    axis([fig.xaxis 20 35]);
    set(gca,'XTick',fig.xtick);
    datetick('x','dd/mm','keepticks')
    set(gca,'YTick',20:2.5:32.5);
    ylabel('Salinity (PSU)');
    xlabel(fig.xlabel);
    legend('MC1525 1mbs','MC4939 2.5mbs','MC4940 10mbs','MC19 15 mbs');
    set(findall(gcf,'type','text'),'FontSize',fig.txtfonts);
end

end