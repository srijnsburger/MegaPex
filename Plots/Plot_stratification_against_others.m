% PLOTS STRATIFICATION AGAINST DIFFERENT PARAMETERS
%% Load data

load('d:\sabinerijnsbur\Matlab_files\Megapex_data\Moorings\Mfiles_adcp\Mooring12_adcp_corr.mat');
load('d:\sabinerijnsbur\Matlab_files\Megapex_data\Moorings\Parameters12.mat');
load('d:\sabinerijnsbur\Matlab_files\Megapex_data\Tidalanalysis\T12');

dD12 = M12.D(5,:)-M12.D(1,:);
% dD18 = M18.D(4,:)-M18.D(1,:);

dS12 = M12.S(5,:)-M12.S(1,:);
% dS18 = M18.S(4,:)-M18.S(1,:);

%% Plot stratification vs tidal displacement

dx12  = interp1(P12.tt,P12.dx,M12.t);
tdx12 = interp1(P12.tt,P12.tdx,M12.t);

figure;
plot(dS12,dx12,'o');

figure; 
plot(dS12,tdx12,'o');

%% Plot stratification against Phi

figure;
plot(dS12,P12.phi,'o');