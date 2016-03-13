%% Calculate PEA 
clc;clear all;close all;

% 12m 
load('d:\sabinerijnsbur\Matlab_files\Megapex_data\Moorings\Mfiles_adcp\Mooring12_adcp_corr.mat');
load('d:\sabinerijnsbur\Matlab_files\Megapex_data\adcp\adcp12');
load('d:\sabinerijnsbur\Matlab_files\Megapex_data\Moorings\Parameters12.mat');

% convert depths
P   = M12.P*-1;
eta = adcp12.h - nanmean(adcp12.h);

for j = 1:size(M12.D,1)
for i = 1:size(M12.D,2)
   depth(j,i) = P(j,i)-eta(i);
end
end

% Calculate PEA
for i = 1:size(M12.D,2)
    rho1     = M12.D(:,i);
    depth1   = depth(:,i);
    mask1    = ~isnan(rho1);
    rho2     = rho1(mask1);
    depth2   = depth1(mask1);
    if isempty(rho2)
    elseif numel(rho2)==1
    else
%         PEA12(i)  = pea_simpson_et_al_1990(depth2(1:1:end)',rho2(1:1:end)');% calculates integral more discreetly
        P12.phi(i) = pea_simpson_et_al_1990_adapted(depth2(1:1:end)',rho2(1:1:end)'); %calculates integral more  analytical
    end
end

clear rho1 rho2 depth1 depth2 mask1
save('d:\sabinerijnsbur\Matlab_files\Megapex_data\Moorings\Parameters12','-append','P12');
%% 18m

load('d:\sabinerijnsbur\Matlab_files\Megapex_data\Moorings\Mfiles_adcp\Mooring18_adcp_corr.mat');
load('d:\sabinerijnsbur\Matlab_files\Megapex_data\adcp\adcp18');
load('d:\sabinerijnsbur\Matlab_files\Megapex_data\Moorings\Parameters18.mat');

P   = M18.P*-1;
eta = adcp18.h - nanmean(adcp18.h);

for j = 1:size(M18.D,1)
for i = 1:size(M18.D,2)
   depth(j,i) = P(j,i)-eta(i);
end
end

% Calculate PEA
for i = 1:size(M18.D,2)
    rho1     = M18.D(:,i);
    depth1   = depth(:,i);
    mask1    = ~isnan(rho1);
    rho2     = rho1(mask1);
    depth2   = depth1(mask1);
    if isempty(rho2)
    elseif numel(rho2)==1
    else
        %         R.PEA(i) = pea_simpson_et_al_1990(depth2(end:-1:1)',rho2(end:-1:1)');
%         PEA18(i)  = pea_simpson_et_al_1990(depth2(1:1:end)',rho2(1:1:end)');
        P18.phi(i) = pea_simpson_et_al_1990_adapted(depth2(1:1:end)',rho2(1:1:end)'); %calculates integral more  analytical
    end
end

save('d:\sabinerijnsbur\Matlab_files\Megapex_data\Moorings\Parameters18','-append','P18');

%% Check with Navicula data

load('d:\sabinerijnsbur\Matlab_files\Navicula_data_2014\SBENav.mat');

figure;
plot(SBENav.t,SBENav.PEA)
hold on
plot(M12.t(103:179),P12.phi(103:179));
plot(M18.t(95:173),P18.phi(95:173));
% titel('18m');
ylabel('PEA (J/m^3)');
legend('Profile data','Mooring 12m','Mooring 18m');


%% Calculate ssh 
load('d:\sabinerijnsbur\Matlab_files\Megapex_data\adcp\adcp12.mat');
load('d:\sabinerijnsbur\Matlab_files\Megapex_data\adcp\adcp18.mat');

ssh12     = adcp12.h-mean(adcp12.h);
np1_12    = find(adcp12.t>=adcp12.t(1) & adcp12.t<266);
spr1_12   = find(adcp12.t>266 & adcp12.t<273);
np2_12    = find(adcp12.t>273 & adcp12.t<280);
spr2_12     = find(adcp12.t>280 & adcp12.t<287);
np3_12    = find(adcp12.t>287 & adcp12.t<294);

ssh18     = adcp18.h-mean(adcp18.h);
np1_18   = find(adcp18.t>=adcp18.t(1) & adcp18.t<266);
spr1_18    = find(adcp18.t>266 & adcp18.t<273);
np2_18   = find(adcp18.t>273 & adcp18.t<280);
spr2_18    = find(adcp18.t>280 & adcp18.t<287);
% neap3   = find(adcp18.t>287 & adcp18.t<294);

%% Plot 12m

fhandle = figure;
h1 = subplot(3,1,1);
plot(adcp12.t(np1_12 ),ssh12(np1_12 ),'r');
hold on
plot(adcp12.t(spr1_12 ),ssh12(spr1_12 ),'b');
plot(adcp12.t(np2_12 ),ssh12(np2_12 ),'r');
plot(adcp12.t(spr2_12 ),ssh12(spr2_12 ),'b');
hline(0,'k');
ylabel('\eta (m)');
title('12m');

h2 = subplot(3,1,2);
plot(M12.t,M12.D(1,:));
hold on
plot(M12.t,M12.D(2,:));
plot(M12.t,M12.D(3,:));
plot(M12.t,M12.D(4,:));
plot(M12.t,M12.D(5,:));
ylabel('\rho (kg/m^3)');

h3 = subplot(3,1,3);
plot(M12.t,P12.phi);
% hold on
% plot(M12.t,Phi12a);
hline(0,'k');
ylabel('\phi (J/m^3)');

linkaxes([h1,h2,h3],'x');

%% Plot 18m

figure;
h4 = subplot(3,1,1);
plot(adcp18.t(np1_18),ssh18(np1_18),'r');
hold on
plot(adcp18.t(spr1_18),ssh18(spr1_18),'b');
plot(adcp18.t(np2_18),ssh18(np2_18),'r');
plot(adcp18.t(spr2_18),ssh18(spr2_18),'b');
hline(0,'k');
ylabel('\eta (m)');
title('18m');

h5 = subplot(3,1,2);
plot(M18.t,M18.D(1,:));
hold on
plot(M18.t,M18.D(2,:));
plot(M18.t,M18.D(3,:));
plot(M18.t,M18.D(4,:));
ylabel('\rho (kg/m^3)');

h6 = subplot(3,1,3);
plot(M18.t,P18.phi);
hold on
% plot(M18.t,PEA18a);
hline(0,'k');
ylabel('\phi (J/m^3)');

linkaxes([h4,h5,h6],'x');


