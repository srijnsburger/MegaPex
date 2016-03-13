% Extending adcptime

load('D:\sabinerijnsbur\Matlab\adcp\adcp12.mat');
load('D:\sabinerijnsbur\Matlab\adcp\adcp18.mat');

t12end = datenum(2014,10,29,08,18,20);
t18end = datenum(2014,10,29,08,19,41);

ext12 = adcp12.time(end)+(1/(24*6)):(1/(24*6)):t12end;
reft.t12   = [adcp12.time ext12];

ext18 = adcp18.time(end)+(1/(24*6)):(1/(24*6)):t18end;
reft.t18   = [adcp18.time ext18];

save('D:\sabinerijnsbur\Matlab\adcp\reft','reft');
