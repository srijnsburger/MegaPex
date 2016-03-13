% Define spring-neap cycle

% MegaPex data
load('d:\sabinerijnsbur\Matlab\Measurements\Conditions\tide.mat');
load('d:\sabinerijnsbur\Matlab\adcp\adcp12.mat');

T1.neap1   = find(T1.t>=adcp12.t(1) & T1.t<266);
T1.spr1    = find(T1.t>266 & T1.t<273);
T1.neap2   = find(T1.t>273 & T1.t<280);
T1.spr2    = find(T1.t>280 & T1.t<287);
T1.neap3   = find(T1.t>287 & T1.t<294);
T1.spr3    = find(T1.t>294 & T1.t<301);
T1.neap4   = find(T1.t>301 & T1.t<303);

save('d:\sabinerijnsbur\Matlab\Measurements\Conditions\tide.mat','T1','T2');

%% Based on adcp


