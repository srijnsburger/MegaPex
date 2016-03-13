clc; clear all; close all;

%% Input data 

load('d:\sabinerijnsbur\Matlab\Moorings\SBE1525_v1.mat');
load('D:\sabinerijnsbur\Matlab\adcp12');
mat  = SBE1525_v1;
time = SBE1525_v1.time;
avp  = 600; % averaging period is 10 min = 600 sec
reft = adcp.mtime;
start =  datenum(2014,09,15,19,00,00); % give date in datenum
stop  =  datenum(2014,10,29,23,30,00); % give date in datenum

%% Determine starttime

% Determination sample freq and width of window
tmp.dt    = (mat.time(2)-mat.time(1))/(1/(24*3600));
tmp.Nt    = floor(avp/tmp.dt); % width of window

% Check reference year
tmp.c    = datevec(time);
tmp.d    = datevec(reft(1));
tmp.diff = datenum(tmp.c(1,1),tmp.c(1,2),tmp.c(1,3))- datenum(tmp.d(1,1),tmp.c(1,2),tmp.c(1,3)); 

if tmp.diff>0
    tstart = (reft(1)-((avp/2)/86400))+tmp.diff;
    tend   = (reft(1)+((avp/2)/86400))+tmp.diff;
else
    tstart = (reft(1)-((avp/2)/86400))-tmp.diff;
    tend   = (reft(1)+((avp/2)/86400))-tmp.diff;
end

% Find start time
t1       = reft(1)-((avp/2)/86400);
t2       = datevec(t1);
start_t  = find(start <= mat.time,1,'first');
ind1     = find((tmp.c(start_t:end,5) == t2(1,5))); % 
[x,ind2] = min(abs(tmp.c(start_t+ind1,6)- t2(1,6)));
tmp.ind3 = find(time == time(start_t+ind1(ind2)));

% Find end time
t3       = reft(end)+((avp/2)/86400)-1;
t4       = datevec(t3);
stop_t   = find(stop <= mat.time,1,'first');
ind4     = find((tmp.c(stop_t:end,5) == t4(1,5)));
[y,ind5] = min(abs(tmp.c(stop_t+ind4,6)-t4(1,6)));
tmp.ind6 = find(time == time(stop_t+ind4(ind5)));

%% Averaging based on adcp

% % Determine number of windows
lts      = (mat.time(tmp.ind6)-mat.time(tmp.ind3))/(1/(24*3600));% length time series
nwindows = floor(lts/avp); % number of windows

% Average
for ni = 1:nwindows
    tii            = tmp.ind3-1+((ni-1)*tmp.Nt+1:ni*tmp.Nt);
    mat.sal10(ni)  = nanmean(mat.sal(tii,1));
    mat.temp10(ni) = nanmean(mat.temp(tii,1));
    mat.cond10(ni) = nanmean(mat.cond(tii,1));
    mat.t10(ni)    = mat.time(tii(1)+(tmp.Nt/2));
%     mat.t10a(ni)   = mean(mat.time(tii,1));
end

%%
if tmp.diff>0
    tstart = (reft(1)-((avp/2)/86400))+tmp.diff;
    tend   = (reft(1)+((avp/2)/86400))+tmp.diff;
else
    tstart = (reft(1)-((avp/2)/86400))-tmp.diff;
    tend   = (reft(1)+((avp/2)/86400))-tmp.diff;
end

%id = find((mat.time >= tstart)&(mat.time<= tend));
id = find(mat.time >= tstart,1,'first');

%% Averaging period = adcp period

% Determine number of windows
lts2      = (mat.time(end)-mat.time(id))/(1/(24*3600));% length time series
nwindows2 = floor(lts2/avp); % number of windows

% Average
for ni = 1:nwindows2
    tii = id-1+((ni-1)*tmp.Nt+1:ni*tmp.Nt);
    sal10(ni)  = nanmean(mat.sal(tii,1));
    temp10(ni) = nanmean(mat.temp(tii,1));
    cond10(ni) = nanmean(mat.cond(tii,1));
    t10(ni)    = mat.time(tii(1)+(tmp.Nt/2));
%     mat.t10a(ni)   = mean(mat.time(tii,1));
end

%% Interpolate

% Make grid:
a1 = datevec(reft(1));
a2 = datevec(mat.t10);
s1 = datenum(a2(1,1),a2(1,2),a2(1,3),a2(1,4),a1(1,5),a1(1,6));
s2 = datenum(a2(end,1),a2(end,2),a2(end,3),a2(end,4),a2(end,5),a1(1,6));
tgrid = s1:(1/(24*6)):s2;

mat2.sal10  = interp1(mat.t10,mat.sal10,tgrid);
mat2.temp10 = interp1(mat.t10,mat.temp10,tgrid);
mat2.cond10 = interp1(mat.t10,mat.cond10,tgrid);
mat2.t10    = tgrid;
