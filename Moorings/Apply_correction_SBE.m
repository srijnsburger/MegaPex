%% Load data

clc;clear all;close all;

dirin = 'd:\sabinerijnsbur\Matlab\Moorings\Mfiles\';
dir_out   = 'd:\sabinerijnsbur\Matlab\Figures\Moorings\';
save_plot = 'no';
% filename  = 'd:\sabinerijnsbur\Matlab\Moorings\Corrections_SBE.xlsx';
load([dirin,'SBE1842.mat']);
load([dirin,'SBE19.mat']);
load([dirin,'SBE5425.mat']);
load([dirin,'SBE4940.mat']);
load('d:\sabinerijnsbur\Matlab\Moorings\CorrectionSBE1842');
load('d:\sabinerijnsbur\Matlab\Moorings\CorrectionSBE19');

% Choose reference time for averaging!!

% Adcp times
% load('d:\sabinerijnsbur\Matlab\adcp\adcp12');
% load('d:\sabinerijnsbur\Matlab\adcp\adcp18');
% reft12 = adcp12.time;
% reft18 = adcp18.time;

% Adcp times extended
load('d:\sabinerijnsbur\Matlab\adcp\reft');
reft12 = reft.t12;
reft18 = reft.t18;

%% Save uncorrected Mfiles
SBE1842_nc = SBE1842;
save([dirin,'SBE1842_nc.mat'],'SBE1842_nc');

SBE19_nc = SBE19;
save([dirin,'SBE19_nc.mat'],'SBE19_nc');
%% SBE1842 

mooring  = '12m'; 
% sheet    = 'SBE1842_fit2';

p1 = C.p(1);%0.011621565823; %C.p(1);
p2 = C.p(2);%-8551.82; %C.p(2);

SBE1842C          = SBE1842;
SBE1842C.C        = SBE1842.time(25719:end,1)*p1+ p2;
SBE1842C.sal      = [SBE1842.sal(1:25718,1); (SBE1842.sal(25719:end,1) + SBE1842C.C)];
SBE1842C.dens     = waterdensity0(SBE1842C.sal,SBE1842.temp); 

[SBE1842C] = time_averaging_reft(SBE1842C,reft12,600);

SBE1842 = SBE1842C;
save([dirin,'SBE1842_corrected'],'SBE1842');

% % Check fit
% C.dS   = SBE1842C.sal10-SBE5425.sal10;
% C.id   = find(C.dS<0); % id where SBE1842 is lower than SBE5425
% C.v    = C.dS(C.id); % values
% C.drho = SBE1842C.dens10 - SBE5425.dens10;
% C.id2  = find(C.drho<0);
% C.v2   = C.drho(C.id2);

% % Insert threshold
% C.th   = -0.10;
% C.I    = find(C.dS < C.th);
% C.v3   = C.dS(C.I);
% C.days = SBE1842C.t10(C.I); % days


% Make excell sheet

% C.mat   = [C.I;C.v3;C.days];
% fit     = {[num2str(p1) ' * x - ' num2str(abs(p2))]};
% names   = {'Index';'Value';'Day'};
% xlswrite(filename,fit,sheet,'A1');
% xlswrite(filename,names,sheet,'A3');
% xlswrite(filename,C.mat,sheet,'B3');

plot_correction(mooring,SBE1842C);

% if strcmp(save_plot,'yes')
%     set(gcf, 'PaperUnits', 'centimeters');
%     set(gcf, 'PaperSize', [18 14]);
%     set(gcf, 'PaperPositionMode', 'manual');
%     set(gcf, 'PaperPosition', [0 0 18 14]);
%     set(gcf,'Renderer','painters');
%     print(gcf, '-dpdf',[dir_out 'Correction_salinity_SBE19_R.pdf']);
% end

%% SBE19

mooring = '18m'; 
% sheet   = 'SBE19_fit2';

p1 = D.p(1);%0.01892050838;%D.p(1);
p2 = D.p(2);%-13922.74;%D.p(2);

SBE19C          = SBE19_nc;
SBE19C.C        = SBE19.time(4720:end,1)*p1+ p2; % convert time to local time
SBE19C.sal      = [SBE19.sal(1:4719,1);(SBE19.sal(4720:end,1) + SBE19C.C)];
SBE19C.dens     = waterdensity0(SBE19C.sal,SBE19.temp); 

[SBE19C] = time_averaging_reft(SBE19C,reft18,600);
SBE19 = SBE19C;
save([dirin,'SBE19_corrected'],'SBE19');
% % Check fit
% D.dS   = SBE19C.sal10-SBE4940.sal10;
% D.id   = find(D.dS<0); % id where SBE19C is lower than SBE1842
% D.v    = D.dS(D.id); % values
% D.drho = SBE19C.dens10 - SBE4940.dens10;
% D.id2  = find(D.drho<0);
% D.v2   = D.drho(D.id2);

% Insert threshold
% D.th   = -0.10;
% D.I    = find(D.dS < D.th);
% D.v3   = D.dS(D.I);
% D.days = SBE19C.t10(D.I); % days
% t,'A1');
% xlswrite(filename,names,sheet,'A3');
% xlswrite(filename,D.mat,sheet,'B3');
% 
% % Make excell sheet
% 
% D.mat   = [D.I;D.v3;D.days];
% fit     = {[num2str(p1) ' * x - ' num2str(abs(p2))]};
% names   = {'Index';'Value';'Day'};
% xlswrite(filename,fit,shee

plot_correction(mooring,SBE19C);
