% Check tidal elevation due to pressure adcp
clc;clear all;close all;

%% 12m

load('d:\sabinerijnsbur\Matlab\adcp\adcp12C.mat');
ssh12 = adcp12C.h - mean(adcp12C.h);

%% 18m

load('d:\sabinerijnsbur\Matlab\adcp\adcp18.mat');
ssh18 = adcp18.h - mean(adcp18.h);

%% Check

load('d:\sabinerijnsbur\Matlab\Megapex\Conditions\tide.mat');

%12m
figure;
h1 = subplot(2,1,1);
plot(T1.t,T1.ssh,'b');
hold on
grid on
plot(adcp12C.t,adcp12C.meanva,'--k');
plot(adcp12C.t,ssh12,'--m');
hline(0,'k');
xlim([adcp12C.t(1) adcp12C.t(end)]);
legend('ssh HvH','mean va','ssh adcp');
legend('Orientation','horizontal');
title('12m');

h2 = subplot(2,1,2);
pcolorcorcen(adcp12C.t,adcp12C.z,adcp12C.va);
hold on
plot(adcp12C.t,adcp12C.h,'k');
xlim([adcp12C.t(1) adcp12C.t(end)]);
colormap(colormapbluewhitered);

linkaxes([h1,h2],'x');
set(gcf,'color','w');

%18m
figure;
h3 = subplot(2,1,1);
plot(T1.t,T1.ssh,'b');
hold on
grid on
plot(adcp18.t,adcp18.meanva,'--k');
plot(adcp18.t,ssh18,'--m');
hline(0,'k');
xlim([adcp18.t(3) adcp18.t(end)]);
legend('ssh HvH','mean va','ssh adcp');
legend('Orientation','horizontal');
title('18m');

h4 = subplot(2,1,2);
pcolorcorcen(adcp18.t,adcp18.z,adcp18.va);
hold on
plot(adcp18.t,adcp18.h,'k');
xlim([adcp18.t(3) adcp18.t(end)]);
colormap(colormapbluewhitered);

linkaxes([h3,h4],'x');
set(gcf,'color','w');


