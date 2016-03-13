function [sal,dens] = calculate_sal_dens_v2(temp,cond,press)

% Temp  in degrees Celsius
% Cond  in mS/cm
% Press in bar

% Check conductivity and temperature, may not be lower than zero
n = length(cond);
for i = 1:n
    if cond(i) <= 0.0
        cond(i) = NaN;
    end
    
    if temp(i) <= 0.0
       temp(i) = NaN;
    end 
end

%Calculate Salinity
% cond2       = cond.*10; % need conductivity in mS/cm

if isfield(mat2,'press')== 1
    press2      = press./10; % need pressure in bar
elseif isfield(mat2,'pref')== 1
    press2        = nan(n,1);
    nan_id        = isnan(press2);
    press2(nan_id)= mat2.pref; 
end

sal = condtemp2sal(cond2,temp,press2);

% Calculate Density
dens = waterdensity0(sal,temp);

end