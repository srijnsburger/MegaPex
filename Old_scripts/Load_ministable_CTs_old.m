%% Old code loading Ministable CTs
%% 
k = 0;
while ~feof(fileID)
	k = k+1;
    if k == 1
        D = textscan(fileID,formatSpec,N,'Headerlines',Headerlines);
    else 
        D = textscan(fileID,formatSpec,N);
    end
    eval(['D',num2str(k),'= D;']);
end

fclose(fileID);
nblocks = k;


%% Replace text with NaNs

id = 1:nblocks;

for i = id
    eval(['tmp1 = strcmp(D',num2str(i),'{1,3},''E020'');']);
    I1 = find(tmp1 == 1);
    eval(['D',num2str(i),'{1,3}(I1,1) = {''1000000''};']);
   
    eval(['tmp2 = strcmp(D',num2str(i),'{1,4},''E020'');']);
    I2 = find(tmp2 == 1);
    eval(['D',num2str(i),'{1,4}(I2,1) = {''100000''};']);
    
    eval(['tmp3 = strcmp(D',num2str(i),'{1,5},''E020'');']);
    I3 = find(tmp3 == 1);
    eval(['D',num2str(i),'{1,5}(I3,1) = {''1000000''};']);
    
    eval(['tmp4 = strcmp(D',num2str(i),'{1,6},''E020'');']);
    I4 = find(tmp4 == 1);
    eval(['D',num2str(i),'{1,6}(I4,1) = {''100000''};']);
    
    eval(['tmp5 = strcmp(D',num2str(i),'{1,7},''E020'');']);
    I5 = find(tmp5 == 1);
    eval(['D',num2str(i),'{1,7}(I5,1) = {''1000000''};']);
    
    eval(['tmp6 = strcmp(D',num2str(i),'{1,8},''E020'');']);
    I6 = find(tmp6 == 1);
    eval(['D',num2str(i),'{1,8}(I6,1) = {''100000''};']);
    
    eval(['tmp7 = strcmp(D',num2str(i),'{1,9},''E020'');']);
    I7 = find(tmp7 == 1);
    eval(['D',num2str(i),'{1,9}(I7,1) = {''100000''};']);    
    
end

%% Make struct per CT

CT7216.cond = [];
CT7216.temp = [];
CT7217.cond = [];
CT7217.temp = [];
CT7218.cond = [];
CT7218.temp = [];
time        = [];
volt        = [];

for i = 1:nblocks

eval(['t1 = D',num2str(i),'{1,1};']);
eval(['t2 = D',num2str(i),'{1,2};']);
t = cellfun(@(C1,C2) datenum([C1,' ',C2],'mm/dd/yy HH:MM:SS.FFF'), t1, t2,'UniformOutput',false);

time = [time; cell2mat(t)];

eval(['c7216 = str2num(cell2mat(D',num2str(i),'{1,3}));'])
CT7216.cond = [CT7216.cond; c7216];

eval(['t7216 = str2num(cell2mat(D',num2str(i),'{1,4}));']);
CT7216.temp = [CT7216.temp; t7216];

eval(['c7217 = str2num(cell2mat(D',num2str(i),'{1,5}));'])
CT7217.cond = [CT7217.cond; c7217];

eval(['t7217 = str2num(cell2mat(D',num2str(i),'{1,6}));']);
CT7217.temp = [CT7217.temp; t7217];

eval(['c7218 = str2num(cell2mat(D',num2str(i),'{1,7}));'])
CT7218.cond = [CT7218.cond; c7218];

eval(['t7218 = str2num(cell2mat(D',num2str(i),'{1,8}));']);
CT7218.temp = [CT7218.temp; t7218];

eval(['v    = str2num(cell2mat(D',num2str(i),'{1,9}));']);
volt        = [volt; v];
end

%% Make struct

% t1    = strrep(D.textdata(3:end,1),'''','');
% t2    = strrep(D.textdata(3:end,2),'''','');
% 
% time  = cellfun(@(C1,C2) datenum([C1,' ',C2],'mm/dd/yy HH:MM:SS.FFF'), t1, t2,'UniformOutput',false); % Mkae one time string and convert to datenum
% 
% % Make struct with all the data
% MS_CTs.time     = cell2mat(time);
% MS_CTs.cond7216 = D.data(:,1);
% MS_CTs.temp7216 = D.data(:,2);
% MS_CTs.cond7217 = D.data(:,3);
% MS_CTs.temp7217 = D.data(:,4);
% MS_CTs.cond7218 = D.data(:,5);
% MS_CTs.temp7218 = D.data(:,6);
% MS_CTs.volt     = D.data(:,7);
% MS_CTs.descr    = 'Three CTs mounted at same height as ADVs. SN7216 is upper, SN7217 middle, SN7218 is lower';
% 
% save('MS_CTs','MS_CTs');