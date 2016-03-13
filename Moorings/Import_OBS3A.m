% Import data

%% Load data OBS3A743
t = cell2mat(OBS3A7);
date = cell2mat(VarName2);
space = repmat(' ',68817,1);
time = [date,space,t];
t2 = time;
time = datenum(t2,'mm/dd/yy HH:MM:SS');
% OBS3A743_org = OBS3A743;
OBS3A743_raw.time = time;
OBS3A743_raw.depth = OBS3A743(:,1);
OBS3A743_raw.obs = OBS3A743(:,2);
OBS3A743_raw.temp = OBS3A743(:,3);
OBS3A743_raw.conductivity = OBS3A743(:,4);
OBS3A743_raw.description = 'Type:OBS3A, Serialnumber 743, Location 12m mooring 1mbs, Units: time [datenum], depth [m], temp [degree C], conductivity [mS/cm]';
save('OBS3A743_raw','OBS3A743_raw');

%% Load data OBS3A578
t = cell2mat(OBS3A5);
date = cell2mat(VarName2);
space = repmat(' ',64584,1);
time = [date,space,t];
t2 = time;
time = datenum(t2,'mm/dd/yy HH:MM:SS');
% OBS3A578_org = OBS3A578;
OBS3A578_raw.time = time;
OBS3A578_raw.depth = OBS3A578(:,1);
OBS3A578_raw.obs = OBS3A578(:,2);
OBS3A578_raw.temp = OBS3A578(:,3);
OBS3A578_raw.conductivity = OBS3A578(:,4);
OBS3A578_raw.description = 'Type:OBS3A, Serialnumber 578, Location 18m mooring 1mbs, Units: time [datenum], depth [m], temp [degree C], conductivity [mS/cm]';
save('OBS3A578_raw','OBS3A578_raw');

%% Load data OBS3A750
t = cell2mat(OBS3A7);
date = cell2mat(VarName2);
space = repmat(' ',54740,1);
time = [date,space,t];
t2 = time;
time = datenum(t2,'mm/dd/yy HH:MM:SS');
% OBS3A750_org = OBS3A750;
OBS3A750_raw.time = time;
OBS3A750_raw.depth = OBS3A750(:,1);
OBS3A750_raw.obs = OBS3A750(:,2);
OBS3A750_raw.temp = OBS3A750(:,3);
OBS3A750_raw.conductivity = OBS3A750(:,4);
OBS3A750_raw.description = 'Type:OBS3A, Serialnumber 750, Location 18m mooring 1mbs, Units: time [datenum], depth [m], temp [degree C], conductivity [mS/cm]';
save('OBS3A750_raw','OBS3A750_raw');

%% Load data OBS3A744
t = cell2mat(OBS3A7);
date = cell2mat(VarName2);
space = repmat(' ',68840,1);
time = [date,space,t];
t2 = time;
time = datenum(t2,'mm/dd/yy HH:MM:SS');
OBS3A744_raw.time = time;
OBS3A744_raw.depth = OBS3A7445mbs12(:,1);
OBS3A744_raw.obs = OBS3A7445mbs12(:,2);
OBS3A744_raw.temp = OBS3A7445mbs12(:,3);
OBS3A744_raw.conductivity = OBS3A7445mbs12(:,4);
OBS3A744_raw.description = 'Type:OBS3A, Serialnumber 744, Location 12m mooring 5mbs, Units: time [datenum], depth [m], temp [degree C], conductivity [mS/cm]';
save('OBS3A744_raw','OBS3A744_raw');
