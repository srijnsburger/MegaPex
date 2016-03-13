function [out] = OBS3A(mat,cal_coeff)
% Script to read raw data & plots
% Input: the .mat file of the different OBS3A instruments with different
% SN (name is OBS3ASN)
%% Convert conductivity to salinity

% Step 1: convert depth to pressure; use approximation: 1m = 0.1 bar

out       = mat;
out.press = mat.depth.*0.1;

% % Step 2: convert conductivity to salinity with equation of state
out.sal  = condtemp2sal(mat.cond,mat.temp,out.press);

%% Calculate density

out.dens = waterdensity0(out.sal,mat.temp);

%% OBS calibration

out.cal_coeff = cal_coeff;
out.obs = cal_coeff.*mat.obs; %calibration obs3As

end

