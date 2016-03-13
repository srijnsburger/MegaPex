% Mainfile calibration OBSs

%% Read data during calibration

List = findAllFiles('d:\sabinerijnsbur\Measurement_Campaigns\Measurements2014\Data_2\Calibration\OBS-3A\','pattern_incl','Calibration_*_a.dat');

nfiles = length(List);
for i=1:nfiles
    [D(i)]          = importdata(List{i},',',4);
    C_OBS3A(i).sn   = D(i).textdata(1,1);
    C_OBS3A(i).time = datenum(D(i).textdata(5:end,1));
    C_OBS3A(i).turb = D(i).data(:,2);
    C_OBS3A(i).unit = 'NTU';
end


