function [timeGMT] = time2GMT(time,numberhours,sign)

% Function to convert timeseries towards GMT time. 
% Input:
%           time            is the timeseries array
%           numberhours     is the number of hours difference with GMT time
%           sign            is the timezone your data is in: GMT+1; GMT+2;
%                           GMT-1 etc. --> answer is 'positive' or
%                           'negative'
% Output:
%           timeGMT         is the time converted to GMT time

if sign == 'positive'
    timeGMT = time - numberhours*(1/24);
elseif sign == 'negative'
    timeGMT = time + numberhours*(1/24);
end


end