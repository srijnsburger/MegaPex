function [R] = make_grid(DD,UD)
%% Make_grid makes a grid and structure with all the casts
% It maxes a matrix per parameter/variable for all the casts. 
% Based on the binned data

% Input:  - DD (structure where the data is binned)
% Output: - R  (structure with matrix per variable for all the casts)

%% Make struct R

R.z         = -12:0.1:-0.05;
nz          = length(R.z);
nfiles      = length(DD);
R.depth     = nan(nz,nfiles);
R.press     = nan(nz,nfiles);
R.temp      = nan(nz,nfiles);
R.sal       = nan(nz,nfiles);
R.obs       = nan(nz,nfiles);
R.volt      = nan(nz,nfiles);
R.starttime = nan(1,nfiles);
R.endtime   = nan(1,nfiles);

% for i = 1:nfiles
%     tmp(i).data        = flipud(DD(i).data);
% end

for i = 1:nfiles
    tmp(i).data                = flipud(DD(i).data);
    nn                         = length(tmp(i).data);
    R.depth(end-nn+1:end,i)    = tmp(i).data(:,7);
    R.press(end-nn+1:end,i)    = tmp(i).data(:,2);
    R.temp(end-nn+1:end,i)     = tmp(i).data(:,3);
    R.sal(end-nn+1:end,i)      = tmp(i).data(:,4);
    R.obs(end-nn+1:end,i)      = tmp(i).data(:,5);
    R.volt(end-nn+1:end,i)     = tmp(i).data(:,6);
    R.starttime(1,i)           = UD.tstart(i);
    R.endtime(1,i)             = UD.tstop(i);
end

end