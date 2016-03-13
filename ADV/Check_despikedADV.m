% Check despiked advs from Raul


addpath d:\sabinerijnsbur\SurfDrive\Scripts\MegaPex\ADV

id=[355 358 496];

cd d:\sabinerijnsbur\Matlab_files\Megapex_data\Mini-stable\Despiked_ADV_Raul\

for i=[id]

eval(['load adv',num2str(i),'.mat;'])

end


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
