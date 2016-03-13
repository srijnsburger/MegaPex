clc; clear all; close all

%% Load data

load('d:\sabinerijnsbur\Matlab\Moorings\MegaPex2014_MC_R');
load('d:\sabinerijnsbur\Matlab\Moorings\SBE1526.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\SBE1527.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\SBE5425.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\SBE5426.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\SBE1842C.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\SBE1842.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\SBE1525.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\SBE4939.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\SBE4940.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\SBE19C.mat');

%% Compare matfiles

%12 m
MC_S12 = [SBE1527.sal10;SBE1526.sal10;SBE5426.sal10;SBE5425.sal10;SBE1842C.sal10];
MC_T12 = [SBE1527.temp10;SBE1526.temp10;SBE5426.temp10;SBE5425.temp10;SBE1842C.temp10];
MC_C12 = [SBE1527.cond10;SBE1526.cond10;SBE5426.cond10;SBE5425.cond10;SBE1842C.cond10];
MC_t10_12 = SBE1527.time10;
% 
% DS12 = S12 - MC_S12;
% DT12 = T12 - MC_T12;
% DC12 = C12 - MC_C12;
% 
%18 m
MC_S18    = [SBE1525.sal10;SBE4939.sal10;SBE4940.sal10;SBE19C.sal10];
MC_T18    = [SBE1525.temp10;SBE4939.temp10;SBE4940.temp10;SBE19C.temp10];
MC_C18    = [SBE1525.cond10;SBE4939.cond10;SBE4940.cond10;SBE19C.cond10];
MC_t10_18 = SBE1525.time10;
% 
% DS18 = S18 - MC_S18;
% DT18 = T18 - MC_T18;
% DC18 = C18 - MC_C18;
%% Correct for GMT

t10_2 = t10 - (1/12);

%% Plot to compare
%12m
figure;
plot(t10_2,S12(1,:))
hold on
plot(MC_t10_12,MC_S12(1,:),'r')

figure;
plot(t10_2,S12(2,:))
hold on
plot(MC_t10_12,MC_S12(2,:),'r')

figure;
plot(t10_2,S12(3,:))
hold on
plot(MC_t10_12,MC_S12(3,:),'r')

figure;
plot(t10_2,S12(4,:))
hold on
plot(MC_t10_12,MC_S12(4,:),'r')

figure;
plot(t10_2,S12(5,:))
hold on
plot(MC_t10_12,MC_S12(5,:),'r')
plot(SBE1842.time10,SBE1842.sal10,'g')
plot(MC_t10_12,MC_S12(4,:),'m')

%% 18m
figure;
plot(t10_2,S18(1,:))
hold on
plot(MC_t10_18,MC_S18(1,:),'r')

figure;
plot(t10_2,S18(2,:))
hold on
plot(MC_t10_18,MC_S18(2,:),'r')

figure;
plot(t10_2,S18(3,:))
hold on
plot(MC_t10_18,MC_S18(3,:),'r')

figure;
plot(t10_2,S18(4,:))
hold on
plot(MC_t10_18,MC_S18(4,:),'r')



