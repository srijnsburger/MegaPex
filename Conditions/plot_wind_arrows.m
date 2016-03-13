load('d:\sabinerijnsbur\Matlab\Measurements\Conditions\wind.mat');
load('d:\sabinerijnsbur\Matlab\Measurements\Conditions\potwind.mat');

x = -wind.speed10.*sin((wind.dir10*pi)/180);
y = -wind.speed10.*cos((wind.dir10*pi)/180);

figure;
h1 = quiver(wind.t,wind.t*0,x,y);
set(gca,'YTickLabel',[]);
grid on