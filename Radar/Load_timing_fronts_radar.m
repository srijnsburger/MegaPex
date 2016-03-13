%% RADAR INFORMATION
clc;clear all;close all;

% Load excell file
file   = 'D:\sabinerijnsbur\Matlab\Fronts_Radar.xlsx';
[num,txt,raw] = xlsread(file,'Fronts_radar');

% Convert to matfile
radar.time = datenum(txt(2:end,1),'dd-mm-yyyy HH:MM:SS');
radar.t    = day_of_year(radar.time);
radar.dir  = txt(2:end,2);
radar.from = txt(2:end,3);
radar.remarks = txt(2:end,4);

% Make classifications
%directions
radar.on1   = find(and(strcmp(radar.dir,'se')==1,strcmp(radar.from,'nw')==1));% onshore: from nw to se
radar.on2   = find(and(strcmp(radar.dir,'se')==1,strcmp(radar.from,'w')==1));% onshore: from w to se
radar.off1  = find(and(strcmp(radar.dir,'nw')==1,strcmp(radar.from,'se')==1));% offshore: from se to nw
radar.off2  = find(and(strcmp(radar.dir,'nw')==1,strcmp(radar.from,'e')==1));% offshore: from e to nw
radar.off3  = find(and(strcmp(radar.dir,'w')==1,strcmp(radar.from,'e')==1));% offshore: from e to w
% some extra remarks
radar.light = find(strcmp(radar.remarks,'light'));% light feature in radar, difficult to examine
radar.refl  = find(strcmp(radar.remarks,'reflected'));% onshore directed front reflected back offshore
radar.hang  = find(strcmp(radar.remarks,'hanging'));% front stays for longer time around moorings
radar.conv  = find(strcmp(radar.remarks,'convergence'));% 2 fronts meet at loc moorings
% combined
radar.on11  = find(and(strcmp(radar.dir,'se')==1,strcmp(radar.from,'nw')==1) & strcmp(radar.remarks,'')==1);
radar.on1l  = find(and(strcmp(radar.dir,'se')==1,strcmp(radar.from,'nw')==1) & strcmp(radar.remarks,'light')==1);
radar.on1h  = find(and(strcmp(radar.dir,'se')==1,strcmp(radar.from,'nw')==1) & strcmp(radar.remarks,'hanging')==1);
radar.on22  = find(and(strcmp(radar.dir,'se')==1,strcmp(radar.from,'w')==1)& strcmp(radar.remarks,'')==1);
radar.on2l  = find(and(strcmp(radar.dir,'se')==1,strcmp(radar.from,'w')==1)& strcmp(radar.remarks,'light')==1);
radar.off11 = find(and(strcmp(radar.dir,'nw')==1,strcmp(radar.from,'se')==1)& strcmp(radar.remarks,'')==1);
radar.off1l = find(and(strcmp(radar.dir,'nw')==1,strcmp(radar.from,'se')==1)& strcmp(radar.remarks,'light')==1);
radar.off1r = find(and(strcmp(radar.dir,'nw')==1,strcmp(radar.from,'se')==1)& strcmp(radar.remarks,'reflected')==1);
radar.off1c = find(and(strcmp(radar.dir,'nw')==1,strcmp(radar.from,'se')==1)& strcmp(radar.remarks,'convergence')==1);
radar.off22 = find(and(strcmp(radar.dir,'nw')==1,strcmp(radar.from,'e')==1)& strcmp(radar.remarks,'')==1);
radar.off3l = find(and(strcmp(radar.dir,'w')==1,strcmp(radar.from,'e')==1)& strcmp(radar.remarks,'light')==1);

% Explanation
radar.notes = {'on1 = to se from nw','on2 = to se from w','off1 = to nw from se','off2 = to nw from e','off3 = to w from e';'light = light in radar/difficult to see','reflected = onsh directed front reflected back off','hanging = front stays for longer time there','convergence = 2 fronts meet at loc',' '};

save('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\radar','radar');

%% Adjusted to adcp data grid

% Adjust length wrt adcp data
load('d:\sabinerijnsbur\Matlab\adcp\adcp12C.mat');

nfiles       = find(radar.t <= adcp12C.t(end),1,'last');
tmp.t        = nan(size(adcp12C.t,1),size(adcp12C.t,2));
tmp.dir      = cell(size(adcp12C.t,1),size(adcp12C.t,2));
tmp.from     = cell(size(adcp12C.t,1),size(adcp12C.t,2));
tmp.remarks  = cell(size(adcp12C.t,1),size(adcp12C.t,2));   

    for i = 1:nfiles
        ind(i)             = find(adcp12C.t >= radar.t(i),1,'first');
        tmp.t(ind(i))      = radar.t(i);
        tmp.dir{ind(i)}    = radar.dir{i};
        tmp.from{ind(i)}   = radar.from{i};
        tmp.remarks{ind(i)}= radar.remarks{i};
    end

% Make classifications same as above
%directions
tmp.ind.on1   = find(and(strcmp(tmp.dir,'se')==1,strcmp(tmp.from,'nw')==1));% onshore: from nw to se
tmp.ind.on2   = find(and(strcmp(tmp.dir,'se')==1,strcmp(tmp.from,'w')==1));% onshore: from w to se
tmp.ind.off1  = find(and(strcmp(tmp.dir,'nw')==1,strcmp(tmp.from,'se')==1));% offshore: from se to nw
tmp.ind.off2  = find(and(strcmp(tmp.dir,'nw')==1,strcmp(tmp.from,'e')==1));% offshore: from e to nw
tmp.ind.off3  = find(and(strcmp(tmp.dir,'w')==1,strcmp(tmp.from,'e')==1));% offshore: from e to w
% some extra remarks
tmp.ind.light = find(strcmp(tmp.remarks,'light'));% light feature in radar, difficult to examine
tmp.ind.refl  = find(strcmp(tmp.remarks,'reflected'));% onshore directed front reflected back offshore
tmp.ind.hang  = find(strcmp(tmp.remarks,'hanging'));% front stays for longer time around moorings
tmp.ind.conv  = find(strcmp(tmp.remarks,'convergence'));% 2 fronts meet at loc moorings
% combined
tmp.ind.on11  = find(and(strcmp(tmp.dir,'se')==1,strcmp(tmp.from,'nw')==1) & strcmp(tmp.remarks,'')==1);
tmp.ind.on1l  = find(and(strcmp(tmp.dir,'se')==1,strcmp(tmp.from,'nw')==1) & strcmp(tmp.remarks,'light')==1);
tmp.ind.on1h  = find(and(strcmp(tmp.dir,'se')==1,strcmp(tmp.from,'nw')==1) & strcmp(tmp.remarks,'hanging')==1);
tmp.ind.on22  = find(and(strcmp(tmp.dir,'se')==1,strcmp(tmp.from,'w')==1)& strcmp(tmp.remarks,'')==1);
tmp.ind.on2l  = find(and(strcmp(tmp.dir,'se')==1,strcmp(tmp.from,'w')==1)& strcmp(tmp.remarks,'light')==1);
tmp.ind.off11 = find(and(strcmp(tmp.dir,'nw')==1,strcmp(tmp.from,'se')==1)& strcmp(tmp.remarks,'')==1);
tmp.ind.off1l = find(and(strcmp(tmp.dir,'nw')==1,strcmp(tmp.from,'se')==1)& strcmp(tmp.remarks,'light')==1);
tmp.ind.off1r = find(and(strcmp(tmp.dir,'nw')==1,strcmp(tmp.from,'se')==1)& strcmp(tmp.remarks,'reflected')==1);
tmp.ind.off1c = find(and(strcmp(tmp.dir,'nw')==1,strcmp(tmp.from,'se')==1)& strcmp(tmp.remarks,'convergence')==1);
tmp.ind.off22 = find(and(strcmp(tmp.dir,'nw')==1,strcmp(tmp.from,'e')==1)& strcmp(tmp.remarks,'')==1);
tmp.ind.off3l = find(and(strcmp(tmp.dir,'w')==1,strcmp(tmp.from,'e')==1)& strcmp(tmp.remarks,'light')==1);

tmp.on11 = nan(size(adcp12C.t,1),size(adcp12C.t,2));
tmp.on1l = nan(size(adcp12C.t,1),size(adcp12C.t,2));
tmp.on1h = nan(size(adcp12C.t,1),size(adcp12C.t,2));
tmp.on22 = nan(size(adcp12C.t,1),size(adcp12C.t,2));
tmp.on2l = nan(size(adcp12C.t,1),size(adcp12C.t,2));
tmp.off11 = nan(size(adcp12C.t,1),size(adcp12C.t,2));
tmp.off1l = nan(size(adcp12C.t,1),size(adcp12C.t,2));
tmp.off1r = nan(size(adcp12C.t,1),size(adcp12C.t,2));
tmp.off1c = nan(size(adcp12C.t,1),size(adcp12C.t,2));
tmp.off22 = nan(size(adcp12C.t,1),size(adcp12C.t,2));
tmp.off3l = nan(size(adcp12C.t,1),size(adcp12C.t,2));

tmp.on11(tmp.ind.on11,1) = 1;
tmp.on1l(tmp.ind.on1l,1) = 1;
tmp.on1h(tmp.ind.on1h,1) = 1;
tmp.on22(tmp.ind.on22,1) = 1;
tmp.on2l(tmp.ind.on2l,1) = 1;
tmp.off11(tmp.ind.off11,1) = 1;
tmp.off1l(tmp.ind.off1l,1) = 1;
tmp.off1r(tmp.ind.off1r,1) = 1;
tmp.off1c(tmp.ind.off1c,1) = 1;
tmp.off22(tmp.ind.off22,1) = 1;
tmp.off3l(tmp.ind.off3l,1) = 1;

% Explanation
tmp.notes = {'on1 = to se from nw','on2 = to se from w','off1 = to nw from se','off2 = to nw from e','off3 = to w from e';'light = light in radar/difficult to see','reflected = onsh directed front reflected back off','hanging = front stays for longer time there','convergence = 2 fronts meet at loc',' '};

clear radar
radar = tmp;
save('d:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\radar_adcp','radar');

%% Adjusted to density signal
clc;clear all;close all;

% Adjust length wrt ctd data
load('d:\sabinerijnsbur\Matlab\moorings\Mfiles\Mooring12_av_corr.mat');
load('d:\sabinerijnsbur\Matlab\moorings\Mfiles\radar.mat');

nfiles       = find(radar.t <= M12.t(end),1,'last');
tmp.t        = nan(size(M12.t,1),size(M12.t,2));
tmp.dir      = cell(size(M12.t,1),size(M12.t,2));
tmp.from     = cell(size(M12.t,1),size(M12.t,2));
tmp.remarks  = cell(size(M12.t,1),size(M12.t,2));   

    for i = 1:nfiles
        ind(i)             = find(M12.t >= radar.t(i),1,'first');
        tmp.t(ind(i))      = radar.t(i);
        tmp.dir{ind(i)}    = radar.dir{i};
        tmp.from{ind(i)}   = radar.from{i};
        tmp.remarks{ind(i)}= radar.remarks{i};
    end

% Make classifications same as above
%directions
tmp.ind.on1   = find(and(strcmp(tmp.dir,'se')==1,strcmp(tmp.from,'nw')==1));% onshore: from nw to se
tmp.ind.on2   = find(and(strcmp(tmp.dir,'se')==1,strcmp(tmp.from,'w')==1));% onshore: from w to se
tmp.ind.off1  = find(and(strcmp(tmp.dir,'nw')==1,strcmp(tmp.from,'se')==1));% offshore: from se to nw
tmp.ind.off2  = find(and(strcmp(tmp.dir,'nw')==1,strcmp(tmp.from,'e')==1));% offshore: from e to nw
tmp.ind.off3  = find(and(strcmp(tmp.dir,'w')==1,strcmp(tmp.from,'e')==1));% offshore: from e to w
% some extra remarks
tmp.ind.light = find(strcmp(tmp.remarks,'light'));% light feature in radar, difficult to examine
tmp.ind.refl  = find(strcmp(tmp.remarks,'reflected'));% onshore directed front reflected back offshore
tmp.ind.hang  = find(strcmp(tmp.remarks,'hanging'));% front stays for longer time around moorings
tmp.ind.conv  = find(strcmp(tmp.remarks,'convergence'));% 2 fronts meet at loc moorings
% combined
tmp.ind.on11  = find(and(strcmp(tmp.dir,'se')==1,strcmp(tmp.from,'nw')==1) & strcmp(tmp.remarks,'')==1);
tmp.ind.on1l  = find(and(strcmp(tmp.dir,'se')==1,strcmp(tmp.from,'nw')==1) & strcmp(tmp.remarks,'light')==1);
tmp.ind.on1h  = find(and(strcmp(tmp.dir,'se')==1,strcmp(tmp.from,'nw')==1) & strcmp(tmp.remarks,'hanging')==1);
tmp.ind.on22  = find(and(strcmp(tmp.dir,'se')==1,strcmp(tmp.from,'w')==1)& strcmp(tmp.remarks,'')==1);
tmp.ind.on2l  = find(and(strcmp(tmp.dir,'se')==1,strcmp(tmp.from,'w')==1)& strcmp(tmp.remarks,'light')==1);
tmp.ind.off11 = find(and(strcmp(tmp.dir,'nw')==1,strcmp(tmp.from,'se')==1)& strcmp(tmp.remarks,'')==1);
tmp.ind.off1l = find(and(strcmp(tmp.dir,'nw')==1,strcmp(tmp.from,'se')==1)& strcmp(tmp.remarks,'light')==1);
tmp.ind.off1r = find(and(strcmp(tmp.dir,'nw')==1,strcmp(tmp.from,'se')==1)& strcmp(tmp.remarks,'reflected')==1);
tmp.ind.off1c = find(and(strcmp(tmp.dir,'nw')==1,strcmp(tmp.from,'se')==1)& strcmp(tmp.remarks,'convergence')==1);
tmp.ind.off22 = find(and(strcmp(tmp.dir,'nw')==1,strcmp(tmp.from,'e')==1)& strcmp(tmp.remarks,'')==1);
tmp.ind.off3l = find(and(strcmp(tmp.dir,'w')==1,strcmp(tmp.from,'e')==1)& strcmp(tmp.remarks,'light')==1);

tmp.on11 = nan(size(M12.t,1),size(M12.t,2));
tmp.on1l = nan(size(M12.t,1),size(M12.t,2));
tmp.on1h = nan(size(M12.t,1),size(M12.t,2));
tmp.on22 = nan(size(M12.t,1),size(M12.t,2));
tmp.on2l = nan(size(M12.t,1),size(M12.t,2));
tmp.off11 = nan(size(M12.t,1),size(M12.t,2));
tmp.off1l = nan(size(M12.t,1),size(M12.t,2));
tmp.off1r = nan(size(M12.t,1),size(M12.t,2));
tmp.off1c = nan(size(M12.t,1),size(M12.t,2));
tmp.off22 = nan(size(M12.t,1),size(M12.t,2));
tmp.off3l = nan(size(M12.t,1),size(M12.t,2));

tmp.on11(1,tmp.ind.on11) = 1;
tmp.on1l(1,tmp.ind.on1l) = 1;
tmp.on1h(1,tmp.ind.on1h) = 1;
tmp.on22(1,tmp.ind.on22) = 1;
tmp.on2l(1,tmp.ind.on2l) = 1;
tmp.off11(1,tmp.ind.off11) = 1;
tmp.off1l(1,tmp.ind.off1l) = 1;
tmp.off1r(1,tmp.ind.off1r) = 1;
tmp.off1c(1,tmp.ind.off1c) = 1;
tmp.off22(1,tmp.ind.off22) = 1;
tmp.off3l(1,tmp.ind.off3l) = 1;

% Explanation
tmp.notes = {'on1 = to se from nw','on2 = to se from w','off1 = to nw from se','off2 = to nw from e','off3 = to w from e';'light = light in radar/difficult to see','reflected = onsh directed front reflected back off','hanging = front stays for longer time there','convergence = 2 fronts meet at loc',' '};

clear radar
radar = tmp;
save('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\radar_ctd','radar','-v7.3');


%% 
% 
% 
% nfiles         = find(radar.t <= adcp12C.t(end),1,'last'); % find times corresponding to adcp time
% 
% % Select data which fall in period of adcp
% radar2.t       = radar.t(1:nfiles);
% radar2.dir     = radar.dir(1:nfiles);
% radar2.from    = radar.from(1:nfiles);
% radar2.remarks = radar.remarks(1:nfiles);
% radar2.on1     = radar.on1(radar.on1<=nfiles);
% radar2.on2     = radar.on2(radar.on2<=nfiles);
% radar2.off1    = radar.off1(radar.off1<=nfiles);
% radar2.off2    = radar.off2(radar.off2<=nfiles);
% radar2.off3    = radar.off3(radar.off3<=nfiles);
% radar2.light   = radar.light(radar.light<=nfiles);
% radar2.hang    = radar.hang(radar.hang<=nfiles);
% radar2.refl    = radar.refl(radar.refl<=nfiles);
% radar2.conv    = radar.conv(radar.conv<=nfiles);
% radar2.on11    = radar.on11(radar.on11<=nfiles);
% radar2.on1l    = radar.on1l(radar.on1l<=nfiles);
% radar2.on1h    = radar.on1h(radar.on1h<=nfiles);
% radar2.on22    = radar.on22(radar.on22<=nfiles);
% radar2.on2l    = radar.on2l(radar.on2l<=nfiles);
% radar2.off11   = radar.off11(radar.off11<=nfiles);
% radar2.off1l   = radar.off1l(radar.off1l<=nfiles);
% radar2.off1r   = radar.off1r(radar.off1r<=nfiles);
% radar2.off1c   = radar.off1c(radar.off1c<=nfiles);
% radar2.off22   = radar.off22(radar.off22<=nfiles);
% radar2.off3l   = radar.off3l(radar.off3l<=nfiles);
% 
% clear radar
% radar = radar2;
% 
% save('d:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\radar','radar');
% 
% 
% % tmp.fld      = fieldnames(radar);
% 
% % for j = 1:length(tmp.fld)
% %     field = tmp.fld{j};
% %     radar2.(field) = radar.(field)(radar.(field)<=nfiles);
% %     
% %     
% % end
% 
% 
% 
% 
% 
% 
% save('d:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\radar_adcp','radar');
