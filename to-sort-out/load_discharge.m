clc;clear all;close all;

dir_out = 'd:\sabinerijnsbur\Matlab\Measurements\Conditions\';

%% load data from excell

% Maassluis
[num,txt,raw] = xlsread('d:\sabinerijnsbur\Measurements\Measurements2014\Data_2\Conditions\Discharge\id29-MAASSS-201409010000-201411012359.xlsx');

t         = num(:,1);
tt        = cellstr(datestr(t,'HH:MM'));
time      = [raw(14:end,3) tt];
time(:,3) = cellfun(@(C1,C2) datenum([C1,' ',C2],'dd-mm-yyyy HH:MM'), time(:,1), time(:,2),'UniformOutput',false);

MSS.datenum  = cell2mat(time(:,3));
MSS.dis      = num(:,3);
MSS.units    = [{'m^3/s'}];

clear num txt raw time tt t

% Maasmond
[num,txt,raw]  = xlsread('d:\sabinerijnsbur\Measurements\Measurements2014\Data_2\Conditions\Discharge\id29-MAASMD-201409010000-201411012359.xlsx');

t         = num(:,1);
tt        = cellstr(datestr(t,'HH:MM'));
time      = [raw(14:end,3) tt];
time(:,3) = cellfun(@(C1,C2) datenum([C1,' ',C2],'dd-mm-yyyy HH:MM'), time(:,1), time(:,2),'UniformOutput',false);

MSM.datenum  = cell2mat(time(:,3));
MSM.dis      = num(:,3);
MSM.units    = [{'m^3/s'}];

clear num txt raw time tt t

% Haringvlietsluis
[num,txt,raw]  = xlsread('d:\sabinerijnsbur\Measurements\Measurements2014\Data_2\Conditions\Discharge\id29-HARVSZBNN-201409010000-201411012359.xlsx');

t         = num(:,1);
tt        = cellstr(datestr(t,'HH:MM'));
time      = [raw(14:end,3) tt];
time(:,3) = cellfun(@(C1,C2) datenum([C1,' ',C2],'dd-mm-yyyy HH:MM'), time(:,1), time(:,2),'UniformOutput',false);

HVS.datenum  = cell2mat(time(:,3));
HVS.dis      = num(:,3);
HVS.units    = [{'m^3/s'}];

clear num txt raw time tt t

%% Save raw mfiles
MSS_raw = MSS; HVS_raw = HVS; MSM_raw = MSM;
save([dir_out 'discharge_raw.mat'],'MSS_raw','HVS_raw','MSM_raw');

%% Convert to GMT time, day of year

MSS.time  = time2GMT(MSS.datenum,1,'positive');
field    = {'datenum','units'};
MSS       = rmfield(MSS,field);
MSS.notes = [{'dis in m^3/s','time in gmt','t in day of year'}];
MSS.t     = day_of_year(MSS.time);

MSM.time  = time2GMT(MSM.datenum,1,'positive');
field    = {'datenum','units'};
MSM       = rmfield(MSM,field);
MSM.notes = [{'dis in m^3/s','time in gmt','t in day of year'}];
MSM.t     = day_of_year(MSM.time);

HVS.time  = time2GMT(HVS.datenum,1,'positive');
field    = {'datenum','units'};
HVS       = rmfield(HVS,field);
HVS.notes = [{'dis in m^3/s','time in gmt','t in day of year'}];
HVS.t     = day_of_year(HVS.time);

%% Save mfiles

save([dir_out 'discharge.mat'],'MSS','HVS','MSM');
