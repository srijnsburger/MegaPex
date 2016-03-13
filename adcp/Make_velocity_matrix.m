%% Make a corrected velocity matrix
clc;clear all;close all;

load('d:\sabinerijnsbur\Matlab\adcp\adcp12.mat');
load('d:\sabinerijnsbur\Matlab\Mini-stable\adv355_int');
load('d:\sabinerijnsbur\Matlab\Mini-stable\adv358_int');
load('d:\sabinerijnsbur\Matlab\Mini-stable\adv496_int');

% Make new depth grid
adcp12C.z  = [0.28:0.25:14.78];

% Allocate 
adcp12C.vc = nan(length(adcp12C.z),length(adcp12.time));
adcp12C.va = nan(length(adcp12C.z),length(adcp12.time));

% Fill new along- and cross-shore velocities
adcp12C.va(6:end,:) = adcp12.va;
adcp12C.va(6:9,:)   = nan;
adcp12C.va(1,:)     = adv496_int.va;
adcp12C.va(2,:)     = adv358_int.va;
adcp12C.va(3,:)     = adv355_int.va;

adcp12C.vc(6:end,:) = adcp12.vc;
adcp12C.vc(6:9,:)   = nan;
adcp12C.vc(1,:)     = adv496_int.vc;
adcp12C.vc(2,:)     = adv358_int.vc;
adcp12C.vc(3,:)     = adv355_int.vc;

% Mean velocities
adcp12C.meanva      = nanmean(adcp12C.va);
adcp12C.meanvc      = nanmean(adcp12C.vc);

% Other variables needed
adcp12C.time        = adcp12.time;
adcp12C.t           = adcp12.t;
adcp12C.notes       = adcp12.notes;
adcp12C.h           = adcp12.h;

%% Save

save('d:\sabinerijnsbur\Matlab\adcp\adcp12C.mat','adcp12C');

%% Test plot
figure;
pcolorcorcen(adcp12C.t,adcp12C.z,adcp12C.va);
clim([-1.0 1.0]);
colorbar;
colormap(colormapbluewhitered);

figure;
pcolorcorcen(adcp12C.t,adcp12C.z,adcp12C.vc);
clim([-0.5 0.5]);
colorbar;
colormap(colormapbluewhitered);
