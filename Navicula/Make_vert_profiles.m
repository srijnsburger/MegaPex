% make profiles for Navicula day
clc;clear all;
%close all;
%% Load data

load('d:\sabinerijnsbur\Matlab\adcp\adcp12C.mat');
adcp = adcp12C;

load('D:\sabinerijnsbur\Measurements\Measurements2014\Matlab\SBENav.mat');

save_plot = 'yes';

%% CTD Nav info
Pr.ct.time  = SBENav.starttime;
Pr.ct.z     = SBENav.z;
Pr.ct.dens  = SBENav.dens;
% Pr.ct.Ihour = [1,3,5,7,12,16,19,22,24,26,28,30]; % Indices about every hour around xx.30 
Pr.ct.Ihour = [11];
% Pr.ct.Ihour = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30]; % Indices about every hour around xx.30 
% Select times adcp during Navicula day
% tvel = adcp.time(find(adcp.time >= datenum(2014,09,17,06,30,00)&adcp.time <= datenum(2014,09,17,17,40,00)));

%% Select adcp around Navicula times

for i = 1:length(Pr.ct.time)
    
    id(i) = find(adcp.time > (Pr.ct.time(i)-(1/(24*12))) & adcp.time < (Pr.ct.time(i) +(1/(24*12))));
    
end

% adcp info
Pr.v.time  = adcp.time(id);
va         = adcp.va(:,id);
vc         = adcp.vc(:,id);
z          = adcp.z;
Pr.v.Ihour = Pr.ct.Ihour;
Pr.v.h     = adcp.h(id);

%% Make same depth profiles
% adapt adcp depths

Pr.v.zz   = -14.50:0.25:0;
Pr.v.vc   = nan(59,30);
Pr.v.va   = nan(59,30);

for i = 1:length(Pr.v.time)
    
id1 = find(isnan(vc(:,i)));
id2 = find(id1>44,1);
nb  = round((Pr.v.h(i)-z(id1(id2)-1))/0.25);
d   = [1:(id1(id2)-1+nb)];
Pr.v.vc(end-d(end)+1:end,i) = vc(d,i);
Pr.v.va(end-d(end)+1:end,i) = va(d,i);

end

%% Plot profiles

id = Pr.ct.Ihour;

for i = id
    
figure;
subplot(1,2,1)
plot(Pr.ct.dens(:,i)-1000,Pr.ct.z,'Linewidth',1)
grid on
% hline(-1.3,':k');
ylim([-13 0]);
xlim([12 24]);
set(gca,'Xtick',12:2:24);
ylabel('z (m)');
xlabel('\rho (kg/m^3)');
title(['Profile',num2str(i),' ',datestr(Pr.ct.time(i),'HH:MM')]);

subplot(1,2,2)
plot(Pr.v.va(:,i),Pr.v.zz,'b','Linewidth',1);
hold on
grid on
plot(Pr.v.vc(:,i),Pr.v.zz,'r','Linestyle','--','Linewidth',2);
% hline(-1.3,':k');
vline(0,':k');
ylim([-13 0]);
xlim([-1 1]);
set(gca,'Xtick',-1:0.5:1);
ylabel('z (m)');
xlabel('v (m/s)');
% legend('va','vc');
% legend('Orientation','horizontal');
title(['Profile',num2str(i),' ',datestr(Pr.v.time(i),'HH:MM')]);

if strcmp(save_plot,'yes')
    set(gcf, 'PaperUnits', 'centimeters');
    set(gcf, 'PaperSize', [15 10]);
    set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperPosition', [0 0 15 10]);
    set(gcf,'Renderer','opengl');
    print(gcf, '-dpng','-r2000',['d:\sabinerijnsbur\Matlab\Figures\Navicula170914\Profile',num2str(i),'.png']);
end

end

%% Plot profiles
% 
% figure;
% subplot(1,6,1)
% plot(Pr.ct.dens(:,1)-1000,Pr.ct.z,'linewidth',1)
% ylim([-13 0]);
% ylabel('z (m)');
% xlabel('\rho (kg/m^3)');
% title(['Profile',num2str(1),' ',datestr(Pr.ct.time(1),'HH:MM')]);
% 
% subplot(1,6,2)
% plot(Pr.v.va(:,1),Pr.v.zz,'linewidth',1);
% hold on
% plot(Pr.v.vc(:,1),Pr.v.zz,'linewidth',1);
% vline(0,':k');
% ylim([-13 0]);
% ylabel('z (m)');
% xlabel('v (m/s)');
% legend('va','vc');
% legend('Orientation','horizontal');
% title(['Profile',num2str(1),' ',datestr(Pr.v.time(1),'HH:MM')]);
% 
% subplot(1,6,3)
% plot(Pr.ct.dens(:,2)-1000,Pr.ct.z,'linewidth',1)
% ylim([-13 0]);
% ylabel('z (m)');
% xlabel('\rho (kg/m^3)');
% title(['Profile',num2str(2),' ',datestr(Pr.ct.time(2),'HH:MM')]);
% 
% subplot(1,6,4)
% plot(Pr.v.va(:,2),Pr.v.zz,'linewidth',1);
% hold on
% plot(Pr.v.vc(:,2),Pr.v.zz,'linewidth',1);
% vline(0,':k');
% ylim([-13 0]);
% ylabel('z (m)');
% xlabel('v (m/s)');
% legend('va','vc');
% legend('Orientation','horizontal');
% title(['Profile',num2str(2),' ',datestr(Pr.v.time(2),'HH:MM')]);
% 
% subplot(1,6,5)
% plot(Pr.ct.dens(:,3)-1000,Pr.ct.z,'linewidth',1)
% ylim([-13 0]);
% ylabel('z (m)');
% xlabel('\rho (kg/m^3)');
% title(['Profile',num2str(3),' ',datestr(Pr.ct.time(3),'HH:MM')]);
% 
% subplot(1,6,6)
% plot(Pr.v.va(:,3),Pr.v.zz,'linewidth',1);
% hold on
% plot(Pr.v.vc(:,3),Pr.v.zz,'linewidth',1);
% vline(0,':k');
% ylim([-13 0]);
% ylabel('z (m)');
% xlabel('v (m/s)');
% legend('va','vc');
% legend('Orientation','horizontal');
% title(['Profile',num2str(3),' ',datestr(Pr.v.time(3),'HH:MM')]);
% 
% if strcmp(save_plot,'yes')
%     set(gcf, 'PaperUnits', 'centimeters');
%     set(gcf, 'PaperSize', [24 10]);
%     set(gcf, 'PaperPositionMode', 'manual');
%     set(gcf, 'PaperPosition', [0 0 24 10]);
%     set(gcf,'Renderer','painters');
%     print(gcf, '-dpdf',['d:\sabinerijnsbur\Matlab\Figures\Navicula170914\Profiles1-3.pdf']);
% end
% 
% figure;
% subplot(1,6,1)
% plot(Pr.ct.dens(:,4)-1000,Pr.ct.z,'linewidth',1)
% ylim([-13 0]);
% ylabel('z (m)');
% xlabel('\rho (kg/m^3)');
% title(['Profile',num2str(4),' ',datestr(Pr.ct.time(4),'HH:MM')]);
% 
% subplot(1,6,2)
% plot(Pr.v.va(:,4),Pr.v.zz,'linewidth',1);
% hold on
% plot(Pr.v.vc(:,4),Pr.v.zz,'linewidth',1);
% vline(0,':k');
% ylim([-13 0]);
% ylabel('z (m)');
% xlabel('v (m/s)');
% legend('va','vc');
% legend('Orientation','horizontal');
% title(['Profile',num2str(4),' ',datestr(Pr.v.time(4),'HH:MM')]);
% 
% subplot(1,6,3)
% plot(Pr.ct.dens(:,5)-1000,Pr.ct.z,'linewidth',1)
% ylim([-13 0]);
% ylabel('z (m)');
% xlabel('\rho (kg/m^3)');
% title(['Profile',num2str(5),' ',datestr(Pr.ct.time(5),'HH:MM')]);
% 
% subplot(1,6,4)
% plot(Pr.v.va(:,5),Pr.v.zz,'linewidth',1);
% hold on
% plot(Pr.v.vc(:,5),Pr.v.zz,'linewidth',1);
% vline(0,':k');
% ylim([-13 0]);
% ylabel('z (m)');
% xlabel('v (m/s)');
% legend('va','vc');
% legend('Orientation','horizontal');
% title(['Profile',num2str(5),' ',datestr(Pr.v.time(5),'HH:MM')]);
% 
% subplot(1,6,5)
% plot(Pr.ct.dens(:,6)-1000,Pr.ct.z,'linewidth',1)
% ylim([-13 0]);
% ylabel('z (m)');
% xlabel('\rho (kg/m^3)');
% title(['Profile',num2str(6),' ',datestr(Pr.ct.time(6),'HH:MM')]);
% 
% subplot(1,6,6)
% plot(Pr.v.va(:,6),Pr.v.zz,'linewidth',1);
% hold on
% plot(Pr.v.vc(:,6),Pr.v.zz,'linewidth',1);
% vline(0,':k');
% ylim([-13 0]);
% ylabel('z (m)');
% xlabel('v (m/s)');
% legend('va','vc');
% legend('Orientation','horizontal');
% title(['Profile',num2str(6),' ',datestr(Pr.v.time(6),'HH:MM')]);
% 
% if strcmp(save_plot,'yes')
%     set(gcf, 'PaperUnits', 'centimeters');
%     set(gcf, 'PaperSize', [24 10]);
%     set(gcf, 'PaperPositionMode', 'manual');
%     set(gcf, 'PaperPosition', [0 0 24 10]);
%     set(gcf,'Renderer','painters');
%     print(gcf, '-dpdf',['d:\sabinerijnsbur\Matlab\Figures\Navicula170914\Profiles4-6.pdf']);
% end
% 
% figure;
% subplot(1,6,1)
% plot(Pr.ct.dens(:,7)-1000,Pr.ct.z,'linewidth',1)
% ylim([-13 0]);
% ylabel('z (m)');
% xlabel('\rho (kg/m^3)');
% title(['Profile',num2str(7),' ',datestr(Pr.ct.time(7),'HH:MM')]);
% 
% subplot(1,6,2)
% plot(Pr.v.va(:,7),Pr.v.zz,'linewidth',1);
% hold on
% plot(Pr.v.vc(:,7),Pr.v.zz,'linewidth',1);
% vline(0,':k');
% ylim([-13 0]);
% ylabel('z (m)');
% xlabel('v (m/s)');
% legend('va','vc');
% legend('Orientation','horizontal');
% title(['Profile',num2str(7),' ',datestr(Pr.v.time(7),'HH:MM')]);
% 
% subplot(1,6,3)
% plot(Pr.ct.dens(:,8)-1000,Pr.ct.z,'linewidth',1)
% ylim([-13 0]);
% ylabel('z (m)');
% xlabel('\rho (kg/m^3)');
% title(['Profile',num2str(8),' ',datestr(Pr.ct.time(8),'HH:MM')]);
% 
% subplot(1,6,4)
% plot(Pr.v.va(:,8),Pr.v.zz,'linewidth',1);
% hold on
% plot(Pr.v.vc(:,8),Pr.v.zz,'linewidth',1);
% vline(0,':k');
% ylim([-13 0]);
% ylabel('z (m)');
% xlabel('v (m/s)');
% legend('va','vc');
% legend('Orientation','horizontal');
% title(['Profile',num2str(8),' ',datestr(Pr.v.time(8),'HH:MM')]);
% 
% subplot(1,6,5)
% plot(Pr.ct.dens(:,9)-1000,Pr.ct.z,'linewidth',1)
% ylim([-13 0]);
% ylabel('z (m)');
% xlabel('\rho (kg/m^3)');
% title(['Profile',num2str(9),' ',datestr(Pr.ct.time(9),'HH:MM')]);
% 
% subplot(1,6,6)
% plot(Pr.v.va(:,9),Pr.v.zz,'linewidth',1);
% hold on
% plot(Pr.v.vc(:,9),Pr.v.zz,'linewidth',1);
% vline(0,':k');
% ylim([-13 0]);
% ylabel('z (m)');
% xlabel('v (m/s)');
% legend('va','vc');
% legend('Orientation','horizontal');
% title(['Profile',num2str(9),' ',datestr(Pr.v.time(9),'HH:MM')]);
% 
% if strcmp(save_plot,'yes')
%     set(gcf, 'PaperUnits', 'centimeters');
%     set(gcf, 'PaperSize', [24 10]);
%     set(gcf, 'PaperPositionMode', 'manual');
%     set(gcf, 'PaperPosition', [0 0 24 10]);
%     set(gcf,'Renderer','painters');
%     print(gcf, '-dpdf',['d:\sabinerijnsbur\Matlab\Figures\Navicula170914\Profiles7-9.pdf']);
% end
% 
% figure;
% subplot(1,6,1)
% plot(Pr.ct.dens(:,10)-1000,Pr.ct.z,'linewidth',1)
% ylim([-13 0]);
% ylabel('z (m)');
% xlabel('\rho (kg/m^3)');
% title(['Profile',num2str(10),' ',datestr(Pr.ct.time(10),'HH:MM')]);
% 
% subplot(1,6,2)
% plot(Pr.v.va(:,10),Pr.v.zz,'linewidth',1);
% hold on
% plot(Pr.v.vc(:,10),Pr.v.zz,'linewidth',1);
% vline(0,':k');
% ylim([-13 0]);
% ylabel('z (m)');
% xlabel('v (m/s)');
% legend('va','vc');
% legend('Orientation','horizontal');
% title(['Profile',num2str(10),' ',datestr(Pr.v.time(10),'HH:MM')]);
% 
% subplot(1,6,3)
% plot(Pr.ct.dens(:,11)-1000,Pr.ct.z,'linewidth',1)
% ylim([-13 0]);
% ylabel('z (m)');
% xlabel('\rho (kg/m^3)');
% title(['Profile',num2str(11),' ',datestr(Pr.ct.time(11),'HH:MM')]);
% 
% subplot(1,6,4)
% plot(Pr.v.va(:,11),Pr.v.zz,'linewidth',1);
% hold on
% plot(Pr.v.vc(:,11),Pr.v.zz,'linewidth',1);
% vline(0,':k');
% ylim([-13 0]);
% ylabel('z (m)');
% xlabel('v (m/s)');
% legend('va','vc');
% legend('Orientation','horizontal');
% title(['Profile',num2str(11),' ',datestr(Pr.v.time(11),'HH:MM')]);
% 
% subplot(1,6,5)
% plot(Pr.ct.dens(:,12)-1000,Pr.ct.z,'linewidth',1)
% ylim([-13 0]);
% ylabel('z (m)');
% xlabel('\rho (kg/m^3)');
% title(['Profile',num2str(12),' ',datestr(Pr.ct.time(12),'HH:MM')]);
% 
% subplot(1,6,6)
% plot(Pr.v.va(:,12),Pr.v.zz,'linewidth',1);
% hold on
% plot(Pr.v.vc(:,12),Pr.v.zz,'linewidth',1);
% vline(0,':k');
% ylim([-13 0]);
% ylabel('z (m)');
% xlabel('v (m/s)');
% legend('va','vc');
% legend('Orientation','horizontal');
% title(['Profile',num2str(12),' ',datestr(Pr.v.time(12),'HH:MM')]);
% 
% if strcmp(save_plot,'yes')
%     set(gcf, 'PaperUnits', 'centimeters');
%     set(gcf, 'PaperSize', [24 10]);
%     set(gcf, 'PaperPositionMode', 'manual');
%     set(gcf, 'PaperPosition', [0 0 24 10]);
%     set(gcf,'Renderer','painters');
%     print(gcf, '-dpdf',['d:\sabinerijnsbur\Matlab\Figures\Navicula170914\Profiles10-12.pdf']);
% end
