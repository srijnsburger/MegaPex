%% Check adcp all ensembles/pings

clc; clear all; close all;

load('D:\sabinerijnsbur\Matlab\Variance adcp\adcp.mat');

%% Matabtime

diff        = datenum(2014,09,16)-datenum(0014,09,16);
adcp.time   = adcp.mtime + diff; 
[adcp.t]    = day_of_year(adcp.time);

%% Check first bins error-velocity

fig_handle = figure;
subplot(2,1,1)
plot(adcp.t,adcp.north_vel(1,:));
hold on
plot(adcp.t,adcp.east_vel(1,:),'r');
plot(adcp.t,adcp.vert_vel(1,:),'g');
legend('north','east','vert');

subplot(2,1,2)
plot(adcp.t,adcp.error_vel(1,:),'k')
legend('error');

all_ha = findobj(fig_handle,'type','axes','tag','');
linkaxes(all_ha,'x');

%% 

fig_handle = figure;
subplot(2,1,1)
plot(adcp.t,adcp.north_vel(4,:));
hold on
plot(adcp.t,adcp.east_vel(4,:),'r');
plot(adcp.t,adcp.vert_vel(4,:),'g');
legend('north','east','vert');

subplot(2,1,2)
plot(adcp.t,adcp.error_vel(4,:),'k')
legend('error');

all_ha = findobj(fig_handle,'type','axes','tag','');
linkaxes(all_ha,'x');