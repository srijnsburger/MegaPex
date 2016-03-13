%Plot pcolor

load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\Mooring12_av_corr.mat');
load('d:\sabinerijnsbur\Matlab\adcp\adcp12.mat');
load('d:\sabinerijnsbur\Matlab\Megapex\Conditions\wind.mat');

adcp = adcp12;

% make z-grid
z12 = [0.9; 3; 7.2; 7.6; 10.4];

fig.xlim = [259 265];

%% Figure: density, velocity & wind

fig_handle = figure;

subplot(4,1,1)
pcolorcorcen(t12,z12,D12)
xlim(fig.xlim);
set(gca,'ydir','reverse');
colorbar;
colormap('jet');

subplot(4,1,2)
pcolorcorcen(adcp.t,adcp.z,adcp12.va)
xlim(fig.xlim);
colorbar;

subplot(4,1,3)
pcolorcorcen(adcp.t,adcp.z,adcp12.vc)
xlim(fig.xlim);
colorbar;

subplot(4,1,4)
h1 = quiver(wind.t,wind.t*0,-wind.speed10.*sin((wind.dir10*pi)/180),-wind.speed10.*cos((wind.dir10*pi)/180));
set(gca,'YTickLabel',[]);
grid on
xlim(fig.xlim);

all_ha = findobj(fig_handle,'type','axes','tag','');
linkaxes(all_ha,'x');

%% 

