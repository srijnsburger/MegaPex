%Plot CTs Ministable

clc;clear all;close all;

load('d:\sabinerijnsbur\Matlab_files\Megapex_data\Mini-stable\CT7216.mat');
load('d:\sabinerijnsbur\Matlab_files\Megapex_data\Mini-stable\CT7217.mat');
load('d:\sabinerijnsbur\Matlab_files\Megapex_data\Mini-stable\CT7218.mat');

%% Input figure

fig.xlim = [259 265];

%% Plot raw data 

figure;
h1 = subplot(2,1,1);
plot(CT7216.time,CT7216.cond);
hold on
plot(CT7217.time,CT7217.cond);
plot(CT7218.time,CT7218.cond);
datetick('x','keepticks');
ylim([20 45]);
legend('c7216 0.75mab','c7217 0.5mab','c7218 0.25mab');
title('Conductivity 12m near bottom');

h2 = subplot(2,1,2);
plot(CT7216.time,CT7216.temp);
hold on
plot(CT7217.time,CT7217.temp);
plot(CT7218.time,CT7218.temp);
datetick('x','keepticks');
ylim([10 25]);
legend('c7216 0.75mab','c7217 0.5mab','c7218 0.25mab');
title('Temperature 12m near bottom');

set(gcf,'color','w');
linkaxes([h1,h2],'x');

%% Plot Temperature, salinity and density - 10min averaged

figure;
h3 = subplot(3,1,1);
plot(CT7216.t15,CT7216.temp15)
hold on
plot(CT7217.t15,CT7217.temp15)
plot(CT7218.t15,CT7218.temp15)
ylim([17 19]);
legend('CT7216 0.75mab','CT7217 0.5mab','CT7218 0.25mab');
title('Temperature burst-av 12m near bottom');

h4 = subplot(3,1,2);
plot(CT7216.t15,CT7216.sal15)
hold on
plot(CT7217.t15,CT7217.sal15)
plot(CT7218.t15,CT7218.sal15)
ylim([22 33]);
title('Salinity burst-av 12m near bottom');

h5 = subplot(3,1,3);
plot(CT7216.t15,CT7216.dens15-1000)
hold on
plot(CT7217.t15,CT7217.dens15-1000)
plot(CT7218.t15,CT7218.dens15-1000)
ylim([15 25]);
title('Relative density burst-av 12m near bottom');

set(gcf,'color','w');
linkaxes([h3,h4,h5],'x');

%% Load ADVs & tidal data

% Load ADVs (raw)
% load('d:\sabinerijnsbur\Matlab\Mini-stable\Despiked ADV (Raul)\adv355');
% load('d:\sabinerijnsbur\Matlab\Mini-stable\Despiked ADV (Raul)\adv358');
% load('d:\sabinerijnsbur\Matlab\Mini-stable\Despiked ADV (Raul)\adv496');

% Load ADVs
load('d:\sabinerijnsbur\Matlab_files\Megapex_data\Mini-stable\adv355');
load('d:\sabinerijnsbur\Matlab_files\Megapex_data\Mini-stable\adv358');
load('d:\sabinerijnsbur\Matlab_files\Megapex_data\Mini-stable\adv496');

% Load tidal elevation data
load('d:\sabinerijnsbur\Matlab_files\Megapex_data\Conditions\tide');

%% Plot Cts with ADVs and tide
figure; 
h6 = subplot(4,1,1);
plot(T1.t,T1.ssh,'b');
hline(0,'k');
ylim([-1 1.5]);
xlim(fig.xlim);
legend('\eta (m)');
title(['Mini stable ADV and CT data']);

h7 = subplot(4,1,2);
plot(CT7216.t15,CT7216.dens15-1000)
hold on
plot(CT7217.t15,CT7217.dens15-1000)
plot(CT7218.t15,CT7218.dens15-1000)
ylim([15 25]);
xlim(fig.xlim);
legend('c7216 0.75mab','c7217 0.5mab','c7218 0.25mab');
title('density');

h8 = subplot(4,1,3);
plot(adv355.ba.t(2:end-1), adv355.ba.va);
hold on
plot(adv358.ba.t(2:end-1), adv358.ba.va);
plot(adv496.ba.t(2:end-1), adv496.ba.va);
hline(0,'k');
ylim([-0.8 0.8]);
xlim(fig.xlim);
legend('adv355 0.75mab','adv358 0.5mab','adv496 0.25mab');
title('alongshore velocity');

h9 = subplot(4,1,4);
plot(adv355.ba.t(2:end-1), adv355.ba.vc);
hold on
plot(adv358.ba.t(2:end-1), adv358.ba.vc);
plot(adv496.ba.t(2:end-1), adv496.ba.vc);
hline(0,'k');
ylim([-0.4 0.4]);
xlim(fig.xlim);
title('cross-shore velocity');
xlabel('Day');

set(gcf,'color','w');
linkaxes([h6,h7,h8,h9],'x');

%% Plot CTs with M12

dirin = 'd:\sabinerijnsbur\Matlab_files\Megapex_data\Moorings\Mfiles_adcp\';
load([dirin,'SBE1526.mat']);
load([dirin,'SBE1527.mat']);
load([dirin,'SBE5425.mat']);
load([dirin,'SBE5426.mat']);
load([dirin,'SBE1842_corrected.mat']);

fig.lwidth = 0.8;

figure;
plot(SBE1527.t10,SBE1527.dens10-1000,'Linewidth',fig.lwidth);
hold on
plot(SBE1526.t10,SBE1526.dens10-1000,'--r','Linewidth',fig.lwidth);
plot(SBE5426.t10,SBE5426.dens10-1000,'-.k','Linewidth',fig.lwidth);
plot(SBE5425.t10,SBE5425.dens10-1000,'c','Linewidth',fig.lwidth);
plot(SBE1842.t10,SBE1842.dens10-1000,'g','Linewidth',fig.lwidth);
plot(CT7216.t15,CT7216.dens15-1000,'Linewidth',fig.lwidth);
plot(CT7217.t15,CT7217.dens15-1000,'Linewidth',fig.lwidth);
plot(CT7218.t15,CT7218.dens15-1000,'Linewidth',fig.lwidth);
legend('1mbs','3mbs','7mbs','8mbs','10.5mbs','0.75mab','0.5mab','0.25mab');
ylim([13 23]);
xlim(fig.xlim);
title('Relative density CTDs M12 and CTs MS'); 




%% Plot Tide, CTs, ADVs and CTDs M12

figure;
h10 = subplot(2,1,1);
plot(T1.t,T1.ssh,'b','linewidth',fig.lwidth);
hline(0,'k');
ylim([-1 1.5]);
xlim(fig.xlim);
legend('\eta (m)');
title(['Mini stable CT data & Mooring 12 data']);

h11 = subplot(2,1,2);
plot(SBE1527.t10,SBE1527.dens10-1000,'linewidth',fig.lwidth);
hold on
plot(SBE1526.t10,SBE1526.dens10-1000,'--r');
plot(SBE5426.t10,SBE5426.dens10-1000,'-.k');
plot(SBE5425.t10,SBE5425.dens10-1000,'c');
plot(SBE1842.t10,SBE1842.dens10-1000,'g');
plot(CT7216.t15,CT7216.dens15-1000);
plot(CT7217.t15,CT7217.dens15-1000);
plot(CT7218.t15,CT7218.dens15-1000);
legend('1mbs','3mbs','7mbs','8mbs','10.5mbs','0.75mab','0.5mab','0.25mab');
ylim([13 23]);
xlim(fig.xlim);
title('Relative density');

linkaxes([h10,h11],'x');

