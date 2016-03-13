clc; clear all; close all;

% Check alignment coast

load('d:\sabinerijnsbur\Matlab\adcp\adcp12');
load('d:\sabinerijnsbur\Matlab\adcp\adcp18');
load('d:\sabinerijnsbur\Matlab\adcp\adcpMS');

x = -1.5:0.5:1.5;
y = x;

% x1 = adcp12.east_vel';
% x1 = x1(:,20);
% y1 = adcp12.north_vel';
% y1 = y1(:,20);
% % a = find(isnan(x1));
% % y1 = adcp12.north_vel(1,:);
% % f12 = polyfit(x1,y1,1);
% f12 = fit(x1,y1,'poly1');
% plot(f12,x1,y1);

%% Fit 12m

% lineaire interpolation to fill NaNs
n = length(adcp12.east_vel);
[out12.ve] = Interpolation_general(adcp12.east_vel(1:37,:),n);
[out12.vn] = Interpolation_general(adcp12.north_vel(1:37,:),n);
p12 = polyfit(out12.ve,out12.vn,1);
yfit12 = polyval(p12,out12.ve);
alpha12  = atand(p12(1));

figure;
plot(out12.ve,out12.vn,'.b');
hold on
plot(out12.ve,yfit12)
text(0.9,-0.8,['alpha = ' num2str(alpha12)]);


%% Fit 18m

% lineaire interpolation to fill NaNs
n = length(adcp18.east_vel);
[out18.ve] = Interpolation_general(adcp18.east_vel(1:59,2:end),n-1);
[out18.vn] = Interpolation_general(adcp18.north_vel(1:59,2:end),n-1);
p18      = polyfit(out18.ve,out18.vn,1);
yfit18   = polyval(p18,out18.ve);
alpha18  = atand(p18(1));

figure;
plot(out18.ve,out18.vn,'.b');
hold on
plot(out18.ve,yfit18)
legend(['Data points']);
text(0.9,-0.8,['alpha = ' num2str(alpha18)]);

%% Fit MS
% 
% % lineaire interpolation to fill NaNs
% n = length(adcpMS.east_vel);
% [outMS.ve] = Interpolation_general(adcpMS.east_vel(1:28,:),n-1);
% [outMS.vn] = Interpolation_general(adcpMS.north_vel(1:28,:),n-1);
% pMS      = polyfit(outMS.ve,outMS.vn,1);
% yfitMS   = polyval(pMS,outMS.ve);
% alphaMS  = atand(pMS(1));
% 
% figure;
% plot(outMS.ve,outMS.vn,'.b');
% hold on
% plot(outMS.ve,yfitMS)
% legend(['Data points']);
% text(0.9,-0.8,['alpha = ' num2str(alphaMS)]);

%% Find angle principle axis 12m

%conquatenate
% n     = size(adcp12.east_vel,1);
% m     = size(adcp12.east_vel,2);
% devve = nan(n,m);

sigUt=[]; sigVt=[];
for i = 1:size(adcp12.east_vel,1)
% devve(:,i)  = adcp12.east_vel(:,i)  - meanve(i);
devve(i,:) = adcp12.east_vel(i,:) - nanmean(adcp12.east_vel(i,:));
% devvn(:,i)  = adcp12.north_vel(:,i) - meanvn(i);
devvn(i,:) = adcp12.north_vel(i,:) - nanmean(adcp12.north_vel(i,:));
sigUt = [sigUt,adcp12.east_vel(i,:)]; % all velocities in one signal
sigVt = [sigVt,adcp12.north_vel(i,:)];
end

% theta calculated for each bin
par   = nanmean(2.*devve.*devvn,2)./(nanmean(devve.^2,2)-nanmean(devvn.^2,2));
% theta = 0.5*atand(par);
theta2 = 0.5*atan2d(nanmean(2.*devve.*devvn,2),(nanmean(devvn.^2,2)-nanmean(devve.^2,2)));% angle x-axis counterclockwise is positive

% theta calculated based on all velocities
parT   = nanmean(2.*sigUt.*sigVt,2)./(nanmean(sigUt.^2,2)-nanmean(sigVt.^2,2));
thetaT = 0.5*atan2d(nanmean(2.*sigUt.*sigVt,2),(nanmean(sigUt.^2,2)-nanmean(sigVt.^2,2)));% angle x-axis counterclockwise is positive
% thetaT2 = 0.5.*atand(parT);

theta3 = nanmean(theta2);

%% Plot figure

figure;
plot(adcp12.east_vel,adcp12.north_vel,'.b');
hold on
% plot(x,y,'k');
axis([-1.5 1.5 -1.5 1.5]);

figure;
plot(adcp18.east_vel,adcp18.north_vel,'.r');
hold on
% plot(x,y,'k');
axis([-1.5 1.5 -1.5 1.5]);

figure;
plot(adcpMS.east_vel,adcpMS.north_vel,'.m');
hold on
% plot(x,y,'k');
axis([-1.5 1.5 -1.5 1.5]);

% close all

%% Find angle principle axis 18m

%conquatenate
% n     = size(adcp12.east_vel,1);
% m     = size(adcp12.east_vel,2);
% devve = nan(n,m);

sigUt18=[]; sigVt18=[];
for i = 1:size(adcp18.east_vel,1)
% devve(:,i)  = adcp12.east_vel(:,i)  - meanve(i);
devve(i,:) = adcp18.east_vel(i,:) - nanmean(adcp18.east_vel(i,:));
% devvn(:,i)  = adcp12.north_vel(:,i) - meanvn(i);
devvn(i,:) = adcp18.north_vel(i,:) - nanmean(adcp18.north_vel(i,:));
sigUt18 = [sigUt18,adcp18.east_vel(i,:)]; % all velocities in one signal
sigVt18 = [sigVt18,adcp18.north_vel(i,:)];
end

% theta calculated for each bin
par   = nanmean(2.*devve.*devvn,2)./(nanmean(devve.^2,2)-nanmean(devvn.^2,2));
% theta = 0.5*atand(par);
theta2 = 0.5*atan2d(nanmean(2.*devve.*devvn,2),(nanmean(devvn.^2,2)-nanmean(devve.^2,2)));% angle x-axis counterclockwise is positive

% theta calculated based on all velocities
parT   = nanmean(2.*sigUt18.*sigVt18,2)./(nanmean(sigUt18.^2,2)-nanmean(sigVt18.^2,2));
thetaT = 0.5*atan2d(nanmean(2.*sigUt18.*sigVt18,2),(nanmean(sigUt18.^2,2)-nanmean(sigVt18.^2,2)));% angle x-axis counterclockwise is positive
% thetaT2 = 0.5.*atand(parT);

theta3 = nanmean(theta2);

