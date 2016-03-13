%% Open, read and save raw data

clc; clear all; close all;

% Input data:
name       = 'SBE4940';
mooring    = '18m xxmbs';
% fname      = 'd:\sabinerijnsbur\Measurements\Measurements2014\Data_2\Raw Data Moorings\CTD DATA\MegsPex2014_37IMP42738-4940_11062014_hta_sv.asc';
% fname2     = 'd:\sabinerijnsbur\Measurements\Measurements2014\Data_2\Raw Data Moorings\CTD DATA\MegsPex2014_37IMP42738-4940_11062014_hta.asc';
indir      = 'd:\sabinerijnsbur\Matlab\Moorings\Mfiles_raw\';
outdir     = 'd:\sabinerijnsbur\Matlab\Moorings\Mfiles\';

% load('d:\sabinerijnsbur\Matlab\adcp\adcp12.mat');
load('d:\sabinerijnsbur\Matlab\adcp\reft.mat');
% reft       = adcp12.time;
reft  = reft.t18;

load([indir,name,'_raw']);
mat = SBE4940_raw;

%% Load data

% [mat] = load_SBE_data(name,mooring,fname,fname2);
% SBE4940_raw = mat; % Find solution!!
% save([outdir,name,'_raw.mat'],[name,'_raw']);

%% Make new struct 

mat2 = mat;
% clear mat time t t2 space mooring fname fname2 fid ans C D

% Check conductivity and temperature, may not be lower than zero
n = length(mat2.cond);
for i = 1:n
    if mat2.cond(i) <= 0.0
        mat2.cond(i) = NaN;
    end
    
    if mat2.temp(i) <= 0.0
        mat2.temp(i) = NaN;
    end 
end

%Calculate Salinity
cond2       = mat2.cond.*10; % need conductivity in mS/cm

if isfield(mat2,'press')== 1
    press2        = mat2.press./10; % need pressure in bar
elseif isfield(mat2,'pref')== 1
    press2        = nan(n,1);
    nan_id        = isnan(press2);
    press2(nan_id)= mat2.pref; 
end

mat2.sal = condtemp2sal(cond2,mat2.temp,press2);

% Calculate Density
mat2.dens = waterdensity0(mat2.sal,mat2.temp);

%% Convert to GMT if needed

[mat2.time] = time2GMT(mat2.time,2,'positive');

%% Convert time to day of year

[mat2.t]    = day_of_year(mat2.time);

%% Time average (based on adcp)

avp        = diff(reft); avp = avp(1)*24*3600;
% avp        = (reft(2)-reft(1))*24*3600; % averaging period in seconds
[mat2]     = time_averaging_reft(mat2,reft,avp);
[mat2.t10] = day_of_year(mat2.time10); % day of year based on time10
mat2.t10   = mat2.t10';

mat2.notes  = {'time converted to GMT','time (datenum)','t (day of year)','*10 10-min average'};

%% Save as seperate file


% [name] = mat2;
% name = mat2; Find solution!!
save([outdir,name,'.mat'],[name]);


%% Define start and end of campaign
% % Now rough for all the same; need to be adjusted 
% start  = find(and(mat2.time >= datenum(2014,09,15,17,05,00),mat2.time <= datenum(2014,09,15,17,10,00)));
% stop   = find(and(mat2.time >= datenum(2014,10,30,14,10,00),mat2.time <= datenum(2014,10,30,14,15,00)));
% 
% if find(mat2.time(end) < datenum(2014,10,30,14,10,00))
%     stop = find(mat2.time,1,'last');
% end
% 
% mat2.start = (start(1));
% mat2.stop  = (stop(1));
% 