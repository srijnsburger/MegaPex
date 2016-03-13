function [T1,T2]=load_tidaldata_nc(varargin)
%% Load_tidaldata_nc
% Function which loads tidal information from netCDF files
% Makes a struct including an interesting time slot

clear all
close all

T1 = nc2struct('http://opendap.deltares.nl/thredds/dodsC/opendap/rijkswaterstaat/waterbase/sea_surface_height/id1-SCHEVNGN.nc'); %tide at Scheveningen
T2 = nc2struct('http://opendap.deltares.nl/thredds/dodsC/opendap/rijkswaterstaat/waterbase/sea_surface_height/id1-HOEKVHLD.nc'); % tide at Hoek van Holland

T1.n15  = find(T1.datenum == datenum('15-Sep-2014'));% Tide at Schevingen
T1.n30  = find(T1.datenum == datenum('30-Oct-2014'));

T2.n15  = find(T2.datenum == datenum('15-Sep-2014'));% Tide at Hoek van Holland
T2.n30  = find(T2.datenum == datenum('30-Oct-2014'));

save(['Tide','.mat']);
end