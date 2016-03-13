%% Read aquadopp data
clc;clear all;close all;

dir_out   = 'd:\sabinerijnsbur\Matlab\Figures\Mini-stable\';
save_plot = 'yes';

aq.v1      = load('d:\sabinerijnsbur\Measurements\MegaPEX 2014 deployment\mini-STABLE2 frame instrument data\Nortek AquaDopp HR\DELFT02.v1');
aq.v2      = load('d:\sabinerijnsbur\Measurements\MegaPEX 2014 deployment\mini-STABLE2 frame instrument data\Nortek AquaDopp HR\DELFT02.v2');
aq.v3      = load('d:\sabinerijnsbur\Measurements\MegaPEX 2014 deployment\mini-STABLE2 frame instrument data\Nortek AquaDopp HR\DELFT02.v3');
sen        = load('D:\sabinerijnsbur\Measurements\MegaPEX 2014 deployment\mini-STABLE2 frame instrument data\Nortek AquaDopp HR\DELFT02.sen');
aq.heading = sen(:,13);
aq.pitch   = sen(:,14);
aq.roll    = sen(:,15);
aq.time    = datenum(sen(:,3),sen(:,1),sen(:,2),sen(:,4),sen(:,5),sen(:,6)); % includes miliseconds
aq.day     = day_of_year(aq.time);
adv.coord  = 'beam'; % see .hdr file
name       = 'Aquadopp';
orientation= 'downlooking';

nt = (4*24*60*60)/(1/4);

%% average

nn = 2400;
id = 1:nn:nt;

for i = 1:length(id)-1
   aq.v1_15(i) = nanmean(aq.v1(id(i):(id(i+1)-1),3));
   aq.v2_15(i) = nanmean(aq.v2(id(i):(id(i+1)-1),3));
   aq.v3_15(i) = nanmean(aq.v3(id(i):(id(i+1)-1),3));
   aq.t(i)     = nanmean(aq.day(id(i):(id(i+1)-1)));
end

%% Rotation
% according to sketch, different axes definitions and from degrees to radians:

hh = pi.*(aq.heading-90)./180;% 
pp = pi.*aq.pitch./180;
rr = pi.*aq.roll./180;

nfiles = length(aq.v1_15);
Vxyz   = [aq.v1_15; aq.v2_15; aq.v3_15];% 
Venu   = zeros(size(Vxyz))';
T = [1.5774 -0.7891 -0.7891; 0.0000  -1.3662  1.3662; 0.3677 0.3677 0.3677];% transformation matrix
if strcmp(orientation,'downlooking')
   T(2,:) = -T(2,:);   
   T(3,:) = -T(3,:);   
end

for i = 1:nfiles
    H = [cos(hh(i)) sin(hh(i)) 0; -sin(hh(i)) cos(hh(i)) 0; 0 0 1];% heading matrix
    P = [cos(pp(i)) -sin(pp(i))*sin(rr(i)) -cos(rr(i))*sin(pp(i)); 0   cos(rr(i))  -sin(rr(i)); sin(pp(i)) sin(rr(i))*cos(pp(i))  cos(pp(i))*cos(rr(i))]; % tilt matrix
    R = H*P*T; % rotation matrix
    Venu(i,1:3) = R*Vxyz(:,i);
end

aq.east_vel  = Venu(:,1);
aq.north_vel = Venu(:,2);
aq.vert_vel  = Venu(:,3);

%% Plots to check

figure;
plot(aq.t,aq.east_vel);
hold on
plot(aq.t,aq.north_vel,'g');
plot(aq.t,aq.vert_vel,'r');
hline(0)
legend('East','North','Up');
title([name, ' (m/s)']);

%% Plot: compare with adv

load('d:\sabinerijnsbur\Matlab\Mini-stable\adv355.mat');
adv = adv355;

figure;
subplot(3,1,1)
plot(adv.Day(2:end-1),adv.north_vel,'b');
hold on
plot(aq.t,aq.north_vel,'g');
hline(0)
xlim([259 266]);
legend('adv','aq');
title([name, 'vs ADV355 - North velocity (m/s)']);

subplot(3,1,2)
plot(adv.Day(2:end-1),-adv.east_vel,'b');
hold on
plot(aq.t,aq.east_vel,'g');
hline(0)
xlim([259 266]);
legend('adv','aq');
title('East velocity (m/s)');

subplot(3,1,3)
plot(adv.Day(2:end-1),adv.vert_vel,'b');
hold on
plot(aq.t,aq.vert_vel,'g');
hline(0)
xlim([259 266]);
legend('adv','aq');
title('Vertical velocity (m/s)');

if strcmp(save_plot,'yes')
    set(gcf, 'PaperUnits', 'centimeters');
    set(gcf, 'PaperSize', [18 10]);
    set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperPosition', [0 0 18 10]);
    set(gcf,'Renderer','painters');
    print(gcf, '-dpdf',[dir_out 'adv355_vs_aquadopp_MS.pdf']);
end

