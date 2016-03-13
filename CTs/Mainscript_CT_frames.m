%% Load CT data frames

%% Input data, CTD 1
file             = 'D:\sabinerijnsbur\Measurements\MegaPEX 2014 deployment\A12 mini-lander ADCP frame instrument data\FSI CTD SN2099\A12_dld3-06-01-15.txt';
name             = 'A12CTD2099';
SN               = 'SN2099';
Location         = 'Frame 12m';
outdir           = 'd:\sabinerijnsbur\Matlab\';
[A12CTD2099_raw] = fsi_ctd(file,SN,Location);
save([outdir,name,'_raw.mat'],[name,'_raw']);

load('d:\sabinerijnsbur\Matlab\adcp\adcp12.mat');
reft = adcp12.time;

%% Processing

[A12CTD2099] = Processing_ctd_fsi(A12CTD2099_raw,SN); %Process

% avp          = diff(reft); avp = avp(1)*24*3600; %averaging period
% [A12CTD2099] = time_averaging_reft(A12CTD2099,reft,avp);% time-averaging based on adcp

save([outdir,name,'.mat'],[name]);

%% Plot

% Input figure
fig.fonts  = 8;
fig.lwidth = 1;
fig.xaxis  = [259 A12CTD2099.t(end)];
fig.turbaxis = [0 80000];
fig.pressaxis = [10 16];
fig.densaxis = [1015 1030];
fig.xlabel = 'day in year';

plot_fsi_ctd(A12CTD2099,'A12CTD2099',fig);
set(gca,'FontSize',8)
set(findall(gcf,'type','text'),'FontSize',8)
set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperSize', [16 16]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperPosition', [0 0 16 16]);
set(gcf,'Renderer','painters');
print(gcf, '-dpdf',['A12CTD2099.pdf']);


% plot_fsi_ctd_dens(A12CTD2099,name,fig);
% set(gca,'FontSize',8)
% set(findall(gcf,'type','text'),'FontSize',8)
% set(gcf, 'PaperUnits', 'centimeters');
% set(gcf, 'PaperSize', [30 22]);
% set(gcf, 'PaperPositionMode', 'manual');
% set(gcf, 'PaperPosition', [0 0 30 22]);
% set(gcf,'Renderer','painters');
% print(gcf, '-dpdf',['A12CTD2099_dens.pdf']);



%% Clear  

clear file name SN Location outdir

%% Input data, CTD 2

file             = 'd:\sabinerijnsbur\Measurements\MegaPEX 2014 deployment\A18 mini-lander ADCP frame instrument data\FSI CTD SN2097\A18-05-01-14-dld2.txt';
name             = 'A18CTD2097';
SN               = 'SN2097';
Location         = 'Frame 18m';
outdir           = 'd:\sabinerijnsbur\Matlab\';
[A18CTD2097_raw] = fsi_ctd(file,SN,Location);
save([outdir,name,'_raw.mat'],[name,'_raw']);

load('d:\sabinerijnsbur\Matlab\adcp\adcp18.mat');
reft = adcp18.time;

%% Processing

[A18CTD2097] = Processing_ctd_fsi(A18CTD2097_raw,SN);

% avp          = diff(reft); avp = avp(1)*24*3600; %averaging period
% [A18CTD2097] = time_averaging_reft(A18CTD2097,reft,avp);% time-averaging based on adcp

save([outdir,name,'.mat'],[name]);

%% Plot

% Input figure
fig.fonts  = 8;
fig.lwidth = 1;
fig.xaxis  = [259 A18CTD2097.t(end)];
fig.turbaxis = [0 500];
fig.pressaxis = [10 30];
fig.xlabel = 'day in year';

plot_fsi_ctd(A18CTD2097,name,fig);
set(gca,'FontSize',8)
set(findall(gcf,'type','text'),'FontSize',8)
set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperSize', [16 16]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperPosition', [0 0 16 16]);
set(gcf,'Renderer','painters');
print(gcf, '-dpdf',['A18CTD2097.pdf']);

% plot_fsi_ctd_dens(A18CTD2097,name,fig);
% set(gca,'FontSize',8)
% set(findall(gcf,'type','text'),'FontSize',8)
% set(gcf, 'PaperUnits', 'centimeters');
% set(gcf, 'PaperSize', [16 16]);
% set(gcf, 'PaperPositionMode', 'manual');
% set(gcf, 'PaperPosition', [0 0 16 16]);
% set(gcf,'Renderer','painters');
% print(gcf, '-dpdf',['A18CTD2097_dens.pdf']);

% clear all