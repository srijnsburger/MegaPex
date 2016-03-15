% PLOTS STRATIFICATION AGAINST DIFFERENT PARAMETERS
%% Load data

Loc       = '12'; %Location
dirin     = 'd:\sabinerijnsbur\Matlab_files\Megapex_data\Moorings\Mfiles_adcp\';
eval(['load([dirin,''Mooring' Loc '_adcp_corr.mat'']);']);
eval(['M = M' Loc ''';']);
eval(['load([dirin,''Parameters' Loc '.mat'']);']);
eval(['P = P' Loc ''';']);
eval(['load([''d:\sabinerijnsbur\Matlab_files\Megapex_data\Tidalanalysis\T' Loc '.mat'']);']);
eval(['T = T' Loc ''';']);

dD = M.D(end,:)-M.D(1,:);
dS = M.S(end,:)-M.S(1,:);

%% Plot stratification vs tidal displacement

dx  = interp1(P.tt,P.dx,M.t);
tdx = interp1(P.tt,P.tdx,M.t);

figure;
plot(dS,dx,'o');
xlabel('dS (psu)');
ylabel('dx (m)');
title([Loc 'm site']);

figure; 
plot(dS,tdx,'o');
xlabel('dS (psu)');
ylabel('tidal dx (m)');
title([Loc 'm site']);

%% Plot stratification against Phi

figure;
plot(dS,P.phi,'o');
xlabel('dS (psu)');
ylabel('\phi (kg/m^3)');
title([Loc 'm site']);

%% Plot tidal avaraged dx and straticiation 

figure; 
plot(P.tav.dD,P.tav.tdx,'.','Markersize',10);
xlabel('dD (psu)');
ylabel('tdx (m)');
title([Loc 'm site;',' Averaged over tidal cycle']);
