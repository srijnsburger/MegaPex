%% Load_potwind
% Script which imports the potential wind data from a text file. 
% It makes a structure with the interesting parameters and times slots
clc; clear all; close all;

%% load data files 

Potwinddata = importdata('d:\sabinerijnsbur\Measurements\Measurements2014\Data_2\Conditions\potwind_330_2011\potwind_330_2011.txt',',',22);
dir_out = 'd:\sabinerijnsbur\Matlab\Measurements\Conditions\';

% Calculate datenum (construct time)
time  = [Potwinddata.data(:,1),Potwinddata.data(:,2)];
t     = num2str(time(:,1));
t2    = num2str(time(:,2));
space = repmat(' ',length(t),1);
t3    = [t,space,t2];
time2 = datenum(t3,'yyyymmdd HH');

potwind.platform = Potwinddata.textdata(1,1);
potwind.datenum  = time2;
potwind.dir      = Potwinddata.data(:,3);
potwind.speed    = Potwinddata.data(:,5).*0.1;% in m/s
potwind.units    = [{'Direction in degrees North','Speed in m/s','datenum is in gmt+1'}]; 
potwind.description = [{'Source:KNMI', 'Potential wind: corrected to the wind speed at 10m height over', 'Station 330 Hoek van Holland', 'measured at 16.6 m height', 'Coordinates X : 68209; Y : 445550'}];

%% Save data
potwind_raw = potwind;
save([dir_out 'potwind_raw'],'potwind_raw');
save([dir_out 'Potwinddata'],'Potwinddata');

%% Convert to GMT time and select timespan

% Adaptation Wind direction
% Notation KNMI: 0 degrees is calm, 990 degrees is variable winds
potwind.dir(potwind.dir==0)   = nan; % calm winds, windspeed ~ 0
potwind.dir(potwind.dir==990) = nan; % variable winds

start = '16-Sep-2014 11:00:00';
stop  = '30-Oct-2014 00:00:00';

potwind.time  = time2GMT(potwind.datenum,1,'positive');
field         = {'datenum','units'};
potwind       = rmfield(potwind,field);
t1            = find(potwind.time == datenum(start,'dd-mmm-yyyy HH:MM:SS'));
t2            = find(potwind.time == datenum(stop,'dd-mmm-yyyy HH:MM:SS'));
potwind.time  = potwind.time(t1:t2);
potwind.dir   = potwind.dir(t1:t2);
potwind.speed = potwind.speed(t1:t2);
potwind.t     = day_of_year(potwind.time);
potwind.notes = [{'Direction in degrees North','Speed in m/s','datenum is in gmt','t is in day of year'}];

save([dir_out 'potwind.mat'],'potwind');