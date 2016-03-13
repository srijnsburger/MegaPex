%% Tidal analysis - with tide_fit.m
clc;clear all;close all;

% Load data
loc = '12';
load('D:\sabinerijnsbur\Matlab\adcp\adcp12C.mat');
adcp = adcp12C;

%% Harmonic analysis & calculate ellipse properties

% Convert time to Julian day vector
t = datevec(adcp.time);
jdate = julian(t(:,1),t(:,2),t(:,3),t(:,4),t(:,5),t(:,6));

% concatonate
va    = nan(size(adcp.va));
vc    = nan(size(adcp.vc));
Const = nan(size(adcp.va));
Major = nan(size(adcp.va));
Minor = nan(size(adcp.va));
Incl  = nan(size(adcp.va));
Phase = nan(size(adcp.va));

range1sided  = 38; % moving analysis with 25h
nt           = numel(jdate);
periods      = [12.42];

for it=1:length(jdate)% loopover tijd
    disp(['TIME>>>>>>>>>>>>>>>> ',num2str(it)])
    for iz=1:size(adcp.va,1)% loopover z
        
        if (it > range1sided) && (it < (nt - range1sided))
            
            itsubset = it + [-range1sided:range1sided]; % 76*10/60 = 12.667hour ; 150*10/60 = 25 hour.
            
            uu = [adcp.va(iz,itsubset)' adcp.vc(iz,itsubset)'];
            
            if sum(isnan(uu(:,1)))<45
                
                [ucoef,unew] = tide_fit_SR(jdate(itsubset),uu,periods);
                
                ell = tide_ell(ucoef,periods);
                
                va(iz,it)     = unew(range1sided+1,1);
                vc(iz,it)     = unew(range1sided+1,2);
                Const(iz,it)  = ell(1,1);
                Major(iz,it)  = ell(1,2);
                Minor(iz,it)  = ell(1,3);
                Incl(iz,it)   = ell(1,4);
                Phase(iz,it)  = ell(1,5);
                
%                 if ell(1,5)>180
%                     Phase(iz,it) = ell(1,5)-360;
%                 else
%                     Phase(iz,it)  = ell(1,5);
%                 end
                
            end
        end
    end
end

%% Shift towards -180:180


% if ell(1,5)>180
%     Phase(iz,it) = ell(1,5)-360;
% else
%     Phase(iz,it)  = ell(1,5);
% end

%% save

save(['d:\sabinerijnsbur\Matlab_files\Megapex_data\Tidalanalysis\Tidefit',loc,'.mat'],'va');
save(['d:\sabinerijnsbur\Matlab_files\Megapex_data\Tidalanalysis\Tidefit',loc,'.mat'],'-append','vc');
save(['d:\sabinerijnsbur\Matlab_files\Megapex_data\Tidalanalysis\Tidefit',loc,'.mat'],'-append','Const');
save(['d:\sabinerijnsbur\Matlab_files\Megapex_data\Tidalanalysis\Tidefit',loc,'.mat'],'-append','Major');
save(['d:\sabinerijnsbur\Matlab_files\Megapex_data\Tidalanalysis\Tidefit',loc,'.mat'],'-append','Minor');
save(['d:\sabinerijnsbur\Matlab_files\Megapex_data\Tidalanalysis\Tidefit',loc,'.mat'],'-append','Incl');
save(['d:\sabinerijnsbur\Matlab_files\Megapex_data\Tidalanalysis\Tidefit',loc,'.mat'],'-append','Phase');

%% Input figure 

fig.plim = [0 360];
fig.ptick= [0:90:360];

%% Plot

figure;
subplot(4,1,1)
pcolorcorcen(adcp.t,adcp.z,va);
cb = colorbar;
title(cb,'va');
title([loc ' - timeseries harmonic analysis tidefit']);

subplot(4,1,2)
pcolorcorcen(adcp.t,adcp.z,vc);
cb = colorbar;
title(cb,'vc');

subplot(4,1,3)
pcolorcorcen(adcp.t,adcp.z,Incl);
cb = colorbar;
title(cb,'Incl');

subplot(4,1,4)
pcolorcorcen(adcp.t,adcp.z,Phase);
cb = colorbar;
title(cb,'Phase');

%% Check

id = [118 132 139 147 161 175];

figure;
subplot(4,4,1)
plot(Major(:,id(1)), adcp.z);
grid on
ylim([0 18]);
xlim([0 0.8]);
xlabel('Major');
title(['profile ' num2str(id(1))]);

subplot(4,4,2)
plot(Major(:,id(2)), adcp.z);
grid on
ylim([0 18]);
xlim([0 0.8]);
xlabel('Major');
title(['profile ' num2str(id(2))]);

subplot(4,4,3)
plot(Major(:,id(3)), adcp.z);
grid on
ylim([0 18]);
xlim([0 0.8]);
xlabel('Major');
title(['profile ' num2str(id(3))]);

subplot(4,4,4)
plot(Major(:,id(4)), adcp.z);
grid on
ylim([0 18]);
xlim([0 0.8]);
xlabel('Major');
title(['profile ' num2str(id(4))]);

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

%% Plot profiles

% id = [54 60 90 155 210 300];
id = [118 132 139 147 161 175];
% id = [400  1000 1500 2000 2500 3000];

figure;
h1 = subplot(2,6,1);
plot(Phase(:,id(1)),adcp.z);
grid on
xlim(fig.plim);
ylim([0 18]);
set(gca,'XTick',fig.ptick);
xlabel('phase (\circ)');
title(h1,['profile ',num2str(id(1))]);

h2 = subplot(2,6,2);
plot(Phase(:,id(2)),adcp.z);
grid on
xlim(fig.plim);
ylim([0 18]);
set(gca,'XTick',fig.ptick);
xlabel('phase (\circ)');
title(h2,['profile ',num2str(id(2))]);

h3 = subplot(2,6,3);
plot(Phase(:,id(3)),adcp.z);
grid on
xlim(fig.plim);
ylim([0 18]);
set(gca,'XTick',fig.ptick);
xlabel('phase (\circ)');
title(h3,['profile ',num2str(id(3))]);

h4 = subplot(2,6,4);
plot(Phase(:,id(4)),adcp.z);
grid on
xlim(fig.plim);
ylim([0 18]);
set(gca,'XTick',fig.ptick);
xlabel('phase (\circ)');
title(h4,['profile ',num2str(id(4))]);

h5 = subplot(2,6,5);
plot(Phase(:,id(5)),adcp.z);
grid on
xlim(fig.plim);
ylim([0 18]);
set(gca,'XTick',fig.ptick);
xlabel('phase (\circ)');
title(h5,['profile ',num2str(id(5))]);

h6 = subplot(2,6,6);
plot(Phase(:,id(6)),adcp.z);
grid on
xlim(fig.plim);
ylim([0 18]);
set(gca,'XTick',fig.ptick);
xlabel('phase (\circ)');
title(h6,['profile ',num2str(id(6))]);

h7 = subplot(2,6,7);
plot(Incl(:,id(1)),adcp.z);
grid on
ylim([0 18]);
xlabel('incl (\circ)');

h8 = subplot(2,6,8);
plot(Incl(:,id(2)),adcp.z);
grid on
ylim([0 18]);
xlabel('incl (\circ)');

h9= subplot(2,6,9);
plot(Incl(:,id(3)),adcp.z);
grid on
ylim([0 18]);
xlabel('incl (\circ)');

h10 = subplot(2,6,10);
plot(Incl(:,id(4)),adcp.z);
grid on
ylim([0 18]);
xlabel('incl (\circ)');

h11 = subplot(2,6,11);
plot(Incl(:,id(5)),adcp.z);
grid on
ylim([0 18]);
xlabel('incl (\circ)');

h12 = subplot(2,6,12);
plot(Incl(:,id(6)),adcp.z);
grid on
ylim([0 18]);
xlabel('incl (\circ)');