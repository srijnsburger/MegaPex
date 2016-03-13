% PLOT SALINITY DIFFERENCE AND REL. DISPLACEMENT

% Load data
dir  = 'd:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\';
load([dir,'Mooring18_adcp_corr.mat']);
load([dir,'Mooring12_adcp_corr.mat']);

load('d:\sabinerijnsbur\Matlab_files\Megapex_data\adcp\adcp12C');
load('d:\sabinerijnsbur\Matlab_files\Megapex_data\adcp\adcp18');

load('d:\sabinerijnsbur\Matlab_files\Megapex_data\Moorings\Parameters12');
load('d:\sabinerijnsbur\Matlab_files\Megapex_data\Moorings\Parameters18');

load('d:\sabinerijnsbur\Matlab_files\Megapex_data\Tidalanalysis\TC12.mat');
load('d:\sabinerijnsbur\Matlab_files\Megapex_data\Tidalanalysis\TC18.mat');
%% 

dD12 = M12.D(5,:)-M12.D(1,:);
dD18 = M18.D(4,:)-M18.D(1,:);

%% Input figure

fig.xlim = [260 290];

%% Plot

%12m
figure;
h1 = subplot(4,1,1);
plot(M12.t,M12.ssh);
grid on
hline(0,'k');
xlim(fig.xlim);

h2 = subplot(4,1,2);
plot(adcp12C.t,adcp12C.meanva);
hold on
grid on
hline(0,'k');
xlim(fig.xlim);

h3 = subplot(4,1,3);
plot(P12.tt,P12.dx);
grid on
hold on
plot(TC12.tdx,TC12.dx);
plot(P12.tt,P12.tdx);
hline(0,'k');
xlim(fig.xlim);

h4 = subplot(4,1,4);
plot(M12.t,dD12);
grid on
xlim(fig.xlim);

linkaxes([h1 h2 h3 h4],'x');

%18m
figure;
h1 = subplot(4,1,1);
plot(M18.t,M18.ssh);
grid on
hline(0,'k');
xlim(fig.xlim);

h2 = subplot(4,1,2);
plot(adcp18.t,adcp18.meanva);
grid on
hline(0,'k');
xlim(fig.xlim);

h3 = subplot(4,1,3);
plot(P18.tt,P18.dx);
grid on
hold on
plot(TC18.tdx,TC18.dx);
plot(P18.tt,P18.tdx);
hline(0,'k');
xlim(fig.xlim);

h4 = subplot(4,1,4);
plot(M18.t,dD18);
grid on
xlim(fig.xlim);

linkaxes([h1 h2 h3 h4],'x');