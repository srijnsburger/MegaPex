%% TRANSFORM ADV XYZ TO ENU COORDINATES WITH USE OF AQUADOPP

clc;clear all;close all;

dir_out     = 'd:\sabinerijnsbur\Matlab\Mini-stable\';
dir_out_fig = 'd:\sabinerijnsbur\Matlab\Figures\Mini-stable\';
save_plot   = 'no';

% Load ADV data : time and velocities
% hd1 file, which is the average per burst, for future need to use ts1
name         = 'adv496';
hd1          = load('d:\sabinerijnsbur\Measurements\MegaPEX 2014 deployment\mini-STABLE2 frame instrument data\ADV G496\G496001-hd1.mat');
adv.ba.time  = day2datenum(hd1.Day,2014);
adv.ba.t     = hd1.Day;
adv.ba.coord = 'xyz'; % see .ctl file
adv.Position = '0.75 mab';

%% Load Aquadopp data : time, roll,pitch and heading information
sen        = load('D:\sabinerijnsbur\Measurements\MegaPEX 2014 deployment\mini-STABLE2 frame instrument data\Nortek AquaDopp HR\DELFT02.sen');
aq.heading = sen(:,13);
aq.pitch   = sen(:,14);
aq.roll    = sen(:,15);
aq.time    = datenum(sen(:,3),sen(:,1),sen(:,2),sen(:,4),sen(:,5),sen(:,6)); % includes miliseconds
aq.day     = day_of_year(aq.time);

%% Interpolate Aquadopp data to ADV times

avp  = mean(diff(adv.ba.time)*24*3600); % time avering period 
[aq] = time_averaging_reft_adv(aq,adv.ba.time,avp);% time-averaging aquadopp

%% Transformation from XYZ to ENU

% according to sketch, different axes definitions and from degrees to radians:
hh = pi.*(aq.heading15-90)./180;% 
pp = pi.*aq.roll15./180;
rr = pi.*aq.pitch15./180;

nfiles = length(aq.time15);
Vxyz   = [hd1.Vel1(2:end-1); hd1.Vel3(2:end-1); hd1.Vel2(2:end-1)];% changed Vel2 and Vel3
Venu   = zeros(size(Vxyz))';

for i = 1:nfiles
    H = [cos(hh(i)) sin(hh(i)) 0; -sin(hh(i)) cos(hh(i)) 0; 0 0 1];% heading matrix
    P = [cos(pp(i)) -sin(pp(i))*sin(rr(i)) -cos(rr(i))*sin(pp(i)); 0   cos(rr(i))  -sin(rr(i)); sin(pp(i)) sin(rr(i))*cos(pp(i))  cos(pp(i))*cos(rr(i))]; % tilt matrix
    R = H*P; % rotation matrix
    Venu(i,1:3) = R*Vxyz(:,i)./100;
end

adv.ba.ve = Venu(:,1);% east velocity
adv.ba.vn = Venu(:,2);% north velocity
adv.ba.vv = Venu(:,3);% vertical velocity

adv.ba.vx = hd1.Vel1;% x velocitiy
adv.ba.vy = hd1.Vel3;% y velocity
adv.ba.vz = hd1.Vel2;% z velocity

%% Correct for east velocities --> needs a minus sign

adv.ba.ve = -adv.ba.ve;

%% Calculate along- & cross-shore velocity

alpha    = 48;
[adv.ba.va,adv.ba.vc] = convert_vel_raul(adv.ba.ve,adv.ba.vn,alpha);

%% Save matfile

save([dir_out,name],'adv496');

%% Plot V1,V2 and V3 velocities ADV (before rotation)

% load('d:\sabinerijnsbur\Matlab\Mini-stable\adv355');
% adv = adv355;

figure;
plot(hd1.Day,hd1.Vel1)
hold on
plot(hd1.Day,hd1.Vel2,'g');
plot(hd1.Day,hd1.Vel3,'r');
legend('V1','V2','V3');
hline(0);
title('Velocities ADV before rotation (XYZ coordinate system)');

if strcmp(save_plot,'yes')
    set(gcf, 'PaperUnits', 'centimeters');
    set(gcf, 'PaperSize', [18 10]);
    set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperPosition', [0 0 18 10]);
    set(gcf,'Renderer','painters');
    print(gcf, '-dpdf',[dir_out_fig 'adv358_V123-velocities.pdf']);
end

%% Plot: first check

figure;
plot(adv.ba.t(2:end-1),adv.ba.ve);
hold on
plot(adv.ba.t(2:end-1),adv.ba.vn,'g');
plot(adv.ba.t(2:end-1),adv.ba.vv,'r');
hline(0)
legend('East','North','Up');
title([name, ' (m/s)']);


% %% Plot:  change sign east_vel --> correct
% figure;
% plot(adv.Day(2:end-1),-adv.east_vel);
% hold on
% plot(adv.Day(2:end-1),adv.north_vel,'g');
% plot(adv.Day(2:end-1),adv.vert_vel,'r');
% hline(0)
% legend('East','North','Up');
% title([name,' (m/s) - negative east vel']);
% 
% if strcmp(save_plot,'yes')
%     set(gcf, 'PaperUnits', 'centimeters');
%     set(gcf, 'PaperSize', [18 10]);
%     set(gcf, 'PaperPositionMode', 'manual');
%     set(gcf, 'PaperPosition', [0 0 18 10]);
%     set(gcf,'Renderer','painters');
%     print(gcf, '-dpdf',[dir_out_fig 'adv355.pdf']);
% end

%% Plot: Compare with adcp velocity
load('d:\sabinerijnsbur\Matlab\adcp\adcp12.mat');

figure;
subplot(3,1,1)
plot(adv.ba.t(2:end-1),adv.ba.vn,'b');
hold on
plot(adcp12.t,adcp12.north_vel(2,:),'g');
hline(0)
legend('adv','adcp');
title([name, ' - North velocity (m/s)']);

subplot(3,1,2)
plot(adv.ba.t(2:end-1),adv.ba.ve,'b');
hold on
plot(adcp12.t,adcp12.east_vel(2,:),'g');
hline(0)
legend('adv','adcp');
title('East velocity (m/s)');

subplot(3,1,3)
plot(adv.ba.t(2:end-1),adv.ba.vv,'b');
hold on
plot(adcp12.t,adcp12.vert_vel(2,:),'g');
hline(0)
legend('adv','adcp');
title('Vertical velocity (m/s)');

if strcmp(save_plot,'yes')
    set(gcf, 'PaperUnits', 'centimeters');
    set(gcf, 'PaperSize', [18 10]);
    set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperPosition', [0 0 18 10]);
    set(gcf,'Renderer','painters');
    print(gcf, '-dpdf',[dir_out_fig 'adv358_vs_adcp12.pdf']);
end
