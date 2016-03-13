
% corr      = mat;
% corr.C    = mat.time*p1+p2;
% corr.sal  = mat.sal + corr.C;
% corr.dens = waterdensity0(corr.sal,mat.temp);
% 
% [corr] = time_averaging_reft(corr,reft,avp);
% 
% % Chek fit
% corr.dS = corr.sal10 - 
%% Load data

clc;clear all;close all;

dirin = 'd:\sabinerijnsbur\Matlab\Moorings\';
dir_out   = 'd:\sabinerijnsbur\Matlab\Figures\Moorings\';
save_plot = 'no';

load([dirin,'SBE1842.mat']);
load([dirin,'SBE19.mat']);
load([dirin,'SBE5425.mat']);
load([dirin,'SBE4940.mat']);
load('d:\sabinerijnsbur\Matlab\adcp\adcp12');
load('d:\sabinerijnsbur\Matlab\adcp\adcp18');
load('d:\sabinerijnsbur\Matlab\Moorings\CorrectionSBE1842');
load('d:\sabinerijnsbur\Matlab\Moorings\CorrectionSBE19');

%% SBE1842 

mooring = '12m'; 

p1 = 0.011621565823; %C.p(1);
p2 = -8551.82; %C.p(2);

SBE1842C          = SBE1842;
SBE1842C.C        = SBE1842.time*p1+ p2;
SBE1842C.sal      = SBE1842.sal + SBE1842C.C;
SBE1842C.dens     = waterdensity0(SBE1842C.sal,SBE1842.temp); 

[SBE1842C] = time_averaging_reft(SBE1842C,adcp12.time,600);

% Check fit
C.dS   = SBE1842C.sal10-SBE5425.sal10;
C.id   = find(C.dS<0); % id where SBE19C is lower than SBE1842
C.v    = C.dS(C.id); % values
C.drho = SBE1842C.dens10 - SBE5425.dens10;
C.id2  = find(C.drho<0);
C.v2   = C.drho(C.id2);

plot_correction(mooring,SBE1842C);

% if strcmp(save_plot,'yes')
    set(gcf, 'PaperUnits', 'centimeters');
    set(gcf, 'PaperSize', [18 14]);
    set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperPosition', [0 0 18 14]);
    set(gcf,'Renderer','painters');
    print(gcf, '-dpdf',[dir_out 'Correction_salinity_SBE19_R.pdf']);
% end

%% SBE19

mooring = '18m'; 

p1 = 0.01892050838;%D.p(1);
p2 = -13922.74;%D.p(2);

SBE19C          = SBE19;
SBE19C.C        = SBE19.time*p1+ p2;
SBE19C.sal      = SBE19.sal + SBE19C.C;
SBE19C.dens     = waterdensity0(SBE19C.sal,SBE19.temp); 

[SBE19C] = time_averaging_reft(SBE19C,adcp18.time,600);

% Check fit
D.dS   = SBE19C.sal10-SBE4940.sal10;
D.id   = find(D.dS<0); % id where SBE19C is lower than SBE1842
D.v    = D.dS(D.id); % values
D.drho = SBE19C.dens10 - SBE4940.dens10;
D.id2  = find(D.drho<0);
D.v2   = D.drho(D.id2);

plot_correction(mooring,SBE19C);
