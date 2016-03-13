%% Moving tidal analysis
clc,clear all,close all

load('D:\sabinerijnsbur\Matlab\adcp\adcp12');

%% 
dt = diff(adcp12.time);dt = dt(1)*24;

close

debug       = 0; % checks for every interval the fitted velocity with the measured velocity
comp        = []; % e.g. 'M2'
range1sided = 38;
nt          = size(adcp12.va,2);
T.tstep       = 1; % timesteps

% concatenate
T.times = 1:tstep:size(adcp12.va,2); % timesteps
T.major = nan(size(adcp12.va,1),length(T.times));
T.minor = nan(size(adcp12.va,1),length(T.times));
T.incl  = nan(size(adcp12.va,1),length(T.times));
T.phase = nan(size(adcp12.va,1),length(T.times));
U       = nan(size(adcp12.va,1),77);

va = nan(size(adcp12.va));
vc = nan(size(adcp12.va));

for itt=1:length(T.times)% loopover tijd
    it = T.times(itt);
    disp(['TIME>>>>>>>>>>>>>>>> ',num2str(it)])
    for iz=1:size(adcp12.va,1)% loopover z
        
        if (it > range1sided) && (it < (nt - range1sided))
            
            itsubset = it + [-range1sided:range1sided]; % 76*10/60 = 12.667hour
            
            U = adcp12.va(iz,itsubset) + sqrt(-1).*adcp12.vc(iz,itsubset);
            
            if sum(isnan(U))<35
                
                [S,Ufitted] = t_tide(U,'interval',dt,'output','none'); %
                %[S,Ufitted] = t_tide(U,'interval',dt,'output','none','rayleigh','M2'); % ALLEEN M2 'shallow' 'rayleigh'
                %[S,Ufitted] = t_tide(U,'interval',dt,'output','none','rayleigh','M2','shallow',['M4';'M6']);
                
                % Check fitted velocity against measured velocity
                if debug
                    close
                    subplot(2,1,1)
                    plot(adcp12.time(itsubset),adcp12.va(iz,itsubset),'b')
                    hold on
                    plot(adcp12.time(itsubset),real(Ufitted),'g')
                    plot(adcp12.time(itsubset),adcp12.va(iz,itsubset) - real(Ufitted),'r')
                    datetick('x')
                    legend('measured va','fitted va','difference');
                    title([iz,it]) 
                    
                    subplot(2,1,2)
                    plot(adcp12.time(itsubset),adcp12.vc(iz,itsubset),'b')
                    hold on
                    plot(adcp12.time(itsubset),imag(Ufitted),'g')
                    plot(adcp12.time(itsubset),adcp12.vc(iz,itsubset) - imag(Ufitted),'r')
                    datetick('x')
                    legend('measured vc','fitted vc','difference');
                     pausedisp
                end
                
                % Define values
                va(iz,it) = real(Ufitted(range1sided+1));
                vc(iz,it) = imag(Ufitted(range1sided+1));
                
                if find(isempty(comp)==0)
                    im = strncmp(comp,S.name);
                    T.major(iz,itt) = S.tidecon(im,1); % major axis
                    T.minor(iz,itt) = S.tidecon(im,3); % minor axis
                    T.incl (iz,itt) = S.tidecon(im,5); % inclination
                    T.phase(iz,itt) = S.tidecon(im,7); % phase
                else
                    T.major(iz,itt) = S.tidecon(:,1); % major axis
                    T.minor(iz,itt) = S.tidecon(:,3); % minor axis
                    T.incl (iz,itt) = S.tidecon(:,5); % inclination
                    T.phase(iz,itt) = S.tidecon(:,7); % phase
                end
                
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

T.tcomp = S.name;
%%
close

if debug
    figure;
    subplot(1,4,1)
    pcolorcorcen(adcp12.time,adcp12.ranges,adcp12.va)
    ylim([0 12])
    axis tight;
    datetick('x')
    colorbarwithhtext('u','horiz')
    
    subplot(1,4,2)
    title(comp)
    pcolorcorcen(adcp12.time(times),adcp12.ranges,T.major)
    ylim([0 12])
    axis tight;datetick('x')
    colorbarwithhtext('maj','horiz')
    
    subplot(1,4,3)
    title(comp)
    pcolorcorcen(adcp12.time(times),adcp12.ranges,T.minor)
    ylim([0 12])
    axis tight;datetick('x')
    colorbarwithhtext('min','horiz')
    
    subplot(1,4,4)
    title(comp)
    pcolorcorcen(adcp12.time(times),adcp12.ranges,T.minor./T.major)
    ylim([0 12])
    axis tight;datetick('x')
    colorbarwithhtext('ecc','horiz')
    
    %% 
    
    % plot(T.incl,adcp12.ranges,'.-')
    % hold on
    % plot(T.phase,adcp12.ranges,'r.-')
    % ylim([0 12])
    
    %% measured, fitted and difference velocity
    
    figure;
    subplot(3,1,1)
    pcolorcorcen(adcp12.time,adcp12.ranges,adcp12.va);
    axis tight;
    ylim([0 12]);
    clim([-1.5 1.5]);
    datetick('x');
    colorbarwithvtext('u','vert');
    
    subplot(3,1,2)
    pcolorcorcen(adcp12.time,adcp12.ranges,va);
    axis tight;
    ylim([0 12]);
    clim([-1.5 1.5]);
    datetick('x');
    colorbarwithvtext('u fitted','vert');
    
    subplot(3,1,3)
    pcolorcorcen(adcp12.time,adcp12.ranges,(adcp12.va-va));
    axis tight;
    ylim([0 12]);
    clim([-1.5 1.5]);
    datetick('x');
    colorbarwithvtext('difference','vert');
    
end
% raw:adcp12.va
% tide:va
% err:adcp12.va - va

% Check fitted velocity, when only loop over depth
%                 if debug
%                     close
%                     plot(adcp12.time,adcp12.va(iz,:),'b')
%                     hold on
%                     plot(adcp12.time,real(Ufitted),'g')
%                     plot(adcp12.time,adcp12.va(iz,:) - real(Ufitted),'r')
%                     datetick('x')
%                     title(iz)
%                     pausedisp
%                 end
