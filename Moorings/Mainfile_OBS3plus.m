%% Mainscript OBS3+ 
% OBS3+ 8150 and 8626 were attached to SBE19+; this script makes two
% seperate structs for the obs data. 

close all; clear all; clc

%% Load data needed

load('d:\sabinerijnsbur\Matlab\Raw_data_struct\SBE19_raw'); % data SBE19+
mat = SBE19_raw;
dir_out = 'd:\sabinerijnsbur\Matlab\Moorings\';

load('d:\sabinerijnsbur\Matlab\adcp\adcp18.mat'); % reference time
reft           = adcp18.time;
avp            = 600; % averaging period in seconds

%% OBS3+ 8150

fields1             = {'sal','press','temp','cond','timeJ','flag','header','description','v2','v3','mooring'};
OBS8150             = rmfield(mat,fields1);
OBS8150.description = {'OBS3+ 8150','Location: 18m 13.43mbs','v (voltage per channel)','cal_coeff = 112.009','For calibration use high voltage channel (v1)', 'OBS (FTU)'};
OBS8150.mooring     = '18m 13.43mbs';
OBS8150.cal_coeff   = 112.009;

OBS8150.obs         = OBS8150.cal_coeff.*OBS8150.v1; %calibration obs --> from voltage to FTU
[OBS8150.time]      = time2GMT(OBS8150.time,2,'positive');
[OBS8150.t]         = day_of_year(OBS8150.time);

[OBS8150]           = time_averaging_reft(OBS8150,reft,avp);
[OBS8150.t10]       = day_of_year(OBS8150.time10); % day of year based on time10
OBS8150.t10         = OBS8150.t10';
OBS8150.notes       = {'time converted to GMT','time (datenum)','t (day of year)','*10 10-min average'};

save([dir_out,'OBS8150.mat'],'OBS8150');
clear OBS8150_raw OBS8150

%% OBS3+ 8626

fields2             = {'sal','press','temp','cond','timeJ','flag','header','description','v0','v1','mooring'};
OBS8626             = rmfield(mat,fields2);
OBS8626.description = {'OBS3+ 8626','Location: 18m 16mbs','v (voltage per channel)','cal_coeff = 92.5077','For calibration use high voltage channel (v3)','OBS (FTU)'};
OBS8626.mooring     = '18m 16mbs';
OBS8626.cal_coeff   = 92.5077;

OBS8626.obs         = OBS8626.cal_coeff.*OBS8626.v3; %calibration obs --> from voltage to FTU
[OBS8626.time]      = time2GMT(OBS8626.time,2,'positive');
[OBS8626.t]         = day_of_year(OBS8626.time);

[OBS8626]           = time_averaging_reft(OBS8626,reft,avp);
[OBS8626.t10]       = day_of_year(OBS8626.time10); % day of year based on time10
OBS8626.t10         = OBS8626.t10';
OBS8626.notes       = {'time converted to GMT','time (datenum)','t (day of year)','*10 10-min average'};

save([dir_out,'OBS8626.mat'],'OBS8626');
clear OBS8626_raw OBS8626
