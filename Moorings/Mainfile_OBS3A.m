% Mainscript OBS3A

close all; clear all; clc
dir_out_raw = 'd:\sabinerijnsbur\Matlab\Moorings\Mfiles_raw\';
dir_out     = 'd:\sabinerijnsbur\Matlab\Moorings\Mfiles\';

%% OBS3A750; calculate salinity, time2GMT, day of year, time-av.

load('D:\sabinerijnsbur\Measurements\Measurements2014\Matlab\OBS3A750_raw.mat')
OBS3A750_raw.description = {'Type:OBS3A','SN 750', 'Mooring 18m 1mbs', 'Units: time [datenum], depth [m], temp [degree C], conductivity [mS/cm]'};
save([dir_out_raw,'OBS3A750_raw.mat'],'OBS3A750_raw');
cal_coeff        = 1.1290;
[OBS3A750]       = OBS3A(OBS3A750_raw,cal_coeff); % calculate salinity
[OBS3A750.time]  = time2GMT(OBS3A750.time,2,'positive');
[OBS3A750.t]     = day_of_year(OBS3A750.time);

% load('d:\sabinerijnsbur\Matlab\adcp\adcp18.mat');
load('d:\sabinerijnsbur\Matlab\adcp\reft.mat');
% reft           = adcp18.time;
reft           = reft.t18;
avp            = 600; % averaging period in seconds
[OBS3A750]     = time_averaging_reft(OBS3A750,reft,avp);
[OBS3A750.t10] = day_of_year(OBS3A750.time10); % day of year based on time10
OBS3A750.t10   = OBS3A750.t10';
OBS3A750.notes = {'time converted to GMT','time (datenum)','t (day of year)','*10 10-min average'};

save([dir_out,'OBS3A750.mat'],'OBS3A750');
clear cal_coeff reft avp OBS3A750_raw OBS3A750
%% OBS3A744; calculate salinity, time2GMT, day of year, time-av.

load('D:\sabinerijnsbur\Measurements\Measurements2014\Matlab\OBS3A744_raw.mat')
OBS3A744_raw.description = {'Type:OBS3A','SN 744', 'Mooring 12m 5mbs', 'Units: time [datenum], depth [m], temp [degree C], conductivity [mS/cm]'};
save([dir_out_raw,'OBS3A744_raw.mat'],'OBS3A744_raw');
cal_coeff       = 1.0942;
[OBS3A744]      = OBS3A(OBS3A744_raw,cal_coeff);
[OBS3A744.time] = time2GMT(OBS3A744.time,2,'positive');
[OBS3A744.t]    = day_of_year(OBS3A744.time);

% load('d:\sabinerijnsbur\Matlab\adcp\adcp12.mat');
load('d:\sabinerijnsbur\Matlab\adcp\reft.mat');
% reft           = adcp12.time;
reft           = reft.t12;
avp            = 600; % averaging period in seconds
[OBS3A744]     = time_averaging_reft(OBS3A744,reft,avp);
[OBS3A744.t10] = day_of_year(OBS3A744.time10); % day of year based on time10
OBS3A744.t10   = OBS3A744.t10';
OBS3A744.notes = {'time converted to GMT','time (datenum)','t (day of year)','*10 10-min average'};

save([dir_out,'OBS3A744.mat'],'OBS3A744');
clear cal_coeff reft avp OBS3A744_raw OBS3A744

%% OBS3A743; calculate salinity, time2GMT, day of year, time-av.
load('D:\sabinerijnsbur\Measurements\Measurements2014\Matlab\OBS3A743_raw.mat')
OBS3A743_raw.description = {'Type:OBS3A','SN 743', 'Mooring 12m 1mbs', 'Units: time [datenum], depth [m], temp [degree C], conductivity [mS/cm]'};
save([dir_out_raw,'OBS3A743_raw.mat'],'OBS3A743_raw');
cal_coeff       = 1.1151;
[OBS3A743]      = OBS3A(OBS3A743_raw,cal_coeff);
[OBS3A743.time] = time2GMT(OBS3A743.time,2,'positive');
[OBS3A743.t]    = day_of_year(OBS3A743.time);

% load('d:\sabinerijnsbur\Matlab\adcp\adcp12.mat');
load('d:\sabinerijnsbur\Matlab\adcp\reft.mat');
% reft           = adcp12.time;
reft           = reft.t12;
avp            = 600; % averaging period in seconds
[OBS3A743]     = time_averaging_reft(OBS3A743,reft,avp);
[OBS3A743.t10] = day_of_year(OBS3A743.time10); % day of year based on time10
OBS3A743.t10   = OBS3A743.t10';
OBS3A743.notes = {'time converted to GMT','time (datenum)','t (day of year)','*10 10-min average'};

save([dir_out,'OBS3A743.mat'],'OBS3A743');
clear cal_coeff reft avp OBS3A743_raw OBS3A743

%% OBS3A578; calculate salinity, time2GMT, day of year, time-av.
load('D:\sabinerijnsbur\Measurements\Measurements2014\Matlab\OBS3A578_raw.mat')
OBS3A578_raw.description = {'Type:OBS3A','SN 578', 'Mooring 18m 5mbs', 'Units: time [datenum], depth [m], temp [degree C], conductivity [mS/cm]'};
save([dir_out_raw,'OBS3A578_raw.mat'],'OBS3A578_raw');
cal_coeff       = 1.1271;
[OBS3A578]      = OBS3A(OBS3A578_raw,cal_coeff);
[OBS3A578.time] = time2GMT(OBS3A578.time,2,'positive');
[OBS3A578.t]    = day_of_year(OBS3A578.time);

% load('d:\sabinerijnsbur\Matlab\adcp\adcp18.mat');
load('d:\sabinerijnsbur\Matlab\adcp\reft.mat');
% reft           = adcp18.time;
reft           = reft.t18;
avp            = 600; % averaging period in seconds
[OBS3A578]     = time_averaging_reft(OBS3A578,reft,avp);
[OBS3A578.t10] = day_of_year(OBS3A578.time10); % day of year based on time10
OBS3A578.t10   = OBS3A578.t10';
OBS3A578.notes = {'time converted to GMT','time (datenum)','t (day of year)','*10 10-min average'};

save([dir_out,'OBS3A578.mat'],'OBS3A578');
clear cal_coeff reft avp OBS3A578_raw OBS3A578

 