clc;clear all;close all;

% Load data
dir  = 'd:\sabinerijnsbur\Matlab_files\Megapex_data\Moorings\Mfiles_adcp\';
load([dir,'Mooring18_adcp_corr.mat']);
load([dir,'Mooring12_adcp_corr.mat']);

%% Calculate relative displacement dx - 12m
tt = M12.t*24*60*60; % in sec

[dx12_s] = f_trapz(tt,M12.vc(1,:)); % displacement surface
[dx12_b] = f_trapz(tt,M12.vc(6,:)); % displacement bottom

P12.dx = dx12_s - dx12_b;

% vcc     = vc12(1,:)-vc12(4,:); % surface - bottom
% [dx12,dx122]  = f_trapz(tt,vcc); % relative displacement between -1 and -11.25m

for i = 1:length(M12.t)-1
P12.tt(i)  = (M12.t(i)+M12.t(i+1))/2;
end

%% Calculate relative displacement dx - 18m
t = M18.t*24*60*60; % in sec

[dx18_s] = f_trapz(t,M18.vc(2,:)); % displacement surface
[dx18_b] = f_trapz(t,M18.vc(4,:)); % displacement surface

P18.dx = dx18_s - dx18_b;

% vc     = vc18(2,:)-vc18(4,:); % surface - bottom
% [dx18] = f_trapz(t,vc); % relative displacement between -2.5 and -15mm

for i = 1:length(M18.t)-1
P18.tt(i)  = (M18.t(i)+M18.t(i+1))/2;
end

%% Tidal velocity 12m - based on entire timeseries

load('d:\sabinerijnsbur\Matlab_files\Megapex_data\Tidalanalysis\T12.mat');

tt = T12.t*24*60*60; % in sec

[dx12_s] = f_trapz(tt,T12.vc(44,:)); % displacement surface
[dx12_b] = f_trapz(tt,T12.vc(3,:)); % displacement bottom

P12.tdx = dx12_s - dx12_b;
T12.dx  = P12.tdx;

% [TC12.dx12_s] = f_trapz(tt,vc12(1,:)); % displacement surface

% vc2       = TC12.vcPM(2,:)-TC12.vcPM(4,:); % surface (3mbs) - bottom
% % vc2       = TC12.vcPM(4,:)-TC12.vcPM(2,:); % bottom - surface (3mbs)
% [TC12.dx] = f_trapz(tt,vc2); % relative displacement between -8 and -3m
% [TC12.dx] = f_trapz(tt,vc2); % relative displacement between -3 and -8m

for i = 1:length(T12.t)-1
T12.tdx(i)  = (T12.t(i)+T12.t(i+1))/2;
end

save('d:\sabinerijnsbur\Matlab_files\Megapex_data\Tidalanalysis\T12','T12');
save([dir,'Parameters12'],'P12');
% save('d:\sabinerijnsbur\Matlab_files\Megapex_data\Moorings\Parameters12','P12');
% clc;clear all;close all;

%% Tidal velocity 18m - based on entire timeseries

load('d:\sabinerijnsbur\Matlab_files\Megapex_data\Tidalanalysis\T18.mat');

tt = T18.t*24*60*60; % in sec

[dx18_s] = f_trapz(tt,T18.vc(58,:)); % displacement surface
[dx18_b] = f_trapz(tt,T18.vc(1,:)); % displacement bottom

P18.tdx = dx18_s - dx18_b;
T18.dx  = P18.tdx;
% % vc3       = TC18.vcPM(2,:)-TC18.vcPM(4,:); % surface - bottom
% vc3       = TC18.vcPM(4,:)-TC18.vcPM(2,:); % bottom - surface
% % [TC18.dx] = f_trapz(tt,vc3); % relative displacement between -2.5 and -15m
% [TC18.dx] = f_trapz(tt,vc3); % relative displacement between -15 and -2.5m

for i = 1:length(T18.t)-1
T18.tdx(i)  = (T18.t(i)+T18.t(i+1))/2;
end

save('d:\sabinerijnsbur\Matlab_files\Megapex_data\Tidalanalysis\T18','T18');
save([dir,'Parameters18'],'P18');
% save('d:\sabinerijnsbur\Matlab_files\Megapex_data\Moorings\Parameters18','P18');

%% Tidal velocity 12m - based on M2 tide

load('d:\sabinerijnsbur\Matlab_files\Megapex_data\Tidalanalysis\TC12.mat');

tt = TC12.t*24*60*60; % in sec

[dx12_s] = f_trapz(tt,TC12.vc(45,:)); % displacement surface
[dx12_b] = f_trapz(tt,TC12.vc(3,:)); % displacement bottom

TC12.dx = dx12_s - dx12_b;

% [TC12.dx12_s] = f_trapz(tt,vc12(1,:)); % displacement surface

% vc2       = TC12.vcPM(2,:)-TC12.vcPM(4,:); % surface (3mbs) - bottom
% % vc2       = TC12.vcPM(4,:)-TC12.vcPM(2,:); % bottom - surface (3mbs)
% [TC12.dx] = f_trapz(tt,vc2); % relative displacement between -8 and -3m
% [TC12.dx] = f_trapz(tt,vc2); % relative displacement between -3 and -8m

for i = 1:length(TC12.t)-1
TC12.tdx(i)  = (TC12.t(i)+TC12.t(i+1))/2;
end

save('d:\sabinerijnsbur\Matlab_files\Megapex_data\Tidalanalysis\TC12','TC12');
% clc;clear all;close all;

%% Tidal velocity 18m - based on M2 tide

load('d:\sabinerijnsbur\Matlab_files\Megapex_data\Tidalanalysis\TC18.mat');

tt = TC18.t*24*60*60; % in sec

[dx18_s] = f_trapz(tt,TC18.vc(59,:)); % displacement surface
[dx18_b] = f_trapz(tt,TC18.vcPM(4,:)); % displacement bottom

TC18.dx = dx18_s - dx18_b;

% % vc3       = TC18.vcPM(2,:)-TC18.vcPM(4,:); % surface - bottom
% vc3       = TC18.vcPM(4,:)-TC18.vcPM(2,:); % bottom - surface
% % [TC18.dx] = f_trapz(tt,vc3); % relative displacement between -2.5 and -15m
% [TC18.dx] = f_trapz(tt,vc3); % relative displacement between -15 and -2.5m

for i = 1:length(TC18.t)-1
TC18.tdx(i)  = (TC18.t(i)+TC18.t(i+1))/2;
end

save('d:\sabinerijnsbur\Matlab_files\Megapex_data\Tidalanalysis\TC18','TC18');