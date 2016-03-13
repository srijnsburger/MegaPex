%Code to get Reynold Stresses from ADV data

clear all
clc

tic;

%First load Aquadopp data
% cd /Users/rfloresa/Desktop/Nortek_AquaDopp_HR
aq=load('d:\sabinerijnsbur\Data\MegaPEX_2014_deployment\MS12_mini-stable\Nortek_AquaDopp_HR\DELFT02.sen');
heading=aq(:,13);
pitch=aq(:,14);
roll=aq(:,15);
T_aquadopp=[1.5774 -0.7891 -0.7891;...
   0.0000 -1.3662 1.3662 ;...
   0.3677 0.3677 0.3677]; %transformation matrix for the aquadopp
% time_aq=datenum(aq(:,3),aq(:,1),aq(:,2),aq(:,4),aq(:,5),aq(:,6))-daysact('01-Jan-0000','01-Jan-2014');
% % do not have that function
time_aq=day_of_year(datenum(aq(:,3),aq(:,1),aq(:,2),aq(:,4),aq(:,5),aq(:,6)));

%now load times for the ADV
% cd /Users/rfloresa/Desktop/ADV_G355
adv=load('d:\sabinerijnsbur\Data\MegaPEX_2014_deployment\MS12_mini-stable\ADV G355\G355001-hd1.mat'); %this contains the time of each adv burst
time_adv=adv.Day;

%% Now we have to make a time grid for the ADV
start_t=time_aq(1);
% load ADVG355_v1.mat
load('d:\sabinerijnsbur\Matlab_files\Megapex_data\Mini-stable\ADVG355_v1.mat');
N=numel(v1);
f=16; %adv frequency
time=zeros(1,N);
n_b=9600; %number of measurements per burst

for i=1:numel(time_adv)
    
 t_aux=ones(1,n_b);% numel in each burst
 t_aux(1)=time_adv(i);
 t_aux(2:end)=t_aux(2:end).*1/(3600*24*f);
 t_aux=cumsum(t_aux);
 time(1,1+(i-1)*n_b:i*n_b)=t_aux;
 
end

ind=zeros(1,numel(time_adv));

for i=1:numel(time_adv)
    
    ind(i)=find(time_adv(i)<=time_aq,1);
    
end


%% Now get an average heading, roll and pitch for each burst

hh=zeros(numel(time_adv)-1,1);
rr=hh;
pp=hh;

for i=1:numel(time_adv)-1
    
    hh(i)=(mean(heading(ind(i):ind(i+1)))-90)*pi/180;
    rr(i)=mean(pitch(ind(i):ind(i+1)))*pi/180; %switch pitch and roll
    pp(i)=mean(roll(ind(i):ind(i+1)))*pi/180;
    
end

%% Now rotate adv

id=[355 358 496];

for k=[id]
    
%first load adv data, xyz coordinate system
% eval(['cd /Users/rfloresa/Desktop/ADV_G',num2str(k)])
eval(['load(''d:\sabinerijnsbur\Matlab_files\Megapex_data\Mini-stable\ADVG',num2str(k),'_v1.mat'')']);
vx=v1;
eval(['load(''d:\sabinerijnsbur\Matlab_files\Megapex_data\Mini-stable\ADVG',num2str(k),'_v2.mat'')']);
vy=v2;
eval(['load(''d:\sabinerijnsbur\Matlab_files\Megapex_data\Mini-stable\ADVG',num2str(k),'_v3.mat'')']);
vz=v3;

%% Now rotate ADV velocities

n_burst=numel(vx)/n_b;
aux=1:n_burst;
aux=n_b.*aux;
aux=[1 aux];

vv=zeros(n_b,3);
vel=zeros(numel(vx),3);

for j=1:n_burst-1
    
    % Make heading matrix
H = [cos(hh(j)) sin(hh(j)) 0; -sin(hh(j)) cos(hh(j)) 0; 0 0 1];

    % Make tilt matrix
P = [cos(pp(j)) -sin(pp(j))*sin(rr(j)) -cos(rr(j))*sin(pp(j));...
      0             cos(rr(j))          -sin(rr(j));  ...
      sin(pp(j)) sin(rr(j))*cos(pp(j))  cos(pp(j))*cos(rr(j))];
  
R=H*P;

vxx=vx(aux(j):aux(j+1)-1);
vyy=vy(aux(j):aux(j+1)-1);
vzz=vz(aux(j):aux(j+1)-1);
    
    for jj=1:numel(vxx)
        
    v=[vxx(jj);vzz(jj);vyy(jj)];    
    vv(jj,1:3)=(R*v)'./100;

    end
    
    vel(1+(j-1)*n_b:j*n_b,1:3)=vv;

end

%%
if 0
figure
set(gcf,'Color','w')
plot(time(1000000:2250000),-vel(1000000:2250000,1)) %invert east velocity
hold on
plot(time(1000000:2250000),vel(1000000:2250000,2),'g')
plot(time(1000000:2250000),vel(1000000:2250000,3),'r')
plot(time(1000000:2250000),zeros(size(time(1000000:2250000))),'k--')
legend('East','North','Up')
xlabel('Year day')
ylabel('Velocity')
end

%% compare to the burst averaged adv

% cd /Users/rfloresa/Dropbox/UW/Research/Netherlands_092014/Data/MegaPex2014/Matlab_structures
cd d:\sabinerijnsbur\Matlab_files\Megapex_data\Mini-stable\
eval(['load adv',num2str(k),'.mat;'])

figure
set(gcf,'Color','w')
s1=subplot(311);
eval(['plot(adv',num2str(k),'.ba.t(2:end-1),adv',num2str(k),'.ba.ve)'])
hold on
plot(time(2000000:3250000),-vel(2000000:3250000,1),'g')
s2=subplot(312);
eval(['plot(adv',num2str(k),'.ba.t(2:end-1),adv',num2str(k),'.ba.vn)'])
hold on
plot(time(2000000:3250000),vel(2000000:3250000,2),'g')
s3=subplot(313);
eval(['plot(adv',num2str(k),'.ba.t(2:end-1),adv',num2str(k),'.ba.vv)'])
hold on
plot(time(2000000:3250000),vel(2000000:3250000,3),'g')
linkaxes([s1 s2 s3],'x')

eval(['adv',num2str(k),'.raw.ve=-vel(:,1)']);
eval(['adv',num2str(k),'.raw.vn=vel(:,2)']);
eval(['adv',num2str(k),'.raw.vu=vel(:,3)']);
eval(['adv',num2str(k),'.raw.t = time']);

end

toc;