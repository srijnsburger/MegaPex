%% Load vaklodingen
clc;clear all;close all;

%% Zoom-in IJmuiden
cd('d:\sabinerijnsbur\Data\Vaklodingen\zoom-in-IJmuiden\');
List = dir('*.nc');

for fi = 1:length(List)
    str = List(fi).name;
    KB{fi}=nc2struct(str);
    KB{fi}.name = str;
end

save('d:\sabinerijnsbur\Matlab\Bottomtopography\zoom-in-IJmuiden\KB');

%% N-S coast

cd('d:\sabinerijnsbur\Data\Vaklodingen\NLCoast');
List = dir('*.nc');

for fi = 1:length(List)
    str = List(fi).name;
    KB{fi}=nc2struct(str);
    KB{fi}.name = str;
end

save('d:\sabinerijnsbur\Matlab\Bottomtopography\NLCoast\KB','-v7.3');


%% OLd, manually loading

% KB120_2120 = nc2struct('d:\sabinerijnsbur\Measurements\Vaklodingen\vaklodingenKB120_2120.nc');
% KB121_2120 = nc2struct('d:\sabinerijnsbur\Measurements\Vaklodingen\vaklodingenKB121_2120.nc');
% KB120_2322 = nc2struct('d:\sabinerijnsbur\Measurements\Vaklodingen\vaklodingenKB120_2322.nc');
% KB121_2322 = nc2struct('d:\sabinerijnsbur\Measurements\Vaklodingen\vaklodingenKB121_2322.nc');
% KB119_2524 = nc2struct('d:\sabinerijnsbur\Measurements\Vaklodingen\vaklodingenKB119_2524.nc');
% KB120_2524 = nc2struct('d:\sabinerijnsbur\Measurements\Vaklodingen\vaklodingenKB120_2524.nc');
% KB121_2524 = nc2struct('d:\sabinerijnsbur\Measurements\Vaklodingen\vaklodingenKB121_2524.nc');
% KB119_2726 = nc2struct('d:\sabinerijnsbur\Measurements\Vaklodingen\vaklodingenKB119_2726.nc');
% KB120_2726 = nc2struct('d:\sabinerijnsbur\Measurements\Vaklodingen\vaklodingenKB120_2726.nc');
% KB121_2726 = nc2struct('d:\sabinerijnsbur\Measurements\Vaklodingen\vaklodingenKB121_2726.nc');
% KB118_2928 = nc2struct('d:\sabinerijnsbur\Measurements\Vaklodingen\vaklodingenKB118_2928.nc');
% KB119_2928 = nc2struct('d:\sabinerijnsbur\Measurements\Vaklodingen\vaklodingenKB119_2928.nc');
% KB120_2928 = nc2struct('d:\sabinerijnsbur\Measurements\Vaklodingen\vaklodingenKB120_2928.nc');
% KB121_2928 = nc2struct('d:\sabinerijnsbur\Measurements\Vaklodingen\vaklodingenKB121_2928.nc');
% KB118_3130 = nc2struct('d:\sabinerijnsbur\Measurements\Vaklodingen\vaklodingenKB118_3130.nc');
% KB119_3130 = nc2struct('d:\sabinerijnsbur\Measurements\Vaklodingen\vaklodingenKB119_3130.nc');
% KB120_3130 = nc2struct('d:\sabinerijnsbur\Measurements\Vaklodingen\vaklodingenKB120_3130.nc');
% KB121_3130 = nc2struct('d:\sabinerijnsbur\Measurements\Vaklodingen\vaklodingenKB121_3130.nc');
% KB118_3332 = nc2struct('d:\sabinerijnsbur\Measurements\Vaklodingen\vaklodingenKB118_3332.nc');
% KB119_3332 = nc2struct('d:\sabinerijnsbur\Measurements\Vaklodingen\vaklodingenKB119_3332.nc');
% KB120_3332 = nc2struct('d:\sabinerijnsbur\Measurements\Vaklodingen\vaklodingenKB120_3332.nc');
% KB117_3534 = nc2struct('d:\sabinerijnsbur\Measurements\Vaklodingen\vaklodingenKB117_3534.nc');
% KB118_3534 = nc2struct('d:\sabinerijnsbur\Measurements\Vaklodingen\vaklodingenKB118_3534.nc');
% KB119_3534 = nc2struct('d:\sabinerijnsbur\Measurements\Vaklodingen\vaklodingenKB119_3534.nc');
% KB120_3534 = nc2struct('d:\sabinerijnsbur\Measurements\Vaklodingen\vaklodingenKB120_3534.nc');
% KB115_3736 = nc2struct('d:\sabinerijnsbur\Measurements\Vaklodingen\vaklodingenKB115_3736.nc');
% KB116_3736 = nc2struct('d:\sabinerijnsbur\Measurements\Vaklodingen\vaklodingenKB116_3736.nc');
% KB117_3736 = nc2struct('d:\sabinerijnsbur\Measurements\Vaklodingen\vaklodingenKB117_3736.nc');
% KB118_3736 = nc2struct('d:\sabinerijnsbur\Measurements\Vaklodingen\vaklodingenKB118_3736.nc');
% KB119_3736 = nc2struct('d:\sabinerijnsbur\Measurements\Vaklodingen\vaklodingenKB119_3736.nc');
% KB114_3938 = nc2struct('d:\sabinerijnsbur\Measurements\Vaklodingen\vaklodingenKB114_3938.nc');
% KB115_3938 = nc2struct('d:\sabinerijnsbur\Measurements\Vaklodingen\vaklodingenKB115_3938.nc');
% KB116_3938 = nc2struct('d:\sabinerijnsbur\Measurements\Vaklodingen\vaklodingenKB116_3938.nc');
% KB117_3938 = nc2struct('d:\sabinerijnsbur\Measurements\Vaklodingen\vaklodingenKB117_3938.nc');
% KB118_3938 = nc2struct('d:\sabinerijnsbur\Measurements\Vaklodingen\vaklodingenKB118_3938.nc');
% KB114_4140 = nc2struct('d:\sabinerijnsbur\Measurements\Vaklodingen\vaklodingenKB114_4140.nc');
% KB115_4140 = nc2struct('d:\sabinerijnsbur\Measurements\Vaklodingen\vaklodingenKB115_4140.nc');
% KB116_4140 = nc2struct('d:\sabinerijnsbur\Measurements\Vaklodingen\vaklodingenKB116_4140.nc');
% KB117_4140 = nc2struct('d:\sabinerijnsbur\Measurements\Vaklodingen\vaklodingenKB117_4140.nc');


%% Notes

% KB119_2524 --> only 5% coverage in 2001 --> gives strange patch in middle of nowhere
% KB118_2928 --> only  % coverage in 2001 --> gives strange patch in middle
% of nowhere 
% In 2001/2002 --> now gap between those tiles --> other tiles more filled
% as well.