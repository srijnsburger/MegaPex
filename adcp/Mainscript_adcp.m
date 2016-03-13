%% Mainscript ADCP

clc,clear all,close all

% select if you want to save figure or not
save_plot = 'no';
dir_out = 'd:\sabinerijnsbur\Matlab\Figures\ADCP_frames\';

%% Load data

load('D:\sabinerijnsbur\Matlab\adcp\adcp12_v0');
load('D:\sabinerijnsbur\Matlab\adcp\cfg12');

load('D:\sabinerijnsbur\Matlab\adcp\adcp18_v0');
load('D:\sabinerijnsbur\Matlab\adcp\cfg18');

load('D:\sabinerijnsbur\Matlab\adcp\adcpMS_v0');
load('D:\sabinerijnsbur\Matlab\adcp\cfgMS');

%% Delete values above surface

[adcp12] = adcpdepthclean(adcp12_v0,cfg12); % uses depth/pressure to delete artificial values; sets depth to 0.9*depth
[adcp18] = adcpdepthclean(adcp18_v0,cfg18);

[Sv]     = backs(adcpMS_v0,cfgMS);
[adcpMS] = adcpsoundlevelclean(adcpMS_v0,cfgMS,Sv);
[adcpMS] = remove_peaks(adcpMS);

%% Determine range of adcp

adcp12.ranges = cfg12.ranges;
adcp18.ranges = cfg18.ranges;
adcpMS.ranges = cfgMS.ranges;

clear adcp12_v0 adcp18_v0 cfg12 cfg18 adcpMS_v0 cfgMS

%% Correct for instrument position above bed (from MegaPEX2014 recovery fieldwork report v1-1, by R. Cook, April 2015)

% Distance instrument above bed
adcp12.bedheight = 0.78; % 78cm  = 0.78 m
adcp18.bedheight = 0.80; % 80cm  = 0.80 m
adcpMS.bedheight = 1.79; % 179cm = 1.79 m

[adcp12.h,adcp12.z] = distance_above_bed(adcp12.ranges,adcp12.bedheight,adcp12.depth);
[adcp18.h,adcp18.z] = distance_above_bed(adcp18.ranges,adcp18.bedheight,adcp18.depth);
[adcpMS.h,adcpMS.z] = distance_above_bed(adcpMS.ranges,adcpMS.bedheight,adcpMS.depth);

%% Convert time

% Now reference year is 2000, convert to normal datenum
diff        = datenum(2014,09,16)-datenum(0014,09,16);
adcp12.time = adcp12.mtime + diff; % adcp12
adcp18.time = adcp18.mtime + diff; % adcp18
adcpMS.time = adcpMS.mtime + diff; % adcpMS

% Calculate day of year
[adcp12.t]  = day_of_year(adcp12.time);
[adcp18.t]  = day_of_year(adcp18.time);
[adcpMS.t]  = day_of_year(adcpMS.time);

%% Calculate along- and cross-shore velocities

alpha = 48; % angle from horizontal x-axis; 42 degrees from north
[adcp12.va,adcp12.vc] = convert_vel_raul(adcp12.east_vel,adcp12.north_vel,alpha); % north is +ve; offshore is +ve
[adcp18.va,adcp18.vc] = convert_vel_raul(adcp18.east_vel,adcp18.north_vel,alpha);
[adcpMS.va,adcpMS.vc] = convert_vel_raul(adcpMS.east_vel,adcpMS.north_vel,alpha);

%% Remove empty fields before instruments in water

[adcp12] = rem_records(adcp12);
[adcp18] = rem_records(adcp18);
[adcpMS] = rem_records(adcpMS);

%% Calculate depth mean velocities

adcp12.meanva = nanmean(adcp12.va);
adcp12.meanvc = nanmean(adcp12.vc);

adcp18.meanva = nanmean(adcp18.va);
adcp18.meanvc = nanmean(adcp18.vc);

adcpMS.meanva = nanmean(adcpMS.va);
adcpMS.meanvc = nanmean(adcpMS.vc);

%% Insert some notes

adcp12.notes = {'ranges = distance from instrument','z = distance from seabed','depth = distance sea-surface from instrument', 'h = distance sea-surface from bed','bedheight = height instrument above bed'};

%% Save

save(['D:\sabinerijnsbur\Matlab\adcp\adcp12.mat'],'adcp12');
save(['D:\sabinerijnsbur\Matlab\adcp\adcp18.mat'],'adcp18');
save(['D:\sabinerijnsbur\Matlab\adcp\adcpMS.mat'],'adcpMS');

%% Plot 

% plot_adcp_nsew(adcp12);% plots north-south and east-west velocities; production and reynolds_stresses
% plot_adcp_nsew(adcp18);% plots north-south and east-west velocities; production and reynolds_stresses
% plot_adcp_nsew(adcpMS);% plots north-south and east-west velocities; production and reynolds_stresses

% Input for figure
fig.fonts       = 8;
fig.txtfonts    = 8;
fig.clim_va     = [-1.4 1.4];
fig.ytick_va    = -1.4:0.2:1.4;
fig.clim_vc     = [-0.5 0.5];
fig.ytick_vc    = -0.5:0.1:0.5;
fig.xlabel      = 'day in year';

fig.position    = '12m';
fig.xtick       = 259:2:floor(adcp12.t(end));
fig.ylim        = [0 14];
plot_adcp_vel(adcp12,fig);% plots along- and cross-shore velocities
if strcmp(save_plot,'yes')
%     set(gcf, 'PaperUnits', 'centimeters');
%     set(gcf, 'PaperSize', [16 16]);
%     set(gcf, 'PaperPositionMode', 'manual');
%     set(gcf, 'PaperPosition', [0 0 16 16]);
%     set(gcf,'Renderer','opengl');
%     print(gcf, '-dpng','-r2000',['adcp12.png']);
    set(gcf,'Color',[1 1 1]);
    set(gcf,'Position',get(0,'ScreenSize'));
    export_fig([dir_out 'adcp12_frombin6.png'],'-png')
end

fig.position    = '18m';
fig.xtick       = 259:1:floor(adcp18.t(end));
fig.ylim        = [0 20];
plot_adcp_vel(adcp18,fig);% plots along- and cross-shore velocities
if strcmp(save_plot,'yes')
    %     set(gcf, 'PaperUnits', 'centimeters');
    %     set(gcf, 'PaperSize', [16 16]);
    %     set(gcf, 'PaperPositionMode', 'manual');
    %     set(gcf, 'PaperPosition', [0 0 16 16]);
    %     set(gcf,'Renderer','opengl');
    %     print(gcf, '-dpng','-r2000',['adcp18.png']);
    set(gcf,'Color',[1 1 1]);
    set(gcf,'Position',get(0,'ScreenSize'));
    export_fig([dir_out 'adcp18.png'],'-png')
end

fig.position    = '12m Mini Stable';
fig.xtick       = 259:1:floor(adcpMS.t(end));
fig.ylim        = [0 14];
plot_adcp_vel(adcpMS,fig);% plots along- and cross-shore velocities
if strcmp(save_plot,'yes')
    %     set(gcf, 'PaperUnits', 'centimeters');
    %     set(gcf, 'PaperSize', [16 16]);
    %     set(gcf, 'PaperPositionMode', 'manual');
    %     set(gcf, 'PaperPosition', [0 0 16 16]);
    %     set(gcf,'Renderer','painters');
    %     print(gcf, '-dpng','-r2000',['adcpMS.png']);
    set(gcf,'Color',[1 1 1]);
    set(gcf,'Position',get(0,'ScreenSize'));
    export_fig([dir_out 'adcpMS.png'],'-png')
end
