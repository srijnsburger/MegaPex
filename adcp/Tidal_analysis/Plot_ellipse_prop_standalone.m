% Plot ellipse properties
clc;clear all;close all;

Loc = '18';

%% Load data

eval(['load(''D:\sabinerijnsbur\Matlab\adcp\Tidal_analysis\TC' Loc ''');']);
eval(['load(''D:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\Mooring' Loc '_adcp_corr.mat'');']);

if find(strcmp(Loc,'12')==1)
    load('D:\sabinerijnsbur\Matlab\adcp\adcp12C');
    adcp = adcp12C;
else
   eval(['load(''D:\sabinerijnsbur\Matlab\adcp\adcp' Loc ''');']);
   eval(['adcp = adcp' Loc ''';']);
end

eval(['TC = TC' Loc ''';']);
eval(['M = M' Loc ''';']);

%% Input figure

ellip = TC.M2minor./TC.M2major;
cwbr  = colormapbluewhitered;
fig.ylim = [0 20];
fig.zlim = [-20 0];
fig.xlim = [260 281];
fig.plim = [-180 180];
fig.ptick= [-180:90:180];
fig.ilim = [0 180];
fig.itick= [0:45:180];


close;

%% Change phases

% M2phase = nan(length(adcp.z),length(adcp.t));
M2incl  = TC.M2incl;
M2phase = TC.M2phase;

% Fix with +/- pi
% for i = 1:length(adcp.t)
%     mask = find(M2incl(:,i)>165);
%     M2incl(mask,i)  = M2incl(mask,i)-180;
%     M2phase(mask,i) = M2phase(mask,i)+180;
% end 

% for i = 1:length(adcp.t)
%     for j = 1:length(adcp.z)
%         if M2incl(j+1,i) > M2incl(j,i)+165
%             
%             
%         end
%     end
% end

% for i = 1:length(adcp.t)
%     for j = 1:length(adcp.z)
%         if M2incl(j,i) > 170
%             M2incl(j,i) = M2incl(j,i)-180;
%             if M2phase(j,i) > 315
%                 M2phase(j,i) = M2phase(j,i)-360;
%             end
%             M2phase(j,i) = M2phase(j,i)+180;
%         end
%     end
% end

% phase = M2phase.*(pi/180);
% incl  = M2incl.*(pi/180);
% 
% for i = 1:length(adcp.t)
%    M2phase(:,i) = unwrap(phase(:,i)); 
%    M2incl(:,i)  = unwrap(incl(:,i));
% end
% 
% M2phase = M2phase.*(180/pi);
% M2incl  = M2incl.*(180/pi);
% 
% % M2phase = M2phase.*(180/pi);
% % M2incl  = M2incl.*(180/pi);
% 
for i = 1:length(adcp.t)
    for j = 1:length(adcp.z)
        if M2phase(j,i) > 180
            M2phase(j,i) = M2phase(j,i)-360;
        else 
            M2phase(j,i) = M2phase(j,i);
        end
    end
end

%% Remove first layer Phase

% 
for i = 1:numel(adcp.t)
    if isempty(find(~isnan(M2phase(:,i))==1))==1;
        I(i) = NaN;
    else
        I(i) = find(~isnan(M2phase(:,i))==1,1,'Last');
        M2phase(I(i),i) = NaN; % something going totally wrong!!
        M2incl(I(i),i) = NaN;
    end
end


%% Figure

figure;
h1 = subplot(5,1,1);
plot(M.t,M.D-1000);
ylim([14 24]);
xlim(fig.xlim);
colorbar;
ylabel('rel. \rho');

h2 = subplot(5,1,2);
pcolorcorcen(adcp.t,adcp.z,adcp.va);
hold on
plot(adcp.t,adcp.h,'k');
ylim(fig.ylim);
xlim(fig.xlim);
colormap(cwbr);
cb1 = colorbar;
title(cb1,'va (m/s)');
clim([-1 1]);

h3 = subplot(5,1,3);
pcolorcorcen(adcp.t,adcp.z,adcp.vc);
hold on
plot(adcp.t,adcp.h,'k');
ylim(fig.ylim);
xlim(fig.xlim);
colormap(cwbr);
cb2 = colorbar;
clim([-0.5 0.5]);
title(cb2,'vc (m/s)');

h4 = subplot(5,1,4);
pcolorcorcen(TC.t',adcp.z,M2incl);
hold on
plot(adcp.t,adcp.h,'k');
colormap(cwbr);
cb2 = colorbar;
title(cb2,'Incl');
xlim(fig.ylim);
ylim(fig.zlim);
clim([0 180]);
set(cb2,'YTick',0:45:180);

h5 = subplot(5,1,5);
pcolorcorcen(adcp.t(TC.times),adcp.z,M2phase);
hold on 
plot(adcp.t,adcp.h,'k');
colormap(cwbr);
cb3 = colorbar;
title(cb3,'Phase');
xlim(fig.xlim);
ylim(fig.ylim);
clim(fig.plim);
set(cb3,'YTick',fig.ptick);

linkaxes([h1 h2 h3 h4 h5],'x');

%% Profiles

if strcmp(Loc,'12')==1
% Load Navicula
load('d:\sabinerijnsbur\Matlab\Matlab-MegaPex2014-chaos\SBENav');
ID = [2,8,13,18,24,29]; % indices profiles

% mooring data
id = [118 132 139 147 161 175]; % indices profiles

figure;
h1 = subplot(4,6,1);
plot(M.D(:,id(1))-1000,-1*M.P(:,id(1)),'Marker','.','Markersize',10);
grid on
hold on 
plot(SBENav.dens(:,ID(1))-1000,SBENav.z);
xlim([15 22]);
ylim(fig.zlim);
xlabel('rel. \rho');

h2 = subplot(4,6,2);
plot(M.D(:,id(2))-1000,-1*M.P(:,id(2)),'Marker','.','Markersize',10);
grid on
hold on 
plot(SBENav.dens(:,ID(2))-1000,SBENav.z);
xlim([15 22]);
ylim(fig.zlim);
xlabel('rel. \rho');

h3 = subplot(4,6,3);
plot(M.D(:,id(3))-1000,-1*M.P(:,id(3)),'Marker','.','Markersize',10);
grid on
hold on 
plot(SBENav.dens(:,ID(3))-1000,SBENav.z);
xlim([15 22]);
ylim(fig.zlim);
xlabel('rel. \rho');

h4 = subplot(4,6,4);
plot(M.D(:,id(4))-1000,-1*M.P(:,id(4)),'Marker','.','Markersize',10);
grid on
hold on 
plot(SBENav.dens(:,ID(4))-1000,SBENav.z);
xlim([15 22]);
ylim(fig.zlim);
xlabel('rel. \rho');

h5 = subplot(4,6,5);
plot(M.D(:,id(5))-1000,-1*M.P(:,id(5)),'Marker','.','Markersize',10);
grid on
hold on 
plot(SBENav.dens(:,ID(5))-1000,SBENav.z);
xlim([15 22]);
ylim(fig.zlim);
xlabel('rel. \rho');

h6 = subplot(4,6,6);
plot(M.D(:,id(6))-1000,-1*M.P(:,id(6)),'Marker','.','Markersize',10);
grid on
hold on 
plot(SBENav.dens(:,ID(6))-1000,SBENav.z);
xlim([15 22]);
ylim(fig.zlim);
xlabel('rel. \rho');

h7 = subplot(4,6,7);
plot(adcp.va(:,id(1)),adcp.z-12);
hold on
grid on
plot(adcp.vc(:,id(1)),adcp.z-12);
plot(zeros(1,59),adcp.z,':k');
xlim([-1 1]);
ylim(fig.zlim);
xlabel('vel (m/s)');

h8 = subplot(4,6,8);
plot(adcp.va(:,id(2)),adcp.z-12);
hold on
grid on
plot(adcp.vc(:,id(2)),adcp.z-12);
plot(zeros(1,59),adcp.z,':k');
xlim([-1 1]);
ylim(fig.zlim);
xlabel('vel (m/s)');

h9 = subplot(4,6,9);
plot(adcp.va(:,id(3)),adcp.z-12);
hold on
grid on
plot(adcp.vc(:,id(3)),adcp.z-12);
plot(zeros(1,59),adcp.z,':k');
xlim([-1 1]);
ylim(fig.zlim);
xlabel('vel (m/s)');

h10 = subplot(4,6,10);
plot(adcp.va(:,id(4)),adcp.z-12);
hold on
grid on
plot(adcp.vc(:,id(4)),adcp.z-12);
plot(zeros(1,59),adcp.z,':k');
xlim([-1 1]);
ylim(fig.zlim);
xlabel('vel (m/s)');

h11 = subplot(4,6,11);
plot(adcp.va(:,id(5)),adcp.z-12);
hold on
grid on
plot(adcp.vc(:,id(5)),adcp.z-12);
plot(zeros(1,59),adcp.z,':k');
xlim([-1 1]);
xlabel('vel (m/s)');
ylim(fig.zlim);

h12 = subplot(4,6,12);
plot(adcp.va(:,id(6)),adcp.z-12);
hold on
grid on
plot(adcp.vc(:,id(6)),adcp.z-12);
plot(zeros(1,59),adcp.z,':k');
xlim([-1 1]);
ylim(fig.zlim);
xlabel('vel (m/s)');

h13 = subplot(4,6,13);
plot(M2phase(:,id(1)),adcp.z-12);
grid on
xlim(fig.plim);
ylim(fig.zlim);
set(gca,'XTick',fig.ptick);
xlabel('phase (\circ)');

h14 = subplot(4,6,14);
plot(M2phase(:,id(2)),adcp.z-12);
grid on
xlim(fig.plim);
ylim([-12 0]);
set(gca,'XTick',fig.ptick);
xlabel('phase (\circ)');

h15 = subplot(4,6,15);
plot(M2phase(:,id(3)),adcp.z-12);
grid on
xlim(fig.plim);
ylim(fig.zlim);
set(gca,'XTick',fig.ptick);
xlabel('phase (\circ)');

h16 = subplot(4,6,16);
plot(M2phase(:,id(4)),adcp.z-12);
grid on
xlim(fig.plim);
ylim(fig.zlim);
set(gca,'XTick',fig.ptick);
xlabel('phase (\circ)');

h17 = subplot(4,6,17);
plot(M2phase(:,id(5)),adcp.z-12);
grid on
xlim(fig.plim);
ylim(fig.zlim);
set(gca,'XTick',fig.ptick);
xlabel('phase (\circ)');

h18 = subplot(4,6,18);
plot(M2phase(:,id(6)),adcp.z-12);
grid on
xlim(fig.plim);
ylim(fig.zlim);
set(gca,'XTick',fig.ptick);
xlabel('phase (\circ)');

h19 = subplot(4,6,19);
plot(M2incl(:,id(1)),adcp.z-12);
grid on
ylim(fig.zlim);
xlabel('incl (\circ)');

h20 = subplot(4,6,20);
plot(M2incl(:,id(2)),adcp.z-12);
grid on
ylim(fig.zlim);
xlabel('incl (\circ)');

h21= subplot(4,6,21);
plot(M2incl(:,id(3)),adcp.z-12);
grid on
ylim(fig.zlim);
xlabel('incl (\circ)');

h22 = subplot(4,6,22);
plot(M2incl(:,id(4)),adcp.z-12);
grid on
ylim(fig.zlim);
xlabel('incl (\circ)');

h23 = subplot(4,6,23);
plot(M2incl(:,id(5)),adcp.z-12);
grid on
ylim(fig.zlim);
xlabel('incl (\circ)');

h24 = subplot(4,6,24);
plot(M2incl(:,id(6)),adcp.z-12);
grid on
ylim(fig.zlim);
xlabel('incl (\circ)');

end




%% Load Navicula

if strcmp(Loc,'12')
load('d:\sabinerijnsbur\Matlab\Matlab-MegaPex2014-chaos\SBENav');
ID = [2,8,13,18,24,29];

id = [118 132 139 147 161 175];

figure;
h1 = subplot(3,6,1);
plot(M.D(:,id(1))-1000,-1*M.P(:,id(1)),'Marker','.','Markersize',10);
grid on
hold on 
plot(SBENav.dens(:,ID(1))-1000,SBENav.z);
xlim([15 22]);
ylim(fig.zlim);
xlabel('rel. \rho (kg/m^3)');

h2 = subplot(3,6,2);
plot(M.D(:,id(2))-1000,-1*M.P(:,id(2)),'Marker','.','Markersize',10);
grid on
hold on 
plot(SBENav.dens(:,ID(2))-1000,SBENav.z);
xlim([15 22]);
ylim(fig.zlim);
xlabel('rel. \rho (kg/m^3)');

h3 = subplot(3,6,3);
plot(M.D(:,id(3))-1000,-1*M.P(:,id(3)),'Marker','.','Markersize',10);
grid on
hold on 
plot(SBENav.dens(:,ID(3))-1000,SBENav.z);
xlim([15 22]);
ylim(fig.zlim);
xlabel('rel. \rho (kg/m^3)');

h4 = subplot(3,6,4);
plot(M.D(:,id(4))-1000,-1*M.P(:,id(4)),'Marker','.','Markersize',10);
grid on
hold on 
plot(SBENav.dens(:,ID(4))-1000,SBENav.z);
xlim([15 22]);
ylim(fig.zlim);
xlabel('rel. \rho (kg/m^3)');

h5 = subplot(3,6,5);
plot(M.D(:,id(5))-1000,-1*M.P(:,id(5)),'Marker','.','Markersize',10);
grid on
hold on 
plot(SBENav.dens(:,ID(5))-1000,SBENav.z);
xlim([15 22]);
ylim(fig.zlim);
xlabel('rel. \rho (kg/m^3)');

h6 = subplot(3,6,6);
plot(M.D(:,id(6))-1000,-1*M.P(:,id(6)),'Marker','.','Markersize',10);
grid on
hold on 
plot(SBENav.dens(:,ID(6))-1000,SBENav.z);
xlim([15 22]);
ylim(fig.zlim);
xlabel('rel. \rho (kg/m^3)');

h7 = subplot(3,6,7);
plot(adcp.va(:,id(1)),adcp.z-12);
hold on
grid on
plot(adcp.vc(:,id(1)),adcp.z-12);
plot(zeros(1,59),adcp.z,':k');
xlim([-1 1]);
ylim(fig.zlim);
xlabel('vel (m/s)');
plot([-0.9 -0.7],[-1 -1],'-b');
text(-0.65,-1,'va');
plot([-0.9 -0.7],[-2.5 -2.5],'-r');
text(-0.65,-2.5,'vc');

h8 = subplot(3,6,8);
plot(adcp.va(:,id(2)),adcp.z-12);
hold on
grid on
plot(adcp.vc(:,id(2)),adcp.z-12);
plot(zeros(1,59),adcp.z,':k');
xlim([-1 1]);
ylim(fig.zlim);
xlabel('vel (m/s)');

h9 = subplot(3,6,9);
plot(adcp.va(:,id(3)),adcp.z-12);
hold on
grid on
plot(adcp.vc(:,id(3)),adcp.z-12);
plot(zeros(1,59),adcp.z,':k');
xlim([-1 1]);
ylim(fig.zlim);
xlabel('vel (m/s)');

h10 = subplot(3,6,10);
plot(adcp.va(:,id(4)),adcp.z-12);
hold on
grid on
plot(adcp.vc(:,id(4)),adcp.z-12);
plot(zeros(1,59),adcp.z,':k');
xlim([-1 1]);
ylim(fig.zlim);
xlabel('vel (m/s)');

h11 = subplot(3,6,11);
plot(adcp.va(:,id(5)),adcp.z-12);
hold on
grid on
plot(adcp.vc(:,id(5)),adcp.z-12);
plot(zeros(1,59),adcp.z,':k');
xlim([-1 1]);
ylim(fig.zlim);
xlabel('vel (m/s)');

h12 = subplot(3,6,12);
plot(adcp.va(:,id(6)),adcp.z-12);
hold on
grid on
plot(adcp.vc(:,id(6)),adcp.z-12);
plot(zeros(1,59),adcp.z,':k');
xlim([-1 1]);
ylim(fig.zlim);
xlabel('vel (m/s)');

h13 = subplot(3,6,13);
plot(M2phase(:,id(1))-M2phase(I(id(1))-2,id(1)),adcp.z-12);
grid on
% xlim([-100 0]);
ylim(fig.zlim);
% set(gca,'XTick',0:90:360);
xlabel('Phase(z)-Phase_s');

h14 = subplot(3,6,14);
plot(M2phase(:,id(2))-M2phase(I(id(2))-2,id(2)),adcp.z-12);
grid on
% xlim([-100 0]);
ylim(fig.zlim);
% set(gca,'XTick',0:90:360);
xlabel('Phase(z)-Phase_s');

h15 = subplot(3,6,15);
plot(M2phase(:,id(3))-M2phase(I(id(3))-2,id(3)),adcp.z-12);
grid on
% xlim([-100 0]);
ylim(fig.zlim);
% set(gca,'XTick',0:90:360);
xlabel('Phase(z)-Phase_s');

h16 = subplot(3,6,16);
plot(M2phase(:,id(4))-M2phase(I(id(4))-2,id(4)),adcp.z-12);
grid on
% xlim([-100 0]);
ylim(fig.zlim);
% set(gca,'XTick',0:90:360);
xlabel('Phase(z)-Phase_s');

h17 = subplot(3,6,17);
plot(M2phase(:,id(5))-M2phase(I(id(5))-2,id(5)),adcp.z-12);
grid on
% xlim([-100 0]);
ylim(fig.zlim);
% set(gca,'XTick',-40:90:360);
xlabel('Phase(z)-Phase_s');

h18 = subplot(3,6,18);
plot(M2phase(:,id(6))-M2phase(I(id(6))-2,id(6)),adcp.z-12);
grid on
hold on
% xlim([-100 0]);
ylim(fig.zlim);
% set(gca,'XTick',-40:90:360);
xlabel('Phase(z)-Phase_s');

end
%% Plot major, minor axis

id = [118 132 139 147 161 175];

figure;
subplot(4,4,1)
plot(TC.M2major(:,id(1)), adcp.z);
grid on
ylim([0 18]);
xlim([0 0.8]);
xlabel('Major');

subplot(4,4,2)
plot(TC.M2major(:,id(2)), adcp.z);
grid on
ylim([0 18]);
xlim([0 0.8]);
xlabel('Major');

subplot(4,4,3)
plot(TC.M2major(:,id(3)), adcp.z);
grid on
ylim([0 18]);
xlim([0 0.8]);
xlabel('Major');

subplot(4,4,4)
plot(TC.M2major(:,id(4)), adcp.z);
grid on
ylim([0 18]);
xlim([0 0.8]);
xlabel('Major');

subplot(4,4,5)
plot(TC.M2minor(:,id(1)), adcp.z);
grid on
ylim([0 18]);
xlim([-0.3 0.2]);
xlabel('Minor');

subplot(4,4,6)
plot(TC.M2minor(:,id(2)), adcp.z);
grid on
ylim([0 18]);
xlim([-0.3 0.2]);
xlabel('Minor');

subplot(4,4,7)
plot(TC.M2minor(:,id(3)), adcp.z);
grid on
ylim([0 18]);
xlim([-0.3 0.2]);
xlabel('Minor');

subplot(4,4,8)
plot(TC.M2minor(:,id(4)), adcp.z);
grid on
ylim([0 18]);
xlim([-0.3 0.2]);
xlabel('Minor');

subplot(4,4,9)
plot(M2phase(:,id(1)), adcp.z);
grid on
ylim([0 18]);
xlim(fig.plim);
set(gca,'XTick',fig.ptick);
xlabel('Phase');

subplot(4,4,10)
plot(M2phase(:,id(2)), adcp.z);
grid on
ylim([0 18]);
xlim(fig.plim);
set(gca,'XTick',fig.ptick);
xlabel('Phase');

subplot(4,4,11)
plot(M2phase(:,id(3)), adcp.z);
grid on
ylim([0 18]);
xlim(fig.plim);
set(gca,'XTick',fig.ptick);
xlabel('Phase');

subplot(4,4,12)
plot(M2phase(:,id(4)), adcp.z);
grid on
ylim([0 18]);
xlim(fig.plim);
set(gca,'XTick',fig.ptick);
xlabel('Phase');

subplot(4,4,13)
plot(M2incl(:,id(1)), adcp.z);
grid on
ylim([0 18]);
xlim([0 180]);
set(gca,'XTick',0:90:180);
xlabel('Incl');

subplot(4,4,14)
plot(M2incl(:,id(2)), adcp.z);
grid on
ylim([0 18]);
xlim([0 180]);
set(gca,'XTick',0:90:180);
xlabel('Incl');

subplot(4,4,15)
plot(M2incl(:,id(3)), adcp.z);
grid on
ylim([0 18]);
xlim([0 180]);
set(gca,'XTick',0:90:180);
xlabel('Incl');

subplot(4,4,16)
plot(M2incl(:,id(4)), adcp.z);
grid on
ylim([0 18]);
xlim([0 180]);
set(gca,'XTick',0:90:180);
xlabel('Incl');


%% Random profiles

% id = [54 60 90 155 210 300];
id = [400  1000 1500 2000 2500 3000];

figure;
h1 = subplot(4,6,1);
plot(M.D(:,id(1))-1000,-1*M.P(:,id(1)),'Marker','.','Markersize',10);
grid on
hold on 
xlim([15 24]);
ylim(fig.zlim);
xlabel('rel. \rho');
title(h1,['profile ',num2str(id(1))]);

h2 = subplot(4,6,2);
plot(M.D(:,id(2))-1000,-1*M.P(:,id(2)),'Marker','.','Markersize',10);
grid on
hold on 
xlim([15 24]);
ylim(fig.zlim);
xlabel('rel. \rho');
title(h2,['profile ',num2str(id(2))]);

h3 = subplot(4,6,3);
plot(M.D(:,id(3))-1000,-1*M.P(:,id(3)),'Marker','.','Markersize',10);
grid on
hold on 
xlim([15 24]);
ylim(fig.zlim);
xlabel('rel. \rho');
title(h3,['profile ',num2str(id(3))]);

h4 = subplot(4,6,4);
plot(M.D(:,id(4))-1000,-1*M.P(:,id(4)),'Marker','.','Markersize',10);
grid on
hold on 
xlim([15 24]);
ylim(fig.zlim);
xlabel('rel. \rho');
title(h4,['profile ',num2str(id(4))]);

h5 = subplot(4,6,5);
plot(M.D(:,id(5))-1000,-1*M.P(:,id(5)),'Marker','.','Markersize',10);
grid on
hold on 
xlim([15 24]);
ylim(fig.zlim);
xlabel('rel. \rho');
title(h5,['profile ',num2str(id(5))]);

h6 = subplot(4,6,6);
plot(M.D(:,id(6))-1000,-1*M.P(:,id(6)),'Marker','.','Markersize',10);
grid on
hold on 
xlim([15 24]);
ylim(fig.zlim);
xlabel('rel. \rho');
title(h6,['profile ',num2str(id(6))]);

h7 = subplot(4,6,7);
plot(adcp.va(:,id(1)),adcp.z-18);
hold on
grid on
plot(adcp.vc(:,id(1)),adcp.z-18);
% plot(zeros(1,59),adcp.z,':k');
xlim([-1 1]);
ylim(fig.zlim);
xlabel('vel (m/s)');

h8 = subplot(4,6,8);
plot(adcp.va(:,id(2)),adcp.z-18);
hold on
grid on
plot(adcp.vc(:,id(2)),adcp.z-18);
% plot(zeros(1,59),adcp.z,':k');
xlim([-1 1]);
ylim(fig.zlim);
xlabel('vel (m/s)');

h9 = subplot(4,6,9);
plot(adcp.va(:,id(3)),adcp.z-18);
hold on
grid on
plot(adcp.vc(:,id(3)),adcp.z-18);
% plot(zeros(1,59),adcp.z,':k');
xlim([-1 1]);
ylim(fig.zlim);
xlabel('vel (m/s)');

h10 = subplot(4,6,10);
plot(adcp.va(:,id(4)),adcp.z-18);
hold on
grid on
plot(adcp.vc(:,id(4)),adcp.z-18);
% plot(zeros(1,59),adcp.z,':k');
xlim([-1 1]);
ylim(fig.zlim);
xlabel('vel (m/s)');

h11 = subplot(4,6,11);
plot(adcp.va(:,id(5)),adcp.z-18);
hold on
grid on
plot(adcp.vc(:,id(5)),adcp.z-18);
% plot(zeros(1,59),adcp.z,':k');
xlim([-1 1]);
xlabel('vel (m/s)');
ylim(fig.zlim);

h12 = subplot(4,6,12);
plot(adcp.va(:,id(6)),adcp.z-18);
hold on
grid on
plot(adcp.vc(:,id(6)),adcp.z-18);
% plot(zeros(1,59),adcp.z,':k');
xlim([-1 1]);
ylim(fig.zlim);
xlabel('vel (m/s)');

h13 = subplot(4,6,13);
plot(M2phase(:,id(1)),adcp.z-18);
grid on
xlim(fig.plim);
ylim(fig.zlim);
set(gca,'XTick',fig.ptick);
xlabel('phase (\circ)');

h14 = subplot(4,6,14);
plot(M2phase(:,id(2)),adcp.z-18);
grid on
xlim(fig.plim);
ylim(fig.zlim);
set(gca,'XTick',fig.ptick);
xlabel('phase (\circ)');

h15 = subplot(4,6,15);
plot(M2phase(:,id(3)),adcp.z-18);
grid on
xlim(fig.plim);
ylim(fig.zlim);
set(gca,'XTick',fig.ptick);
xlabel('phase (\circ)');

h16 = subplot(4,6,16);
plot(M2phase(:,id(4)),adcp.z-18);
grid on
xlim(fig.plim);
ylim(fig.zlim);
set(gca,'XTick',fig.ptick);
xlabel('phase (\circ)');

h17 = subplot(4,6,17);
plot(M2phase(:,id(5)),adcp.z-18);
grid on
xlim(fig.plim);
ylim(fig.zlim);
set(gca,'XTick',fig.ptick);
xlabel('phase (\circ)');

h18 = subplot(4,6,18);
plot(M2phase(:,id(6)),adcp.z-18);
grid on
xlim(fig.plim);
ylim(fig.zlim);
set(gca,'XTick',fig.ptick);
xlabel('phase (\circ)');

h19 = subplot(4,6,19);
plot(M2incl(:,id(1)),adcp.z-18);
grid on
ylim(fig.zlim);
xlabel('incl (\circ)');

h20 = subplot(4,6,20);
plot(M2incl(:,id(2)),adcp.z-18);
grid on
ylim(fig.zlim);
xlabel('incl (\circ)');

h21= subplot(4,6,21);
plot(M2incl(:,id(3)),adcp.z-18);
grid on
ylim(fig.zlim);
xlabel('incl (\circ)');

h22 = subplot(4,6,22);
plot(M2incl(:,id(4)),adcp.z-18);
grid on
ylim(fig.zlim);
xlabel('incl (\circ)');

h23 = subplot(4,6,23);
plot(M2incl(:,id(5)),adcp.z-18);
grid on
ylim(fig.zlim);
xlabel('incl (\circ)');

h24 = subplot(4,6,24);
plot(M2incl(:,id(6)),adcp.z-18);
grid on
ylim(fig.zlim);
xlabel('incl (\circ)');

%% Test

figure;
h1 = subplot(4,1,1);
plot(adcp.t,adcp.va(6,:));
hold on
grid on
plot(adcp.t,adcp.va(58,:));
ylabel('va (m/s)');
legend('lower layer','upper layer');
title('Timeseries t-tide harmonic analysis - in upper and lower layer');

h2 = subplot(4,1,2);
plot(adcp.t,adcp.vc(6,:));
hold on 
grid on
plot(adcp.t,adcp.vc(58,:));
ylabel('vc (m/s)');

h3 = subplot(4,1,3);
plot(adcp.t,M2incl(6,:),'marker','.','Markersize',10);
hold on 
grid on
plot(adcp.t,M2incl(58,:),'marker','.','Markersize',10);
ylim(fig.ilim);
ylabel('Incl (\circ)');
set(gca,'YTick',fig.itick);

h4 = subplot(4,1,4);
plot(adcp.t,M2phase(6,:),'marker','.','Markersize',10);
hold on 
grid on
plot(adcp.t,M2phase(58,:),'marker','.','Markersize',10);
ylabel('Phase (\circ)');
ylim([fig.plim]);
set(gca,'YTick',fig.ptick);

linkaxes([h1 h2 h3 h4],'x');

%% Total velocity: U^2 = va^2+vc^2

% U = sqrt(adcp.va(15,:).^2+adcp.vc(15,:).^2);
U = sqrt(adcp.va.^2+adcp.vc.^2);

% fig.plim = [-180 180];
% fig.ptick= [-180:90:180];

figure;
h1 = subplot(3,1,1);
plot(adcp.t,U(6,:));
hold on
grid on
plot(adcp.t,U(58,:));
legend('lower layer','upper layer');
ylabel('U (m/s)');

h2 = subplot(3,1,2);
plot(adcp.t,M2phase(6,:),'marker','.','Markersize',10);
hold on 
grid on
plot(adcp.t,M2phase(58,:),'marker','.','Markersize',10);
ylim(fig.plim);
set(gca,'YTick',fig.ptick);

ylabel('Phase (\circ)');

h3 = subplot(3,1,3);
plot(adcp.t,M2incl(6,:),'marker','.','Markersize',10);
hold on 
grid on
plot(adcp.t,M2incl(58,:),'marker','.','Markersize',10);
ylim(fig.ilim);
ylabel('Incl (\circ)');
set(gca,'YTick',fig.itick);

linkaxes([h1 h2 h3],'x');
