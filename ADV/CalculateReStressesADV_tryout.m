% Calculate Reynoldsstresses from ADVs
% Using method of Shaw and Trowbridge (2000)
clc;clear all;close all;

% Load wave data
load('d:\sabinerijnsbur\Data\Conditions\Sep-Oct-2014\Waverider\Measurements_Zandmotor_Monitoring_Dec_2011_till_Nov_2014.mat');

addpath d:\sabinerijnsbur\SurfDrive\Scripts\

% Fill NaNs Peak period / Wave period
[Fp09] = Fill_NaNs(data.Sep2014.Fp(:,3));
[Fp10] = Fill_NaNs(data.Oct2014.Fp(:,3));

%%  Calculate Reynolds stresses

addpath d:\sabinerijnsbur\SurfDrive\Scripts\MegaPex\ADV
cd d:\sabinerijnsbur\Matlab_files\Megapex_data\Mini-stable\

n_b    = 9600;
fs     = 16; % sampling frequency in Hz

id = [355 496 355];

for j=1:numel(id)-1
    
eval(['load adv',num2str(id(j)),'.mat;']);
eval(['adv1 = adv',num2str(id(j)),';']);

eval(['load adv',num2str(id(j+1)),'.mat;']);
eval(['adv2 = adv',num2str(id(j+1)),';']);

eval(['nburst = min(adv',num2str(id(j)),'.nburst , adv',num2str(id(j+1)),'.nburst);']);

% Calculate Reynolds stresses
for i = 1:nburst
    
    ind     = 1+(i-1)*n_b:i*n_b;
    VelPos1 = [adv1.raw.ve(ind) adv1.raw.vn(ind) adv1.raw.vu(ind)];
    VelPos2 = [adv2.raw.ve(ind) adv2.raw.vn(ind) adv2.raw.vu(ind)];
    
    vec = datevec(day2datenum(adv1.raw.t(ind(1)),2014));
    
    if vec(2) == 9
        %         I = find(data.Sep2014.Tm02(:,1)>= day2datenum(adv496.raw.t(id(1)),2014) & data.Sep2014.Tm02(:,1)<= day2datenum(adv496.raw.t(id(end)),2014));
        I = find(data.Sep2014.Tm01(:,1) <= day2datenum(adv1.raw.t(ind(end)),2014),1,'Last');
        N = round(0.5*(1/Fp09(I))*fs);
        
    elseif vec(2) == 10
        I = find(data.Oct2014.Tm01(:,1) <= day2datenum(adv1.raw.t(ind(end)),2014),1,'Last');
        N = round(0.5*(1/Fp10(I))*fs);
    end
    
%     % Check if N is NaN
%     if isnan(N)==1
%         N = round(0.5*(1/data.Sep2014.Fp(I+1,3)));
%     end
    
    [uw vw turbVel Uconvolved] = turbulentStressST02(VelPos1,VelPos2,N);
    
    eval(['Stress',num2str(id(j)),'.Rewave(i,1) = uw;']);
    eval(['Stress',num2str(id(j)),'.Rewave(i,2) = vw;']);
%     turbVel(id,1:3) = turbVel;
%     Uconvolved(id,1:3) = Uconvolved;
    
end

eval(['Stress',num2str(id(j)),'.time = adv',num2str(id(j)),'.ba.time']);
eval(['Stress',num2str(id(j)),'.t    = adv',num2str(id(j)),'.ba.t']);

end






