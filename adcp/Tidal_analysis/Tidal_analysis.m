% Tidal analysis
%% Load data
clc;clear all;close all;

Loc       = '18'; %Location

if find(strcmp(Loc,'12')==1)
    load('d:\sabinerijnsbur\Matlab_files\Megapex_data\adcp\adcp12C');
    adcp = adcp12C;
else
   eval(['load(''d:\sabinerijnsbur\Matlab_files\Megapex_data\adcp\adcp' Loc ''');']);
   eval(['adcp = adcp' Loc ''';']);
end

%% Tidal analysis

dt  = diff(adcp.time)*24;
lat = 52.06883;

for iz=1:size(adcp.va,1)% loopover z
    
    U = adcp.va(iz,:) + sqrt(-1).*adcp.vc(iz,:);
    
    if sum(isnan(U))<100
        
        [S,Ufitted] = t_tide(U,'interval',dt,'start',adcp.time(1),'latitude',lat,'output','none','error','linear'); %
        T.va(iz,:) = real(Ufitted);
        T.vc(iz,:) = imag(Ufitted);
    else
        T.va(iz,:) = nan;
        T.vc(iz,:) = nan;
    end
   
end

T.time  = adcp.time;
T.t     = adcp.t;
T.notes = {'Tidal analysis based on entire timeseries','nodal corrections'};

eval(['T' Loc '= T;']);
save(['d:\sabinerijnsbur\Matlab_files\Megapex_data\Tidalanalysis\T' Loc],['T' Loc ]);

