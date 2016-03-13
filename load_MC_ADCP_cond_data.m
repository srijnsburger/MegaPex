function load_MC_ADCP_cond_data(position,dirin)
%% Load matfiles

if strcmp(position,'12m');
    load([dirin,'SBE1526.mat']);
    load([dirin,'SBE1527.mat']);
    load([dirin,'SBE5425.mat']);
    load([dirin,'SBE5426.mat']);
    load([dirin,'SBE1842_corrected.mat']);
    load('d:\sabinerijnsbur\Matlab\adcp\adcp12.mat');
    adcp = adcp12;
    in.ylim = [0 15];
elseif strcmp(position,'18m')
    load([dirin,'SBE1525.mat']);
    load([dirin,'SBE4939.mat']);
    load([dirin,'SBE4940.mat']);
    load([dirin,'SBE19_corrected.mat']);
    load('d:\sabinerijnsbur\Matlab\adcp\adcp18.mat');
    adcp = adcp18;
    in.ylim = [0 20];
else
end

%% Load conditions
load('d:\sabinerijnsbur\Matlab\Measurements\Conditions\wave.mat');
load('d:\sabinerijnsbur\Matlab\Measurements\Conditions\tide.mat');
load('d:\sabinerijnsbur\Matlab\Measurements\Conditions\wind.mat');
load('d:\sabinerijnsbur\Matlab\Measurements\Conditions\potwind.mat');

end