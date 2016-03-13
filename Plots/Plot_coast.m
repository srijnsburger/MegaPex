% PLOT LAND BOUNDARY DUTCH COAST
clc;clear all;close all;

dir_out    = 'd:\sabinerijnsbur\Figures-Matlab\Figures-MegaPex-2014\Presentation_OS2016\';
flag_print = 1;

% Coordinates measurements
M12 = [4.17781 52.06883];
M18 = [4.14159 52.09176];

% Load landboundary
P = nc2struct('d:\sabinerijnsbur\SurfDrive\Scripts\Bottomtopography\holland_fillable.nc');
cmp = get(groot,'DefaultAxesColorOrder');

% Plot
figure;
plot(P.lon,P.lat,'Color',[0.2 0.2 0.2]);
hold on
plot(M12(1),M12(2),'p','Markersize',12,'Color',cmp(3,1:3),'Markerfacecolor',cmp(3,1:3));
plot(M18(1),M18(2),'p','Markersize',12,'Color',cmp(5,1:3),'Markerfacecolor',cmp(5,1:3));
% plot(4.341973,52.009321,'.','Markersize',15,'Color',[0.5 0.5 0.5]);
% plot(4.134263,51.981327,'.','Markersize',17,'Color',[0.5 0.5 0.5]);
plot(4.450208,52.240044,'.','Markersize',17,'Color',[0.5 0.5 0.5]);
% plot(4.578580,52.449535,'.','Markersize',16,'Color',[0.5 0.5 0.5]);
% plot(4.573655,52.471325,'.','Markersize',17,'Color',[0.5 0.5 0.5]);
plot(4.4739,51.91,'.','Markersize',19,'Color',[0.5 0.5 0.5]);
% plot(4.897516,52.371977,'.','Markersize',19,'Color',[0.5 0.5 0.5]);
plot(4.167591,52.029939,'.','Markersize',19,'Color',[0.5 0.5 0.5]);
% fill(P.lon,P.lat,[0.5 0.5 0.5]);
axis equal  
axis([3.8 5 51.5 53])
tickmap('ll')
axislat(52.5)
% text(4.35,52.009321,'Delft');
% t1 = text(4.183,51.981327,'Hoek van Holland');
t2 = text(4.488,52.240044,'Noordwijk');
t2.Color = [0.5 0.5 0.5];
% t3 = text(4.592,52.49,'IJmuiden');
% t.n1 = text(4.39,51.942,'Rotterdam');
% t.n1.Color = [0.5 0.5 0.5];
% t.n2 = text(4.75,52.35,'Amsterdam');
% t.n2.Color = [0.5 0.5 0.5];
% t.n3 = text(4.195,52.028,'Zandmotor');
% t.n3.Color = [0.5 0.5 0.5];
t1 = text(4.25,51.945,'Rotterdam');
t1.Color = [0.5 0.5 0.5];
% t2 = text(4.54,52.35,'Amsterdam');
% t2.Color = [0.5 0.5 0.5];
t3 = text(4.195,52.028,'Zandmotor');
t3.Color = [0.5 0.5 0.5];

% save figure 
fs  = 18;
opts = struct('format','png','Preview','tiff',...
        'width',12,'height',24,'Bounds','loose',...
        'color','cmyk','Renderer','painters','Resolution',300,...
        'LockAxes','loose',...
        'FontMode','scaled','DefaultFixedFontSize',fs,'FontSizeMin',fs-2,'FontSizeMax',fs+2,'LineMode','scaled');


    applytofig(gcf,opts);
    if flag_print
        set(gcf,'PaperUnits','centimeters');
        exportfig(gcf,[dir_out 'land_bnd3.png'],opts);
    end



% opts = struct('format','png','Preview','tiff',...
%         'width',12,'height',24,'Bounds','loose',...
%         'color','cmyk','Renderer','painters','Resolution',300,...
%         'LockAxes','loose',...
%         'FontMode','scaled','DefaultFixedFontSize',fs,'FontSizeMin',fs-2,'FontSizeMax',fs+2,'LineMode','scaled');
% 
%     applytofig(gcf,opts);
%     if flag_print
%         set(gcf,'PaperUnits','centimeters');
%         exportfig(gcf,[dir_out 'Land_bnd2.png'],opts);
%     end


%% Zoom-in

% Plot
figure;
plot(P.lon,P.lat,'Color',[0.2 0.2 0.2]);
hold on
plot(M12(1),M12(2),'p','Markersize',12,'Color',cmp(3,1:3),'Markerfacecolor',cmp(3,1:3));
plot(M18(1),M18(2),'p','Markersize',12,'Color',cmp(3,1:3),'Markerfacecolor',cmp(3,1:3));
plot(4.134263,51.981327,'.','Markersize',17,'Color',[0.5 0.5 0.5]);
plot(4.450208,52.240044,'.','Markersize',17,'Color',[0.5 0.5 0.5]);
% plot(4.578580,52.449535,'.','Markersize',16,'Color',[0.5 0.5 0.5]);
plot(4.167591,52.029939,'.','Markersize',17,'Color',[0.5 0.5 0.5]);
% fill(P.lon,P.lat,[0.5 0.5 0.5]);
axis equal  
axis([3.8 5 51.5 52.28])
tickmap('ll')
axislat(51.5)
% axislat(52.5)
% text(4.35,52.009321,'Delft');
t1 = text(4.183,51.981327,'Hoek van Holland');
t1.Color = [0.5 0.5 0.5];
t2 = text(4.488,52.240044,'Noordwijk');
t2.Color = [0.5 0.5 0.5];
t4 = text(4.195,52.028,'Ter Heijde');
t4.Color = [0.5 0.5 0.5];

% save figure 
fs  = 14;
opts = struct('format','png','Preview','tiff',...
        'width',14,'height',20,'Bounds','loose',...
        'color','cmyk','Renderer','painters','Resolution',300,...
        'LockAxes','loose',...
        'FontMode','scaled','DefaultFixedFontSize',fs,'FontSizeMin',fs-2,'FontSizeMax',fs+2,'LineMode','scaled');

flag_print = 0;

    applytofig(gcf,opts);
    if flag_print
        set(gcf,'PaperUnits','centimeters');
        exportfig(gcf,[dir_out 'Studyarea.png'],opts);
    end




