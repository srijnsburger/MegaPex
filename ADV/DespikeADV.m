%Code to despike ADV velocities. We'll make use of the script
%func_despike_phasespace3d.m

clear all
clc

tic;

addpath /Users/rfloresa/Dropbox/UW/Research/Netherlands_092014/mcodes/ADV

id=[355 358 496];

cd /Users/rfloresa/Dropbox/UW/Research/Netherlands_092014/Data/MegaPex2014/Matlab_structures

for i=[id]

eval(['load adv',num2str(i),'.mat;'])

eval(['v_north=adv',num2str(i),'.raw.n;'])
eval(['v_east=adv',num2str(i),'.raw.e;'])
eval(['v_up=adv',num2str(i),'.raw.u;'])

[v_north_desp, ip1] = func_despike_phasespace3d( v_north, 9, 2);
[v_east_desp, ip2] = func_despike_phasespace3d( v_east, 9, 2 );
[v_up_desp, ip3] = func_despike_phasespace3d( v_up, 9, 2 );

eval(['adv',num2str(i),'.raw.n=v_north_desp;'])
eval(['adv',num2str(i),'.raw.e=v_east_desp;'])
eval(['adv',num2str(i),'.raw.u=v_up_desp;'])

end

toc;

%% plot to check

figure
set(gcf,'Color','w')
s1=subplot(311);
plot(time(1000000:5000000),adv496.raw.n(1000000:5000000))
hold on
plot(adv496.time(1:end-1),adv496.north_vel,'g.-')
s2=subplot(312);
plot(time(1000000:5000000),adv496.raw.e(1000000:5000000))
hold on
plot(adv496.time(1:end-1),adv496.east_vel,'g.-')
s3=subplot(313);
plot(time(1000000:5000000),adv496.raw.u(1000000:5000000))
hold on
plot(adv496.time(1:end-1),adv496.up,'g.-')
linkaxes([s1 s2 s3],'x')