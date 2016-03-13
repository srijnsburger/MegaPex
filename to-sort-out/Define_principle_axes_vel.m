clc; clear all; close all

load('d:\sabinerijnsbur\Matlab\adcp\adcp12');
load('d:\sabinerijnsbur\Matlab\adcp\adcp18');
load('d:\sabinerijnsbur\Matlab\adcp\adcpMS');

dir_out = 'd:\sabinerijnsbur\Matlab\Figures\ADCP_frames\';

%% Fit 12m

C12.ve  = adcp12.east_vel';
C12.vn  = adcp12.north_vel';

% Depthmean velocities
C12.meanve = nanmean(adcp12.east_vel);
C12.meanvn = nanmean(adcp12.north_vel);
C12.meanve = C12.meanve';
C12.meanvn = C12.meanvn';
C12.fm     = fit(C12.meanve,C12.meanvn,'poly1');
C12.cm     = coeffvalues(C12.fm);
C12.am     = atand(C12.cm(1));% angle from horizontal
C12.am2    = atan2d(C12.cm(1),1);
C12.pm     = polyfit(C12.meanve,C12.meanvn,1);

% Bin 11 (4 mab)
C12.f11    = fit(C12.ve(:,11),C12.vn(:,11),'poly1');
C12.c11    = coeffvalues(C12.f11);
C12.a11    = atand(C12.c11(1));% angle from horizontal
C12.p11    = polyfit(C12.ve(:,11),C12.vn(:,11),1);

% Bin 15 (5 mab)
C12.f15    = fit(C12.ve(:,15),C12.vn(:,15),'poly1');
C12.c15    = coeffvalues(C12.f15);
C12.a15    = atand(C12.c15(1));% angle from horizontal
C12.p15    = polyfit(C12.ve(:,15),C12.vn(:,15),1);

% Bin 23 (7 mab)
C12.f23    = fit(C12.ve(:,23),C12.vn(:,23),'poly1');
C12.c23    = coeffvalues(C12.f23);
C12.a23    = atand(C12.c23(1));% angle from horizontal
C12.p23    = polyfit(C12.ve(:,23),C12.vn(:,23),1);

% Bin 29 (8.5 mab)
C12.f29    = fit(C12.ve(:,29),C12.vn(:,29),'poly1');
C12.c29    = coeffvalues(C12.f29);
C12.a29    = atand(C12.c29(1));% angle from horizontal
C12.p29    = polyfit(C12.ve(:,29),C12.vn(:,29),1);

% Bin 35 (10 mab)
C12.f35    = fit(C12.ve(:,35),C12.vn(:,35),'poly1');
C12.c35    = coeffvalues(C12.f35);
C12.a35    = atand(C12.c35(1));% angle from horizontal
C12.p35    = polyfit(C12.ve(:,35),C12.vn(:,35),1);


%% Fit 18m

C18.ve  = adcp18.east_vel';
C18.vn  = adcp18.north_vel';

% Depthmean velocities
C18.meanve = nanmean(adcp18.east_vel);
C18.meanvn = nanmean(adcp18.north_vel);
C18.meanve = C18.meanve';
C18.meanvn = C18.meanvn';
C18.fm     = fit(C18.meanve,C18.meanvn,'poly1');
C18.cm     = coeffvalues(C18.fm);
C18.am     = atand(C18.cm(1));% angle from horizontal
C18.am2    = atan2d(C18.cm(1),1);
C18.pm     = polyfit(C18.meanve,C18.meanvn,1);

% Bin 15 (5 mab)
C18.f15    = fit(C18.ve(:,15),C18.vn(:,15),'poly1');
C18.c15    = coeffvalues(C18.f15);
C18.a15    = atand(C18.c15(1));% angle from horizontal
C18.p15    = polyfit(C18.ve(:,15),C18.vn(:,15),1);

% Bin 29 (8.5 mab)
C18.f29    = fit(C18.ve(:,29),C18.vn(:,29),'poly1');
C18.c29    = coeffvalues(C18.f29);
C18.a29    = atand(C18.c29(1));% angle from horizontal
C18.p29    = polyfit(C18.ve(:,29),C18.vn(:,29),1);

% Bin 43 (12 mab)
C18.f43    = fit(C18.ve(2:end,43),C18.vn(2:end,43),'poly1');
C18.c43    = coeffvalues(C18.f43);
C18.a43    = atand(C18.c43(1));% angle from horizontal
C18.p43    = polyfit(C18.ve(2:end,43),C18.vn(2:end,43),1);

%% Plot

figure;
subplot(2,3,1)
plot(C12.fm,C12.meanve,C12.meanvn);
xlabel('East velocity');
ylabel('North velocity');
title('Depth averaged, 12m');
text(-0.1,-0.4,['Fit: ' num2str(C12.cm(1)) '.*x +' num2str(C12.cm(2))]);
text(-0.1,-0.5,['Angle from North: ' num2str(90-C12.am)]);

% subplot(2,4,2)
% plot(C12.f11,C12.ve(:,11),C12.vn(:,11),'.m')
% xlabel('East velocity');
% ylabel('North velocity');
% title('Bin 11 (4 mab), 12m');
% text(-0.1,-0.6,['Fit: ' num2str(C12.c11(1)) '.*x +' num2str(C12.c11(2))]);
% text(-0.1,-0.7,['Angle from North: ' num2str(90-C12.a11)]);

subplot(2,3,2)
plot(C12.f15,C12.ve(:,15),C12.vn(:,15),'.g')
xlabel('East velocity');
ylabel('North velocity');
title('Bin 15 (5mab), 12m');
text(-0.1,-0.6,['Fit: ' num2str(C12.c15(1)) '.*x +' num2str(C12.c15(2))]);
text(-0.1,-0.7,['Angle from North: ' num2str(90-C12.a15)]);

subplot(2,3,3)
plot(C12.f29,C12.ve(:,29),C12.vn(:,29),'.m')
xlabel('East velocity');
ylabel('North velocity');
title('Bin 29 (8.5mab), 12m');
text(-0.1,-0.6,['Fit: ' num2str(C12.c29(1)) '.*x +' num2str(C12.c29(2))]);
text(-0.1,-0.7,['Angle from North: ' num2str(90-C12.a29)]);

subplot(2,3,4)
plot(C18.fm,C18.meanve,C18.meanvn);
xlabel('East velocity');
ylabel('North velocity');
title('Depth averaged, 18m');
text(0.1,-0.4,['Fit: ' num2str(C18.cm(1)) '.*x +' num2str(C18.cm(2))]);
text(0.1,-0.5,['Angle from North: ' num2str(90-C18.am)]);

subplot(2,3,5)
plot(C18.f15,C18.ve(:,15),C18.vn(:,15),'.g')
xlabel('East velocity');
ylabel('North velocity');
title('Bin 15 (5mab), 18m');
text(0.1,-0.4,['Fit: ' num2str(C18.c15(1)) '.*x +' num2str(C18.c15(2))]);
text(0.1,-0.5,['Angle from North: ' num2str(90-C18.a15)]);

subplot(2,3,6)
plot(C18.f29,C18.ve(:,29),C18.vn(:,29),'.m')
xlabel('East velocity');
ylabel('North velocity');
title('Bin 29 (8.5mab), 18m');
text(-0.1,-0.4,['Fit: ' num2str(C18.c29(1)) '.*x +' num2str(C18.c29(2))]);
text(-0.1,-0.5,['Angle from North: ' num2str(90-C18.a29)]);

% subplot(2,3,8)
% plot(C18.f43,C18.ve(2:end,43),C18.vn(2:end,43),'.c')
% xlabel('East velocity');
% ylabel('North velocity');
% title('Bin 43 (12 mab), 18m');
% text(-0.1,-0.6,['Fit: ' num2str(C18.c43(1)) '.*x +' num2str(C18.c43(2))]);
% text(-0.10,-0.7,['Angle from North: ' num2str(90-C18.a43)]);

set(gca,'FontSize',8)
set(findall(gcf,'type','text'),'FontSize',8)
set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperSize', [30 16]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperPosition', [0 0 30 16]);
set(gcf,'Renderer','painters');
print(gcf, '-dpdf',[dir_out 'Alignment_velocities.pdf']);

print2a4([dir_out,'Alignment_velocities.png'],'v','t');
