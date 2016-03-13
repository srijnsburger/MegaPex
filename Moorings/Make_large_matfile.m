%% Making Large matfile
clc;clear all;close all;

dirin  = 'd:\sabinerijnsbur\Matlab\Moorings\Mfiles\';
dirout = 'd:\sabinerijnsbur\Matlab\Moorings\Mfiles\';

%% 12m
load([dirin,'SBE1526.mat']);
load([dirin,'SBE1527.mat']);
load([dirin,'SBE5425.mat']);
load([dirin,'SBE5426.mat']);
load([dirin,'SBE1842_corrected.mat']);
load('d:\sabinerijnsbur\Matlab\adcp\adcp12C.mat');


p1526 = SBE1526.pref*ones(1,size(SBE1526.t10,2));
p1527 = SBE1527.pref*ones(1,size(SBE1527.t10,2));

M12.S = [SBE1527.sal10 ; SBE1526.sal10; SBE5426.sal10; SBE5425.sal10; SBE1842.sal10];
M12.T = [SBE1527.temp10 ; SBE1526.temp10; SBE5426.temp10; SBE5425.temp10; SBE1842.temp10];
M12.C = [SBE1527.cond10 ; SBE1526.cond10; SBE5426.cond10; SBE5425.cond10; SBE1842.cond10];
M12.D = [SBE1527.dens10 ; SBE1526.dens10; SBE5426.dens10; SBE5425.dens10; SBE1842.dens10];
M12.t = SBE1527.t10;
M12.P = [p1527 ; p1526; SBE5426.press10; SBE5425.press10; SBE1842.press10];
M12.time = SBE1527.time10;
M12.note = {'Data is time-averaged for entire timeseries','for averaging adcp times used and extended','Salinity SBE1842 and SBE19 are corrected!'};

if strcmp(dirin,'d:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\')
    for i = 1:size(M12.P,1)
        for j = 1:size(M12.P,2)
            loc       = adcp12C.h(j)-M12.P(i,j);
            id        = find(loc <= adcp12C.z,1);
            M12.va(i,j) = adcp12C.va(id,j);
            M12.vc(i,j) = adcp12C.vc(id,j);
        end
    end
    
    if isnan(M12.vc(5,:))==1;
        M12.vc(6,:) = adcp12C.vc(3,:); % adding ADV velocity at 0.78 mab instead 
        M12.va(6,:) = adcp12C.va(3,:);
    end
        
    M12.ssh = adcp12C.h-mean(adcp12C.h);
    
    save([dirout,'Mooring12_adcp_corr'],'M12');
else
    save([dirout,'Mooring12_av_corr'],'M12');
end

%% 18m

load([dirin,'SBE1525.mat']);
load([dirin,'SBE4939.mat']);
load([dirin,'SBE4940.mat']);
load([dirin,'SBE19_corrected.mat']);
load('d:\sabinerijnsbur\Matlab\adcp\adcp18.mat');

p1525 = SBE1525.pref*ones(1,size(SBE1525.t10,2));

M18.S = [SBE1525.sal10; SBE4939.sal10; SBE4940.sal10; SBE19.sal10];
M18.T = [SBE1525.temp10; SBE4939.temp10; SBE4940.temp10; SBE19.temp10];
M18.C = [SBE1525.cond10; SBE4939.cond10; SBE4940.cond10; SBE19.cond10];
M18.D = [SBE1525.dens10; SBE4939.dens10; SBE4940.dens10; SBE19.dens10];
M18.t = SBE1525.t10;
M18.P = [p1525 ; SBE4939.press10; SBE4940.press10; SBE19.press10];
M18.time = SBE1525.time10;
M18.note = {'Data is time-averaged for entire timeseries','for averaging adcp times used and extended','Salinity SBE1842 and SBE19 are corrected!'};

if strcmp(dirin,'d:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\')
    for i = 1:size(M18.P,1)
        for j = 1:size(M18.P,2)
            loc       = adcp18.h(j)-M18.P(i,j);
            id        = find(loc <= adcp18.z,1);
            M18.va(i,j) = adcp18.va(id,j);
            M18.vc(i,j) = adcp18.vc(id,j);
        end
    end
    
    M18.ssh = adcp18.h-mean(adcp18.h);
    
    save([dirout,'Mooring18_adcp_corr'],'M18');
else
    save([dirout,'Mooring18_av_corr'],'M18');
end
