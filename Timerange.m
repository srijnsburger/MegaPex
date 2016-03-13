function [time] = Timerange(time,tstart,tend)
% Timerange is a function which gives the start and stop index of the
% data. 
% Input:    
% time = array of times
% tstart = the 


% Define start and end of campaign
% Now rough for all the same; need to be adjusted 
start  = find(and(mat.time >= datenum(2014,09,15,17,05,00),mat.time <= datenum(2014,09,15,17,10,00)));
stop   = find(and(mat.time >= datenum(2014,10,30,14,10,00),mat.time <= datenum(2014,10,30,14,15,00)));

if find(mat.time(end) < datenum(2014,10,30,14,10,00))
    stop = find(mat.time,1,'last');
end

mat.start = (start(1));
mat.stop  = (stop(1));

end