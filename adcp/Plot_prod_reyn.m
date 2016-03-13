clc;clear all;close all;

load('D:\sabinerijnsbur\Matlab\adcp\adcp18');
load('D:\sabinerijnsbur\Matlab\adcp\cfg18');
load(['d:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\Mooring18_adcp_corr.mat']);

adcp = adcp18;
cfg  = cfg18;

%% plot

figure;
h1 = subplot(6,1,1);
plot(M18.t,M18.D-1000);
xlim([260 282]);
ylabel('rel. rho');
colorbar;

h2 = subplot(6,1,2);
pcolorcorcen(adcp.t,adcp.z,adcp.va);
hold on 
plot(adcp.t,adcp.h,'k');
xlim([260 282]);
clim([-1.5 1.5]);
colorbar;

h3 = subplot(6,1,3);
pcolorcorcen(adcp.t,adcp.z,adcp.vc);
hold on 
plot(adcp.t,adcp.h,'k');
xlim([260 282]);
clim([-0.5 0.5]);
colorbar;

h4 = subplot(6,1,4);
pcolorcorcen(adcp.t,adcp.z,adcp.vw_str);
hold on 
plot(adcp.t,adcp.h,'k');
xlim([260 282]);
colorbar;


h5 = subplot(6,1,5);
pcolorcorcen(adcp.t,adcp.z,adcp.uw_str);
hold on 
plot(adcp.t,adcp.h,'k');
xlim([260 282]);
colorbar;


h6 = subplot(6,1,6);
pcolorcorcen(adcp.t,adcp.z,adcp.prod);
hold on 
plot(adcp.t,adcp.h,'k');
xlim([260 282]);
colorbar;

linkaxes([h1 h2 h3 h4 h5 h6],'x');

%% 12 m

load('D:\sabinerijnsbur\Matlab\adcp\adcp12');
load('D:\sabinerijnsbur\Matlab\adcp\cfg12');
load(['d:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\Mooring12_adcp_corr.mat']);

adcp = adcp12;
cfg  = cfg12;


figure;
h1 = subplot(6,1,1);
plot(M18.t,M18.D-1000);
xlim([260 282]);
ylabel('rel. rho');
colorbar;

h2 = subplot(6,1,2);
pcolorcorcen(adcp.t,adcp.z,adcp.va);
hold on 
plot(adcp.t,adcp.h,'k');
xlim([260 282]);
clim([-1.5 1.5]);
colorbar;

h3 = subplot(6,1,3);
pcolorcorcen(adcp.t,adcp.z,adcp.vc);
hold on 
plot(adcp.t,adcp.h,'k');
xlim([260 282]);
clim([-0.5 0.5]);
colorbar;

h4 = subplot(6,1,4);
pcolorcorcen(adcp.t,adcp.z,adcp.vw_str);
hold on 
plot(adcp.t,adcp.h,'k');
xlim([260 282]);
colorbar;


h5 = subplot(6,1,5);
pcolorcorcen(adcp.t,adcp.z,adcp.uw_str);
hold on 
plot(adcp.t,adcp.h,'k');
xlim([260 282]);
colorbar;


h6 = subplot(6,1,6);
pcolorcorcen(adcp.t,adcp.z,adcp.prod);
hold on 
plot(adcp.t,adcp.h,'k');
xlim([260 282]);
colorbar;

linkaxes([h1 h2 h3 h4 h5 h6],'x');


