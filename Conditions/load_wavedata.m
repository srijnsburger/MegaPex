%% load_wave_data
% Loads wave information from an excell/text file

clc;
clear all;
close all;

dir_out = 'd:\sabinerijnsbur\Measurements\Measurements2013\STRAINS Dropbox\mfiles and mat files\AlexHD2\';

%% Load significant wave height

[num,txt,raw] = xlsread('d:\sabinerijnsbur\Measurements\Measurements2013\STRAINS Dropbox\mfiles and mat files\AlexHD2\id22-EURPFM-201302010000-201303092359.xlsx');

t = num(:,1);
tt = cellstr(datestr(t,'HH:MM'));
time      = [raw(14:end,3) tt];
time(:,3) = cellfun(@(C1,C2) datenum([C1,' ',C2],'dd-mm-yyyy HH:MM'), time(:,1), time(:,2),'UniformOutput',false);

Hs.station               = raw(14,1);
Hs.x                     = raw(14,15);
Hs.y                     = raw(14,16);
Hs.ccsystem              = raw(13:14,14);
Hs.datenum               = cell2mat(time(:,3));
Hs.hs_cm                 = num(:,3); % in cm
Hs.hs                    = num(:,3)/100; % in cm
Hs.units                 = [{'hs_cm is in cm', 'hs is in m wrt NAP','datenum is in gmt+1'}];

clear num txt raw id test time tt 

% Hs.n15  = find(Hs.datenum == datenum('15-Sep-2014 00:00:00','dd-mmm-yyyy HH:MM:SS'));% Europlatform
% Hs.n16  = find(Hs.datenum == datenum('16-Sep-2014 00:00:00','dd-mmm-yyyy HH:MM:SS'));% Europlatform
% Hs.n17  = find(Hs.datenum == datenum('17-Sep-2014 00:00:00','dd-mmm-yyyy HH:MM:SS'));% Europlatform
% Hs.n18  = find(Hs.datenum == datenum('18-Sep-2014 00:00:00','dd-mmm-yyyy HH:MM:SS'));% Europlatform
% Hs.n30  = find(Hs.datenum == datenum('30-Oct-2014 23:00:00','dd-mmm-yyyy HH:MM:SS'));

%% Load wave direction

[num,txt,raw] = xlsread('d:\sabinerijnsbur\Measurements\Measurements2013\STRAINS Dropbox\mfiles and mat files\AlexHD2\id23-EURPFM-201302010000-201303092359.xlsx');

t         = num(:,1);
tt        = cellstr(datestr(t,'HH:MM'));
time      = [raw(14:end,3) tt];
time(:,3) = cellfun(@(C1,C2) datenum([C1,' ',C2],'dd-mm-yyyy HH:MM'), time(:,1), time(:,2),'UniformOutput',false);

Wd.station               = raw(14,1);
Wd.x                     = raw(14,15);
Wd.y                     = raw(14,16);
Wd.ccsystem              = raw(13:14,14);
Wd.datenum               = cell2mat(time(:,3));
Wd.dir                   = num(:,3); % in degrees
Wd.units                 = [{'wave direction in degrees north','datenum is in gmt+1'}];

% Wd.n15  = find(Wd.datenum == datenum('15-Sep-2014 00:00:00','dd-mmm-yyyy HH:MM:SS'));% Europlatform
% Wd.n16  = find(Wd.datenum == datenum('16-Sep-2014 00:00:00','dd-mmm-yyyy HH:MM:SS'));% Europlatform
% Wd.n17  = find(Wd.datenum == datenum('17-Sep-2014 00:00:00','dd-mmm-yyyy HH:MM:SS'));% Europlatform
% Wd.n18  = find(Wd.datenum == datenum('18-Sep-2014 00:00:00','dd-mmm-yyyy HH:MM:SS'));% Europlatform
% Wd.n30  = find(Wd.datenum == datenum('30-Oct-2014 23:00:00','dd-mmm-yyyy HH:MM:SS'));

clear num txt raw id test time tt 

%% Load wave period

[num,txt,raw] = xlsread('d:\sabinerijnsbur\Measurements\Measurements2013\STRAINS Dropbox\mfiles and mat files\AlexHD2\id24-EURPFM-201302010000-201303092359.xlsx');

t = num(:,1);
tt = cellstr(datestr(t,'HH:MM'));
time      = [raw(14:end,3) tt];
time(:,3) = cellfun(@(C1,C2) datenum([C1,' ',C2],'dd-mm-yyyy HH:MM'), time(:,1), time(:,2),'UniformOutput',false);

Tm0.station                    = raw(14,1);
Tm0.x                          = raw(14,15);
Tm0.y                          = raw(14,16);
Tm0.ccsystem                   = raw(13:14,14);
Tm0.datenum                    = cell2mat(time(:,3));
Tm0.tm0                        = num(:,3); % in sec
Tm0.units                      = [{'wave period in seconds','datenum is in gmt+1'}];

% Tm0.n15  = find(Tm0.datenum == datenum('15-Sep-2014 00:00:00','dd-mmm-yyyy HH:MM:SS'));% Europlatform
% Tm0.n16  = find(Tm0.datenum == datenum('16-Sep-2014 00:00:00','dd-mmm-yyyy HH:MM:SS'));% Europlatform
% Tm0.n17  = find(Tm0.datenum == datenum('17-Sep-2014 00:00:00','dd-mmm-yyyy HH:MM:SS'));% Europlatform
% Tm0.n18  = find(Tm0.datenum == datenum('18-Sep-2014 00:00:00','dd-mmm-yyyy HH:MM:SS'));% Europlatform
% Tm0.n30  = find(Tm0.datenum == datenum('30-Oct-2014 23:00:00','dd-mmm-yyyy HH:MM:SS'));

clear num txt raw id test time tt 

%% Save "raw data" as struct
Hs_raw = Hs; Wd_raw = Wd; Tm0_raw = Tm0;
save([dir_out 'wave_raw.mat'],'Hs_raw','Wd_raw','Tm0_raw');

%% Convert to GMT time and select timespan

% start = '16-Sep-2014 11:00:00';
% stop  = '30-Oct-2014 00:00:00';
start = '11-Feb-2013 08:00:00';
stop  = '09-Mar-2013 00:00:00';

Hs.time  = time2GMT(Hs.datenum,1,'positive');
field    = {'datenum','hs_cm','units'};
Hs       = rmfield(Hs,field);
Hs.notes = [{'hs in m','time in gmt','t in day of year'}];
t1       = find(Hs.time == datenum(start,'dd-mmm-yyyy HH:MM:SS'));
t2       = find(Hs.time == datenum(stop,'dd-mmm-yyyy HH:MM:SS'));
Hs.time  = Hs.time(t1:t2);
Hs.hs    = Hs.hs(t1:t2);
Hs.t     = day_of_year(Hs.time);

Wd.time  = time2GMT(Wd.datenum,1,'positive');
field    = {'datenum','units'};
Wd       = rmfield(Wd,field);
Wd.notes = [{'wave dir in degrees north','time in gmt','t in day of year'}];
t1       = find(Wd.time == datenum(start,'dd-mmm-yyyy HH:MM:SS'));
t2       = find(Wd.time == datenum(stop,'dd-mmm-yyyy HH:MM:SS'));
Wd.time  = Wd.time(t1:t2);
Wd.dir   = Wd.dir(t1:t2);
Wd.t     = day_of_year(Wd.time);

Tm0.time = time2GMT(Tm0.datenum,1,'positive');
field    = {'datenum','units'};
Tm0      = rmfield(Tm0,field);
Tm0.notes= [{'wave period (tm0) in sec','time in gmt','t in day of year'}];
t1       = find(Tm0.time == datenum(start,'dd-mmm-yyyy HH:MM:SS'));
t2       = find(Tm0.time == datenum(stop,'dd-mmm-yyyy HH:MM:SS'));
Tm0.time = Tm0.time(t1:t2);
Tm0.tm0  = Tm0.tm0(t1:t2);
Tm0.t    = day_of_year(Tm0.time);

save([dir_out 'wave.mat'],'Hs','Wd','Tm0');
