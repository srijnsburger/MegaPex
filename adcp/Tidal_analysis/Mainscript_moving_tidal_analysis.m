% Mainscript tidal analysis
clc;clear all;close all;

% Load data
load('D:\sabinerijnsbur\Matlab\adcp\adcp12C.mat');
load('D:\sabinerijnsbur\Matlab\adcp\adcp18.mat');
load('D:\sabinerijnsbur\Matlab\adcp\adcpMS.mat');

dir_out = 'd:\sabinerijnsbur\Matlab\Figures\Tidal_Analysis\'; % For saving figures

%% Tidal analysis
% using t_tide
tstep   = 1;
lat12   = 52.06883; % M12

% Test 
[T] = moving_tidal_analysis(adcp12C.time,adcp12C.va,adcp12C.vc,tstep,lat12);

% [TC12] = tidal_analysis(adcp12C.time,adcp12C.va,adcp12C.vc,tstep);
% [TC18] = tidal_analysis(adcp18.time,adcp18.va,adcp18.vc,tstep);
% [TCMS] = tidal_analysis(adcpMS.time,adcpMS.va,adcpMS.vc,tstep);

%% Caculate mean values of fitted velocities

TC12.meanva = nanmean(TC12.va);
TC12.meanvc = nanmean(TC12.vc);

TC18.meanva = nanmean(TC18.va);
TC18.meanvc = nanmean(TC18.vc);

TCMS.meanva = nanmean(TCMS.va);
TCMS.meanvc = nanmean(TCMS.vc);

%% Get velocities on locations moorings
%12m

load('d:\sabinerijnsbur\Matlab_files\Megapex_data\Tidalanalysis\TC12.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\Mooring12_adcp_corr.mat');

for i = 1:size(M12.P,1)
    for j = 1:size(M12.P,2)
        %             loc            = adcp12C.h(j)-P12(i,j);
        %             id             = find(loc <= adcp12C.z,1);
        loc            = adcp12C.h(j)-M12.P(i,j);
        id             = find(loc <= adcp12C.z,1);
        
        if i == 2
            id = id - 2; % 3.5 mbs (0.5m deeper than CTD)
        end
        TC12.vaPM(i,j) = TC12.va(id,j);
        TC12.vcPM(i,j) = TC12.vc(id,j);
    end
end

%18m

load('d:\sabinerijnsbur\Matlab_files\Megapex_data\Tidalanalysis\TC18.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\Mooring18_adcp_corr.mat');

    for i = 1:size(M18.P,1)
        for j = 1:size(M18.P,2)
            loc            = adcp18.h(j)-M18.P(i,j);
            id             = find(loc <= adcp18.z,1);
            if i == 2
                id = id - 2; % 3 mbs (0.5m deeper than CTD)
            end
            TC18.vaPM(i,j) = TC18.va(id,j);
            TC18.vcPM(i,j) = TC18.vc(id,j);
        end
    end

%% save

save('TC12','TC12');
save('TC18','TC18');

%% Input figure(s)
fig.fonts = 8;
fig.lwidth= 1;
save_plot ='no';
fig.legendloc = 'NorthEast';
fig.legendorien = 'horizontal';
%% Plot Fitted velocity

fig.ylim  = [0 15];
fig.xlim  = [adcp12C.t(1) adcp12C.t(end)];
fig.txtX  = adcp12C.t(10);
fig.txtY  = adcp12C.z(52);
fig.position = '12m';
plot_fittedvelocities(adcp12C,TC12,fig,save_plot);

fig.ylim  = [0 22];
fig.xlim  = [adcp18.t(1) adcp18.t(end)];
fig.txtX  = adcp18.t(10);
fig.txtY  = adcp18.z(77);
fig.position = '18m';
plot_fittedvelocities(adcp18,TC18,fig,save_plot);

%% Plot ellipse properties

fig.ylim   = [0 14];
fig.xlim  = [adcp12C.t(1) adcp12C.t(end)];
fig.position = '12m';
comp         = 'M2';
plot_ellipse_prop(adcp12C,TC12,fig,comp,save_plot);

fig.ylim = [0 20];
fig.xlim  = [adcp18.t(1) adcp18.t(end)];
fig.position = '18m';
comp         = 'M2';
plot_ellipse_prop(adcp18,TC18,comp,fig,save_plot);

