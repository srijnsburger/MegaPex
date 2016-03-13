%Test tide_fit

%% Tidal analysis - with tide_fit.m
clc;clear all;close all;

% Load data
load('D:\sabinerijnsbur\Matlab\adcp\adcp12C.mat');
adcp = adcp12C;

%% Harmonic analysis & calculate ellipse properties

% Convert time to Julian day vector
t = datevec(adcp.time);
jdate = julian(t(:,1),t(:,2),t(:,3),t(:,4),t(:,5),t(:,6));

% Make velocity
omega = (2*pi)/12.42;
z     = 0:0.5:12;
U     = sin(omega*(jdate*24))';
uvel  = repmat(U,length(z),1);
V     = 0.1*sin(omega*(jdate*24))';
vvel  = repmat(V,length(z),1);

% concatonate
u     = nan(size(uvel));
v     = nan(size(vvel));
Const = nan(size(vvel));
Major = nan(size(vvel));
Minor = nan(size(vvel));
Incl  = nan(size(vvel));
Phase = nan(size(vvel));

range1sided  = 38; % moving analysis with 25h
nt           = numel(jdate);
periods      = [12.42];

for it=1:length(jdate)% loopover tijd
    disp(['TIME>>>>>>>>>>>>>>>> ',num2str(it)])
    for iz=1:size(uvel,1)% loopover z
        
        if (it > range1sided) && (it < (nt - range1sided))
            
            itsubset = it + [-range1sided:range1sided]; % 76*10/60 = 12.667hour ; 150*10/60 = 25 hour.
            
            uu = [uvel(iz,itsubset)' vvel(iz,itsubset)'];
            
            if sum(isnan(uu(:,1)))<35
                
                [ucoef,unew] = tide_fit_SR(jdate(itsubset),uu,periods);
                
                ell = tide_ell(ucoef,periods);
                
                u(iz,it)     = unew(range1sided+1,1);
                v(iz,it)     = unew(range1sided+1,2);
                Const(iz,it) = ell(1,1);
                Major(iz,it) = ell(1,2);
                Minor(iz,it) = ell(1,3);
                Incl(iz,it)  = ell(1,4);
                Phase(iz,it) = ell(1,5);
                
%                 if ell(1,5)>180
%                     Phase(iz,it) = ell(1,5)-360;
%                 else
%                     Phase(iz,it)  = ell(1,5);
%                 end
                
            end
        end
    end
end

%% Save

save('d:\sabinerijnsbur\Matlab_files\Megapex_data\Tidalanalysis\Tidefit_test','uvel');
save('d:\sabinerijnsbur\Matlab_files\Megapex_data\Tidalanalysis\Tidefit_test','-append','vvel');
save('d:\sabinerijnsbur\Matlab_files\Megapex_data\Tidalanalysis\Tidefit_test','-append','u');
save('d:\sabinerijnsbur\Matlab_files\Megapex_data\Tidalanalysis\Tidefit_test','-append','u');
save('d:\sabinerijnsbur\Matlab_files\Megapex_data\Tidalanalysis\Tidefit_test','-append','Const');
save('d:\sabinerijnsbur\Matlab_files\Megapex_data\Tidalanalysis\Tidefit_test','-append','Major');
save('d:\sabinerijnsbur\Matlab_files\Megapex_data\Tidalanalysis\Tidefit_test','-append','Minor');
save('d:\sabinerijnsbur\Matlab_files\Megapex_data\Tidalanalysis\Tidefit_test','-append','Incl');
save('d:\sabinerijnsbur\Matlab_files\Megapex_data\Tidalanalysis\Tidefit_test','-append','Phase');

%% Input figure 

fig.plim = [0 360];
fig.ptick= [0:90:360];

%% Plot

figure;
subplot(4,1,1)
pcolorcorcen(adcp12C.t,z,uvel);
colorbar;
clim([-1.1 1.1]);
title('Simple sine in tidefit');

subplot(4,1,2)
pcolorcorcen(adcp12C.t,z,vvel);
colorbar;
clim([-0.15 0.15]);

subplot(4,1,3)
pcolorcorcen(adcp12C.t,z,Incl);
colorbar;
clim([0 180]);
text(281,10,['Incl = ' num2str(Incl(1,100)) '\circ']);

subplot(4,1,4)
pcolorcorcen(adcp12C.t,z,Phase);
colorbar;
clim([0 360]);
text(281,10,['Phase = ' num2str(Phase(1,100)) '\circ']);

%% Check

id = [118 132 139 147 161 175];

figure;
subplot(4,4,1)
plot(Major(:,id(1)), z);
grid on
ylim([0 18]);
xlim([0 1.5]);
xlabel('Major');
title('Simple sine in Tidefit for different profiles');

subplot(4,4,2)
plot(Major(:,id(2)),z);
grid on
ylim([0 18]);
xlim([0 1.5]);
xlabel('Major');

subplot(4,4,3)
plot(Major(:,id(3)), z);
grid on
ylim([0 18]);
xlim([0 1.5]);
xlabel('Major');

subplot(4,4,4)
plot(Major(:,id(4)), z);
grid on
ylim([0 18]);
xlim([0 1.5]);
xlabel('Major');

subplot(4,4,5)
plot(Minor(:,id(1)), z);
grid on
ylim([0 18]);
xlim([-0.3 0.2]);
xlabel('Minor');

subplot(4,4,6)
plot(Minor(:,id(2)), z);
grid on
ylim([0 18]);
xlim([-0.3 0.2]);
xlabel('Minor');

subplot(4,4,7)
plot(Minor(:,id(3)), z);
grid on
ylim([0 18]);
xlim([-0.3 0.2]);
xlabel('Minor');

subplot(4,4,8)
plot(Minor(:,id(4)), z);
grid on
ylim([0 18]);
xlim([-0.3 0.2]);
xlabel('Minor');

subplot(4,4,9)
plot(Phase(:,id(1)), z);
grid on
ylim([0 18]);
xlim(fig.plim);
set(gca,'XTick',fig.ptick);
xlabel('Phase');

subplot(4,4,10)
plot(Phase(:,id(2)), z);
grid on
ylim([0 18]);
xlim(fig.plim);
set(gca,'XTick',fig.ptick);
xlabel('Phase');

subplot(4,4,11)
plot(Phase(:,id(3)), z);
grid on
ylim([0 18]);
xlim(fig.plim);
set(gca,'XTick',fig.ptick);
xlabel('Phase');

subplot(4,4,12)
plot(Phase(:,id(4)), z);
grid on
ylim([0 18]);
xlim(fig.plim);
set(gca,'XTick',fig.ptick);
xlabel('Phase');

subplot(4,4,13)
plot(Incl(:,id(1)), z);
grid on
ylim([0 18]);
xlim([0 180]);
set(gca,'XTick',0:90:180);
xlabel('Incl');

subplot(4,4,14)
plot(Incl(:,id(2)), z);
grid on
ylim([0 18]);
xlim([0 180]);
set(gca,'XTick',0:90:180);
xlabel('Incl');

subplot(4,4,15)
plot(Incl(:,id(3)), z);
grid on
ylim([0 18]);
xlim([0 180]);
set(gca,'XTick',0:90:180);
xlabel('Incl');

subplot(4,4,16)
plot(Incl(:,id(4)), z);
grid on
ylim([0 18]);
xlim([0 180]);
set(gca,'XTick',0:90:180);
xlabel('Incl');

% Test phase
figure;
h1 = subplot(5,1,1);
plot(adcp.t,uvel(1,:));
grid on
ylabel('u (m/s)');
title('Timeseries of simple sine in tidefit');

h2 = subplot(5,1,2);
plot(adcp.t,Major(1,:));
grid on
ylabel('Major');
ylim([1 1.01]);

h3 = subplot(5,1,3);
plot(adcp.t,Minor(1,:));
grid on
ylabel('Minor');
ylim([-1 1]);

h4 = subplot(5,1,4);
plot(adcp.t,Incl(1,:));
grid on
ylabel('Incl');
ylim([0 180]);
set(gca,'YTick',0:45:180);

h5 = subplot(5,1,5);
plot(adcp.t,Phase(1,:));
grid on
ylabel('Phase');
ylim([0 360]);
set(gca,'YTick',0:90:360);

linkaxes([h1 h2 h3 h4 h5],'x');

