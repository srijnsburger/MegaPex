% Plot ellipse properties
clc;clear all;close all;

Loc = '12';

%% Load data

% eval(['load(''D:\sabinerijnsbur\Matlab\adcp\Tidal_analysis\TC' Loc ''');']);
eval(['load(''d:\sabinerijnsbur\Matlab_files\Megapex_data\Tidalanalysis\Tidefit' Loc ''');']);
eval(['load(''D:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\Mooring' Loc '_adcp_corr.mat'');']);

if find(strcmp(Loc,'12')==1)
    load('D:\sabinerijnsbur\Matlab\adcp\adcp12C');
    adcp = adcp12C;
else
   eval(['load(''D:\sabinerijnsbur\Matlab\adcp\adcp' Loc ''');']);
   eval(['adcp = adcp' Loc ''';']);
end

% eval(['TC = TC' Loc ''';']);
eval(['M = M' Loc ''';']);

%% Input figure

ellip = Minor./Major;
cwbr  = colormapbluewhitered;
fig.ylim = [0 15];
fig.xlim = [260 289];
fig.plim = [0 180];
fig.ptick= [0:45:180];
fig.ilim = [-45 45];
fig.itick= [-45:15:45];

close;

%% Change phases

% M2phase = nan(length(adcp.z),length(adcp.t));
% 
for i = 1:length(adcp.t)
    mask = find(Incl(:,i)>165);
    Incl(mask,i)  = Incl(mask,i)-180;
    Phase(mask,i) = Phase(mask,i)+180;
end 

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
% 
for i = 1:length(adcp.t)
    for j = 1:length(adcp.z)
        if Phase(j,i) > 180
            Phase(j,i) = Phase(j,i)-360;
        else 
            Phase(j,i) = Phase(j,i);
        end
    end
end

%% Remove first layer Phase

% 
for i = 1:numel(adcp.t)
    if isempty(find(~isnan(Phase(:,i))==1))==1;
        I(i) = NaN;
    else
        I(i) = find(~isnan(Phase(:,i))==1,1,'Last');
        Phase(I(i),i) = NaN; % something going totally wrong!!
        Incl(I(i),i) = NaN;
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
title('Tidefit timeseries - 12m site');

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
pcolorcorcen(adcp.t,adcp.z,Incl);
hold on
plot(adcp.t,adcp.h,'k');
colormap(cwbr);
cb2 = colorbar;
title(cb2,'Incl');
xlim(fig.xlim);
ylim(fig.ylim);
clim([0 180]);
set(cb2,'YTick',0:45:180);

h5 = subplot(5,1,5);
pcolorcorcen(adcp.t,adcp.z,Phase);
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

%% Plot Phase Navicula day

cwbr = colormapbluewhitered;

figure;
h1 = subplot(4,1,1);
pcolorcorcen(SBENav.t,SBENav.z,SBENav.dens-1000);
hold on
vline(SBENav.t,':k');
ylim([-10 -1]);
xlim([SBENav.t(1) SBENav.t(end)]);
cb4 = colorbar;
title(cb4,'rel dens (kg/m^3)');
clim([12 24]);

h2 = subplot(4,1,2);
pcolorcorcen(adcp.t,adcp.z,adcp.va);
hold on
plot(adcp.t,adcp.h,'k');
vline(SBENav.t,':k');
ylim(fig.ylim);
xlim([SBENav.t(1) SBENav.t(end)]);
colormap(cwbr);
cb1 = colorbar;
title(cb1,'va (m/s)');
clim([-1 1]);

h3 = subplot(4,1,3);
pcolorcorcen(adcp.t,adcp.z,adcp.vc);
hold on
plot(adcp.t,adcp.h,'k');
vline(SBENav.t,':k');
ylim(fig.ylim);
xlim([SBENav.t(1) SBENav.t(end)]);
colormap(cwbr);
cb2 = colorbar;
clim([-0.5 0.5]);
title(cb2,'vc (m/s)');

h4 = subplot(4,1,4);
pcolorcorcen(adcp.t,adcp.z,Phase);
hold on 
plot(adcp.t,adcp.h,'k');
vline(SBENav.t,':k');
cb3 = colorbar;
title(cb3,'Phase');
xlim([SBENav.t(1) SBENav.t(end)]);
ylim(fig.ylim);
clim(fig.plim);
set(cb3,'YTick',fig.ptick);

linkaxes([h1 h2 h3 h4],'x');


%% Profiles

if strcmp(Loc,'12')==1
% Load Navicula
load('d:\sabinerijnsbur\Matlab\Matlab-MegaPex2014-chaos\SBENav');
% ID = [2,8,13,18,24,29]; % indices profiles
ID = [14,15,16,17,18,19];

% mooring data
% id = [118 132 139 147 161 175]; % indices profiles
id = [140 142 143 145 147 151];

figure;
h1 = subplot(4,6,1);
plot(M.D(:,id(1))-1000,-1*M.P(:,id(1)),'Marker','.','Markersize',10);
grid on
hold on 
plot(SBENav.dens(:,ID(1))-1000,SBENav.z);
xlim([15 22]);
ylim([-12 0]);
xlabel('rel. \rho');
title(h1,['profile ',num2str(ID(1))]);

h2 = subplot(4,6,2);
plot(M.D(:,id(2))-1000,-1*M.P(:,id(2)),'Marker','.','Markersize',10);
grid on
hold on 
plot(SBENav.dens(:,ID(2))-1000,SBENav.z);
xlim([15 22]);
ylim([-12 0]);
xlabel('rel. \rho');
title(h2,['profile ',num2str(ID(2))]);

h3 = subplot(4,6,3);
plot(M.D(:,id(3))-1000,-1*M.P(:,id(3)),'Marker','.','Markersize',10);
grid on
hold on 
plot(SBENav.dens(:,ID(3))-1000,SBENav.z);
xlim([15 22]);
ylim([-12 0]);
xlabel('rel. \rho');
title(h3,['profile ',num2str(ID(3))]);

h4 = subplot(4,6,4);
plot(M.D(:,id(4))-1000,-1*M.P(:,id(4)),'Marker','.','Markersize',10);
grid on
hold on 
plot(SBENav.dens(:,ID(4))-1000,SBENav.z);
xlim([15 22]);
ylim([-12 0]);
xlabel('rel. \rho');
title(h4,['profile ',num2str(ID(4))]);

h5 = subplot(4,6,5);
plot(M.D(:,id(5))-1000,-1*M.P(:,id(5)),'Marker','.','Markersize',10);
grid on
hold on 
plot(SBENav.dens(:,ID(5))-1000,SBENav.z);
xlim([15 22]);
ylim([-12 0]);
xlabel('rel. \rho');
title(h5,['profile ',num2str(ID(5))]);

h6 = subplot(4,6,6);
plot(M.D(:,id(6))-1000,-1*M.P(:,id(6)),'Marker','.','Markersize',10);
grid on
hold on 
plot(SBENav.dens(:,ID(6))-1000,SBENav.z);
xlim([15 22]);
ylim([-12 0]);
xlabel('rel. \rho');
title(h6,['profile ',num2str(ID(6))]);

h7 = subplot(4,6,7);
plot(adcp.va(:,id(1)),adcp.z-12);
hold on
grid on
plot(adcp.vc(:,id(1)),adcp.z-12);
plot(zeros(1,59),adcp.z,':k');
xlim([-1 1]);
ylim([-12 0]);
xlabel('vel (m/s)');

h8 = subplot(4,6,8);
plot(adcp.va(:,id(2)),adcp.z-12);
hold on
grid on
plot(adcp.vc(:,id(2)),adcp.z-12);
plot(zeros(1,59),adcp.z,':k');
xlim([-1 1]);
ylim([-12 0]);
xlabel('vel (m/s)');

h9 = subplot(4,6,9);
plot(adcp.va(:,id(3)),adcp.z-12);
hold on
grid on
plot(adcp.vc(:,id(3)),adcp.z-12);
plot(zeros(1,59),adcp.z,':k');
xlim([-1 1]);
ylim([-12 0]);
xlabel('vel (m/s)');

h10 = subplot(4,6,10);
plot(adcp.va(:,id(4)),adcp.z-12);
hold on
grid on
plot(adcp.vc(:,id(4)),adcp.z-12);
plot(zeros(1,59),adcp.z,':k');
xlim([-1 1]);
ylim([-12 0]);
xlabel('vel (m/s)');

h11 = subplot(4,6,11);
plot(adcp.va(:,id(5)),adcp.z-12);
hold on
grid on
plot(adcp.vc(:,id(5)),adcp.z-12);
plot(zeros(1,59),adcp.z,':k');
xlim([-1 1]);
xlabel('vel (m/s)');
ylim([-12 0]);

h12 = subplot(4,6,12);
plot(adcp.va(:,id(6)),adcp.z-12);
hold on
grid on
plot(adcp.vc(:,id(6)),adcp.z-12);
plot(zeros(1,59),adcp.z,':k');
xlim([-1 1]);
ylim([-12 0]);
xlabel('vel (m/s)');

h13 = subplot(4,6,13);
plot(Phase(:,id(1)),adcp.z-12);
grid on
xlim(fig.plim);
ylim([-12 0]);
set(gca,'XTick',fig.ptick);
xlabel('phase (\circ)');

h14 = subplot(4,6,14);
plot(Phase(:,id(2)),adcp.z-12);
grid on
xlim(fig.plim);
ylim([-12 0]);
set(gca,'XTick',fig.ptick);
xlabel('phase (\circ)');

h15 = subplot(4,6,15);
plot(Phase(:,id(3)),adcp.z-12);
grid on
xlim(fig.plim);
ylim([-12 0]);
set(gca,'XTick',fig.ptick);
xlabel('phase (\circ)');

h16 = subplot(4,6,16);
plot(Phase(:,id(4)),adcp.z-12);
grid on
xlim(fig.plim);
ylim([-12 0]);
set(gca,'XTick',fig.ptick);
xlabel('phase (\circ)');

h17 = subplot(4,6,17);
plot(Phase(:,id(5)),adcp.z-12);
grid on
xlim(fig.plim);
ylim([-12 0]);
set(gca,'XTick',fig.ptick);
xlabel('phase (\circ)');

h18 = subplot(4,6,18);
plot(Phase(:,id(6)),adcp.z-12);
grid on
xlim(fig.plim);
ylim([-12 0]);
set(gca,'XTick',fig.ptick);
xlabel('phase (\circ)');

h19 = subplot(4,6,19);
plot(Incl(:,id(1)),adcp.z-12);
grid on
ylim([-12 0]);
xlabel('incl (\circ)');

h20 = subplot(4,6,20);
plot(Incl(:,id(2)),adcp.z-12);
grid on
ylim([-12 0]);
xlabel('incl (\circ)');

h21= subplot(4,6,21);
plot(Incl(:,id(3)),adcp.z-12);
grid on
ylim([-12 0]);
xlabel('incl (\circ)');

h22 = subplot(4,6,22);
plot(Incl(:,id(4)),adcp.z-12);
grid on
ylim([-12 0]);
xlabel('incl (\circ)');

h23 = subplot(4,6,23);
plot(Incl(:,id(5)),adcp.z-12);
grid on
ylim([-12 0]);
xlabel('incl (\circ)');

h24 = subplot(4,6,24);
plot(Incl(:,id(6)),adcp.z-12);
grid on
ylim([-12 0]);
xlabel('incl (\circ)');

end

%% Plot Phase Navicula day

figure;
pcolorcorcen(adcp.t,adcp.z,Phase);
hold on 
plot(adcp.t,adcp.h,'k');
cb3 = colorbar;
colormap(parula(10));
title(cb3,'Phase');
xlim([SBENav.t(1) SBENav.t(end)]);
ylim(fig.ylim);
clim(fig.plim);
set(cb3,'YTick',fig.ptick);


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
ylim([-12 0]);
xlabel('rel. \rho (kg/m^3)');

h2 = subplot(3,6,2);
plot(M.D(:,id(2))-1000,-1*M.P(:,id(2)),'Marker','.','Markersize',10);
grid on
hold on 
plot(SBENav.dens(:,ID(2))-1000,SBENav.z);
xlim([15 22]);
ylim([-12 0]);
xlabel('rel. \rho (kg/m^3)');

h3 = subplot(3,6,3);
plot(M.D(:,id(3))-1000,-1*M.P(:,id(3)),'Marker','.','Markersize',10);
grid on
hold on 
plot(SBENav.dens(:,ID(3))-1000,SBENav.z);
xlim([15 22]);
ylim([-12 0]);
xlabel('rel. \rho (kg/m^3)');

h4 = subplot(3,6,4);
plot(M.D(:,id(4))-1000,-1*M.P(:,id(4)),'Marker','.','Markersize',10);
grid on
hold on 
plot(SBENav.dens(:,ID(4))-1000,SBENav.z);
xlim([15 22]);
ylim([-12 0]);
xlabel('rel. \rho (kg/m^3)');

h5 = subplot(3,6,5);
plot(M.D(:,id(5))-1000,-1*M.P(:,id(5)),'Marker','.','Markersize',10);
grid on
hold on 
plot(SBENav.dens(:,ID(5))-1000,SBENav.z);
xlim([15 22]);
ylim([-12 0]);
xlabel('rel. \rho (kg/m^3)');

h6 = subplot(3,6,6);
plot(M.D(:,id(6))-1000,-1*M.P(:,id(6)),'Marker','.','Markersize',10);
grid on
hold on 
plot(SBENav.dens(:,ID(6))-1000,SBENav.z);
xlim([15 22]);
ylim([-12 0]);
xlabel('rel. \rho (kg/m^3)');

h7 = subplot(3,6,7);
plot(adcp.va(:,id(1)),adcp.z-12);
hold on
grid on
plot(adcp.vc(:,id(1)),adcp.z-12);
plot(zeros(1,59),adcp.z,':k');
xlim([-1 1]);
ylim([-12 0]);
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
ylim([-12 0]);
xlabel('vel (m/s)');

h9 = subplot(3,6,9);
plot(adcp.va(:,id(3)),adcp.z-12);
hold on
grid on
plot(adcp.vc(:,id(3)),adcp.z-12);
plot(zeros(1,59),adcp.z,':k');
xlim([-1 1]);
ylim([-12 0]);
xlabel('vel (m/s)');

h10 = subplot(3,6,10);
plot(adcp.va(:,id(4)),adcp.z-12);
hold on
grid on
plot(adcp.vc(:,id(4)),adcp.z-12);
plot(zeros(1,59),adcp.z,':k');
xlim([-1 1]);
ylim([-12 0]);
xlabel('vel (m/s)');

h11 = subplot(3,6,11);
plot(adcp.va(:,id(5)),adcp.z-12);
hold on
grid on
plot(adcp.vc(:,id(5)),adcp.z-12);
plot(zeros(1,59),adcp.z,':k');
xlim([-1 1]);
ylim([-12 0]);
xlabel('vel (m/s)');

h12 = subplot(3,6,12);
plot(adcp.va(:,id(6)),adcp.z-12);
hold on
grid on
plot(adcp.vc(:,id(6)),adcp.z-12);
plot(zeros(1,59),adcp.z,':k');
xlim([-1 1]);
ylim([-12 0]);
xlabel('vel (m/s)');

h13 = subplot(3,6,13);
plot(Phase(:,id(1))-Phase(I(id(1))-2,id(1)),adcp.z-12);
grid on
% xlim([-100 0]);
ylim([-12 0]);
% set(gca,'XTick',0:90:360);
xlabel('Phase(z)-Phase_s');

h14 = subplot(3,6,14);
plot(Phase(:,id(2))-Phase(I(id(2))-2,id(2)),adcp.z-12);
grid on
% xlim([-100 0]);
ylim([-12 0]);
% set(gca,'XTick',0:90:360);
xlabel('Phase(z)-Phase_s');

h15 = subplot(3,6,15);
plot(Phase(:,id(3))-Phase(I(id(3))-2,id(3)),adcp.z-12);
grid on
% xlim([-100 0]);
ylim([-12 0]);
% set(gca,'XTick',0:90:360);
xlabel('Phase(z)-Phase_s');

h16 = subplot(3,6,16);
plot(Phase(:,id(4))-Phase(I(id(4))-2,id(4)),adcp.z-12);
grid on
% xlim([-100 0]);
ylim([-12 0]);
% set(gca,'XTick',0:90:360);
xlabel('Phase(z)-Phase_s');

h17 = subplot(3,6,17);
plot(Phase(:,id(5))-Phase(I(id(5))-2,id(5)),adcp.z-12);
grid on
% xlim([-100 0]);
ylim([-12 0]);
% set(gca,'XTick',-40:90:360);
xlabel('Phase(z)-Phase_s');

h18 = subplot(3,6,18);
plot(Phase(:,id(6))-Phase(I(id(6))-2,id(6)),adcp.z-12);
grid on
hold on
% xlim([-100 0]);
ylim([-12 0]);
% set(gca,'XTick',-40:90:360);
xlabel('Phase(z)-Phase_s');

end
%% Plot major, minor axis

id = [118 132 139 147 161 175];

figure;
subplot(4,4,1)
plot(Major(:,id(1)), adcp.z);
grid on
ylim([0 18]);
xlim([0 0.8]);
xlabel('Major');

subplot(4,4,2)
plot(Major(:,id(2)), adcp.z);
grid on
ylim([0 18]);
xlim([0 0.8]);
xlabel('Major');

subplot(4,4,3)
plot(Major(:,id(3)), adcp.z);
grid on
ylim([0 18]);
xlim([0 0.8]);
xlabel('Major');

subplot(4,4,4)
plot(Major(:,id(4)), adcp.z);
grid on
ylim([0 18]);
xlim([0 0.8]);
xlabel('Major');

subplot(4,4,5)
plot(Minor(:,id(1)), adcp.z);
grid on
ylim([0 18]);
xlim([-0.3 0.2]);
xlabel('Minor');

subplot(4,4,6)
plot(Minor(:,id(2)), adcp.z);
grid on
ylim([0 18]);
xlim([-0.3 0.2]);
xlabel('Minor');

subplot(4,4,7)
plot(Minor(:,id(3)), adcp.z);
grid on
ylim([0 18]);
xlim([-0.3 0.2]);
xlabel('Minor');

subplot(4,4,8)
plot(Minor(:,id(4)), adcp.z);
grid on
ylim([0 18]);
xlim([-0.3 0.2]);
xlabel('Minor');

subplot(4,4,9)
plot(Phase(:,id(1)), adcp.z);
grid on
ylim([0 18]);
xlim(fig.plim);
set(gca,'XTick',fig.ptick);
xlabel('Phase');

subplot(4,4,10)
plot(Phase(:,id(2)), adcp.z);
grid on
ylim([0 18]);
xlim(fig.plim);
set(gca,'XTick',fig.ptick);
xlabel('Phase');

subplot(4,4,11)
plot(Phase(:,id(3)), adcp.z);
grid on
ylim([0 18]);
xlim(fig.plim);
set(gca,'XTick',fig.ptick);
xlabel('Phase');

subplot(4,4,12)
plot(Phase(:,id(4)), adcp.z);
grid on
ylim([0 18]);
xlim(fig.plim);
set(gca,'XTick',fig.ptick);
xlabel('Phase');

subplot(4,4,13)
plot(Incl(:,id(1)), adcp.z);
grid on
ylim([0 18]);
xlim([0 180]);
set(gca,'XTick',0:90:180);
xlabel('Incl');

subplot(4,4,14)
plot(Incl(:,id(2)), adcp.z);
grid on
ylim([0 18]);
xlim([0 180]);
set(gca,'XTick',0:90:180);
xlabel('Incl');

subplot(4,4,15)
plot(Incl(:,id(3)), adcp.z);
grid on
ylim([0 18]);
xlim([0 180]);
set(gca,'XTick',0:90:180);
xlabel('Incl');

subplot(4,4,16)
plot(Incl(:,id(4)), adcp.z);
grid on
ylim([0 18]);
xlim([0 180]);
set(gca,'XTick',0:90:180);
xlabel('Incl');


%% Random profiles

id = [54 60 90 155 210 300];
% id = [400  1000 1500 2000 2500 3000];

figure;
h1 = subplot(4,6,1);
plot(M.D(:,id(1))-1000,-1*M.P(:,id(1)),'Marker','.','Markersize',10);
grid on
hold on 
xlim([15 22]);
ylim([-12 0]);
xlabel('rel. \rho');
title(h1,['profile ',num2str(id(1))]);

h2 = subplot(4,6,2);
plot(M.D(:,id(2))-1000,-1*M.P(:,id(2)),'Marker','.','Markersize',10);
grid on
hold on 
xlim([15 22]);
ylim([-12 0]);
xlabel('rel. \rho');
title(h2,['profile ',num2str(id(2))]);

h3 = subplot(4,6,3);
plot(M.D(:,id(3))-1000,-1*M.P(:,id(3)),'Marker','.','Markersize',10);
grid on
hold on 
xlim([15 22]);
ylim([-12 0]);
xlabel('rel. \rho');
title(h3,['profile ',num2str(id(3))]);

h4 = subplot(4,6,4);
plot(M.D(:,id(4))-1000,-1*M.P(:,id(4)),'Marker','.','Markersize',10);
grid on
hold on 
xlim([15 22]);
ylim([-12 0]);
xlabel('rel. \rho');
title(h4,['profile ',num2str(id(4))]);

h5 = subplot(4,6,5);
plot(M.D(:,id(5))-1000,-1*M.P(:,id(5)),'Marker','.','Markersize',10);
grid on
hold on 
xlim([15 22]);
ylim([-12 0]);
xlabel('rel. \rho');
title(h5,['profile ',num2str(id(5))]);

h6 = subplot(4,6,6);
plot(M.D(:,id(6))-1000,-1*M.P(:,id(6)),'Marker','.','Markersize',10);
grid on
hold on 
xlim([15 22]);
ylim([-12 0]);
xlabel('rel. \rho');
title(h6,['profile ',num2str(id(6))]);

h7 = subplot(4,6,7);
plot(adcp.va(:,id(1)),adcp.z-12);
hold on
grid on
plot(adcp.vc(:,id(1)),adcp.z-12);
plot(zeros(1,59),adcp.z,':k');
xlim([-1 1]);
ylim([-12 0]);
xlabel('vel (m/s)');

h8 = subplot(4,6,8);
plot(adcp.va(:,id(2)),adcp.z-12);
hold on
grid on
plot(adcp.vc(:,id(2)),adcp.z-12);
plot(zeros(1,59),adcp.z,':k');
xlim([-1 1]);
ylim([-12 0]);
xlabel('vel (m/s)');

h9 = subplot(4,6,9);
plot(adcp.va(:,id(3)),adcp.z-12);
hold on
grid on
plot(adcp.vc(:,id(3)),adcp.z-12);
plot(zeros(1,59),adcp.z,':k');
xlim([-1 1]);
ylim([-12 0]);
xlabel('vel (m/s)');

h10 = subplot(4,6,10);
plot(adcp.va(:,id(4)),adcp.z-12);
hold on
grid on
plot(adcp.vc(:,id(4)),adcp.z-12);
plot(zeros(1,59),adcp.z,':k');
xlim([-1 1]);
ylim([-12 0]);
xlabel('vel (m/s)');

h11 = subplot(4,6,11);
plot(adcp.va(:,id(5)),adcp.z-12);
hold on
grid on
plot(adcp.vc(:,id(5)),adcp.z-12);
plot(zeros(1,59),adcp.z,':k');
xlim([-1 1]);
xlabel('vel (m/s)');
ylim([-12 0]);

h12 = subplot(4,6,12);
plot(adcp.va(:,id(6)),adcp.z-12);
hold on
grid on
plot(adcp.vc(:,id(6)),adcp.z-12);
plot(zeros(1,59),adcp.z,':k');
xlim([-1 1]);
ylim([-12 0]);
xlabel('vel (m/s)');

h13 = subplot(4,6,13);
plot(Phase(:,id(1)),adcp.z-12);
grid on
xlim(fig.plim);
ylim([-12 0]);
set(gca,'XTick',fig.ptick);
xlabel('phase (\circ)');

h14 = subplot(4,6,14);
plot(Phase(:,id(2)),adcp.z-12);
grid on
xlim(fig.plim);
ylim([-12 0]);
set(gca,'XTick',fig.ptick);
xlabel('phase (\circ)');

h15 = subplot(4,6,15);
plot(Phase(:,id(3)),adcp.z-12);
grid on
xlim(fig.plim);
ylim([-12 0]);
set(gca,'XTick',fig.ptick);
xlabel('phase (\circ)');

h16 = subplot(4,6,16);
plot(Phase(:,id(4)),adcp.z-12);
grid on
xlim(fig.plim);
ylim([-12 0]);
set(gca,'XTick',fig.ptick);
xlabel('phase (\circ)');

h17 = subplot(4,6,17);
plot(Phase(:,id(5)),adcp.z-12);
grid on
xlim(fig.plim);
ylim([-12 0]);
set(gca,'XTick',fig.ptick);
xlabel('phase (\circ)');

h18 = subplot(4,6,18);
plot(Phase(:,id(6)),adcp.z-12);
grid on
xlim(fig.plim);
ylim([-12 0]);
set(gca,'XTick',fig.ptick);
xlabel('phase (\circ)');

h19 = subplot(4,6,19);
plot(Incl(:,id(1)),adcp.z-12);
grid on
ylim([-12 0]);
xlabel('incl (\circ)');

h20 = subplot(4,6,20);
plot(Incl(:,id(2)),adcp.z-12);
grid on
ylim([-12 0]);
xlabel('incl (\circ)');

h21= subplot(4,6,21);
plot(Incl(:,id(3)),adcp.z-12);
grid on
ylim([-12 0]);
xlabel('incl (\circ)');

h22 = subplot(4,6,22);
plot(Incl(:,id(4)),adcp.z-12);
grid on
ylim([-12 0]);
xlabel('incl (\circ)');

h23 = subplot(4,6,23);
plot(Incl(:,id(5)),adcp.z-12);
grid on
ylim([-12 0]);
xlabel('incl (\circ)');

h24 = subplot(4,6,24);
plot(Incl(:,id(6)),adcp.z-12);
grid on
ylim([-12 0]);
xlabel('incl (\circ)');

%% Test

figure;
h1 = subplot(4,1,1);
plot(adcp.t,adcp.va(15,:));
hold on
grid on
plot(adcp.t,adcp.va(39,:));
legend('lower layer','upper layer');
title('Timeseries tidefit harmonic analysis - in upper and lower layer - 12m site');

h2 = subplot(4,1,2);
plot(adcp.t,adcp.vc(15,:));
hold on 
grid on
plot(adcp.t,adcp.vc(39,:));

h3 = subplot(4,1,3);
plot(adcp.t,Incl(15,:),'marker','.','Markersize',10);
hold on 
grid on
plot(adcp.t,Incl(39,:),'marker','.','Markersize',10);
ylim(fig.ilim);
ylabel('Incl (\circ)');
set(gca,'YTick',fig.itick);

h4 = subplot(4,1,4);
plot(adcp.t,Phase(15,:),'marker','.','Markersize',10);
hold on 
grid on
plot(adcp.t,Phase(39,:),'marker','.','Markersize',10);
ylabel('Phase (\circ)');
ylim([fig.plim]);
set(gca,'YTick',fig.ptick);

linkaxes([h1 h2 h3 h4],'x');

%% Total velocity: U^2 = va^2+vc^2

% U = sqrt(adcp.va(15,:).^2+adcp.vc(15,:).^2);
U = sqrt(adcp.va.^2+adcp.vc.^2);

figure;
h1 = subplot(3,1,1);
plot(adcp.t,U(15,:));
hold on
grid on
plot(adcp.t,U(39,:));
legend('lower layer','upper layer');
ylabel('U (m/s)');

h2 = subplot(3,1,2);
plot(adcp.t,Phase(15,:),'marker','.','Markersize',10);
hold on 
grid on
plot(adcp.t,Phase(39,:),'marker','.','Markersize',10);
ylim(fig.plim);
set(gca,'YTick',fig.ptick);

ylabel('Phase (\circ)');

h3 = subplot(3,1,3);
plot(adcp.t,Incl(15,:),'marker','.','Markersize',10);
hold on 
grid on
plot(adcp.t,Incl(39,:),'marker','.','Markersize',10);
ylim(fig.ilim);
ylabel('Incl (\circ)');
set(gca,'YTick',fig.itick);

linkaxes([h1 h2 h3],'x');
