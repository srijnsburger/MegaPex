function [h,z] = distance_above_bed(ranges,bedheight,depth)
%% function that determines the distance from the bed till the measurement
% Input:  ranges (distance from the instrument where values are assigned;
%                         e.g. in case of adcp, middle of a bin)
%         bedheight
%         depth  (total depth)

% Distance "sea surface: depth" above bed : bedheight + depth  
if depth == 0 % or nan
    h = depth;
else
    h = depth + bedheight;
end

% Distance bins/signal above bed : bedheight + ranges
z = bedheight + ranges;

end