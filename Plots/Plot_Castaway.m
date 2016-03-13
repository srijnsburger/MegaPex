% Load & plot castaway data
clc;clear all;close all;

%% Load data & make one struct - 17/09/14
dname  = 'd:\sabinerijnsbur\Measurements\Measurements2014\Data_2\Castaway\Raw_castaway_170914';
d      = dir(fullfile(dname,'*.mat'));
nfiles = numel(d);

CW17.press     = nan(348,nfiles);
CW17.temp      = nan(348,nfiles);
CW17.cond      = nan(348,nfiles);
CW17.ts        = nan(348,nfiles);
CW17.time      = nan(1,nfiles);
CW17.lat       = nan(1,nfiles);
CW17.lon       = nan(1,nfiles);
CW17.raw.press = nan(658,nfiles);
CW17.raw.temp  = nan(658,nfiles);
CW17.raw.cond  = nan(658,nfiles);
CW17.raw.ts    = nan(658,nfiles);

% Load data, define downcast & make struct
for i = 1:nfiles
    name = d(i).name;
    data = load(fullfile(dname,name));
    
    if isempty(data.Pressure)==1
        
    else
    %to select downcast
    figure;
    plot(data.Time,data.Pressure);
    [x(1),y(1)] = ginput(1);
    id1   = find(x(1) <= data.Time,1); % start
    hold on
    plot(data.Time(id1),data.Pressure(id1),'.r');% to check points
    [x(2),y(2)] = ginput(1);
    id2   = find(x(2) <= data.Time,1); % end
    plot(data.Time(id2),data.Pressure(id2),'.r');
    
    sz                     = numel(data.Pressure(id1:id2));
    CW17.press(1:sz,i)     = data.Pressure(id1:id2);
    CW17.temp(1:sz,i)      = data.Temperature(id1:id2);
    CW17.cond(1:sz,i)      = data.Conductivity(id1:id2);
    CW17.time(1,i)         = datenum(data.CastTimeUtc(1,1),data.CastTimeUtc(2,1),data.CastTimeUtc(3,1),data.CastTimeUtc(4,1),data.CastTimeUtc(5,1),data.CastTimeUtc(6,1));
    CW17.ts(1:sz,i)        = data.Time(id1:id2);
    CW17.lat(1,i)          = (data.LatitudeStart+data.LatitudeEnd)/2;
    CW17.lon(1,i)          = (data.LongitudeStart+data.LongitudeEnd)/2;
    sm                     = numel(data.Pressure);
    CW17.raw.press(1:sm,i) = data.Pressure;
    CW17.raw.cond(1:sm,i)  = data.Conductivity;
    CW17.raw.temp(1:sm,i)  = data.Temperature;
    CW17.id1(i)            = id1;
    CW17.id2(i)            = id2;
    
    end
end 

CW17.sal  = condtemp2sal(CW17.cond/1000,CW17.temp,CW17.press);
CW17.dens = waterdensity0(CW17.sal,CW17.temp);

%save
save('D:\sabinerijnsbur\Matlab\MegaPex\CastAway170914','CW17');

clear dname d nfiles

%% Load data & make one struct - 18/09/14
dname  = 'd:\sabinerijnsbur\Measurements\Measurements2014\Data_2\Castaway\Raw_castaway_180914\';
d      = dir(fullfile(dname,'*.mat'));
nfiles = numel(d);

CW18.press = nan(150,nfiles);
CW18.temp  = nan(150,nfiles);
CW18.cond  = nan(150,nfiles);
CW18.ts    = nan(150,nfiles);
CW18.time  = nan(1,nfiles);
CW18.lat   = nan(1,nfiles);
CW18.lon   = nan(1,nfiles);
CW18.raw.press = nan(559,nfiles);
CW18.raw.temp  = nan(559,nfiles);
CW18.raw.cond  = nan(559,nfiles);
CW18.raw.ts    = nan(559,nfiles);

% Load data, define downcast & make struct
for i = 1:nfiles
    name = d(i).name;
    data = load(fullfile(dname,name));
    
    %to select downcast
    figure;
    plot(data.Time,data.Pressure);
    [x(1),y(1)] = ginput(1);
    id1   = find(x(1) <= data.Time,1); % start
    hold on
    plot(data.Time(id1),data.Pressure(id1),'.r');% to check points
    [x(2),y(2)] = ginput(1);
    id2   = find(x(2) <= data.Time,1); % end
    plot(data.Time(id2),data.Pressure(id2),'.r');
    
    sz                 = numel(data.Pressure(id1:id2));
    CW18.press(1:sz,i) = data.Pressure(id1:id2);
    CW18.temp(1:sz,i)  = data.Temperature(id1:id2);
    CW18.cond(1:sz,i)  = data.Conductivity(id1:id2);
    CW18.time(1,i)     = datenum(data.CastTimeUtc(1,1),data.CastTimeUtc(2,1),data.CastTimeUtc(3,1),data.CastTimeUtc(4,1),data.CastTimeUtc(5,1),data.CastTimeUtc(6,1));
    CW18.ts(1:sz,i)    = data.Time(id1:id2);
    CW18.lat(1,i)      = (data.LatitudeStart+data.LatitudeEnd)/2;
    CW18.lon(1,i)      = (data.LongitudeStart+data.LongitudeEnd)/2;
    sm                 = numel(data.Pressure);
    CW18.raw.press(1:sm,i) = data.Pressure;
    CW18.raw.cond(1:sm,i)  = data.Conductivity;
    CW18.raw.temp(1:sm,i)  = data.Temperature;
    CW18.id1(i)            = id1;
    CW18.id2(i)            = id2;
end 

CW18.sal  = condtemp2sal(CW18.cond/1000,CW18.temp,CW18.press);
CW18.dens = waterdensity0(CW18.sal,CW18.temp);

%save
save('D:\sabinerijnsbur\Matlab\MegaPex\CastAway180914','CW18');

%% Plot profiles

CW=CW17;

% Plot profiles
% n = 1:numel(CW.press);
n = [1,5,10,15,20,25,30,35,40,45,50];

for i = n
figure;
plot(CW.dens(:,i)-1000,-CW.press(:,i));
ylabel('z(m)');
xlabel('rel. \rho (kg/m^3)');
title([datestr(CW.time(i))]);
end


%% Check coordinates

% coordinates M12
M12 = [4.17781 52.06883];
M18 = [4.14159 52.09176];
A12 = [4.17624 52.06764];
A18 = [4.14326 52.09290];
MS12 = [4.17493 52.06660];

% CW18
figure;
plot(CW18.lon,CW18.lat,'.')
hold on
plot(M12(1),M12(2),'.r');
plot(A12(1),A12(2),'.r');
plot(M18(1),M18(2),'.r');
plot(A18(1),A18(2),'.r');
plot(MS12(1),MS12(2),'.r');
axis equal  
axis([4 4.5 51.8 52.4])
tickmap('ll')
axislat(52.5)
hold on 
grid on
P = nc2struct('d:\sabinerijnsbur\Matlab\MegaPex\northsea.nc');
plot(P.lon,P.lat,'color',[.5 .5 .5])

% CW17
figure;
plot(CW17.lon,CW17.lat,'.')
hold on
plot(M12(1),M12(2),'.r');
plot(A12(1),A12(2),'.r');
plot(M18(1),M18(2),'.r');
plot(A18(1),A18(2),'.r');
plot(MS12(1),MS12(2),'.r');
axis equal  
axis([4 4.5 51.8 52.4])
tickmap('ll')
axislat(52.5)
hold on 
grid on
P = nc2struct('d:\sabinerijnsbur\Matlab\MegaPex\northsea.nc');
plot(P.lon,P.lat,'color',[.5 .5 .5])


%% Calibrate Castaway

load('d:\sabinerijnsbur\Measurements\Measurements2014\Matlab\Navicula_170914\SBENav.mat');
load('CastAway170914.mat');

% find times
for ii = 1:length(SBENav.time)
id = find(and(SBENav.time(ii)-(1/(24*60)*2) <= CW17.bin.time,SBENav.time(ii)+(1/(24*60)*2) >= CW17.bin.time),1);
if isempty(id) == 1
    id = nan;
end
    x(ii) = id;
end

temp = find(~isnan(x)==1);
dd = x(temp);

% compare
for j = 1:length(temp)
figure;
plot(SBENav.sal(:,temp(j)),SBENav.press(:,temp(j)));
hold on
plot(CW17.sal(:,dd(j)),CW17.press(:,dd(j)));
end

% for ii = 1:length(SBENav.time)
% id = find(and(SBENav.time(ii)-(1/(24*60)*2) <= CW17.time,SBENav.time(ii)+(1/(24*60)*2) >= CW17.time),1);
% if isempty(id) == 1
%     id = nan;
% end
%     x(ii) = id;
% end
% 
% temp = find(~isnan(x)==1);
% dd = x(temp);
% 
% n = [2:8,10:41,43:60];
% for ii = n
% aux = find(isnan(CW17.sal(ii))==1,1);
% sal = interp1(CW17.time,CW17.sal,SBENav.time);
% temp = interp1(CW17.time,CW17.temp,SBENav.time);
% end
% 
% figure;
% plot(SBENav.sal(temp),CW17.sal(dd),'.r');




