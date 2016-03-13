function [mat] = time_averaging_reft_old(mat,reft,avp)
% Function for doing a time average based on a reference time
% 
% Input     - matfile (with fields to average time, sal, temp, cond and possible obs and/or press)
%           - reft    (reference time -> an array with times which are
%                      already averaged over the avp period)
%           - avp     (averaging period)
%
%% Time averaging

n          = length(reft);
% mat.sal10  = nan(1,n);
% mat.temp10 = nan(1,n);
% mat.cond10 = nan(1,n);
% mat.time10 = nan(1,n);

for i = 1:n
    tstart(i)     = reft(i) - ((avp/2)/86400);
    tend(i)       = reft(i) + ((avp/2)/86400);
    id            = find(mat.time > tstart(i) & mat.time < tend(i));
    if isfield(mat,'obs')== 1
        mat.obs10(i)  = nanmean(mat.obs(id));
    end
    if isfield(mat,'press')== 1
        mat.press10 = nanmean(mat.press(id));
    end
    if isfield(mat,'sal') == 1
        mat.sal10(i)  = nanmean(mat.sal(id));
    end
    if isfield(mat,'cond') == 1
        mat.cond10(i) = nanmean(mat.cond(id));
    end
    if isfield(mat,'temp') == 1
        mat.temp10(i) = nanmean(mat.temp(id));
    end
%     t10(i) = nanmean(mat.time(id)); % time based on mean value
    mat.time10(i)    = reft(i); % adcp time
end 

end