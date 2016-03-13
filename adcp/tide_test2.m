%% Moving tidal analysis

clear all; close;

load('D:\sabinerijnsbur\Matlab\adcp\adcp12.mat');
adcp     = adcp12;
position = '12m';
dir_out  = 'D:\sabinerijnsbur\Matlab\adcp\Tidal_analysis\';

debug       = 0;
% comp        = 'M2';
range1sided = 38;
nt          = size(adcp.va,2);
dt          = diff(adcp.time); dt = dt(1)*24;

%% 

% concatenate
times   = 1:1:size(adcp.va,2);% timesteps
T.major = nan(size(adcp.va,1),length(times));
T.minor = nan(size(adcp.va,1),length(times));
T.incl  = nan(size(adcp.va,1),length(times));
T.phase = nan(size(adcp.va,1),length(times));

va = nan(size(adcp.va));
vc = nan(size(adcp.va));

for itt=1:length(times)% loopover tijd
    it = times(itt);
    disp(['TIME>>>>>>>>>>>>>>>> ',num2str(it)])
    for iz=1:size(adcp.va,1)% loopover z
        
        if (it > range1sided) && (it < (nt - range1sided))
        
            itsubset = it + [-range1sided:range1sided]; % 76*10/60 = 12.667hour

            U = adcp.va(iz,itsubset) + sqrt(-1).*adcp.vc(iz,itsubset); % velocity
            
            if sum(isnan(U))<50
                
                  [S,Ufitted] = t_tide(U,'interval',dt,'output','none'); % 
%                  [S,Ufitted] = t_tide(U,'interval',dt,'output','none','rayleigh','M2'); % ALLEEN M2 'shallow' 'rayleigh'
%                  [S,Ufitted] = t_tide(U,'interval',dt,'output','none','rayleigh','M2','shallow',['M4';'M6']);
                
                %% Check fitted velocity
                if debug
                    close
                    plot(adcp.time(itsubset),adcp.va(iz,itsubset),'b')
                    hold on
                    plot(adcp.time(itsubset),real(Ufitted),'g')
                    plot(adcp.time(itsubset),adcp.va(iz,itsubset) - real(Ufitted),'r')
                    datetick('x')
                    title(iz) 
                    pausedisp
                end
                
                %% Fitted velocity and ellipse properties
                
                va(iz,it) = real(Ufitted(range1sided+1));
                vc(iz,it) = imag(Ufitted(range1sided+1));
                
%                 im = strmatch(comp,S.name);
                
                T.major(iz,itt) = S.tidecon(:,1);
                T.minor(iz,itt) = S.tidecon(:,3);
                T.incl (iz,itt) = S.tidecon(:,5);
                T.phase(iz,itt) = S.tidecon(:,7);     
                
                %% Smooth
                
                X.major(iz,itt) = smooth(T.major(iz,itt));
                X.minor(iz,itt) = smooth(T.minor(iz,itt));
                X.incl(iz,itt)  = smooth(T.incl(iz,itt));
                X.phase(iz,itt) = smooth(T.phase(iz,itt));
                
            end

        end

    end
end

%% Save

name = ['T' position];
save([dir_out,name,'.mat'],'T');

%%
close

fonts = 12;

figure;
AX = subplot_meshgrid(3,1,[.06 .02 .02 .04],[.07],[nan nan nan],[nan]);
% axes(AX(1,1))
% pcolorcorcen(adcp.t,adcp.ranges,adcp.va)
% hold on
% plot(adcp.t,adcp.depth)
% set(gca,'fontsize',fonts);
% ylim([0 12])
% axis tight;
% % datetick('x');
% clim([-1.3 1.3]);
% colorbarwithhtext('u','horiz')

axes(AX(1,1))
pcolorcorcen(adcp.t(times),adcp.ranges,T.major)
hold on
plot(adcp.t,adcp.depth)
set(gca,'fontsize',fonts);
ylim([0 12])
axis tight;
% datetick('x');
clim([0 1.4]);
colorbarwithhtext('maj','horiz','fontsize',fonts)
title({[comp,',', position]})

axes(AX(2,1))
pcolorcorcen(adcp.t(times),adcp.ranges,T.minor)
hold on
plot(adcp.t,adcp.depth)
set(gca,'fontsize',fonts);
ylim([0 12])
axis tight;
% datetick('x');
clim([-0.3 0.3]);
colorbarwithhtext('min','horiz','fontsize',fonts)
title({[comp,',', position]})

axes(AX(3,1))
title(comp)
pcolorcorcen(adcp.t(times),adcp.ranges,T.minor./T.major)
hold on
plot(adcp.t,adcp.depth)
set(gca,'fontsize',fonts);
ylim([0 12])
axis tight;
% datetick('x');
clim([-0.4 0.6]);
colorbarwithhtext('ecc','horiz','fontsize',fonts)
title({[comp,',', position,',tstep = 20']})

%% plot

figure;
% subplot(2,1,1)
pcolorcorcen(adcp.t(times),adcp.ranges,T.minor./T.major)
hold on
plot(adcp.t,adcp.depth)
set(gca,'fontsize',fonts);
ylim([0 12])
axis tight;
% datetick('x');
clim([-0.4 0.6]);
colorbarwithhtext('ecc','horiz')
title({[comp,',', position,',tstep = 20']})

% subplot(1,2,2)
% pcolorcorcen(adcp.t(times),adcp.ranges,X.minor./X.major)
% hold on
% plot(adcp.t,adcp.depth)
% ylim([0 12])
% axis tight;
% % datetick('x');
% colorbarwithhtext('ecc','horiz')

%% 
% figure;
% subplot(1,4,1)
% pcolorcorcen(adcp.t,adcp.ranges,adcp.va)
% ylim([0 12])
% axis tight;
% datetick('x');
% colorbarwithhtext('u','horiz')
% 
% subplot(1,4,2)
% title(comp)
% pcolorcorcen(adcp.t(times),adcp.ranges,T.major)
% ylim([0 12])
% axis tight;
% datetick('x');
% colorbarwithhtext('maj','horiz')
% 
% subplot(1,4,3)
% title(comp)
% pcolorcorcen(adcp.t(times),adcp.ranges,T.minor)
% ylim([0 12])
% axis tight;
% datetick('x');
% colorbarwithhtext('min','horiz')
% 
% subplot(1,4,4)
% title(comp)
% pcolorcorcen(adcp.t(times),adcp.ranges,T.minor./T.major)
% ylim([0 12])
% axis tight;
% datetick('x');
% plot(T.incl,adcp12.ranges,'.-')
% colorbarwithhtext('ecc','horiz')
% hold on
% plot(T.phase,adcp12.ranges,'r.-')
% ylim([0 12])
%% Plot 



%% 
figure;
AX = subplot_meshgrid(3,1,[.06 .02 .02 .04],[.07],[nan nan nan],[nan]);
axes(AX(1,1))
pcolorcorcen(adcp.t,adcp.ranges,adcp.va);
axis tight;
set(gca,'fontsize',fonts);
ylim([0 18]);
clim([-1.5 1.5]);
% datetick('x');
colorbarwithhtext('u','horiz');

axes(AX(2,1))
pcolorcorcen(adcp.t,adcp.ranges,va);
axis tight;
set(gca,'fontsize',fonts);
ylim([0 18]);
clim([-1.5 1.5]);
% datetick('x');
colorbarwithhtext('u fitted','horiz');
title({[comp,',', position,',tstep = 20']})

axes(AX(3,1))
pcolorcorcen(adcp.t,adcp.ranges,(adcp.va-va));
axis tight;
set(gca,'fontsize',fonts);
ylim([0 18]);
clim([-1.5 1.5]);
% datetick('x');
colorbarwithhtext('difference','horiz');

% raw:adcp12.va
% tide:va
% err:adcp12.va - va