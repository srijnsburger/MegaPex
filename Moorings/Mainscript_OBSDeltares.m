%% Mainscript OBS Deltares

clc; clear all; close all;

load('d:\sabinerijnsbur\Measurements\Measurements2014\Matlab\OBSD_raw');
location = {'Mooring 12m 10.98mbs','Mooring 12m 7.13mbs','Mooring 12m 8.37mbs'};
dir_out  = 'd:\sabinerijnsbur\Matlab\Moorings\';

%% Convert time
[OBSD_raw.time]     = time2GMT(OBSD_raw.time,2,'positive');
[OBSD_raw.t]        = day_of_year(OBSD_raw.time);

%% Split the matfile, calibrate obs
[OBSD1] = split_matfile_obsD(OBSD_raw,1,1.0290,location);
[OBSD2] = split_matfile_obsD(OBSD_raw,2,0.9074,location);
[OBSD3] = split_matfile_obsD(OBSD_raw,3,0.9249,location);

%% Time-averaging
load('d:\sabinerijnsbur\Matlab\adcp\adcp12.mat');
reft           = adcp12.time;
avp            = 600; % averaging period in seconds

% OBS nmr 1
[OBSD1]     = time_averaging_reft(OBSD1,reft,avp);
[OBSD1.t10] = day_of_year(OBSD1.time10); % day of year based on time10
OBSD1.t10   = OBSD1.t10';
OBSD1.notes = {'time converted to GMT','time (datenum)','t (day of year)','*10 10-min average'};
save([dir_out,'OBSD1.mat'],'OBSD1');

% OBS nmr 2
[OBSD2]     = time_averaging_reft(OBSD2,reft,avp);
[OBSD2.t10] = day_of_year(OBSD2.time10); % day of year based on time10
OBSD2.t10   = OBSD2.t10';
OBSD2.notes = {'time converted to GMT','time (datenum)','t (day of year)','*10 10-min average'};
save([dir_out,'OBSD2.mat'],'OBSD2');

% OBS nmr 3
[OBSD3]     = time_averaging_reft(OBSD3,reft,avp);
[OBSD3.t10] = day_of_year(OBSD3.time10); % day of year based on time10
OBSD3.t10   = OBSD3.t10';
OBSD3.notes = {'time converted to GMT','time (datenum)','t (day of year)','*10 10-min average'};
save([dir_out,'OBSD3.mat'],'OBSD3');


