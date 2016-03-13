%% TRANSFORM ADV XYZ TO ENU COORDINATES WITH USE OF AQUADOPP

% Uses the raw ADV data and the aquadopp to rotate the xyz velocities of
% the ADV.

clc;clear all;close all;

dir_out = 'd:\sabinerijnsbur\Matlab\Mini-stable\';
dir_out_fig = 'd:\sabinerijnsbur\Matlab\Figures\Mini-stable\';
% save_plot = 'yes';

% Load raw ADV data : velocities
name         = 'adv355';
load('d:\sabinerijnsbur\Matlab\Mini-stable\adv355_vel1.mat');
load('d:\sabinerijnsbur\Matlab\Mini-stable\adv355_vel2.mat');
load('d:\sabinerijnsbur\Matlab\Mini-stable\adv355_vel3.mat');
adv.Vel1 = v1;
adv.Vel2 = v2;
adv.Vel3 = v3;

adv.coord    = 'xyz'; % see .ctl file

% Load time from burst average file
hd1         = load('d:\sabinerijnsbur\Measurements\MegaPEX 2014 deployment\mini-STABLE2 frame instrument data\ADV G355\G355001-hd1.mat');
hd1.time    = day2datenum(hd1.Day,2014);

%% Make time grid ADV

nburst = length(hd1.time);
time   = nan(1,hd1.Samples_Per_Burst(1)*nburst);
ii     = 1;

for i = 1:nburst
    adv.time(1,ii:ii+9600-1) = hd1.time(i):(1/(24*3600*16)):(hd1.time(i)+(1/(24*3600)*600)-(1/(24*3600*16)));
    ii = ii+9600;
end


%% Load Aquadopp data : time, roll,pitch and heading information

sen        = load('D:\sabinerijnsbur\Measurements\MegaPEX 2014 deployment\mini-STABLE2 frame instrument data\Nortek AquaDopp HR\DELFT02.sen');
aq.heading = sen(:,13);
aq.pitch   = sen(:,14);
aq.roll    = sen(:,15);
aq.time    = datenum(sen(:,3),sen(:,1),sen(:,2),sen(:,4),sen(:,5),sen(:,6)); % includes miliseconds
aq.day     = day_of_year(aq.time);

%% Interpolate Aquadopp data to ADV times

% allocate
aq_int.heading = nan(1,hd1.Samples_Per_Burst(1)*nburst);
aq_int.pitch   = nan(1,hd1.Samples_Per_Burst(1)*nburst);
aq_int.roll    = nan(1,hd1.Samples_Per_Burst(1)*nburst);
ii = 1;

for i = 1:(nburst-1)
   id = find(hd1.time(i)<=aq.time & aq.time <= hd1.time(i+1));
   if length(id) < 10
       aq_int.heading(1,ii:ii+9600-1) = nanmean(aq.heading(id));
       aq_int.pitch(1,ii:ii+9600-1)   = nanmean(aq.pitch(id));
       aq_int.roll(1,ii:ii+9600-1)    = nanmean(aq.roll(id));
   else
   aq_int.heading(1,ii:ii+9600-1) = interp1(aq.time(id),aq.heading(id),adv.time(1,ii:ii+9600-1));
   aq_int.pitch(1,ii:ii+9600-1)   = interp1(aq.time(id),aq.pitch(id),adv.time(1,ii:ii+9600-1));
   aq_int.roll(1,ii:ii+9600-1)    = interp1(aq.time(id),aq.roll(id),adv.time(1,ii:ii+9600-1));
   ii = ii+9600;
   end
end

aq_int.time = adv.time; 

% [aq_int.heading] = interp1(aq.time,aq.heading,adv.time);
% [aq_int.pitch]   = interp1(aq.time,aq.pitch,adv.time);
% [aq_int.roll]    = interp1(aq.time,aq.roll,adv.time);
% aq_int.time      = adv.time;

%% Transformation from XYZ to ENU

% according to sketch, different axes definitions and from degrees to radians:
hh = pi.*(aq_int.heading-90)./180;% 
pp = pi.*aq_int.roll./180;
rr = pi.*aq_int.pitch./180;

nfiles = length(aq_int.time);
% Vxyz   = [adv355.Vel1(2:end-1); adv355.Vel2(2:end-1); adv355.Vel3(2:end-1)];% change Vel2 and Vel3?
Vxyz   = [adv.Vel1; adv.Vel3; adv.Vel2];% changed Vel2 and Vel3
Venu   = zeros(size(Vxyz))';

for i = 1:nfiles
    H = [cos(hh(i)) sin(hh(i)) 0; -sin(hh(i)) cos(hh(i)) 0; 0 0 1];% heading matrix
    P = [cos(pp(i)) -sin(pp(i))*sin(rr(i)) -cos(rr(i))*sin(pp(i)); 0   cos(rr(i))  -sin(rr(i)); sin(pp(i)) sin(rr(i))*cos(pp(i))  cos(pp(i))*cos(rr(i))]; % tilt matrix
    R = H*P; % rotation matrix
    Venu(i,1:3) = R*Vxyz(:,i)./100;
end

adv.east_vel  = Venu(:,1);
adv.north_vel = Venu(:,2);
adv.vert_vel  = Venu(:,3);

%% Correct for east velocities --> needs a minus sign

adv.east_vel = -adv.east_vel;

%% Calculate along- & cross-shore velocity

alpha = 48;
[adv] = convert_vel_raul(adv,alpha);

%% Save matfile

save([dir_out 'adv355_ts_rot'],'adv355');

%% Check plot

fig = figure;
plot(adv.time,adv.north_vel);
hold on
plot(adv.time,adv.east_vel);
plot(adv.time,adv.vert_vel);
datetick('x','keepticks');