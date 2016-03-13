%% Load data
% AML CT mounted at Mini Stable

clc; clear all; close all;

%% Load separate txt files 

nfiles      = 12;
formatSpec  = '%s %s %f %f %f %f %f %f %f';
Headerlines = 2;

for i = 1:nfiles

    eval(['fileID = fopen(''d:\sabinerijnsbur\Measurements\MegaPEX 2014 deployment\mini-STABLE2 frame instrument data\AML MC7 CT logger sn1102\AML MC7 CT-',num2str(i),'.txt'');']);
    eval(['D',num2str(i),'= textscan(fileID,formatSpec,''Headerlines'',Headerlines);']);
    status(i) = fclose(fileID);
    
end

%% Make struct per CT

CT7216.cond = [];
CT7216.temp = [];
CT7217.cond = [];
CT7217.temp = [];
CT7218.cond = [];
CT7218.temp = [];
time        = [];
volt        = [];

for i = 1:nfiles

eval(['t1 = D',num2str(i),'{1,1};']);
eval(['t2 = D',num2str(i),'{1,2};']);
t = cellfun(@(C1,C2) datenum([C1,' ',C2],'mm/dd/yy HH:MM:SS.FFF'), t1, t2,'UniformOutput',false);

time = [time; cell2mat(t)];

eval(['c7216 = D',num2str(i),'{1,3};']);
CT7216.cond = [CT7216.cond; c7216];

eval(['t7216 = D',num2str(i),'{1,4};']);
CT7216.temp = [CT7216.temp; t7216];

eval(['c7217 = D',num2str(i),'{1,5};'])
CT7217.cond = [CT7217.cond; c7217];

eval(['t7217 = D',num2str(i),'{1,6};']);
CT7217.temp = [CT7217.temp; t7217];

eval(['c7218 = D',num2str(i),'{1,7};'])
CT7218.cond = [CT7218.cond; c7218];

eval(['t7218 = D',num2str(i),'{1,8};']);
CT7218.temp = [CT7218.temp; t7218];

eval(['v    = D',num2str(i),'{1,9};']);
volt        = [volt; v];
end


%% Delete values 5/09 when instrument activated for first time

I = find(time < datenum(2014,09,16,06,00,00));
CT7216.cond(I) = [];
CT7216.temp(I) = [];
CT7217.cond(I) = [];
CT7217.temp(I) = [];
CT7218.cond(I) = [];
CT7218.temp(I) = [];
time(I)        = [];
volt(I)        = [];

%% Time & volt structs

[day] = day_of_year(time);

CT7216.time = time;
CT7216.t    = day;
CT7216.volt = volt;
CT7217.time = time;
CT7217.t    = day;
CT7217.volt = volt;
CT7218.time = time;
CT7218.t    = day;
CT7218.volt = volt;

%% Calculate salinity and temperature

% fill in reference pressure
CT7216.pref = (12-0.75);
[CT7216]    = calculate_sal_dens(CT7216);
CT7217.pref = (12-0.50);
[CT7217]    = calculate_sal_dens(CT7217);
CT7218.pref = (12-0.25);
[CT7218]    = calculate_sal_dens(CT7218);

%% Time-averaging

% load('d:\sabinerijnsbur\Matlab\Mini-stable\adv355');
% [CT7216] = time_averaging_reft(CT7216,adv355.ba.time,900); 
% [CT7217] = time_averaging_reft(CT7217,adv355.ba.time,900);
% [CT7218] = time_averaging_reft(CT7218,adv355.ba.time,900);

%% Time averaging based on burst

nsamp  = 9600;
nburst = length(CT7216.time)/nsamp;
aux    = [1:9600:length(CT7216.time)];
id     = [6,7,8];

for j = id
    for i = 1:nburst
        eval(['CT721',num2str(j),'.cond15(i) = nanmean(CT721',num2str(j),'.cond(aux(i):aux(i+1)-1));']);
        eval(['CT721',num2str(j),'.temp15(i) = nanmean(CT721',num2str(j),'.temp(aux(i):aux(i+1)-1));']);
        eval(['CT721',num2str(j),'.sal15(i)  = nanmean(CT721',num2str(j),'.sal(aux(i):aux(i+1)-1));']);
        eval(['CT721',num2str(j),'.dens15(i) = nanmean(CT721',num2str(j),'.dens(aux(i):aux(i+1)-1));']);
        eval(['CT721',num2str(j),'.time15(i) = CT721',num2str(j),'.time(aux(i));']);% starttime burst
        eval(['CT721',num2str(j),'.t15(i) = CT721',num2str(j),'.t(aux(i));']);% starttime burst days
    end
end

%% Save structs

save('d:\sabinerijnsbur\Matlab\Mini-stable\CT7216.mat','CT7216');
save('d:\sabinerijnsbur\Matlab\Mini-stable\CT7217.mat','CT7217');
save('d:\sabinerijnsbur\Matlab\Mini-stable\CT7218.mat','CT7218');

