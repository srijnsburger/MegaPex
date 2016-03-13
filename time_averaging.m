function [mat] = time_averaging(mat,starttime,endtime,avp)

% Determine number of windows
lts      = (endtime-starttime)/(1/(24*3600));% length time series
nwindows = floor(lts/avp); % number of windows
id_start = find(starttime == mat.time); % index starttime

% Determine sample freq input data and width window
dt    = (mat.time(2)-mat.time(1))/(1/(24*3600));% sample frequency input
Nt    = floor(avp/dt); % width of window

% Average
for ni = 1:nwindows
    tii            = id_start-1+((ni-1)*Nt+1:ni*Nt);
    mat.sal10(ni)  = nanmean(mat.sal(tii,1));
    mat.temp10(ni) = nanmean(mat.temp(tii,1));
    mat.cond10(ni) = nanmean(mat.cond(tii,1));
    mat.t10(ni)    = mat.time(tii(1)+(Nt/2));
%     mat.t10a(ni)   = mean(mat.time(tii,1));
end

end 