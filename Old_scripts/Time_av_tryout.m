clc; clear all; close all;

%% Input data 

load('d:\sabinerijnsbur\Matlab\Moorings\SBE1526_v1.mat');
load('d:\sabinerijnsbur\Matlab\adcp\adcp12.mat');
mat   = SBE1526_v1;
avp   = 600; % averaging period in seconds
reft  = adcp12.mtime;
start = datenum(2014,09,15,19,00,00); % give date in datenum
stop  = datenum(2014,10,29,23,30,00); % give date in datenum

%% Determine starttime

% Check reference year
tmp.c    = datevec(mat.time);
tmp.d    = datevec(reft(1));
tmp.diff = datenum(tmp.c(1,1),tmp.c(1,2),tmp.c(1,3))- datenum(tmp.d(1,1),tmp.c(1,2),tmp.c(1,3)); 

if tmp.diff>0
    reft   = reft + tmp.diff;
elseif tmp.diff<0
    reft   = reft - tmp.diff;
end

% Find index start time
tstart      = reft(1)-((avp/2)/86400);
t1          = datevec(tstart);
start_t     = find(start <= mat.time,1,'first');
ind1        = find((tmp.c(start_t:end,5) == t1(1,5))); % 
[x,ind2]    = min(abs(tmp.c(start_t+ind1,6)- t1(1,6)));
tmp.start   = mat.time(mat.time == mat.time(start_t+ind1(ind2)));

% Find index end time
tend        = reft(end)+((avp/2)/86400);
t2          = datevec(tend);
stop_t      = find(stop <= mat.time,1,'first');
ind4        = find((tmp.c(stop_t:end,5) == t2(1,5)));
[y,ind5]    = min(abs(tmp.c(stop_t+ind4,6)-t2(1,6)));
tmp.end     = mat.time(mat.time == mat.time(stop_t+ind4(ind5)));

%% Averaging based on adcp

[mat] = time_averaging(mat,tmp.start,tmp.end,avp);

%% Interpolate

% Make grid:
a1 = datevec(reft(1));
a2 = datevec(mat.t10);
s1 = datenum(a2(1,1),a2(1,2),a2(1,3),a2(1,4),a1(1,5),a1(1,6));
s2 = datenum(a2(end,1),a2(end,2),a2(end,3),a2(end,4),a2(end,5),a1(1,6));
tgrid = s1:(1/(24*3600))*avp:s2;

mat2.sal10  = interp1(mat.t10,mat.sal10,tgrid);
mat2.temp10 = interp1(mat.t10,mat.temp10,tgrid);
mat2.cond10 = interp1(mat.t10,mat.cond10,tgrid);
mat2.t10    = tgrid;
