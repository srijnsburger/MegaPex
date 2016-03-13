function [ctd] = Processing_ctd_fsi(ctd,SN)
%% processing of fsi ctds

%% Day of year

[ctd.t] = day_of_year(ctd.time);

%% remove spikes
if SN == 'SN2099';
    [ctd] = despike_fsi_ctd(ctd);
end

%% Calculate density

ctd.dens = waterdensity0(ctd.sal,ctd.temp);

end