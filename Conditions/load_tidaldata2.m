function [T1,T2]=load_tidaldata2(varargin)
%% Load_tidaldata
% Loads tide information from an excell/text file

clear all;
close all;

dir_out = 'd:\sabinerijnsbur\Matlab\Measurements\Conditions\';

%% Tide Hoek van Holland

[num,txt,raw] = xlsread('d:\sabinerijnsbur\Measurements\Measurements2014\Data_2\Conditions\waterhoogtes_HvH.xlsx');
id = fopen('d:\sabinerijnsbur\Measurements\Measurements2014\Data_2\Conditions\waterhoogte_HoekvanHolland.csv');
test = textscan(id,'%s %s %s %n %n','Headerlines',60,'Delimiter',';');

time      = [test{1}(:,1) test{2}(:,1)];
time(:,3) = cellfun(@(C1,C2) datenum([C1,' ',C2],'dd-mm-yyyy HH:MM'), time(:,1), time(:,2),'UniformOutput',false);

T1.station               = raw(14,1);
T1.x                     = raw(14,15);
T1.y                     = raw(14,16);
T1.ccsystem              = raw(13:14,14);
T1.datenum               = cell2mat(time(:,3));% GMT+1h
% T1.datenumGMT            = cell2mat(time(:,3))-(1/24); % GMT
T1.sea_surface_height_cm = num(:,3); % in cm
T1.sea_surface_height    = num(:,3)/100; % in m
T1.units                 = [{'sea_surface_height_cm is in cm','sea_surface_height is in m wrt NAP','datenum is in GMT+1'}];

% T1.n15  = find(T1.datenumGMT == datenum('15-Sep-2014','dd-mmm-yyyy'),1,'first');% Hoek van Holland
% T1.n16  = find(T1.datenumGMT == datenum('16-Sep-2014','dd-mmm-yyyy'),1,'first');
% T1.n30  = find(T1.datenumGMT == datenum('30-Oct-2014','dd-mmm-yyyy'),1,'last');

clear num txt raw id test time 

%% Tide Scheveningen

[num2,txt2,raw2] = xlsread('d:\sabinerijnsbur\Measurements\Measurements2014\Data_2\Conditions\waterhoogtes_Scheveningen.xlsx');
id2              = fopen('d:\sabinerijnsbur\Measurements\Measurements2014\Data_2\Conditions\waterhoogte_Scheveningen.csv');
test2            = textscan(id2,'%s %s %s %n %n','Headerlines',60,'Delimiter',';');

time2      = [test2{1}(:,1) test2{2}(:,1)];
time2(:,3) = cellfun(@(C1,C2) datenum([C1,' ',C2],'dd-mm-yyyy HH:MM'), time2(:,1), time2(:,2),'UniformOutput',false);

T2.station               = raw2(14,1);
T2.x                     = raw2(14,15);
T2.y                     = raw2(14,16);
T2.ccsystem              = raw2(13:14,14);
T2.datenum               = cell2mat(time2(:,3));% GMT+1
% T2.datenumGMT            = cell2mat(time2(:,3))-(1/24); % GMT
% T2.sea_surface_height_cm = num2(:,3); % in cm
% T2.sea_surface_height    = num2(:,3)/100; % in m
T2.sea_surface_height_cm = test2{1,4};
T2.sea_surface_height    = test2{1,4}/100; % in m
T2.units                 = [{'sea_surface_height_cm is in cm','sea_surface_height is in m wrt NAP','datenum is gmt+1'}];

% T2.n15  = find(T2.datenumGMT == datenum('15-Sep-2014','dd-mmm-yyyy'),1,'first');% Scheveningen
% T2.n16  = find(T2.datenumGMT == datenum('16-Sep-2014','dd-mmm-yyyy'),1,'first');% 
% T2.n30  = find(T2.datenumGMT == datenum('30-Oct-2014','dd-mmm-yyyy'),1,'last');

clear num2 txt2 raw2 id2 test2 time2 

%% Save as struct
T1_raw = T1; T2_raw = T2;
save([dir_out 'tide_raw.mat'],'T1_raw','T2_raw');

%% Convert to GMT time and select timespan

start = '16-Sep-2014 11:00:00';
stop  = '30-Oct-2014 00:00:00';

T1.time  = time2GMT(T1.datenum,1,'positive');
fields   = {'sea_surface_height_cm','datenum','units'};
T1       = rmfield(T1,fields);
T1.notes = [{'sea surface height (ssh) in m wrt NAP','time in gmt','t in day of year'}];
t1       = find(T1.time == datenum(start,'dd-mmm-yyyy HH:MM:SS'));
t2       = find(T1.time == datenum(stop,'dd-mmm-yyyy HH:MM:SS'));
T1.ssh   = T1.sea_surface_height(t1:t2);
T1       = rmfield(T1,'sea_surface_height');
T1.time  = T1.time(t1:t2);
T1.t     = day_of_year(T1.time);

T2.time  = time2GMT(T2.datenum,1,'positive');
fields   = {'sea_surface_height_cm','datenum','units'};
T2       = rmfield(T2,fields);
T2.notes = [{'sea surface height (ssh) in m wrt NAP','time in gmt','t in day of year'}];
t1       = find(T2.time == datenum(start,'dd-mmm-yyyy HH:MM:SS'));
t2       = find(T2.time == datenum(stop,'dd-mmm-yyyy HH:MM:SS'));
T2.ssh   = T2.sea_surface_height(t1:t2);
T2       = rmfield(T2,'sea_surface_height');
T2.time  = T2.time(t1:t2);
T2.t     = day_of_year(T2.time);

save([dir_out 'tide.mat'],'T1','T2');
end