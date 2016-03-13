clc; clear all; close all;

load('D:\sabinerijnsbur\Matlab\adcp\adcp12.mat');
adcp       = adcp12;
% load('D:\sabinerijnsbur\Matlab\adcp\adcp18.mat');
% adcp       = adcp18;
east_vel   = adcp.east_vel;
north_vel  = adcp.north_vel;
east_vel2  = adcp.east_vel;
north_vel2 = adcp.north_vel;

for i = 1:length(adcp.east_vel)
id_error               = find(abs(adcp.error_vel(:,i)) > 0.01);
id_east                = find(abs(adcp.error_vel(:,i)) > abs(0.15.*adcp.east_vel(:,i)));
id_north               = find(abs(adcp.error_vel(:,i)) > abs(0.15.*adcp.north_vel(:,i)));
east_vel(id_error,i)   = NaN;
east_vel2(id_east,i)   = NaN;
north_vel(id_error,i)  = NaN;
north_vel2(id_north,i) = NaN;
end
