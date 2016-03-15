%% AVERAGE DX OVER ONE TIDAL CYCLE

%% Load data
clc;clear all;
%close all;

Loc       = '18'; %Location
dirin     = 'd:\sabinerijnsbur\Matlab_files\Megapex_data\Moorings\Mfiles_adcp\';
eval(['load([dirin,''Matrix_TC_' Loc '.mat'']);']);
eval(['MT = MT' Loc ''';']);
eval(['load([dirin,''Parameters' Loc '.mat'']);']);
eval(['P = P' Loc ''';']);

%% Average over 1 tidal cycle

for i = 1:size(MT.dx,1)
    P.tav.dx(i)  = nanmean(MT.dx(i,:));
    P.tav.tdx(i) = nanmean(MT.tdx(i,:));
    P.tav.t(i)   = nanmean(MT.t(i,:));
    P.tav.dD(i)  = nanmean(MT.dD(i,:));
end

%% Save

eval(['P' Loc '= P;']);
save([dirin,'Parameters' Loc '.mat'],'-append',['P' Loc]);

%% Plot

eval(['load([dirin,''Mooring' Loc '_adcp_corr.mat'']);']);
eval(['M = M' Loc ''';']);
eval(['load([''d:\sabinerijnsbur\Matlab_files\Megapex_data\adcp\adcp' Loc ''']);']);
eval(['adcp = adcp' Loc ''';']);

% Determine tidal cycles
[zc]  = Zero_crossing(M.t,M.ssh);

% Determine spring-neap
[period] = determine_spring_neap(adcp.t);

% input
fig.xlim = [260 285];

figure;
h1 = subplot(5,1,1);
plot(M.t(period.p1),M.ssh(period.p1),'b');
hold on
plot(M.t(period.p2),M.ssh(period.p2),'r');
legend('Neap','Spring');
plot(M.t(period.p3),M.ssh(period.p3),'b');
plot(M.t(period.p4),M.ssh(period.p4),'r');
hline(0,'k');
vline(M.t(zc),':k');
ylim([-1.5 1.5]);
xlim(fig.xlim);
ylabel('\eta (m)');
title([Loc 'm site']);

h2 = subplot(5,1,2);
plot(M.t,M.D-1000);
vline(M.t(zc),':k');
xlim(fig.xlim);
ylabel('rel. \rho (kg/m^3)');

h3 = subplot(5,1,3);
plot(M.t,(M.D(end,:)-M.D(1,:)));
vline(M.t(zc),':k');
ylim([0 10]);
xlim(fig.xlim);
ylabel('\Delta \rho');

h4 = subplot(5,1,4);
plot(P.tav.t,P.tav.dD,'o');
hold on
hline(0,'k');
vline(M.t(zc),':k');
xlim(fig.xlim);
ylabel('tidal av. \Delta \rho')

h5 = subplot(5,1,5);
plot(P.tav.t,P.tav.tdx,'o');
hold on
hline(0,'k');
vline(M.t(zc),':k');
xlim(fig.xlim);
ylabel('tidal av. dx (m)');

linkaxes([h1,h2,h3,h4,h5],'x');

%% 

