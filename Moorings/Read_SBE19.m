%% Load SBE19Plus data

clc;clear all;close all;

D = importdata('d:\sabinerijnsbur\Measurements\Measurements2014\Data_2\Raw Data Moorings\CTD DATA\Converted\MegaPex2014_19P43025-4762_4.asc');

year = 2014;
SBE19_raw.header = D.colheaders;
SBE19_raw.press  = D.data(:,1);
SBE19_raw.cond   = D.data(:,2);
SBE19_raw.temp   = D.data(:,3);
SBE19_raw.sal    = D.data(:,4);
SBE19_raw.timeJ  = D.data(:,7);
SBE19_raw.time   = datenum(year-1,12,31,0,0,0)+SBE19_raw.timeJ; 
SBE19_raw.v0     = D.data(:,8);
SBE19_raw.v1     = D.data(:,9);
SBE19_raw.v2     = D.data(:,10);
SBE19_raw.v3     = D.data(:,11);
SBE19_raw.flag   = D.data(:,12);
SBE19_raw.mooring= '18m 15.13mbs';
SBE19_raw.description = {'Pressure (dB), Conductivity (S/m), Temperature(degreeC), Salinity (PSU), timeJ (Julian days), time (datenum), v (Voltage per channel)'};

save('d:\sabinerijnsbur\Matlab\Raw_data_struct\SBE19_raw','SBE19_raw');
save('d:\sabinerijnsbur\Matlab\Moorings\Mfiles_raw\SBE19_raw','SBE19_raw');

clear;

%% Define start and stoptime

load('d:\sabinerijnsbur\Matlab\Raw_data_struct\SBE19_raw');

mat2 = SBE19_raw;
fields = {'timeJ','flag','header'};
mat2 = rmfield(mat2,fields);

%% Calculate density

[mat2.dens] = waterdensity0(mat2.sal,mat2.temp);

%% Convert to GMT if needed

[mat2.time] = time2GMT(mat2.time,2,'positive');

%% Convert time to day of year

[mat2.t]    = day_of_year(mat2.time);

%% Time average (based on adcp)

% load('d:\sabinerijnsbur\Matlab\adcp\adcp18.mat');
% reft       = adcp18.time;
load('d:\sabinerijnsbur\Matlab\adcp\reft.mat');
reft       = reft.t18;
avp        = 600; % averaging period in seconds
[mat2]     = time_averaging_reft(mat2,reft,avp);
[mat2.t10] = day_of_year(mat2.time10); % day of year based on time10
mat2.t10   = mat2.t10';

mat2.notes  = {'time converted to GMT','time (datenum)','t (day of year)','*10 10-min average'};

%% Save

SBE19 = mat2;
save('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\SBE19','SBE19');

%% Old
% SBE19_v1.description = SBE19_v0.description;
% SBE19_v1.press       = SBE19_v0.press;
% SBE19_v1.cond        = SBE19_v0.cond;
% SBE19_v1.temp        = SBE19_v0.temp;
% SBE19_v1.sal         = SBE19_v0.sal;
% SBE19_v1.obs8150     = SBE19_v0.obs8150;
% SBE19_v1.obs8626     = SBE19_v0.obs8626;
% SBE19_v1.time        = SBE19_v0.time;
% SBE19_v1.cond2       = SBE19_v1.cond.*10;
% SBE19_v1.press2      = SBE19_v1.press./10;
% SBE19_v1.units       = 'cond = conductivity in S/m, cond2 = conductivity in mS/cm';
% SBE19_v1.sal2        = condtemp2sal(SBE19_v1.cond2,SBE19_v1.temp,SBE19_v1.press2);
% SBE19_v1.diffsal12   = SBE19_v1.sal2 - SBE19_v1.sal;

% % Define start and end time
% start  = find(and(SBE19_v1.time >= datenum(2014,09,15,17,05,00),SBE19_v1.time <= datenum(2014,09,15,17,10,00)));
% stop   = find(and(SBE19_v1.time >= datenum(2014,10,30,14,10,00),SBE19_v1.time <= datenum(2014,10,30,14,15,00)));
% 
% if find(SBE19_v1.time(end) < datenum(2014,10,30,14,10,00))
%     stop = find(SBE19_v1.time,1,'last');
% end
% 
% SBE19_v1.start = (start(1));
% SBE19_v1.stop  = (stop(1));


