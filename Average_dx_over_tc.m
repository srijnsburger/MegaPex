%% AVERAGE DX OVER ONE TIDAL CYCLE

%% Load data
clc;clear all;close all;

Loc       = '18'; %Location
dirin = 'd:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\';
eval(['load([dirin,''Matrix_TC_' Loc '.mat'']);']);
eval(['MT = MT' Loc ''';']);
   
% load([dirin,'Matrix_TC_12.mat']);
% load([dirin,'Matrix_TC_18.mat']);

%% distinction periods --> manually for now

if strcmp(dirin,'d:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\')
    p1 = [1:12];
    p2 = [13:26];
    p3 = [27:38];
    p4 = [39:52];
    p5 = [53:56];
else
    p1 = [1:12];
    p2 = [13:26];
    p3 = [27:38];
    p4 = [39:52];
    p5 = [53:66];
    p6 = [67:77];
end

%% 

