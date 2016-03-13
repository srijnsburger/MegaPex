clc;clear all;close all;

dir     = 'd:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\';
load([dir,'Mooring12_adcp_corr.mat']);
load([dir,'Mooring18_adcp_corr.mat']);

%% Calculate relative displacement dx - 12m
tt = t12*24*60*60; % in sec

[dx12_s] = f_trapz(tt,vc12(1,:)); % displacement surface

vcc     = vc12(1,:)-vc12(4,:); % surface - bottom
[dx12]  = f_trapz(tt,vcc); % relative displacement between -1 and -8m

for i = 1:length(t12)-1
    tg12(i) = (t12(i)+t12(i+1))/2;
end

%% Calculate relative displacement dx - 18m
t = t18*24*60*60; % in sec

[dx18_s] = f_trapz(t,vc18(2,:)); % displacement surface

vc     = vc18(2,:)-vc18(4,:); % surface - bottom
[dx18] = f_trapz(t,vc); % relative displacement between -2.5 and -15mm

for i = 1:length(t18)-1
    tg18(i) = (t18(i)+t18(i+1))/2;
end

%% Period

[pd12] = determine_spring_neap(t12);
[pd18] = determine_spring_neap(t18);

%% Plot all data 12m
figure;
h1 = subplot(5,1,1);
plot(t12(pd12.p1),ssh12(pd12.p1),'r');
hold on
plot(t12(pd12.p2),ssh12(pd12.p2),'b');
plot(t12(pd12.p3),ssh12(pd12.p3),'r');
plot(t12(pd12.p4),ssh12(pd12.p4),'b');
plot(t12(pd12.p5),ssh12(pd12.p5),'r');
hline(0,'k');
title('12m');
xlim([260 289]);

h2 = subplot(5,1,2);
plot(t12,va12(1,:));
hold on
plot(t12,va12(4,:));
hline(0,'k');
legend('1mbs','8mbs');
legend('Orientation','horizontal');
xlim([260 289]);

h3 = subplot(5,1,3);
plot(t12,vc12(1,:));
hold on
plot(t12,vc12(4,:));
hline(0,'k');
legend('1mbs','8mbs');
legend('Orientation','horizontal');
xlim([260 289]);

h4 = subplot(5,1,4);
plot(tg12,dx12);
hline(0,'k');
xlim([260 289]);

h5 = subplot(5,1,5);
plot(t12,(D12(5,:)-D12(1,:)));
xlim([260 289]);

linkaxes([h1,h2,h3,h4,h5],'x');

%% Plot all data 18m

figure;
x1 = subplot(5,1,1);
plot(t18(pd18.p1),ssh18(pd18.p1),'r');
hold on
plot(t18(pd18.p2),ssh18(pd18.p2),'b');
plot(t18(pd18.p3),ssh18(pd18.p3),'r');
plot(t18(pd18.p4),ssh18(pd18.p4),'b');
hline(0,'k');
title('18m');
xlim([260 280]);

x2 = subplot(5,1,2);
plot(t18,va18(2,:));
hold on
plot(t18,va18(4,:));
hline(0,'k');
legend('2.5mbs','15mbs');
legend('Orientation','horizontal');
xlim([260 280]);

x3 = subplot(5,1,3);
plot(t18,vc18(2,:));
hold on
plot(t18,vc18(4,:));
hline(0,'k');
legend('2.5mbs','15mbs');
legend('Orientation','horizontal');
xlim([260 280]);

x4 = subplot(5,1,4);
plot(tg18,dx18);
hline(0,'k');
xlim([260 280]);
xlim([260 280]);

x5 = subplot(5,1,5);
plot(t18,(D18(4,:)-D18(1,:)));
xlim([260 280]);

linkaxes([x1,x2,x3,x4,x5],'x');

%% Tidal velocity (due to tidal analysis)

load('D:\sabinerijnsbur\Matlab\adcp\Tidal_analysis\TC12');
load('D:\sabinerijnsbur\Matlab\adcp\Tidal_analysis\TC18');

% 12m
figure;
hh1 = subplot(5,1,1);
plot(t12(pd12.p1),ssh12(pd12.p1),'r');
hold on
plot(t12(pd12.p2),ssh12(pd12.p2),'b');
plot(t12(pd12.p3),ssh12(pd12.p3),'r');
plot(t12(pd12.p4),ssh12(pd12.p4),'b');
plot(t12(pd12.p5),ssh12(pd12.p5),'r');
hline(0,'k');
title('12m - filtered tidal velocity (harm. analysis)');
xlim([260 289]);

hh2 = subplot(5,1,2);
plot(TC12.t,TC12.vaPM(2,:));
hold on
plot(TC12.t,TC12.vaPM(4,:));
hline(0,'k');
legend('3mbs','8mbs');
legend('Orientation','horizontal');
xlim([260 289]);

hh3 = subplot(5,1,3);
plot(TC12.t,TC12.vcPM(2,:));
hold on
plot(TC12.t,TC12.vcPM(4,:));
hline(0,'k');
legend('3mbs','8mbs');
legend('Orientation','horizontal');
xlim([260 289]);

hh4 = subplot(5,1,4);
plot(TC12.tdx,TC12.dx);
hline(0,'k');
xlim([260 289]);

hh5 = subplot(5,1,5);
plot(t12,(D12(5,:)-D12(1,:)));
xlim([260 289]);

linkaxes([hh1,hh2,hh3,hh4,hh5],'x');

%18m

figure;
xx1 = subplot(5,1,1);
plot(t18(pd18.p1),ssh18(pd18.p1),'r');
hold on
plot(t18(pd18.p2),ssh18(pd18.p2),'b');
plot(t18(pd18.p3),ssh18(pd18.p3),'r');
plot(t18(pd18.p4),ssh18(pd18.p4),'b');
hline(0,'k');
title('18m');
xlim([260 280]);

xx2 = subplot(5,1,2);
plot(TC18.t,TC18.vaPM(2,:));
hold on
plot(TC18.t,TC18.vaPM(4,:));
hline(0,'k');
legend('2.5mbs','15mbs');
legend('Orientation','horizontal');
xlim([260 280]);

xx3 = subplot(5,1,3);
plot(TC18.t,TC18.vcPM(2,:));
hold on
plot(TC18.t,TC18.vcPM(4,:));
hline(0,'k');
legend('2.5mbs','15mbs');
legend('Orientation','horizontal');
xlim([260 280]);

xx4 = subplot(5,1,4);
plot(TC18.tdx,TC18.dx);
hline(0,'k');
xlim([260 280]);
xlim([260 280]);

xx5 = subplot(5,1,5);
plot(t18,(D18(4,:)-D18(1,:)));
xlim([260 280]);

linkaxes([xx1,xx2,xx3,xx4,xx5],'x');