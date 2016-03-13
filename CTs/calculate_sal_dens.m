function [mat2] = calculate_sal_dens(mat2)

% INPUT:
% Temp  in degrees Celsius
% Cond  in mS/cm
% Press in bar

% Check conductivity and temperature, may not be lower than zero
n = length(mat2.cond);
for i = 1:n
    if mat2.cond(i) <= 0.0
        mat2.cond(i) = NaN;
    end
    
    if mat2.temp(i) <= 0.0
        mat2.temp(i) = NaN;
    end 
end

%Calculate Salinity: changed at 29/07/15 --> need to be carefull when
%calculating SBEs etc. 
% cond2       = mat2.cond.*10; % need conductivity in mS/cm

if isfield(mat2,'press')== 1
    press2      = mat2.press./10; % need pressure in bar
elseif isfield(mat2,'pref')== 1
    press2        = nan(n,1);
    nan_id        = isnan(press2);
    press2(nan_id)= mat2.pref; 
end

mat2.sal = condtemp2sal(mat2.cond,mat2.temp,press2);

% Calculate Density
mat2.dens = waterdensity0(mat2.sal,mat2.temp);

% convert to days
[mat2.t]    = day_of_year(mat2.time);
end