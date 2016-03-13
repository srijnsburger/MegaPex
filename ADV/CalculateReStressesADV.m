% Calculate Reynoldsstresses from ADVs
% Using method of Shaw and Trowbridge (2000)
clc;clear all;close all;

% Load wave data
load('d:\sabinerijnsbur\Data\Conditions\Sep-Oct-2014\Waverider\Measurements_Zandmotor_Monitoring_Dec_2011_till_Nov_2014.mat');

addpath d:\sabinerijnsbur\SurfDrive\Scripts\

% Fill NaNs Peak period / Wave period
[Fp09] = Fill_NaNs(data.Sep2014.Fp(:,3));
[Fp10] = Fill_NaNs(data.Oct2014.Fp(:,3));

%%  Load adv's

addpath d:\sabinerijnsbur\SurfDrive\Scripts\MegaPex\ADV

id=[355 358 496];

cd d:\sabinerijnsbur\Matlab_files\Megapex_data\Mini-stable\

for i=[id]
    
eval(['load adv',num2str(i),'.mat;'])

end

%% Calculate Re stresses

nburst = adv496.nburst;
n_b    = 9600;
fs     = 16; % sampling frequency in Hz

for i = 1:nburst
    
    id = 1+(i-1)*n_b:i*n_b;
    VelPos1 = [adv496.raw.ve(id) adv496.raw.vn(id) adv496.raw.vu(id)];
    VelPos2 = [adv355.raw.ve(id) adv355.raw.vn(id) adv355.raw.vu(id)];
    
    vec = datevec(day2datenum(adv496.raw.t(id(1)),2014));
    
    if vec(2) == 9
        %         I = find(data.Sep2014.Tm02(:,1)>= day2datenum(adv496.raw.t(id(1)),2014) & data.Sep2014.Tm02(:,1)<= day2datenum(adv496.raw.t(id(end)),2014));
        I = find(data.Sep2014.Tm01(:,1) <= day2datenum(adv496.raw.t(id(end)),2014),1,'Last');
        N = round(0.5*(1/Fp09(I))*fs);
    elseif vec(2) == 10
        I = find(data.Oct2014.Tm01(:,1) <= day2datenum(adv496.raw.t(id(end)),2014),1,'Last');
        N = round(0.5*(1/Fp10(I))*fs);
    end
    
%     % Check if N is NaN
%     if isnan(N)==1
%         N = round(0.5*(1/data.Sep2014.Fp(I+1,3)));
%     end
    
    [uw vw turbVel Uconvolved] = turbulentStressST02(VelPos1,VelPos2,N);
    
    UW(i) = uw;
    VW(i) = vw; 
%     turbVel(id,1:3) = turbVel;
%     Uconvolved(id,1:3) = Uconvolved;
    
end

