%% TRANSFORM ADV XYZ TO ENU COORDINATES WITH USE OF AQUADOPP

clc;clear all;close all;

dir_out = 'd:\sabinerijnsbur\Matlab\Mini-stable\';
dir_out_fig = 'd:\sabinerijnsbur\Matlab\Figures\Mini-stable\';
% save_plot = 'yes';

% Load raw ADV data : velocities
name        = 'adv358';
load('d:\sabinerijnsbur\Matlab\Mini-stable\adv358');
adv         = adv358;
load('d:\sabinerijnsbur\Matlab\Mini-stable\ADVG358_v1.mat');
load('d:\sabinerijnsbur\Matlab\Mini-stable\ADVG358_v2.mat');
load('d:\sabinerijnsbur\Matlab\Mini-stable\ADVG358_v3.mat');
adv.raw.vx  = v1;
adv.raw.vy  = v2;
adv.raw.vz  = v3;
adv.position = '0.50 mab';
adv.raw.coord= 'xyz'; % see .ctl file

% Load time from burst average file
hd1         = load('d:\sabinerijnsbur\Measurements\MegaPEX 2014 deployment\mini-STABLE2 frame instrument data\ADV G358\G358001-hd1.mat');

%% Make time grid ADV

nburst = length(adv.ba.time);
nsamp  = hd1.Samples_Per_Burst(1);
time   = nan(1,nsamp*nburst);
ii     = 1;

for i = 1:nburst
    adv.raw.time(1,ii:ii+9600-1) = adv.ba.time(i):(1/(24*3600*16)):(adv.ba.time(i)+(1/(24*3600)*600)-(1/(24*3600*16)));
    ii = ii+9600;
end

%% Load Aquadopp data : time, roll,pitch and heading information

sen        = load('D:\sabinerijnsbur\Measurements\MegaPEX 2014 deployment\mini-STABLE2 frame instrument data\Nortek AquaDopp HR\DELFT02.sen');
aq.heading = sen(:,13);
aq.pitch   = sen(:,14);
aq.roll    = sen(:,15);
aq.time    = datenum(sen(:,3),sen(:,1),sen(:,2),sen(:,4),sen(:,5),sen(:,6)); % includes miliseconds
aq.day     = day_of_year(aq.time);

%% Calculate the mean heading, pitch and roll for each burst

for i = 1:nburst
   id(i) = find(adv.ba.time(i)<=aq.time,1); % find for every burst of adv the datapoints of the aquadopp
end 

% calculate a mean heading, pitch and roll per burst
for i = 1:nburst-1
   hh(i) = pi.*(mean(aq.heading(id(i):id(i+1)-1))-90)./180;% 
   pp(i) = pi.*mean(aq.roll(id(i):id(i+1)-1))./180;
   rr(i) = pi.*mean(aq.pitch(id(i):id(i+1)-1))./180;
end

%% Transformation from XYZ to ENU

nfiles = length(adv.raw.vx); % number of files
aux    = 1:9600:nfiles; % indices begin burst
Vxyz   = [adv.raw.vx; adv.raw.vy; adv.raw.vz];%xyz velocities
Venu   = nan(nfiles,3);

for i = 1:nburst-1
    H = [cos(hh(i)) sin(hh(i)) 0; -sin(hh(i)) cos(hh(i)) 0; 0 0 1];% heading matrix
    P = [cos(pp(i)) -sin(pp(i))*sin(rr(i)) -cos(rr(i))*sin(pp(i)); 0   cos(rr(i))  -sin(rr(i)); sin(pp(i)) sin(rr(i))*cos(pp(i))  cos(pp(i))*cos(rr(i))]; % tilt matrix
    R = H*P; % rotation matrix
    
    vxx=adv.raw.vx(aux(i):aux(i+1)-1);
    vyy=adv.raw.vy(aux(i):aux(i+1)-1);
    vzz=adv.raw.vz(aux(i):aux(i+1)-1);
    
    for jj=1:numel(vxx)
        
    v=[vxx(jj);vzz(jj);vyy(jj)];    
    vv(jj,1:3)=(R*v)'./100;

    end
    
    Venu(1+(i-1)*nsamp:i*nsamp(1),1:3)=vv;

end

adv.raw.ve  = Venu(:,1);% east vel
adv.raw.vn  = Venu(:,2);% north vel
adv.raw.vv  = Venu(:,3);% vertical vel

%% Correct for east velocities --> needs a minus sign

adv.raw.ve = -adv.raw.ve;

%% Calculate along- & cross-shore velocity

% alpha = 48;
% [adv.raw.va,adv.raw.vc] = convert_vel_raul(adv.raw.ve,adv.raw.vn,alpha);

%% Save raw data

adv.nburst = nburst;
adv.nsamp  = nsamp;

%% Save matfile

adv358 = adv;
save([dir_out, name],'adv358','-v7.3');

%% Check plot

fig = figure;
plot(adv.raw.time(1000000:2000000),adv.raw.vn(1000000:2000000));
hold on
plot(adv.raw.time(1000000:2000000),adv.raw.ve(1000000:2000000));
plot(adv.raw.time(1000000:2000000),adv.raw.vv(1000000:2000000));
hline(0,'k');
datetick('x','keepticks');

%% Check with time-averaged

fig = figure;
subplot(3,1,1)
plot(adv.ba.time(2:end-1),adv.ba.ve);
hold on
plot(adv.raw.time(1000000:6000000),adv.raw.ve(1000000:6000000));
hline(0,'k');
datetick('x','keepticks');
legend('15-min av','raw');
ylabel('east vel (m/s)');
title([name,' ',adv.position]);

subplot(3,1,2)
plot(adv.ba.time(2:end-1),adv.ba.vn);
hold on
plot(adv.raw.time(1000000:6000000),adv.raw.vn(1000000:6000000));
hline(0,'k');
datetick('x','keepticks');
ylabel('north vel (m/s)');

subplot(3,1,3)
plot(adv.ba.time(2:end-1),adv.ba.vv);
hold on
plot(adv.raw.time(1000000:6000000),adv.raw.vv(1000000:6000000));
hline(0,'k');
datetick('x','keepticks');
ylabel('vert vel (m/s)');

handle = findobj(fig,'type','axes','tag','');
linkaxes(handle,'x');