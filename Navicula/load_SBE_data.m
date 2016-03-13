function [mat] = load_SBE_data(name,mooring,fname,fname2)
%% Load data
fid = fopen(fname);
if or(strcmp(name,'SBE1525'),or(strcmp(name,'SBE1526'),strcmp(name,'SBE1527')))
    C = textscan(fid,'%f %f %s %s','Delimiter',',');
else
    C = textscan(fid,'%f %f %f %s %s','Delimiter',',');
end

if or(strcmp(name,'SBE4939'),strcmp(name,'SBE4940'))
    D = importdata(fname2,',',59);
else
    D = importdata(fname2,',',47);
end

fclose(fid);

%% Concatenate date and time
if or(strcmp(name,'SBE1525'),or(strcmp(name,'SBE1526'),strcmp(name,'SBE1527')))
    t = cell2mat(C{1,4});
    date = cell2mat(C{1,3});
else
    t = cell2mat(C{1,5});
    date = cell2mat(C{1,4});
end
space = repmat(' ',length(date),1);
t2 = [date,space,t];
time = datenum(t2,'dd mmm yyyy HH:MM:SS'); 

%% Make struct

mat.datatext = D;
mat.mooring  = mooring;
mat.time     = time; 
mat.temp     = C{1,1};
mat.cond     = C{1,2};
if or(strcmp(name,'SBE1525'),strcmp(name,'SBE1527'))
    mat.pref     = 1;
elseif strcmp(name,'SBE1526')
    mat.pref     = 3;
else
    mat.press    = C{1,3};
end

clear time t t2 space mooring fname fname2 fid ans C D

end