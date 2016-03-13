% Manually frontal speed based on radar images
clc,clear all;close all;

%% Load some data

load('d:\sabinerijnsbur\Matlab\adcp\adcp12.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Metrics_Fronts.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\SBE1527.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\SBE1526.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\SBE5426.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\SBE5425.mat');
load('d:\sabinerijnsbur\Matlab\Moorings\Mfiles\SBE1842_corrected.mat');

debug = 0; % for figures to check processing

%% Calculate frontal speed & Froude number

file   = 'D:\sabinerijnsbur\Matlab\Fronts_Radar.xlsx';
[num,txt,raw] = xlsread(file,'Matlab version');

Uf.time = datenum(txt(2:end,1),'dd-mm-yyyy HH:MM:SS');
Uf.im4  = num(:,1); % # of images from Mooring till buoy M4
Uf.im5  = num(:,2); % # of images from Mooring till buoy M5
Uf.dx4  = 730;% distance M12 - M4 -> using google earth and coord.
Uf.dx5  = 800; % distance M12 - M5 -> using google earth and coord.
Uf.dt   = 5*60;
Uf.uf4  = Uf.dx4./(Uf.dt.*Uf.im4); % speed according to the radar images
Uf.uf5  = Uf.dx5./(Uf.dt.*Uf.im5);

% Calculate angle front compared to the coast (=42 deg)
fac    = 42/num(:,6); % angle coast divided by angele coast in radar image
Uf.anM = num(:,3)*fac;
Uf.an4 = num(:,4)*fac;
Uf.an5 = num(:,5)*fac;

% Find corresponding velocity data & calculate ambient velocity 
for i = 1:length(Uf.time)
    
    id(i) = find(and(Uf.time(i)-(1/(24*60)*5)<= adcp12.time, Uf.time(i) + (1/(24*60)*5) >= adcp12.time),1);
    U     = sqrt(adcp12.vc(:,id(i)-3:id(i)).^2+adcp12.va(:,id(i)-3:id(i)).^2); % total velocity
    dir   = atan(adcp12.vc(:,id(i)-3:id(i))./adcp12.va(:,id(i)-3:id(i))); % direction of total velocity
    
    if Uf.anM == 0
        UU    = U.*cos(90-dir-(Uf.an4(i)-42)); % Calculate velocity perpendicular to front
    else
        UU    = U.*cos(90-dir-(Uf.anM(i)-42)); % Calculate velocity perpendicular to front
    end
    
    % check velocity
    if debug == 1
        figure;
        pcolorcorcen(adcp12.time(1,id(i)-3:id(i)),adcp12.z,UU);
        datetick('x','keepticks');
        colorbar
        colormap(colormapbluewhitered);
        clim([-1.0 1.0]);
        vline(adcp12.time(1,id(i)-3:id(i)),':k');
        
        figure;
        plot(UU,adcp12.z);
        vline(0,'k');
        legend('t1','t2','t3','tfront');
        ylabel('z');
        xlabel('vel (m/s)');
    end
    
    % How to define?!
    Uam = mean(nanmean(UU(27:end,1:2)));
    Uf.Uf4(i) = -Uf.uf4(i) - mean(nanmean(UU(27:end,1:2))); % frontal propagation speed
    Uf.Uf5(i) = -Uf.uf5(i) - mean(nanmean(UU(27:end,1:2)));
    
    %
    
    dd  = find(and(Uf.time(i) <= F12.time, Uf.time(i)+ (1/(24)) >= F12.time),1);
    
    if isempty(dd) == 1
        dd    = nan;
        xx    = find(Uf.time(i)< adcp12.time,1);
        range = xx:xx+3;
%         yy    = find(min(SBE1527.dens10(range)));
        [v,yy]= min(SBE1527.dens10(range));
        ind   = range(yy);
        aux   = find(adcp12.vc(6:end,ind)<0 & adcp12.vc(6:end,ind)<-0.05,1)+3;
        if isempty(aux) == 1
            z(i) = nan;
        else
            z(i) = adcp12.z(aux);
        end
        Uf.d(i) = adcp12.h(ind)-z(i); % thickness layer
        
        if Uf.d(i) > 7
            Uf.d(i) = nan;
        end
        
    % reduced gravity, where rho1 is upper layer and rho2 is lower
        if Uf.d(i) >= 3
            rho1 = (SBE1527.dens10(ind)+SBE1526.dens10(ind))/2;
            rho2 = (SBE5426.dens10(ind)+SBE5425.dens10(ind)+SBE1842.dens10(ind))/3;
        else
            rho1 = SBE1527.dens10(ind);
            rho2 = (SBE1526.dens10(ind)+SBE5426.dens10(ind)+SBE5425.dens10(ind)+SBE1842.dens10(ind))/4;
        end
        rg(i) = 9.81*(rho2-rho1)/rho2;
        Uf.tf(i) = adcp12.time(ind);
    else 
        Uf.d(i)  = F12.thick(dd);
        rg(i)    = F12.rg(dd);
        Uf.tf(i) = F12.time(dd);
    end
    II(i) = dd;
    
end

Uf.Fr4 = abs(Uf.Uf4)./sqrt(rg.*Uf.d);
Uf.Fr5 = abs(Uf.Uf5)./sqrt(rg.*Uf.d);
  
%% Compare Frontal speed and froude number

tmp = find(~isnan(II));
II  = II(tmp);

ssh12     = adcp12.h-mean(adcp12.h);
np2_12    = find(adcp12.t>273 & adcp12.t<280);
spr2_12   = find(adcp12.t>280 & adcp12.t<287);
np3_12    = find(adcp12.t>287 & adcp12.t<294);


figure;
h1 = subplot(3,1,1);
plot(adcp12.time(np2_12),ssh12(np2_12),'r');
hold on
plot(adcp12.time(spr2_12),ssh12(spr2_12),'b');
plot(adcp12.time(np3_12),ssh12(np3_12),'r');
% vline(datenum(2014,09,30,00,00,00),'b');
% vline(datenum(2014,
datetick('x','keepticks');
ylabel('\eta (m)');
title('Comparison Froude number calculation');

h2 = subplot(3,1,2);
plot(Uf.tf,abs(Uf.Uf4),'.','Markersize',8)
hold on
plot(Uf.tf,abs(Uf.Uf5),'xk')
plot(F12.time(II),abs(F12.Uf(II)),'*r');
ylabel('abs u (m/s)')
datetick('x','keepticks');
legend('man. radar p1','man. radar p2','adcp');

h3 = subplot(3,1,3);
plot(Uf.tf,Uf.Fr4,'.','Markersize',8)
hold on
plot(Uf.tf,Uf.Fr5,'xk')
plot(F12.time(II),F12.Fr(II),'*r');
ylabel('Fr')
datetick('x','keepticks');
legend('man. radar p1','man. radar p2','adcp');

set(gcf,'Color','w');
% linkaxes([h1,h2,h3],'x');


%% Check fronts

fhandle = figure;
h4 = subplot(2,1,1);
plot(SBE1527.time10,SBE1527.dens10-1000);
hold on
vline(Uf.tf,':k');
xlim([datenum(2014,09,29,00,00,00) datenum(2014,10,16,00,00,00)]);
set(gca,'Xtick',datenum(2014,09,29,00,00,00):1:datenum(2014,10,16,00,00,00));
datetick('x','keepticks');
colorbar

h5 = subplot(2,1,2);
pcolorcorcen(adcp12.time,adcp12.z,adcp12.vc);
hold on
plot(adcp12.time,adcp12.h);
vline(Uf.tf,':k');
clim([-0.5 0.5]);
colorbar
colormap(colormapbluewhitered);
xlim([datenum(2014,09,29,00,00,00) datenum(2014,10,16,00,00,00)]);
set(gca,'Xtick',datenum(2014,09,29,00,00,00):1:datenum(2014,10,16,00,00,00));
datetick('x','keepticks');

set(gcf,'Color','w');
linkaxes([h4,h5],'x');


%% Scatterplots

for i = 1:length(Uf.time)
Ind(i)    = find(Uf.time(i)< adcp12.time,1);
end

% Fr vs drho/dt
figure; 
subplot(2,2,1)
plot(F12.drdt10(Ind),Uf.Fr4,'o');
ylabel('Fr M4');
xlabel('d\rho/dt (kg/m^3)')

subplot(2,2,2)
plot(F12.dR2(Ind),Uf.Fr4,'o');
ylabel('Fr M4');
xlabel('\delta\rho (kg/m^3)');

subplot(2,2,3)
plot(F12.drdt10(Ind),Uf.Fr5,'o');
ylabel('Fr M5');
xlabel('d\rho/dt (kg/m^3)');

subplot(2,2,4)
plot(F12.dR2(Ind),Uf.Fr5,'o');
ylabel('Fr M5');
xlabel('\delta\rho (kg/m^3)');

set(gcf,'Color','w');

%% All metrics

figure;
h9 = subplot(6,1,1);
plot(adcp12.time(np2_12),ssh12(np2_12),'r');
hold on
plot(adcp12.time(spr2_12),ssh12(spr2_12),'b');
plot(adcp12.time(np3_12),ssh12(np3_12),'r');
vline(Uf.tf,':k');
xlim([datenum(2014,09,30,00,00,00) datenum(2014,10,16,00,00,00)]);
datetick('x','keepticks');
ylabel('\eta (m)');
title('12m - attempt frontal strength');

h10 = subplot(6,1,2);
plot(SBE1527.time10,SBE1527.dens10-1000);
hold on
grid on
plot(SBE1526.time10,SBE1526.dens10-1000,'--r');
plot(SBE5426.time10,SBE5426.dens10-1000,'-.k');
plot(SBE5425.time10,SBE5425.dens10-1000,'c');
plot(SBE1842.time10,SBE1842.dens10-1000,'g');
vline(Uf.tf,':k');
xlim([datenum(2014,09,30,00,00,00) datenum(2014,10,16,00,00,00)]);
ylim([11 24]);
datetick('x','keepticks');
legend('1mbs','3mbs','7mbs','8mbs','10.5mbs');
legend('Orientation','horizontal','Location','SouthEast');

h11 = subplot(6,1,3);
plot(SBE1527.time10,F12.dR);
hold on
plot(SBE1527.time10,F12.dR2,'Linestyle','--');
hline(0,'k');
vline(Uf.tf,':k');
xlim([datenum(2014,09,30,00,00,00) datenum(2014,10,16,00,00,00)]);
ylim([-0.5 10]);
datetick('x','keepticks');
ylabel('\Delta \rho (kg/m^3)');
legend('bot-surf','av.bot - surf');
title('10-min averaged');
legend('Orientation','horizontal');

h12 = subplot(6,1,4);
plot(SBE1527.time10,F12.drdt10);
hline(0,'k');
vline(Uf.tf,':k');
xlim([datenum(2014,09,30,00,00,00) datenum(2014,10,16,00,00,00)]);
datetick('x','keepticks');
ylabel('d\rho /dt (kg/m^3)');
title('10-min averaged');

h13 = subplot(6,1,5);
plot(Uf.tf,abs(Uf.Uf4),'.','Markersize',8)
hold on
plot(Uf.tf,abs(Uf.Uf5),'xk')
plot(F12.time(II),abs(F12.Uf(II)),'*r');
vline(Uf.tf,':k');
xlim([datenum(2014,09,30,00,00,00) datenum(2014,10,16,00,00,00)]);
ylabel('abs u (m/s)')
datetick('x','keepticks');
legend('man. radar p1','man. radar p2','adcp');
legend('Orientation','horizontal');

h14 = subplot(6,1,6);
plot(Uf.tf,Uf.Fr4,'.','Markersize',8)
hold on
plot(Uf.tf,Uf.Fr5,'xk')
plot(F12.time(II),F12.Fr(II),'*r');
vline(Uf.tf,':k');
xlim([datenum(2014,09,30,00,00,00) datenum(2014,10,16,00,00,00)]);
ylabel('Fr')
datetick('x','keepticks');
legend('man. radar p1','man. radar p2','adcp');
legend('Orientation','horizontal');

set(gcf,'color','w');
linkaxes([h9,h10,h11,h12,h13,h14],'x');

% On grid

fhandle = figure;
AX = subplot_meshgrid(1,6,[.06 0.05],[.03 .025 .025 .025 .025 .025 .04],[nan],[nan nan nan nan nan nan]);
axes(AX(1,1))
plot(adcp12.time(np2_12),ssh12(np2_12),'r');
hold on
plot(adcp12.time(spr2_12),ssh12(spr2_12),'b');
plot(adcp12.time(np3_12),ssh12(np3_12),'r');
vline(Uf.tf,':k');
xlim([datenum(2014,09,30,00,00,00) datenum(2014,10,16,00,00,00)]);
datetick('x','keepticks');
ylabel('\eta (m)');
title('12m - attempt frontal strength (10-min averaged data used)');

axes(AX(1,2))
plot(SBE1527.time10,SBE1527.dens10-1000);
hold on
grid on
plot(SBE1526.time10,SBE1526.dens10-1000,'--r');
plot(SBE5426.time10,SBE5426.dens10-1000,'-.k');
plot(SBE5425.time10,SBE5425.dens10-1000,'c');
plot(SBE1842.time10,SBE1842.dens10-1000,'g');
vline(Uf.tf,':k');
xlim([datenum(2014,09,30,00,00,00) datenum(2014,10,16,00,00,00)]);
ylim([14 24]);
datetick('x','keepticks');
legend('1mbs','3mbs','7mbs','8mbs','10.5mbs');
legend('Orientation','horizontal','Location','SouthEast');

axes(AX(1,3))
plot(SBE1527.time10,F12.dR);
hold on
plot(SBE1527.time10,F12.dR2,'Linestyle','--');
hline(0,'k');
vline(Uf.tf,':k');
xlim([datenum(2014,09,30,00,00,00) datenum(2014,10,16,00,00,00)]);
ylim([0 7]);
datetick('x','keepticks');
ylabel('\Delta \rho (kg/m^3)');
legend('bot-surf','av.bot - surf');
% title('10-min averaged');
legend('Orientation','horizontal');

axes(AX(1,4))
plot(SBE1527.time10,F12.drdt10);
hline(0,'k');
vline(Uf.tf,':k');
xlim([datenum(2014,09,30,00,00,00) datenum(2014,10,16,00,00,00)]);
ylim([-0.005 0.005]);
datetick('x','keepticks');
ylabel('d\rho /dt (kg/m^3)');
% title('10-min averaged');

axes(AX(1,5))
plot(Uf.tf,abs(Uf.Uf4),'.','Markersize',11)
hold on
plot(Uf.tf,abs(Uf.Uf5),'xk')
plot(F12.time(II),abs(F12.Uf(II)),'*r');
vline(Uf.tf,':k');
xlim([datenum(2014,09,30,00,00,00) datenum(2014,10,16,00,00,00)]);
ylabel('abs Uf (m/s)')
datetick('x','keepticks');
legend('radar B4','radar B5','adcp');
legend('Orientation','horizontal');

axes(AX(1,6))
plot(Uf.tf,Uf.Fr4,'.','Markersize',11)
hold on
plot(Uf.tf,Uf.Fr5,'xk')
plot(F12.time(II),F12.Fr(II),'*r');
vline(Uf.tf,':k');
xlim([datenum(2014,09,30,00,00,00) datenum(2014,10,16,00,00,00)]);
ylabel('Fr')
datetick('x','keepticks');
legend('radar B4','radar B5','adcp');
legend('Orientation','horizontal');

set(AX(:,1:5),'xticklabel',[])

set(gcf,'color','w');
h = findobj(fhandle,'type','axes','tag','');
linkaxes(h,'x');

%% Manually frontal speed based on radar images :First Attempt
% clc,clear all;close all;
% 
% % Uf.start = [datenum(2014,09,30,05,55,00),datenum(2014,09,30,18,15,00),datenum(2014,10,01,07,15,00),datenum(2014,10,01,19,10,00),datenum(2014,10,03,22,29,00),datenum(2014,10,06,01,19,00),datenum(2014,10,06,13,12,00),datenum(2014,10,12,04,37,00),datenum(2014,10,13,17,52,00),datenum(2014,10,15,06,52,00),datenum(2014,10,14,08,22,00),datenum(2014,10,16,19,52,00),datenum(2014,10,16,21,02,00),datenum(2014,10,17,08,07,00),datenum(2014,10,18,11,32,00)];
% % Uf.imag  = [7,4,6,4,5,5,7,7,3,4,4,6,7,12,7];
% 
% Uf.start = [datenum(2014,09,30,05,55,00),datenum(2014,09,30,18,15,00),datenum(2014,10,01,07,15,00),datenum(2014,10,01,19,10,00),datenum(2014,10,03,22,29,00),datenum(2014,10,06,01,19,00),datenum(2014,10,06,13,12,00),datenum(2014,10,12,04,37,00),datenum(2014,10,13,17,52,00),datenum(2014,10,15,06,52,00)];
% Uf.imag  = [7,5,7,4,5,5,7,7,3,4]; % # of images from Mooring till M4
% Uf.imag5 = [9,6,9,6,8,9,13,nan,6,5]; % at M5
% Uf.dx    = 730;% distance M12 - M4 -> using google earth and coord.
% Uf.dx5   = 800; % distance M12 - M5 -> using google earth and coord.
% Uf.dt    = 5*60;
% Uf.uf    = Uf.dx./(Uf.dt.*Uf.imag);
% Uf.uf5   = Uf.dx5./(Uf.dt.*Uf.imag5);
% 
% % Compare with vel adcp
% 
% load('d:\sabinerijnsbur\Matlab\Moorings\Metrics_Fronts.mat');
% 
% for i = 1:length(Uf.start)
%     
%     id(i) = find(Uf.start(i) <= F12.time,1); 
%     t12(i)= F12.time(id(i));
% %     thick = F12.thick(id);
% %     rg    = F12.rg(id);
% end
% 
% Uf.Fr = abs(Uf.uf)./sqrt(F12.rg(id).*F12.thick(id));
% Uf.Fr5 = abs(Uf.uf5)./sqrt(F12.rg(id).*F12.thick(id));  