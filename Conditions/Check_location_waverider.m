%% Check location waverider

% Load wave data; waverider
load('d:\sabinerijnsbur\Data\Conditions\Sep-Oct-2014\Waverider\Measurements_Zandmotor_Monitoring_Dec_2011_till_Nov_2014.mat');

% check location
EPSG        = load('EPSG');
x           = 70744;
y           = 451833;

[lon,lat] = convertCoordinates(x,y,EPSG,'CS1.code',28992,'CS2.code',4326);

% Load wave data: Europlatform
load('d:\sabinerijnsbur\Matlab_files\Megapex_data\Conditions\wave.mat');
x = cell2mat(Hs.x);
y = cell2mat(Hs.y);
[lon2,lat2] = convertCoordinates(y,x,'CS1.code',4230,'CS2.code',4326);

% Load wind data: HvH
load('d:\sabinerijnsbur\Matlab_files\Megapex_data\Conditions\wind.mat');
lon3 = 4.1;
lat3 = 51.9833;

% Coordinates discharge data: Maasmond
x = 62800;
y = 445400;
[lon4,lat4] = convertCoordinates(x,y,'CS1.code',7415,'CS2.code',4326);		

% coordinates M12
M12 = [4.17781 52.06883];
M18 = [4.14159 52.09176];
A12 = [4.17624 52.06764];
A18 = [4.14326 52.09290];
MS12 = [4.17493 52.06660];

figure;
cmp = get(groot,'DefaultAxesColorOrder');
plot(lon,lat,'s','Markersize',5,'Markerfacecolor',cmp(1,1:3))
hold on
plot(lon2,lat2,'s','Markersize',5,'Color',cmp(5,1:3),'Markerfacecolor',cmp(5,1:3));
plot(lon3,lat3,'o','Markersize',5,'Color',cmp(2,1:3),'Markerfacecolor',cmp(2,1:3));
plot(lon4,lat4,'p','Markersize',7,'Color',cmp(7,1:3),'Markerfacecolor',cmp(7,1:3));
plot(M12(1),M12(2),'^','Markersize',5,'Color',cmp(3,1:3),'Markerfacecolor',cmp(3,1:3));
plot(MS12(1),MS12(2),'^','Markersize',5,'Color',cmp(3,1:3),'Markerfacecolor',cmp(3,1:3));
plot(A12(1),A12(2),'^','Markersize',5,'Color',cmp(3,1:3),'Markerfacecolor',cmp(3,1:3));
plot(M18(1),M18(2),'^','Markersize',5,'Color',cmp(3,1:3),'Markerfacecolor',cmp(3,1:3));
plot(A18(1),A18(2),'^','Markersize',5,'Color',cmp(3,1:3),'Markerfacecolor',cmp(3,1:3));
axis equal  
axis([3 4.75 51.8 53])
tickmap('ll')
% axislat(52.5)
hold on 
grid on
P = nc2struct('d:\sabinerijnsbur\SurfDrive\Scripts\MegaPex\northsea.nc');
plot(P.lon,P.lat,'color',[.5 .5 .5])
legend('Waverider (waves)','Europlatform (waves)','HvH (wind)','Discharge','Study site & ssh');
legend('Boxoff');
set(gca,'Fontsize',12);

