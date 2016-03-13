function [Wind]=load_winddata(varargin)

Wind  = nc2struct('d:\sabinerijnsbur\Measurement_Campaigns\Measurements2014\Data_2\Conditions\potwind_330_2011.nc');%Hoek van Holland

Wind.n1   = find(Wind.datenum == datenum('01-Sep-2014'));
Wind.n15  = find(Wind.datenum == datenum('15-Sep-2014')); 
Wind.n30  = find(Wind.datenum == datenum('30-Oct-2014'));

save(['Wind','.mat']);
end