clc,clear all,close all

load('A12_CTD2099');

% Remove artificial spikes

nlines = length(A12_CTD2099.sal);

for i = 1:nlines
    if A12_CTD2099.sal(i)<20
        A12_CTD2099.sal(i) = nan;
        A12_CTD2099.temp(i) = nan;
        A12_CTD2099.cond(i) = nan;
        A12_CTD2099.press(i) = nan;
        A12_CTD2099.sv(i) = nan;
        A12_CTD2099.turb(i) = nan;
        A12_CTD2099.time(i) = nan;
    elseif A12_CTD2099.sal(i)>35
        A12_CTD2099.sal(i) = nan;
        A12_CTD2099.temp(i) = nan;
        A12_CTD2099.cond(i) = nan;
        A12_CTD2099.press(i) = nan;
        A12_CTD2099.sv(i) = nan;
        A12_CTD2099.turb(i) = nan;
        A12_CTD2099.time(i) = nan;
    elseif A12_CTD2099.press(i) > 20;
        A12_CTD2099.sal(i) = nan;
        A12_CTD2099.temp(i) = nan;
        A12_CTD2099.cond(i) = nan;
        A12_CTD2099.press(i) = nan;
        A12_CTD2099.sv(i) = nan;
        A12_CTD2099.turb(i) = nan;
        A12_CTD2099.time(i) = nan;
        
    end
end
    

%% Scatter plot

figure;
subplot(4,1,1)
plot(A12_CTD2099.time-datenum(2014,09,16),A12_CTD2099.sal,'.');
ylabel('Salinity (psu)')
title('Scatter plot to check data FSI CTD2099 (after despiking)');

subplot(4,1,2)
plot(A12_CTD2099.time-datenum(2014,09,16),A12_CTD2099.temp,'.');
ylabel('Temperature (\circ C)')

subplot(4,1,3)
plot(A12_CTD2099.time-datenum(2014,09,16),A12_CTD2099.press,'.');
ylabel('Pressure (dbar)')

subplot(4,1,4)
plot(A12_CTD2099.time-datenum(2014,09,16),A12_CTD2099.turb,'.');
ylabel('Turbidity (FTU)')
xlabel('days (start 16/09/14)');


%Scatter plot salinity
figure;
scatter(A12_CTD2099.time-datenum(2014,09,16),A12_CTD2099.sal,'.');
ylabel('Salinity (psu)')
title('Scatter plot to check salinity data FSI CTD2099 (after despiking)');
xlabel('days (start 16/09/14)');

%% Plot 

figure;
subplot(4,1,1)
plot(A12_CTD2099.time-datenum(2014,09,16),A12_CTD2099.press);
ylabel('Pressure (dbar)');
title('Check data FSI CTD2099 after despiking');

subplot(4,1,2)
plot(A12_CTD2099.time-datenum(2014,09,16),A12_CTD2099.temp);
ylabel('Temperature (\circ C)')

subplot(4,1,3)
plot(A12_CTD2099.time-datenum(2014,09,16),A12_CTD2099.sal);
ylabel('Salinity (psu)')

subplot(4,1,4)
plot(A12_CTD2099.time-datenum(2014,09,16),A12_CTD2099.turb);
ylabel('Turbidity (FTU)')
xlabel('days (start 16/09/14');






    


