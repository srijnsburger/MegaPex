
mooring = '12m';
load('d:\sabinerijnsbur\Matlab\adcp\adcp12.mat');
adcp = adcp12;

% instruments mooring
dirin = 'd:\sabinerijnsbur\Matlab\Moorings\Mfiles\';

if strcmp(mooring,'12m');
    load([dirin,'SBE1526.mat']);
    load([dirin,'SBE1527.mat']);
    load([dirin,'SBE5425.mat']);
    load([dirin,'SBE5426.mat']);
    load([dirin,'SBE1842_corrected.mat']);
    in.dR   = SBE1842.dens10 - SBE1527.dens10;
    in.dRs  = SBE1526.dens10 - SBE1527.dens10;
    in.dRb  = SBE1842.dens10 - SBE5425.dens10;
    in.dR2  = SBE1842.dens10 - SBE1526.dens10;
    in.time10  = SBE1527.time10;
    in.t10     = SBE1527.t10;
    in.ylim = [0 15];
elseif strcmp(mooring,'18m')
    load([dirin,'SBE1525.mat']);
    load([dirin,'SBE4939.mat']);
    load([dirin,'SBE4940.mat']);
    load([dirin,'SBE19_corrected.mat']);
    in.dR   = SBE19.dens10 - SBE1525.dens10;
    in.dRs  = SBE4939.dens10 - SBE1525.dens10;
    in.dRb  = SBE19.dens10 - SBE4940.dens10;
    in.dR2  = SBE19.dens10 - SBE4939.dens10;
    in.time10  = SBE1525.time10;
    in.t10     = SBE1525.t10;
    in.ylim = [0 20];
else
end

% conditions
load('d:\sabinerijnsbur\Matlab\Measurements\Conditions\wave.mat');
load('d:\sabinerijnsbur\Matlab\Measurements\Conditions\tide.mat');
load('d:\sabinerijnsbur\Matlab\Measurements\Conditions\wind.mat');
% load('d:\sabinerijnsbur\Matlab\Measurements\Conditions\potwind.mat');

[vel] = surface_bottom_velocity(adcp.va,adcp.vc);