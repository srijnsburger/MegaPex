%% Load_uurgeg
% Script which imports hourly wind data which is averaged over every 10min
% It makes a struct with the important wind data and time slots
clc;
clear all;
close all;

dir_out = 'd:\sabinerijnsbur\Measurements\Measurements2013\STRAINS Dropbox\mfiles and mat files\AlexHD2\';

%% Load data files
Uurgeg = importdata('d:\sabinerijnsbur\Measurements\Measurements2013\STRAINS Dropbox\mfiles and mat files\AlexHD2\KNMI_20150731_hourly.txt');

% Calculate datenum (construct time)
time  = [Uurgeg.data(:,2),Uurgeg.data(:,3)];
t     = num2str(time(:,1));
t2    = num2str(time(:,2));
space = repmat(' ',length(t),1);
t3    = [t,space,t2];
time2 = datenum(t3,'yyyymmdd HH');

wind.platform     = Uurgeg.data(1,1);
wind.datenum      = time2;
wind.dir10avg     = Uurgeg.data(:,4);
wind.speedhavg    = Uurgeg.data(:,5).*0.1;% in m/s
wind.speed10avg   = Uurgeg.data(:,6).*0.1;% in m/s
wind.gust         = Uurgeg.data(:,7).*0.1;% in m/s
wind.units        = [{'datenum is gmt+1','Direction in degrees avg over last 10 min (360=north, 90=east, 180=south, 270=west, 0=calm, 990=variable)','Speedhavg in m/s, hourly average','Speed10avg in m/s,is averaged over last 10 min','gust is maximum wind gust during the hourly division'}]; 
wind.description  = [{'Source:KNMI', 'Hourly averaged', 'Station 330 Hoek van Holland'}];

%% Save "raw data" as struct

wind_raw = wind;
save([dir_out 'wind_raw.mat'],'wind_raw');
save('Uurgeg','Uurgeg');% save very raw struct

%% Convert to GMT time and select timespan

% Adaptation Wind direction
% Notation KNMI: 0 degrees is calm, 990 degrees is variable winds
wind.dir10avg(wind.dir10avg ==0)   = nan; % calm winds, windspeed ~ 0
wind.dir10avg(wind.dir10avg ==990) = nan; % variable winds

% start = '16-Sep-2014 11:00:00';
% stop  = '30-Oct-2014 00:00:00';

start = '11-Feb-2013 08:00:00';
stop  = '09-Mar-2013 00:00:00';

wind.time  = time2GMT(wind.datenum,1,'positive');% convert to gmt timezone
field      = {'datenum','units'};
wind       = rmfield(wind,field);
t1         = find(wind.time == datenum(start,'dd-mmm-yyyy HH:MM:SS'));
t2         = find(wind.time == datenum(stop,'dd-mmm-yyyy HH:MM:SS'));
wind.time  = wind.time(t1:t2);
wind.dir10 = wind.dir10avg(t1:t2);
wind.speed = wind.speedhavg(t1:t2);
wind.speed10 = wind.speed10avg(t1:t2);
wind.gust  = wind.gust(t1:t2);
% wind.time  = wind.time;
% wind.dir10 = wind.dir10avg;
% wind.speed = wind.speedhavg;
% wind.speed10 = wind.speed10avg;
% wind.gust  = wind.gust;
wind.t     = day_of_year(wind.time);
field2     = {'speedhavg','dir10avg','speed10avg'};
wind       = rmfield(wind,field2);
wind.notes = [{'time in gmt','t in day of year','direction (dir) in degrees avg over last 10 min (360=north, 90=east, 180=south, 270=west)','Speedhavg in m/s, hourly average','Speed10avg in m/s,is averaged over last 10 min'}]; 

save([dir_out 'wind.mat'],'wind');
