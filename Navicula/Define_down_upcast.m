function [C3,UD]= Define_down_upcast(C2)
%% Downcast and upcast manually
% Up- and downcast is defined manually based on the pressure

% Input:  - struct C2 with all the data for each cast
% Outout: - C3 (= struct with only data during downcast)
%         - UD (= struct with information over start and stop downcast)

% close all; clear all; clc;
% load('C2');

%% Determine max and min pressure

[UD.Pmax,UD.Imax]  = arrayfun(@(x) max(x.data(:,2)), C2);% max pressure
% [Pmin,Imin]  = arrayfun(@(x) min(x.data(:,2)), C2);% min pressure
% [dmax,Idmax] = arrayfun(@(x) max(x.data(:,9)), C2);% max depth
% [dmin,Idmin] = arrayfun(@(x) min(x.data(:,9)), C2);% min depth
UD.Istop  =  UD.Imax-3; % index of stop downcast (= offset from max, to avoid strange peaks)

% Define start downcast
nfiles = length(C2);

for j = 1:nfiles
   [UD.Pmin(j),UD.Imin(j)] = min(C2(j).data(1:UD.Istop(j),2)); % min pressure downcast
end

UD.Istart =  UD.Imin+3; % index of start downcast (= offset from min, to avoid strange peaks)

%% Determine start and stoptime

for k = 1:nfiles
    UD.tstart(k) = C2(k).data(UD.Istart(k),13); % start time
    UD.tstop(k)  = C2(k).data(UD.Istop(k),13);
end

%% Make struct with down- (and upcast)

for i = 1:nfiles
C3(i).data = C2(i).data(UD.Istart(i):UD.Istop(i),:);
end


end
 



