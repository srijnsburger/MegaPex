
figure;
subplot(2,1,1)
plot(A12_CTD2099.time-datenum(2014,09,15),A12_CTD2099.sal,'linewidth',1.5)
hold on
plot(SBE1842_v1.time-datenum(2014,09,15),SBE1842_v1.sal,'linewidth',1.5,'Color','r')

subplot(2,1,2)
plot(A12_CTD2099.time-datenum(2014,09,15),A12_CTD2099.press,'linewidth',1.5)
hold on
plot(SBE1842_v1.time-datenum(2014,09,15),SBE1842_v1.press,'linewidth',1.5,'Color','r')

% CTD2099 is in GMT
% SBE1842 is in local time (= GMT+2)

SBE1842_v1.timeGMT = SBE1842_v1.time - 2*(1/24);% local time Dutch coastal zone was GMT+2
SBE1527_v1.timeGMT = SBE1527_v1.time - 2*(1/24);% local time Dutch coastal zone was GMT+2
SBE1526_v1.timeGMT = SBE1526_v1.time - 2*(1/24);% local time Dutch coastal zone was GMT+2
SBE5426_v1.timeGMT = SBE5426_v1.time - 2*(1/24);% local time Dutch coastal zone was GMT+2
SBE5425.timeGMT    = SBE5425.time - 2*(1/24);% local time Dutch coastal zone was GMT+2

figure;
subplot(2,1,1)
plot(A12_CTD2099.time-datenum(2014,09,15),A12_CTD2099.sal,'linewidth',2)
hold on
plot(SBE1842_v1.timeGMT-datenum(2014,09,15),SBE1842_v1.sal,'linewidth',1.5,'Color','r','Linestyle','--')
legend('A12 CTD2099','M12 SBE1842')

subplot(2,1,2)
plot(A12_CTD2099.time-datenum(2014,09,15),A12_CTD2099.press,'linewidth',2)
hold on
plot(SBE1842_v1.timeGMT-datenum(2014,09,15),SBE1842_v1.press,'linewidth',1.5,'Color','r','Linestyle','--')

%%

figure;
subplot(2,1,1)
plot(SBE1527_v1.timeGMT-datenum(2014,09,15),SBE1527_v1.sal,'linewidth',1.5);
hold on
plot(SBE1526_v1.timeGMT-datenum(2014,09,15),SBE1526_v1.sal,'--r','linewidth',1.5);
plot(SBE5426_v1.timeGMT-datenum(2014,09,15),SBE5426_v1.sal,'-.k','linewidth',1.5);
plot(SBE5425.timeGMT(1:99746)-datenum(2014,09,15),SBE5425.sal(1:99746),'c','linewidth',1.5);
plot(SBE1842_v1.timeGMT-datenum(2014,09,15),SBE1842_v1.sal,'g','linewidth',1.5);
plot(A12_CTD2099.time-datenum(2014,09,15),A12_CTD2099.sal,'m','linewidth',1.5);
% set(gca,'Xtick',SBE1527_v1.time(SBE1527_v1.start):5:SBE1527_v1.time(SBE1527_v1.stop));
% datetick('x','dd/mm/yy','keepticks');
set(gca,'Fontsize',14);
% set(gca,'YTick',[20 22.5 25 27.5 30 32.5]);
% axis([SBE1527_v1.time(SBE1527_v1.start) SBE1527_v1.time(SBE1527_v1.stop) 20 32.5]);
ylabel('Salinity (PSU)');
title('12 m mooring vs A12 CTD2099');

subplot(2,1,2)
plot(SBE1527_v1.timeGMT-datenum(2014,09,15),SBE1527_v1.press,'linewidth',1.5);
hold on
plot(SBE1526_v1.timeGMT-datenum(2014,09,15),SBE1526_v1.press,'--r','linewidth',1.5);
plot(SBE5426_v1.timeGMT-datenum(2014,09,15),SBE5426_v1.press,'-.k','linewidth',1.5);
plot(SBE5425.timeGMT(1:99746)-datenum(2014,09,15),SBE5425.press(1:99746),'c','linewidth',1.5);
plot(SBE1842_v1.timeGMT-datenum(2014,09,15),SBE1842_v1.press,'g','linewidth',1.5);
plot(A12_CTD2099.time-datenum(2014,09,15),A12_CTD2099.press,'m','linewidth',1.5);
% set(gca,'Xtick',SBE1527_v1.time(SBE1527_v1.start):5:SBE1527_v1.time(SBE1527_v1.stop));
% datetick('x','dd/mm/yy','keepticks');
set(gca,'Fontsize',14);
% set(gca,'YTick',[10 12.5 15 17.5 20 22.5]);
% axis([SBE1527_v1.time(SBE1527_v1.start) SBE1527_v1.time(SBE1527_v1.stop) 10 22.5]);
legend('MC1527 1mbs','MC1526 3mbs','MC5426 7mbs','MC5425 ?mbs','MC1842 10.5mbs','CTD2099 12mbs');
ylabel('Pressure (dbar)');
xlabel('Days (Start 15/09/14');


