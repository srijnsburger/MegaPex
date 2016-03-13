%% Test manual thickness plume

load('d:\sabinerijnsbur\Matlab\Moorings\Metrics_Fronts.mat');
load('d:\sabinerijnsbur\Matlab\adcp\adcp12.mat');

load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\SBE1527.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\SBE1526.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\SBE5426.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\SBE5425.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\SBE1842_corrected.mat');

load('D:\sabinerijnsbur\Measurements\Measurements2014\Matlab\SBENav.mat');
load('d:\sabinerijnsbur\Matlab\adcp\adcp12C.mat');
% adcp = adcp12C;

%% Calculate layer thickness & froude number based on adcp

% Find adcp time close to time of selected profile (profile 11)
id = find(adcp12.time > (SBENav.time(11)-(1/(24*12))) & adcp12.time < (SBENav.time(11) +(1/(24*12))));

% Find the change of velocity
H.a.ii  = find(adcp12.vc(6:end,id)<0 & adcp12.vc(6:end,id)<-0.1,1)+5;
H.a.h   = adcp12.h(id)-adcp12.z(H.a.ii); % layer thickness based on velocity
H.a.Uf  = nanmean(adcp12.vc(H.a.ii:end,id));
H.a.time= adcp12.time(id);

% reduced gravity
if H.a.h>=3
    rho1 = (SBE1527.dens10(id)+SBE1526.dens10(id))/2;
    rho2 = (SBE5426.dens10(id)+SBE5425.dens10(id)+SBE1842.dens10(id))/3;
else
    rho1 = SBE1527.dens10(id);
    rho2 = (SBE1526.dens10(id)+SBE5426.dens10(id)+SBE5425.dens10(id)+SBE1842.dens10(id))/4;
end

H.a.rg = 9.81*(rho2-rho1)/rho2;

% Froude number
H.a.Fr = abs(H.a.Uf)./sqrt(H.a.rg.*H.a.h);

%% Manual layer thickness & froude number

H.m.h    = 1.3; % based on profile data for profile 11.
hh       = adcp12.h(id)-H.m.h;
H.m.ii   = find(adcp12.z < (hh + 0.2) & adcp12.z > (hh - 0.2));% gives position in vertical velocity profile
H.m.Uf   = nanmean(adcp12.vc(H.m.ii:end,id));
H.m.time = SBENav.time(11);

%reduced gravity Way 1: use density of profiles
I      = find(abs(SBENav.z)<= H.m.h,1);
rho1   = nanmean(SBENav.dens(I:end));
rho2   = nanmean(SBENav.dens(1:I-1));
H.m.rg = 9.81*(rho2-rho1)/rho2;

% reduced gravity Way 2: use mooring data
if H.m.h>=3
    rho1 = (SBE1527.dens10(id)+SBE1526.dens10(id))/2;
    rho2 = (SBE5426.dens10(id)+SBE5425.dens10(id)+SBE1842.dens10(id))/3;
else
    rho1 = SBE1527.dens10(id);
    rho2 = (SBE1526.dens10(id)+SBE5426.dens10(id)+SBE5425.dens10(id)+SBE1842.dens10(id))/4;
end
H.m.rg2 = 9.81*(rho2-rho1)/rho2;

% Froude number
H.m.Fr  = abs(H.m.Uf)./sqrt(H.m.rg.*H.m.h);
H.m.Fr2 = abs(H.m.Uf)./sqrt(H.m.rg2.*H.m.h);

%% Compare calculations

figure;
h1 = subplot(3,1,1);
plot(H.m.time,H.m.h,'.','Markersize',8);
hold on
grid on
plot(H.m.time,H.a.h,'*r');
datetick('x','dd/mm HH:MM','keepticks');
xlim([datenum(2014,09,17,00,000,00) datenum(2014,09,18,00,00,00)]);
legend('manual','adcp');
ylabel('h (m)');
title('Comparison thickness front');

h2 = subplot(3,1,2);
plot(H.m.time,abs(H.m.Uf),'.','Markersize',8);
hold on
grid on
plot(H.m.time,abs(H.a.Uf),'*r');
datetick('x','dd/mm HH:MM','keepticks');
xlim([datenum(2014,09,17,00,000,00) datenum(2014,09,18,00,00,00)]);
legend('manual','adcp');
ylabel('abs Uf (m/s)');
title('Comparison frontal speed');

h3 = subplot(3,1,3);
plot(H.m.time,H.m.Fr,'.','Markersize',8);
hold on
grid on
plot(H.m.time,H.m.Fr2,'xk');
plot(H.m.time,H.a.Fr,'*r');
datetick('x','dd/mm HH:MM','keepticks');
xlim([datenum(2014,09,17,00,000,00) datenum(2014,09,18,00,00,00)]);
legend('manual','manual2','adcp');
ylabel('Fr');
title('Comparison Froude number');

linkaxes([h1,h2,h3],'x');
set(gcf,'Color','w');




