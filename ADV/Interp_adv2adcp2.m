% Interpolate ADV to ADCP

%% ADV 355 (0.75mab)

dirin = 'd:\sabinerijnsbur\Matlab\Mini-stable\';
load([dirin,'adv355']);
load(['d:\sabinerijnsbur\Matlab\adcp\adcp12.mat']);

x1 = find(adv355.ba.time > adcp12.time(1),1,'first');
x2 = find(adv355.ba.time > adcp12.time(end),1,'first');
adv355_int.va   = interp1(adv355.ba.time(x1:x2-1),adv355.ba.va(x1:x2-1),adcp12.time);
adv355_int.vc   = interp1(adv355.ba.time(x1:x2-1),adv355.ba.vc(x1:x2-1),adcp12.time);
adv355_int.time = adcp12.time; 
adv355_int.t    = adcp12.t; 
adv355_int.depth= '0.75mab';

save([dirin,'adv355_int'],'adv355_int');


%% ADV 358 (0.5mab)

dirin = 'd:\sabinerijnsbur\Matlab\Mini-stable\';
load([dirin,'adv358']);
load(['d:\sabinerijnsbur\Matlab\adcp\adcp12.mat']);

x1 = find(adv358.ba.time > adcp12.time(1),1,'first');
x2 = find(adv358.ba.time > adcp12.time(end),1,'first');
adv358_int.va   = interp1(adv358.ba.time(x1:x2-1),adv358.ba.va(x1:x2-1),adcp12.time);
adv358_int.vc   = interp1(adv358.ba.time(x1:x2-1),adv358.ba.vc(x1:x2-1),adcp12.time);
adv358_int.time = adcp12.time; 
adv358_int.t    = adcp12.t; 
adv358_int.depth= '0.5mab';

save([dirin,'adv358_int'],'adv358_int');

%% ADV 496 (0.25mab)

dirin = 'd:\sabinerijnsbur\Matlab\Mini-stable\';
load([dirin,'adv496']);
load(['d:\sabinerijnsbur\Matlab\adcp\adcp12.mat']);

x1 = find(adv496.ba.time > adcp12.time(1),1,'first');
x2 = find(adv496.ba.time > adcp12.time(end),1,'first');
adv496_int.va   = interp1(adv496.ba.time(x1:x2-1),adv496.ba.va(x1:x2-1),adcp12.time);
adv496_int.vc   = interp1(adv496.ba.time(x1:x2-1),adv496.ba.vc(x1:x2-1),adcp12.time);
adv496_int.time = adcp12.time; 
adv496_int.t    = adcp12.t; 
adv496_int.depth = '0.25mab';

save([dirin,'adv496_int'],'adv496_int');
