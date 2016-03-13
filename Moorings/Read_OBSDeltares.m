% Read OBSs Deltares

close all; clear all; clc

fid = fopen('d:\sabinerijnsbur\Measurement_Campaigns\Measurements2014\Data_2\Raw Data Moorings\OBS deltares\TU_obs_admi_measurements_sv.dat');
C   = textscan(fid,'%s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f','Delimiter',',');
% D   = importdata('d:\sabinerijnsbur\Measurement_Campaigns\Measurements2014\Data_2\Raw Data Moorings\OBS deltares\TU_obs_admi_measurements.dat',',',5);
fclose(fid);

time = strrep(C{1,1},'"','');
t    = datenum(time,'yyyy-mm-dd HH:MM:SS');

%% Make struct with "raw" data

OBSD_raw.time            = t;
OBSD_raw.record          = C{1,2};
OBSD_raw.logger_volt_Avg = C{1,3};
OBSD_raw.logger_temp_Avg = C{1,4};
OBSD_raw.TurbFTU_Avg_1   = C{1,5};
OBSD_raw.TurbFTU_Avg_2   = C{1,6};
OBSD_raw.TurbFTU_Avg_3   = C{1,7};
OBSD_raw.TurbFTU_std_1   = C{1,8};
OBSD_raw.TurbFTU_std_2   = C{1,9};
OBSD_raw.TurbFTU_std_3   = C{1,10};
OBSD_raw.TurbFTU_min_1   = C{1,11};
OBSD_raw.TurbFTU_min_2   = C{1,12};
OBSD_raw.TurbFTU_min_3   = C{1,13};
OBSD_raw.TurbFTU_max_1   = C{1,14};
OBSD_raw.TurbFTU_max_2   = C{1,15};
OBSD_raw.TurbFTU_max_3   = C{1,16};
OBSD_raw.units           = 'FTU';
OBSD_raw.SN              = {'obs1 = 12773', 'obs2 = 13309','obs3 = 13310'};

save('OBSD_raw','OBSD_raw');

