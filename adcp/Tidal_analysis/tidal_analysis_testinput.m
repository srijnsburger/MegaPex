function [T] = tidal_analysis_testinput(time,va,vc,tstep)
% To test the input of va and vc: whether which one is U and V.
% Here: U = -vc (U is defined positive as eastward; vc is positive
% offshore)
%       V = va (positive northwards)
% In the original script: U = va and V = vc

%% Moving tidal analysis

close

debug        = 0; % checks for every interval the fitted velocity with the measured velocity
comp         = []; % e.g. 'M2'
range1sided  = 38;
nt           = size(va,2);
T.tstep      = tstep; % timesteps
dt           = diff(time);dt = dt(1)*24; % time interval data

% concatenate
T.times = 1:tstep:size(va,2); % timesteps
T.major = nan(size(va,1),length(T.times));
T.minor = nan(size(va,1),length(T.times));
T.incl  = nan(size(va,1),length(T.times));
T.phase = nan(size(va,1),length(T.times));

T.va = nan(size(va));
T.vc = nan(size(va));

for itt=1:length(T.times)% loopover tijd
    it = T.times(itt);
    disp(['TIME>>>>>>>>>>>>>>>> ',num2str(it)])
    for iz=1:size(va,1)% loopover z
        
        if (it > range1sided) && (it < (nt - range1sided))
            
            itsubset = it + [-range1sided:range1sided]; % 76*10/60 = 12.667hour
            
            U = -vc(iz,itsubset) + sqrt(-1).*va(iz,itsubset);
            
            if sum(isnan(U))<35
                
                [S,Ufitted] = t_tide(U,'interval',dt,'output','none'); %
                %[S,Ufitted] = t_tide(U,'interval',dt,'output','none','rayleigh','M2'); % ALLEEN M2 'shallow' 'rayleigh'
                %[S,Ufitted] = t_tide(U,'interval',dt,'output','none','rayleigh','M2','shallow',['M4';'M6']);
                
                % Check fitted velocity against measured velocity
                if debug
                    close
                    subplot(2,1,1)
                    plot(time(itsubset),va(iz,itsubset),'b')
                    hold on
                    plot(time(itsubset),real(Ufitted),'g')
                    plot(time(itsubset),va(iz,itsubset) - real(Ufitted),'r')
                    datetick('x')
                    legend('measured va','fitted va','difference');
                    title([iz,it]) 
                    
                    subplot(2,1,2)
                    plot(time(itsubset),vc(iz,itsubset),'b')
                    hold on
                    plot(time(itsubset),imag(Ufitted),'g')
                    plot(time(itsubset),vc(iz,itsubset) - imag(Ufitted),'r')
                    datetick('x')
                    legend('measured vc','fitted vc','difference');
                     pausedisp
                end
                
                % Define values
                T.va(iz,it) = real(Ufitted(range1sided+1));
                T.vc(iz,it) = imag(Ufitted(range1sided+1));
                
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

T.comp = S.name;
close

end
