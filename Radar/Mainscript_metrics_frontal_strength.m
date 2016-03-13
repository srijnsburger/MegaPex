%% Metrics for frontal strength
clc;clear all;close all;

%% Load density & velocity data

% 12m mooring
load('d:\sabinerijnsbur\Matlab\adcp\adcp12.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\SBE1527.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\SBE1526.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\SBE5426.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\SBE5425.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\SBE1842_corrected.mat');

% 18m mooring
load('d:\sabinerijnsbur\Matlab\adcp\adcp18.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\SBE1525.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\SBE4939.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\SBE4940.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\SBE19_corrected.mat');


%% Density difference

% 12m mooring
F12.dR   = SBE1842.dens10 - SBE1527.dens10;
F12.dRs  = SBE1526.dens10 - SBE1527.dens10;

%2nd try out
bd      = (SBE1842.dens10+SBE5425.dens10+SBE5426.dens10)./3;
F12.dR2 = bd - SBE1527.dens10;

% 18m mooring
F18.dR  = SBE19.dens10   - SBE1525.dens10;
F18.dRs = SBE4939.dens10 - SBE1525.dens10;

%2nd try out
bd      = (SBE19.dens10+SBE4940.dens10)./2;
F18.dR2 = bd - SBE1525.dens10;

%% Density difference in time (drho/dt)

% 12m mooring: for 1mbs
% time averaged
t12        = SBE1527.time10.*86400;% time need to be in seconds
F12.drdt10 = diff(SBE1527.dens10)./diff(t12);
F12.drdt10 = [nan F12.drdt10];% now on same time grid as adcp12

% raw data
time12   = SBE1527.time.*86400;
F12.drdt = diff(SBE1527.dens)./diff(time12);
F12.drdt = [nan F12.drdt'];

%time average over 2 minute
st  = diff(SBE1527.time);
dt  = 120/(st(1)*86400); %2 min averaging
num = [1:dt:length(SBE1527.time)];

for i = 1:length(num)
   F12.drdt2(i) = nanmean(F12.drdt(i:(i+1)-1));
   F12.time2(i) = nanmean(SBE1527.time(i:(i+1)-1));
end

% time in middle of 2 points
% for i = 1:length(SBE1527.time10)-1
% F12.drtime(i)  = (SBE1527.time10(i)+SBE1527.time10(i+1))./2;
% F12.drt(i)     = (SBE1527.t10(i)+SBE1527.t10(i+1))./2; 
% end

% 18m mooring: for 1mbs
%time averaged
t18        = SBE1525.time10.*86400;% time need to be in seconds
F18.drdt10 = diff(SBE1525.dens10)./diff(t18);
F18.drdt10 = [nan F18.drdt10];

% raw data:
time18   = SBE1525.time.*86400;% time need to be in seconds
F18.drdt = diff(SBE1525.dens)./diff(time18);
F18.drdt = [nan F18.drdt'];

%time average over 2 minute
st  = diff(SBE1525.time);
dt  = 120/(st(1)*86400); %2 min averaging
num = [1:dt:length(SBE1525.time)];

for i = 1:length(num)
   F18.drdt2(i) = nanmean(F18.drdt(i:(i+1)-1));
   F18.time2(i) = nanmean(SBE1525.time(i:(i+1)-1));
end

% for i = 1:length(SBE1525.time10)-1
% F18.drtime(i)  = (SBE1525.time10(i)+SBE1525.time10(i+1))./2;
% F18.drt(i)     = (SBE1525.t10(i)+SBE1525.t10(i+1))./2;
% end

%% Thickness plume --> first attempt

% Step 1: Find peak in density after high water --> use drho/dt
file = [12 18];

for k = file
    eval(['[zc]   = Zero_crossing(adcp',num2str(k),'.t,adcp',num2str(k),'.meanva);']);
    eval(['drhodt = 0.05 - F',num2str(k),'.drdt10;']);% invert data to find peaks of lower salinity
    n = length(zc);
    
    for i = 1:n-1
        [pks,locs] = findpeaks(drhodt(zc(i):(zc(i+1)-1)),'MinPeakDistance',40,'NPeaks',1);
        %     t   = adcp12.t(zc12(i):(zc12(i+1)-1));
        %     vc  = adcp12.vc(:,zc12(i):(zc12(i+1)-1));
        x                           = zc(i):zc(i+1)-1; % indices tidal period
        eval(['F',num2str(k),'.I(i) = x(locs);']);% indices of the peaks
        eval(['vc                   = adcp',num2str(k),'.vc(:,F',num2str(k),'.I(i));']);
        id                          = find(vc(6:end,1)<0 & vc(6:end)<-0.05,1)+5;
        
%         if k == 12
%             figure; % plot to check peaks
%             plot(adcp12.t(x),drhodt(x));
%             hold on
%             plot(adcp12.t(F12.I(i)),pks,'or');
%         end
        
        if isempty(id)==1;
            eval(['F',num2str(k),'.z(i) = nan;']); % when there is no onshore surface layer
        else
            eval(['F',num2str(k),'.z(i)     = adcp',num2str(k),'.z(id);']); % location of change of velocity signal over depth
        end
        
        eval(['F',num2str(k),'.thick(i) = adcp',num2str(k),'.h(F',num2str(k),'.I(i))-F',num2str(k),'.z(i);']); % thickness of plume based on velocities
        
        if eval(['F',num2str(k),'.thick(i)> 7']);
            eval(['F',num2str(k),'.thick(i) = nan;']);
        end
        
        eval(['F',num2str(k),'.Uf(i)    = nanmean(adcp',num2str(k),'.vc(id:end,F',num2str(k),'.I(i)));']); % estimation of propgation speed front
        eval(['F',num2str(k),'.time(i)  = adcp',num2str(k),'.time(F',num2str(k),'.I(i));']); % times of the peaks
        
        % reduced gravity, where rho1 is upper layer and rho2 is lower
        % layer
        if k == 12
            if eval(['F',num2str(k),'.thick(i) >= 3'])
                eval(['rho1 = (SBE1527.dens10(F',num2str(k),'.I(i))+SBE1526.dens10(F',num2str(k),'.I(i)))/2;']);
                eval(['rho2 = (SBE5426.dens10(F',num2str(k),'.I(i))+SBE5425.dens10(F',num2str(k),'.I(i))+SBE1842.dens10(F',num2str(k),'.I(i)))/3;']);
            else
                eval(['rho1 = SBE1527.dens10(F',num2str(k),'.I(i));']);
                eval(['rho2 = (SBE1526.dens10(F',num2str(k),'.I(i))+SBE5426.dens10(F',num2str(k),'.I(i))+SBE5425.dens10(F',num2str(k),'.I(i))+SBE1842.dens10(F',num2str(k),'.I(i)))/4;']);
            end
    
        elseif k == 18
            if eval(['F',num2str(k),'.thick(i) >= 2.5']);
                eval(['rho1 = (SBE1525.dens10(F',num2str(k),'.I(i))+SBE4939.dens10(F',num2str(k),'.I(i)))/2;']);
                eval(['rho2 = (SBE4940.dens10(F',num2str(k),'.I(i))+SBE19.dens10(F',num2str(k),'.I(i)))/2;']);
            else
                eval(['rho1 = SBE1525.dens10(F',num2str(k),'.I(i));']);
                eval(['rho2 = (SBE4939.dens10(F',num2str(k),'.I(i))+SBE4940.dens10(F',num2str(k),'.I(i))+SBE19.dens10(F',num2str(k),'.I(i)))/3;']);
            end
        end
        
        eval(['F',num2str(k),'.rg(i) = 9.81*(rho2-rho1)/rho2;']); 
        
    end
   
    
end

%% Froude number

F12.Fr = abs(F12.Uf)./sqrt(F12.rg.*F12.thick);
F18.Fr = abs(F18.Uf)./sqrt(F18.rg.*F18.thick);

%% Save matfiles

save(['D:\sabinerijnsbur\Matlab\Moorings\Metrics_Fronts'],'F12','F18');

