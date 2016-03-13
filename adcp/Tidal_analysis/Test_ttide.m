% test ttide
clc;clear all;close all;

load('D:\sabinerijnsbur\Matlab\adcp\adcp12C');
adcp = adcp12C;

% Convert time to Julian day vector
t     = datevec(adcp.time);
jdate = julian(t(:,1),t(:,2),t(:,3),t(:,4),t(:,5),t(:,6))';

omega = (2*pi)/(12.42);
z     = 0:0.5:12;
% u     = sin(omega*(jdate*24));
% uvel  = repmat(u,length(z),1);
% v     = 0.1*sin(omega*(jdate*24));
% vvel  = repmat(v,length(z),1);


%% 
hrs = adcp12C.t*24;
% uu = sin(omega*hrs);
% figure;plot(adcp12C.t,uu);
% hold on 
% plot(adcp12C.t,u);

u     = sin(omega*hrs)';
uvel  = repmat(u,length(z),1);
v     = 0.1*sin(omega*hrs)';
vvel  = repmat(v,length(z),1);
% tend  = 12.42*20; % in hours
% t     = 0:(10/60):tend; % in hours; 10min
% st    = datenum(2016,01,01,00,00,00);

%% 
debug        = 0; % checks for every interval the fitted velocity with the measured velocity
range1sided  = 38;
nt           = length(jdate);
% dt           = diff(jdate)*24;
dt           = diff(adcp12C.time)*24;
%dt = dt(1)*24; % time interval data
st           = adcp12C.time(1);
lat          = 52.06883;

% concatenate
T.major = nan(size(vvel));
T.minor = nan(size(vvel));
T.incl  = nan(size(vvel));
T.phase = nan(size(vvel));
T.v     = nan(size(vvel));
T.u     = nan(size(uvel));

for it =1:length(adcp12C.time)% loopover tijd
    disp(['TIME>>>>>>>>>>>>>>>> ',num2str(it)])
    for iz=1:size(vvel,1)% loopover z
        
        if (it > range1sided) && (it < (nt - range1sided))
            
            itsubset = it + [-range1sided:range1sided]; % 77*10/60 = 12.8333hour; 75*10/60 = 12.50
            
            U = uvel(iz,itsubset) + sqrt(-1).*vvel(iz,itsubset);
            
            if sum(isnan(U))<40
                
                 [S,Ufitted] = t_tide(U,'interval',dt(itsubset(1:end-1)),'start time',adcp12C.time(itsubset(1)),'latitude',lat,'output','none','error','linear'); %
%                  [S,Ufitted] = t_tide(U,'interval',dt,'output','none','rayleigh','M2'); % ALLEEN M2 'shallow' 'rayleigh'
%                   [S,Ufitted] = t_tide(U,'interval',dt,'output','none','rayleigh','M2','shallow',['M4';'M6']);
                
                % Check fitted velocity against measured velocity
                if debug
                    close
                    plot(t(itsubset),vel(iz,itsubset),'b')
                    hold on
                    plot(t(itsubset),Ufitted,'g')
                    plot(t(itsubset),va(iz,itsubset) - Ufitted,'r')
                    datetick('x')
                    legend('measured v','fitted v','difference');
                    title([iz,it]) 
                    
                    pausedisp
                end
                
                % Define values
                T.u(iz,it) = real(Ufitted(range1sided+1));
                T.v(iz,it) = imag(Ufitted(range1sided+1));
                
                %                     im = find(strcmp(comp,S.name)==1);
                T.major(iz,it) = S.tidecon(1,1); % major axis
                T.minor(iz,it) = S.tidecon(1,3); % minor axis
                T.incl (iz,it) = S.tidecon(1,5); % inclination
                T.phase(iz,it) = S.tidecon(1,7); % phase

% %                 else
%                     T.M2major(iz,itt) = S.tidecon(1,1); % major axis
%                     T.M2minor(iz,itt) = S.tidecon(1,3); % minor axis
%                     T.M2incl (iz,itt) = S.tidecon(1,5); % inclination
%                     T.M2phase(iz,itt) = S.tidecon(1,7); % phase
%                     T.M4major(iz,itt) = S.tidecon(2,1); % major axis
%                     T.M4minor(iz,itt) = S.tidecon(2,3); % minor axis
%                     T.M4incl (iz,itt) = S.tidecon(2,5); % inclination
%                     T.M4phase(iz,itt) = S.tidecon(2,7); % phase
%                     T.M6major(iz,itt) = S.tidecon(3,1); % major axis
%                     T.M6minor(iz,itt) = S.tidecon(3,3); % minor axis
%                     T.M6incl (iz,itt) = S.tidecon(3,5); % inclination
%                     T.M6phase(iz,itt) = S.tidecon(3,7); % phase
% %                 end
                
            end
            
        end
        
    end
%     close
%     if (it > range1sided) && (it < (nt - range1sided))
%     if debug
%     close
%     plot(adcp12.time(itsubset),adcp12.va(:,itsubset),'Color',[0.5 0.5 0.5])
%     hold on
%     plot(adcp12.time(itsubset),adcp12.va(nz,itsubset),'Color','r','Linewidth',1.5)
%     plot(adcp12.time(itsubset),imag(Ufitted(:,itsubset)),'Color','g')
%     plot(adcp12.time(itsubset),imag(Ufitted(nz,itsubset)),'Color','k','Linewidth',1.5)
%     datetick('x')
%     pausedip
%     end
%     end
    
end


T.comp = S.name;
T3 = T;
close

%% Save 

save('d:\sabinerijnsbur\Matlab_files\Megapex_data\Tidalanalysis\Ttide_test2','T3');
save('d:\sabinerijnsbur\Matlab_files\Megapex_data\Tidalanalysis\Ttide_test2','-append','uvel');
save('d:\sabinerijnsbur\Matlab_files\Megapex_data\Tidalanalysis\Ttide_test2','-append','vvel');

%% Plot

% Input figures
fig.plim = [0 360];
fig.ptick= [0:90:360];

%Pcolor
figure;
h1 = subplot(4,1,1);
pcolorcorcen(adcp12C.t,z,T.u);
cb = colorbar;
clim([-1.1 1.1]);
title('Simple sine in t-tide');

h2 = subplot(4,1,2);
pcolorcorcen(adcp12C.t,z,T.v);
cb = colorbar;
clim([-0.15 0.15]);

h3 = subplot(4,1,3);
pcolorcorcen(adcp12C.t,z,T.incl);
cb = colorbar;
clim([0 180]);
text(281,10,['Incl = ' num2str(T.incl(1,100)) '\circ']);

h4 = subplot(4,1,4);
pcolorcorcen(adcp12C.t,z,T.phase);
cb = colorbar;
clim([0 360]);
text(281,10,['Phase = ' num2str(T.phase(1,100)) '\circ']);
linkaxes([h1 h2 h3 h4],'x');

% Profiles
id = [118 132 139 147 161 175];

figure;
subplot(4,4,1)
plot(T.major(:,id(1)), z);
grid on
ylim([0 12]);
xlim([0 1.5]);
xlabel('Major');
title('Simple sine in t-tide for different profiles');

subplot(4,4,2)
plot(T.major(:,id(2)),z);
grid on
ylim([0 12]);
xlim([0 1.5]);
xlabel('Major');

subplot(4,4,3)
plot(T.major(:,id(3)), z);
grid on
ylim([0 12]);
xlim([0 1.5]);
xlabel('Major');

subplot(4,4,4)
plot(T.major(:,id(4)), z);
grid on
ylim([0 12]);
xlim([0 1.5]);
xlabel('Major');

subplot(4,4,5)
plot(T.minor(:,id(1)), z);
grid on
ylim([0 12]);
xlim([-0.3 0.2]);
xlabel('Minor');

subplot(4,4,6)
plot(T.minor(:,id(2)), z);
grid on
ylim([0 12]);
xlim([-0.3 0.2]);
xlabel('Minor');

subplot(4,4,7)
plot(T.minor(:,id(3)), z);
grid on
ylim([0 12]);
xlim([-0.3 0.2]);
xlabel('Minor');

subplot(4,4,8)
plot(T.minor(:,id(4)), z);
grid on
ylim([0 12]);
xlim([-0.3 0.2]);
xlabel('Minor');

subplot(4,4,9)
plot(T.phase(:,id(1)), z);
grid on
ylim([0 12]);
xlim(fig.plim);
set(gca,'XTick',fig.ptick);
xlabel('Phase');

subplot(4,4,10)
plot(T.phase(:,id(2)), z);
grid on
ylim([0 12]);
xlim(fig.plim);
set(gca,'XTick',fig.ptick);
xlabel('Phase');

subplot(4,4,11)
plot(T.phase(:,id(3)), z);
grid on
ylim([0 12]);
xlim(fig.plim);
set(gca,'XTick',fig.ptick);
xlabel('Phase');

subplot(4,4,12)
plot(T.phase(:,id(4)), z);
grid on
ylim([0 12]);
xlim(fig.plim);
set(gca,'XTick',fig.ptick);
xlabel('Phase');

subplot(4,4,13)
plot(T.incl(:,id(1)), z);
grid on
ylim([0 12]);
xlim([0 180]);
set(gca,'XTick',0:90:180);
xlabel('Incl');

subplot(4,4,14)
plot(T.incl(:,id(2)), z);
grid on
ylim([0 12]);
xlim([0 180]);
set(gca,'XTick',0:90:180);
xlabel('Incl');

subplot(4,4,15)
plot(T.incl(:,id(3)), z);
grid on
ylim([0 12]);
xlim([0 180]);
set(gca,'XTick',0:90:180);
xlabel('Incl');

subplot(4,4,16)
plot(T.incl(:,id(4)), z);
grid on
ylim([0 12]);
xlim([0 180]);
set(gca,'XTick',0:90:180);
xlabel('Incl');

% Test phase
figure;
h1 = subplot(5,1,1);
plot(adcp.t,uvel(1,:));
grid on
ylabel('u (m/s)');
title('Timeseries of simple sine in t-tide');

h2 = subplot(5,1,2);
plot(adcp.t,T.major(1,:));
grid on
ylabel('Major');
ylim([1 1.01]);

h3 = subplot(5,1,3);
plot(adcp.t,T.minor(1,:));
grid on
ylabel('Minor');
ylim([-1 1]);

h4 = subplot(5,1,4);
plot(adcp.t,T.incl(1,:));
grid on
ylabel('Incl');
ylim([0 180]);
set(gca,'YTick',0:45:180);

h5 = subplot(5,1,5);
plot(adcp.t,T.phase(1,:));
grid on
ylabel('Phase');
ylim([0 360]);
set(gca,'YTick',0:90:360);

linkaxes([h1 h2 h3 h4 h5],'x');

