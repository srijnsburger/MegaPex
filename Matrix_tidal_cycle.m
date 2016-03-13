%% MAKE MATRIX WITH SIGNALS CUTTED BASED ON 1 TIDAL CYCLE
clc,clear all,close all;
%% load data

mooring = '12';
dir     = 'd:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\';

load([dir,'Mooring',mooring,'_adcp_corr.mat']);

if strcmp(mooring,'12');
    load('d:\sabinerijnsbur\Matlab\adcp\adcp12C.mat');
    load([dir,'radar_adcp']);
    adcp = adcp12C;
    t    = M12.t;
    D    = M12.D;
    if strcmp(dir,'d:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\')
        va   = M12.va;
        vc   = M12.vc;
    end
else
    load('d:\sabinerijnsbur\Matlab\adcp\adcp18.mat');
    adcp = adcp18;
    t    = M18.t;
    D    = M18.D;
    if strcmp(dir,'d:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\')
        va   = M18.va;
        vc   = M18.vc;
    end
end

% %% Radar data
% 
% if strcmp(mooring,'12');
% %     nfiles = find(radar.t <= t(end),1,'last');
%     tmp.t = nan(size(t,1),size(t,2));
%     
%     for i = 1:numel(radar.t)
%         ind(i)        = find(t >= radar.t(i),1,'first');
%         tmp.t(ind(i)) = radar.t(i);
% 
%     end
%     
% end




%% Select tidal cycle

if strcmp(dir,'d:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\')
    ssh  = adcp.h-mean(adcp.h);
    [zc] = Zero_crossing(adcp.time,ssh);
    time = adcp.t;
else
    load('d:\sabinerijnsbur\Matlab\MegaPex\Conditions\tide');
    [ssh] = interp1(T1.t,T1.ssh,t);
    [zc]  = Zero_crossing(t,ssh);
    time  = t;
end

% Find the maxima --> HW 
for i = 1:length(zc)-1
    [m,idd] = max(ssh(zc(i):zc(i+1)));
    aux     = zc(i):zc(i+1);
    id(i)   = aux(idd);
end

%% Figures to check

% t = cell2mat({['t' mooring]});
% D = ['D',mooring];

% Check finding maxima
figure;
plot(time,ssh)
hold on
plot(time(id),ssh(id),'or');
hline(0,'k');

% Check cutting at LW slack
fig.cvline = 'k';

fig_handle1 = figure;
subplot(2,1,1)
plot(time,ssh)
hold on
hline(0,'k');
h = vline(time(zc),fig.cvline);
h2= vline(t(1,zc),'--r');

subplot(2,1,2)
plot(t(1,:),D(1,:)-1000)
hold on
hline(0,'k');
h  = vline(time(zc),fig.cvline);
h2 = vline(t(1,zc),'--r');

all_ha1 = findobj(fig_handle1,'type','axes','tag','');
linkaxes(all_ha1,'x');

%% Correct wrong zero-crossing

% Correction for wrong zero-crossings
for i = 1:length(zc)-1
    x(i) = zc(i+1)-zc(i)+1;
end 

[v,I]   = min(x);
zcc     = [zc(1:I-1),zc(I+1:end)];% removes wrong "cut"
[vv,II] = find(x<100);

%% Make matrix

% make matrix(dens, time, vel)
if strcmp(mooring,'12')
    MT.D1527 = nan((length(zcc)-1),max(x(II)));
    MT.D1526 = nan((length(zcc)-1),max(x(II)));
    MT.D5425 = nan((length(zcc)-1),max(x(II)));
    MT.D5426 = nan((length(zcc)-1),max(x(II)));
    MT.D1842 = nan((length(zcc)-1),max(x(II)));
    MT.ssh   = nan((length(zcc)-1),max(x(II)));
    MT.t     = nan((length(zcc)-1),max(x(II)));
    MTR.t    = nan((length(zcc)-1),max(x(II)));
    MTR.on11 = nan((length(zcc)-1),max(x(II)));
    MTR.on1l = nan((length(zcc)-1),max(x(II)));
    MTR.on1h = nan((length(zcc)-1),max(x(II)));
    MTR.on22 = nan((length(zcc)-1),max(x(II)));
    MTR.on2l = nan((length(zcc)-1),max(x(II)));
    MTR.off11 = nan((length(zcc)-1),max(x(II)));
    MTR.off1l = nan((length(zcc)-1),max(x(II)));
    MTR.off1r = nan((length(zcc)-1),max(x(II)));
    MTR.off1c = nan((length(zcc)-1),max(x(II)));
    MTR.off22 = nan((length(zcc)-1),max(x(II)));
    MTR.off3l = nan((length(zcc)-1),max(x(II)));
    if strcmp(dir,'d:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\')
        MT.va1527= nan((length(zcc)-1),max(x(II)));
        MT.va1526= nan((length(zcc)-1),max(x(II)));
        MT.va5425= nan((length(zcc)-1),max(x(II)));
        MT.va5426= nan((length(zcc)-1),max(x(II)));
        MT.va1842= nan((length(zcc)-1),max(x(II)));
        MT.va355 = nan((length(zcc)-1),max(x(II)));
        MT.vc1527= nan((length(zcc)-1),max(x(II)));
        MT.vc1526= nan((length(zcc)-1),max(x(II)));
        MT.vc5425= nan((length(zcc)-1),max(x(II)));
        MT.vc5426= nan((length(zcc)-1),max(x(II)));
        MT.vc1842= nan((length(zcc)-1),max(x(II)));
        MT.vc355 = nan((length(zcc)-1),max(x(II)));
        MT.dx    = nan((length(zcc)-1),max(x(II)));
        MT.tdx   = nan((length(zcc)-1),max(x(II)));
        MT.tt    = nan((length(zcc)-1),max(x(II)));
    end
    
    for i = 1:length(zcc)-1
        nz = length(D(1,zcc(i):zcc(i+1)));
        if nz > max(x(II))
            MT.D1527(i,1:max(x(II))) = nan;
            MT.D1526(i,1:max(x(II))) = nan;
            MT.D5426(i,1:max(x(II))) = nan;
            MT.D5425(i,1:max(x(II))) = nan;
            MT.D1842(i,1:max(x(II))) = nan;
            MT.ssh(i,1:max(x(II)))   = nan;
            MT.t(i,1:max(x(II)))     = nan;
            MTR.t(i,1:max(x(II)))    = nan;
            MTR.on11(i,1:max(x(II))) = nan;
            MTR.on1l(i,1:max(x(II))) = nan;
            MTR.on1h(i,1:max(x(II))) = nan;
            MTR.on22(i,1:max(x(II))) = nan;
            MTR.on2l(i,1:max(x(II))) = nan;
            MTR.off11(i,1:max(x(II)))= nan;
            MTR.off1l(i,1:max(x(II)))= nan;
            MTR.off1r(i,1:max(x(II)))= nan;
            MTR.off1c(i,1:max(x(II)))= nan;
            MTR.off22(i,1:max(x(II)))= nan;
            MTR.off3l(i,1:max(x(II)))= nan;
            if strcmp(dir,'d:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\')
                MT.va1527(i,1:max(x(II)))= nan;
                MT.va1526(i,1:max(x(II)))= nan;
                MT.va5425(i,1:max(x(II)))= nan;
                MT.va5426(i,1:max(x(II)))= nan;
                MT.va1842(i,1:max(x(II)))= nan;
                MT.va355(i,1:max(x(II))) = nan;
                MT.vc1527(i,1:max(x(II)))= nan;
                MT.vc1526(i,1:max(x(II)))= nan;
                MT.vc5425(i,1:max(x(II)))= nan;
                MT.vc5426(i,1:max(x(II)))= nan;
                MT.vc1842(i,1:max(x(II)))= nan;
                MT.vc355(i,1:max(x(II))) = nan;
                MT.dx(i,1:max(x(II)))    = nan;
                MT.tdx(i,1:max(x(II)))   = nan;
                MT.tt(i,1:max(x(II)))    = nan;
            end
        else
            MT.D1527(i,1:nz) = D(1,zcc(i):zcc(i+1));
            MT.D1526(i,1:nz) = D(2,zcc(i):zcc(i+1));
            MT.D5426(i,1:nz) = D(3,zcc(i):zcc(i+1));
            MT.D5425(i,1:nz) = D(4,zcc(i):zcc(i+1));
            MT.D1842(i,1:nz) = D(5,zcc(i):zcc(i+1));
            MT.ssh(i,1:nz)   = ssh(zcc(i):zcc(i+1));
            MT.t(i,1:nz)     = t(zcc(i):zcc(i+1));
            MTR.t(i,1:nz)    = radar.t(zcc(i):zcc(i+1));
            MTR.on11(i,1:nz) = radar.on11(zcc(i):zcc(i+1));
            MTR.on1l(i,1:nz) = radar.on1l(zcc(i):zcc(i+1));
            MTR.on1h(i,1:nz) = radar.on1h(zcc(i):zcc(i+1));
            MTR.on22(i,1:nz) = radar.on22(zcc(i):zcc(i+1));
            MTR.on2l(i,1:nz) = radar.on2l(zcc(i):zcc(i+1));
            MTR.off11(i,1:nz)= radar.off11(zcc(i):zcc(i+1));
            MTR.off1l(i,1:nz)= radar.off1l(zcc(i):zcc(i+1));
            MTR.off1r(i,1:nz)= radar.off1r(zcc(i):zcc(i+1));
            MTR.off1c(i,1:nz)= radar.off1c(zcc(i):zcc(i+1));
            MTR.off22(i,1:nz)= radar.off22(zcc(i):zcc(i+1));
            MTR.off3l(i,1:nz)= radar.off3l(zcc(i):zcc(i+1));
            if strcmp(dir,'d:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\')
                MT.va1527(i,1:nz)= va(1,zcc(i):zcc(i+1));
                MT.va1526(i,1:nz)= va(2,zcc(i):zcc(i+1));
                MT.va5425(i,1:nz)= va(3,zcc(i):zcc(i+1));
                MT.va5426(i,1:nz)= va(4,zcc(i):zcc(i+1));
                MT.va1842(i,1:nz)= va(5,zcc(i):zcc(i+1));
                MT.va355(i,1:nz) = va(6,zcc(i):zcc(i+1));
                MT.vc1527(i,1:nz)= vc(1,zcc(i):zcc(i+1));
                MT.vc1526(i,1:nz)= vc(2,zcc(i):zcc(i+1));
                MT.vc5425(i,1:nz)= vc(3,zcc(i):zcc(i+1));
                MT.vc5426(i,1:nz)= vc(4,zcc(i):zcc(i+1));
                MT.vc1842(i,1:nz)= vc(5,zcc(i):zcc(i+1));
                MT.vc355(i,1:nz) = vc(6,zcc(i):zcc(i+1));
%                 MT.dx(i,1:nz)    = (6,zcc(i):zcc(i+1));
            end
        end
    end
    
    MT.tg = 1:max(x(II));
    
elseif strcmp(mooring,'18');
    MT.D1525 = nan((length(zcc)-1),max(x(II)));
    MT.D4939 = nan((length(zcc)-1),max(x(II)));
    MT.D4940 = nan((length(zcc)-1),max(x(II)));
    MT.D19   = nan((length(zcc)-1),max(x(II)));
    MT.ssh   = nan((length(zcc)-1),max(x(II)));
    MT.t     = nan((length(zcc)-1),max(x(II)));
    if strcmp(dir,'d:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\')
        MT.va1525= nan((length(zcc)-1),max(x(II)));
        MT.va4939= nan((length(zcc)-1),max(x(II)));
        MT.va4940= nan((length(zcc)-1),max(x(II)));
        MT.va19  = nan((length(zcc)-1),max(x(II)));
        MT.vc1525= nan((length(zcc)-1),max(x(II)));
        MT.vc4939= nan((length(zcc)-1),max(x(II)));
        MT.vc4940= nan((length(zcc)-1),max(x(II)));
        MT.vc19  = nan((length(zcc)-1),max(x(II)));
    end
    
    for i = 1:length(zcc)-1
        nz = length(D(1,zcc(i):zcc(i+1)));
        if nz > max(x(II))
            MT.D1525(i,1:max(x(II))) = nan;
            MT.D4939(i,1:max(x(II))) = nan;
            MT.D4940(i,1:max(x(II))) = nan;
            MT.D19  (i,1:max(x(II))) = nan;
            MT.ssh(i,1:max(x(II)))   = nan;
            MT.t(i,1:max(x(II)))     = nan;
            if strcmp(dir,'d:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\')
                MT.va1525(i,1:max(x(II)))= nan;
                MT.va4939(i,1:max(x(II)))= nan;
                MT.va4940(i,1:max(x(II)))= nan;
                MT.va19  (i,1:max(x(II)))= nan;
                MT.vc1525(i,1:max(x(II)))= nan;
                MT.vc4939(i,1:max(x(II)))= nan;
                MT.vc4940(i,1:max(x(II)))= nan;
                MT.vc19  (i,1:max(x(II)))= nan;
            end
        else
            MT.D1525(i,1:nz) = D(1,zcc(i):zcc(i+1));
            MT.D4939(i,1:nz) = D(2,zcc(i):zcc(i+1));
            MT.D4940(i,1:nz) = D(3,zcc(i):zcc(i+1));
            MT.D19(i,1:nz)   = D(4,zcc(i):zcc(i+1));
            MT.ssh(i,1:nz)   = ssh(zcc(i):zcc(i+1));
            MT.t(i,1:nz)     = t(zcc(i):zcc(i+1));
            if strcmp(dir,'d:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\')
                MT.va1525(i,1:nz)= va(1,zcc(i):zcc(i+1));
                MT.va4939(i,1:nz)= va(2,zcc(i):zcc(i+1));
                MT.va4940(i,1:nz)= va(3,zcc(i):zcc(i+1));
                MT.va19(i,1:nz)  = va(4,zcc(i):zcc(i+1));
                MT.vc1525(i,1:nz)= vc(1,zcc(i):zcc(i+1));
                MT.vc4939(i,1:nz)= vc(2,zcc(i):zcc(i+1));
                MT.vc4940(i,1:nz)= vc(3,zcc(i):zcc(i+1));
                MT.vc19(i,1:nz)  = vc(4,zcc(i):zcc(i+1));
            end
        end
    end
    
    MT.tg = 1:max(x(II));
end

eval(['MT' mooring '= MT;']);
save([dir,'Matrix_TC_' mooring],['MT' mooring]);

if strcmp(mooring,'12')
save([dir,'Matrix_TC_' mooring],'-append',['MTR']);
end

