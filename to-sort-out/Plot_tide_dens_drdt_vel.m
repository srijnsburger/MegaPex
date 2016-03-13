% Plot 

%% Load data
load('d:\sabinerijnsbur\Matlab\Megapex\Conditions\tide.mat');

% 12m mooring
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\SBE1527.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\SBE1526.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\OBS3A744.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\SBE5425.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\SBE5426.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\SBE1842_corrected.mat');

% 18m mooring
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\SBE1525.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\SBE4939.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\OBS3A744.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\SBE4940.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\SBE19_corrected.mat');

% ADCPs
load('d:\sabinerijnsbur\Matlab\adcp\adcp12.mat');
load('d:\sabinerijnsbur\Matlab\adcp\adcp18.mat');

% ADV 0.75 mab
load('d:\sabinerijnsbur\Matlab\Mini-stable\adv355.mat');

% Frontal metrics
load('d:\sabinerijnsbur\Matlab\Moorings\Metrics_Fronts.mat');

%% Input figure

fig.xlim = [259 289];
fig.lwidth = 0.8;

%% Plot 12m

t12 = day_of_year(F12.time);
[vel12] = surface_bottom_velocity(adcp12.va,adcp12.vc);

figure;
h1 = subplot(5,1,1);
plot(T1.t(T1.neap1),T1.ssh(T1.neap1),'r');
hold on
plot(T1.t(T1.spr1),T1.ssh(T1.spr1),'b');
plot(T1.t(T1.neap2),T1.ssh(T1.neap2),'r');
plot(T1.t(T1.spr2),T1.ssh(T1.spr2),'b');
plot(T1.t(T1.neap3),T1.ssh(T1.neap3),'r');
plot(T1.t(T1.spr3),T1.ssh(T1.spr3),'b');
plot(T1.t(T1.neap4),T1.ssh(T1.neap4),'r');
plot(adcp12.t,adcp12.meanva,'--k');
hline(0,'k');
vline(t12,':k');
ylim([-1 1.5]);
xlim(fig.xlim);
% legend('\eta (m)','depth mean va (m/s)');
legend('Orientation','horizontal','Location','SouthEast');
title('12m');

h2 = subplot(5,1,2);
plot(SBE1527.t10,SBE1527.dens10-1000,'linewidth',fig.lwidth);
hold on
grid on
plot(SBE1526.t10,SBE1526.dens10-1000,'--r','linewidth',fig.lwidth);
plot(SBE5426.t10,SBE5426.dens10-1000,'-.k','linewidth',fig.lwidth);
plot(SBE5425.t10,SBE5425.dens10-1000,'c','linewidth',fig.lwidth);
plot(SBE1842.t10,SBE1842.dens10-1000,'g','linewidth',fig.lwidth);
vline(t12,':k');
xlim(fig.xlim);
ylim([11 24]);
legend('1mbs','3mbs','7mbs','8mbs','10.5mbs');
legend('Orientation','horizontal','Location','SouthEast');

h3 = subplot(5,1,3);
plot(SBE1527.t10,F12.drdt,'linewidth',fig.lwidth);
hline(0,'k');
vline(t12,':k');
xlim(fig.xlim);
% ylim([-0.3 0.2]);
ylabel('d\rho /dt (kg/m^3)');

h4 = subplot(5,1,4);
plot(adcp12.t,vel12.sva);
hold on 
plot(adcp12.t,vel12.svc);
hline(0,'k');
vline(t12,':k');
xlim(fig.xlim);
ylim([-1 1.5]);
ylabel('(m/s)');
legend('va','vc');
legend('Orientation','horizontal','Location','SouthEast');
title('Surface velocity');

h5 = subplot(5,1,5);
plot(adv355.ba.t(2:end-1),adv355.ba.va);
hold on 
plot(adv355.ba.t(2:end-1),adv355.ba.vc);
hline(0,'k');
vline(t12,':k');
xlim(fig.xlim);
ylim([-0.5 0.7]);
ylabel('(m/s)');
legend('va','vc');
legend('Orientation','horizontal','Location','SouthEast');
title('Bottom velocity');

set(gcf,'color','w');
linkaxes([h1,h2,h3,h4,h5],'x');

%% 18 m

t18 = day_of_year(F18.time);
[vel18] = surface_bottom_velocity(adcp18.va,adcp18.vc);

figure;
h6 = subplot(5,1,1);
plot(T1.t(T1.neap1),T1.ssh(T1.neap1),'r');
hold on
plot(T1.t(T1.spr1),T1.ssh(T1.spr1),'b');
plot(T1.t(T1.neap2),T1.ssh(T1.neap2),'r');
plot(T1.t(T1.spr2),T1.ssh(T1.spr2),'b');
plot(T1.t(T1.neap3),T1.ssh(T1.neap3),'r');
plot(T1.t(T1.spr3),T1.ssh(T1.spr3),'b');
plot(T1.t(T1.neap4),T1.ssh(T1.neap4),'r');
plot(adcp18.t,adcp18.meanva,'--k');
hline(0,'k');
vline(t18,':k');
ylim([-1 1.5]);
xlim(fig.xlim);
legend('\eta (m)','depth mean va (m/s)');
legend('Orientation','horizontal','Location','SouthEast');
title('18m');

h7 = subplot(5,1,2);
plot(SBE1525.t10,SBE1525.dens10-1000,'linewidth',fig.lwidth);
hold on
grid on
plot(SBE4939.t10,SBE4939.dens10-1000,'--r','linewidth',fig.lwidth);
plot(SBE4940.t10,SBE4940.dens10-1000,'-.k','linewidth',fig.lwidth);
plot(SBE19.t10,SBE19.dens10-1000,'c','linewidth',fig.lwidth);
xlim(fig.xlim);
vline(t18,':k');
ylim([11 24]);
legend('1mbs','2.5mbs','10mbs','15mbs');
legend('Orientation','horizontal','Location','SouthEast');

h8 = subplot(5,1,3);
plot(SBE1525.t10,F18.drdt,'linewidth',fig.lwidth);
hline(0,'k');
vline(t18,':k');
xlim(fig.xlim);
% ylim([-0.3 0.2]);
ylabel('d\rho /dt (kg/m^3)');

h9 = subplot(5,1,4);
plot(adcp18.t,vel18.sva);
hold on 
plot(adcp18.t,vel18.svc);
hline(0,'k');
vline(t18,':k');
xlim(fig.xlim);
ylim([-1 1.5]);
ylabel('v (m/s)');
legend('va','vc');
legend('Orientation','horizontal','Location','SouthEast');
title('Surface velocity');

h10 = subplot(5,1,5);
plot(adcp18.t,vel18.bva);
hold on 
plot(adcp18.t,vel18.bvc);
hline(0,'k');
vline(t18,':k');
xlim(fig.xlim);
ylim([-0.5 0.7]);
ylabel('v (m/s)');
legend('va','vc');
legend('Orientation','horizontal','Location','SouthEast');
title('Bottom velocity');

set(gcf,'color','w');
linkaxes([h6,h7,h8,h9,h10],'x');

