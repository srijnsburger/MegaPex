%% Mainscript for loading and reading Seabird profile data 
% Profile data from a Seabird, on the Navicula 17th of September 2014

clc; clear all; close all;

%% Load files

list    = findAllFiles('d:\sabinerijnsbur\Data\Navicula profiles 2014\Data Navicula_091714\CTD\','pattern_incl','cast*.asc');
down    = findAllFiles('d:\sabinerijnsbur\Data\Navicula profiles 2014\Data Navicula_091714\CTD\down_upcast\','pattern_incl','dcast*.asc');
% up      = findAllFiles('d:\sabinerijnsbur\Measurement_Campaigns\Measurements2014\Data_2\Data Navicula_091714\CTD\down_upcast','pattern_incl','ucast*.asc');

%% Load/import data

nfiles = length(list);

for i=1:nfiles
    [C(i)] = importdata(list{i},' ',1);
    [D(i)] = importdata(down{i},' ',1);
end

%% Get first time log from each file for sorting C{:}(1,7)

tmp  = arrayfun(@(x) x.data(1,7), C);
tmp2 = arrayfun(@(x) x.data(1,7), D);

%% Sort files on time

[tmp,I] = sort(tmp);
[tmp2,I2] = sort(tmp2);

C2 = C(I);
D2 = D(I2);

clear tmp I tmp2 I2 C D

save C2.mat C2
save D2.mat D2

%% Convert time

year = 2014;
nfiles = length(C2);
for j = 1:nfiles
    C2(j).data(:,13)  = datenum(year-1,12,31,0,0,0)+ C2(j).data(:,7);
    D2(j).data(:,13)  = datenum(year-1,12,31,0,0,0)+ D2(j).data(:,7);
end

save C2.mat C2
save D2.mat D2
% close all; clear all

%% Determine max and min pressure

load('D2');

[Pmax,Imax]  = arrayfun(@(x) max(x.data(:,2)), D2);% max pressure
[Pmin,Imin]  = arrayfun(@(x) min(x.data(:,2)), D2);% min pressure
[dmax,Idmax] = arrayfun(@(x) max(x.data(:,9)), D2);% max depth
[dmin,Idmin] = arrayfun(@(x) min(x.data(:,9)), D2);% min depth

Istop  =  Imax-3;
Istart =  Imin+3;

%% Determine start and stoptime

t1  = arrayfun(@(x) x.data(1,13), D2); % start time
t2  = arrayfun(@(x) x.data(end,13),D2); % end time

%% Split longer casts 
% cast 11 and 19 are longer casts, these need to be splitted in "seperate
% casts"

[Split11,Split19] = split_data(C2); % split the data

%% Determine (up- and) downcast manually

[C3,UD]     = Define_down_upcast(C2);
[Sp11,UD11] = Define_down_upcast(Split11);
[Sp19,UD19] = Define_down_upcast(Split19);

% % Check downcast
% check_downcast(C2,D2,C3);
% check_downcast(C2,D2,Sp11,11);
% check_downcast(C2,D2,Sp19,19);
% 
% % Plot_profiles
% Plot_profiles(C2,D2,C3);
% Plot_profiles(C2,D2,Sp11,11);
% Plot_profiles(C2,D2,Sp19,19);

close all; 
%% Make bins (smoothing data over bins)

[DD]   = Make_bins(C3);
[SP11] = Make_bins(Sp11);
[SP19] = Make_bins(Sp19);

% save everything
save('d:\sabinerijnsbur\Matlab_files\Navicula_data_2014\Data_SBENav.mat','C3','DD','SP11','SP19','Sp11','Sp19','C2','D2','Split11','Split19');

%% Make depth grid & matrices

[R]   = make_grid(DD,UD);
[R11] = make_grid(SP11,UD11);
[R19] = make_grid(SP19,UD19);

% Insert splitted casts
variables = {'depth','press','temp','sal','obs','volt','starttime','endtime'};
for k = 1:length(variables)
    variable = variables{k};
    Rdown.(variable)  = [R.(variable)(:,1:10) R11.(variable)(:,:) R.(variable)(:,12:18) R19.(variable)(:,:) R.(variable)(:,20:end)];
    Rdown2.(variable) = [R.(variable)(:,1:5) R.(variable)(:,7:10) R11.(variable)(:,:) R.(variable)(:,12:18) R19.(variable)(:,:) R.(variable)(:,20:23) R.(variable)(:,25:end)]; % delete cast 6 and 24, only 1 m surface measurements
    R2.(variable)     = [R.(variable)(:,1:5) R.(variable)(:,7:23) R.(variable)(:,25:end)]; % without cast 6 and 24, without splitting cast 11 and 19
end

Rdown.z  = R.z;
Rdown2.z = R.z;
R2.z     = R.z;
R2.descr = 'time is in GMT';

save R.mat R R11 R19
save R2.mat R2
save Rdown.mat Rdown
save Rdown2.mat Rdown2 % Is without cast 6 and 24

%% Set time to local time 
% Instrument/computer time was 09.38 when local time was 11.38 --> 2 hours
% difference (GMT+2 (summertime)). 
% Now time in GMT+1

% R.startGMT(1,:)      = R.starttime(1,:)+0.0417; % plus 1 hour
% R.endGMT(1,:)        = R.endtime(1,:)+0.0417; % plus 1 hour
% Rdown.startGMT(1,:)  = Rdown.starttime(1,:)+0.0417; % plus 1 hour
% Rdown.endGMT(1,:)    = Rdown.endtime(1,:)+0.0417; % plus 1 hour
% Rdown2.startGMT(1,:) = Rdown2.starttime(1,:)+0.0417; % plus 1 hour
% Rdown2.endGMT(1,:)   = Rdown2.endtime(1,:)+0.0417; % plus 1 hour
% R2.startGMT(1,:)     = R2.starttime(1,:)+0.0417; % plus 1 hour
% R2.endGMT(1,:)       = R2.endtime(1,:)+0.0417; % plus 1 hour
% 
% save R.mat R 
% save R2.mat R2
% save Rdown.mat Rdown
% save Rdown2.mat Rdown2

%% Interpolate over vertical (fill in NaN's)

%% Option: delete casts which did measure profile
% when the CTD has been only at the surface for a reason, this cast can be
% delete if required

% Test will be the structure without cast 6 & 24, which didn't measured over
% the entire vertical; Cast 6 stays cast 6 ; Cast 24 will become cast 38
% (because of the splitted casts 11 and 19).

% test = Rdown;
% test.(variable)(:,6) = [];
% test.(variable)(:,38)= [];
%% Density

R2.dens = waterdensity0(R2.sal,R2.temp);

%% Day of the year

R2.time   = R2.starttime;
[R2.t]    = day_of_year(R2.time);
R2.t      = R2.t';


%% PEA

% Calculate PEA
for i = 1:size(R2.dens,2)
    rho1     = R2.dens(:,i);
    depth1   = R2.depth(:,i);
    mask1    = ~isnan(rho1);
    rho2   = rho1(mask1);
    depth2 = depth1(mask1);
    if isempty(rho2)
    elseif numel(rho2)==1
    else
        R2.PEA(i) = pea_simpson_et_al_1990(depth2(end:-1:1)',rho2(end:-1:1)');
    end
end


%% Time average (based on adcp)

% load('d:\sabinerijnsbur\Matlab\adcp\adcp12.mat');
% reft       = adcp12.time;
% avp        = 600; % averaging period in seconds
% [R2]       = time_averaging_reft(R2,reft,avp);
% [R2.t10]   = day_of_year(R2.time10); % day of year based on time10

SBENav = R2;
save('d:\sabinerijnsbur\Matlab_files\Navicula_data_2014\SBENav.mat','SBENav');

%% Plot CTD data
% Plot_CTD_Navicula(Rdown)% see separate script






