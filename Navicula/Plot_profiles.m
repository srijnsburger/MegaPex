%% Plot CTD casts SBE 

load('d:\sabinerijnsbur\Measurements\Measurements2014\Matlab\Navicula_170914\Data_SBENav.mat');
dir_out   = 'd:\sabinerijnsbur\Matlab\Figures\Navicula170914\';
save_plot = 'yes';

%% Input figures

fig.fonts  = 8;
fig.xaxis  = [20 32];
fig.yaxis  = [-14 0];
fig.line   = 'b';
fig.lwidth = 1;

%% Plot casts

figure;
subplot(2,5,1)
plot(C2(1).data(:,11),-C2(1).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(1) ' ' datestr(C2(1).data(1,13),'HH:MM')]);

subplot(2,5,2)
plot(C2(2).data(:,11),-C2(2).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(2) ' ' datestr(C2(2).data(1,13),'HH:MM')]);

subplot(2,5,3)
plot(C2(3).data(:,11),-C2(3).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(3) ' ' datestr(C2(3).data(1,13),'HH:MM')]);

subplot(2,5,4)
plot(C2(4).data(:,11),-C2(4).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(4) ' ' datestr(C2(4).data(1,13),'HH:MM')]);

subplot(2,5,5)
plot(C2(5).data(:,11),-C2(5).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(5) ' ' datestr(C2(5).data(1,13),'HH:MM')]);

subplot(2,5,6)
plot(C2(6).data(:,11),-C2(6).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(6) ' ' datestr(C2(6).data(1,13),'HH:MM')]);

subplot(2,5,7)
plot(C2(7).data(:,11),-C2(7).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(7) ' ' datestr(C2(7).data(1,13),'HH:MM')]);

subplot(2,5,8)
plot(C2(8).data(:,11),-C2(8).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(8) ' ' datestr(C2(8).data(1,13),'HH:MM')]);

subplot(2,5,9)
plot(C2(9).data(:,11),-C2(9).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(9) ' ' datestr(C2(9).data(1,13),'HH:MM')]);

subplot(2,5,10)
plot(C2(10).data(:,11),-C2(10).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(10) ' ' datestr(C2(10).data(1,13),'HH:MM')]);

if strcmp(save_plot,'yes')
    set(gcf, 'PaperUnits', 'centimeters');
    set(gcf, 'PaperSize', [30 21]);
    set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperPosition', [0 0 30 21]);
    set(gcf,'Renderer','painters');
    print(gcf, '-dpdf',[dir_out 'CTDprofiles1-10.pdf']);
end

%% Profiles 11 - 20

figure;
subplot(2,5,1)
plot(C2(11).data(:,11),-C2(11).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(11) ' ' datestr(C2(11).data(1,13),'HH:MM')]);

subplot(2,5,2)
plot(C2(12).data(:,11),-C2(12).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(12) ' ' datestr(C2(12).data(1,13),'HH:MM')]);

subplot(2,5,3)
plot(C2(13).data(:,11),-C2(13).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(13) ' ' datestr(C2(13).data(1,13),'HH:MM')]);

subplot(2,5,4)
plot(C2(14).data(:,11),-C2(14).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(14) ' ' datestr(C2(14).data(1,13),'HH:MM')]);

subplot(2,5,5)
plot(C2(15).data(:,11),-C2(15).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(15) ' ' datestr(C2(15).data(1,13),'HH:MM')]);

subplot(2,5,6)
plot(C2(16).data(:,11),-C2(16).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(16) ' ' datestr(C2(16).data(1,13),'HH:MM')]);

subplot(2,5,7)
plot(C2(17).data(:,11),-C2(17).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(17) ' ' datestr(C2(17).data(1,13),'HH:MM')]);

subplot(2,5,8)
plot(C2(18).data(:,11),-C2(18).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(18) ' ' datestr(C2(18).data(1,13),'HH:MM')]);

subplot(2,5,9)
plot(C2(19).data(:,11),-C2(19).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(19) ' ' datestr(C2(19).data(1,13),'HH:MM')]);

subplot(2,5,10)
plot(C2(20).data(:,11),-C2(20).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(20) ' ' datestr(C2(20).data(1,13),'HH:MM')]);

if strcmp(save_plot,'yes')
    set(gcf, 'PaperUnits', 'centimeters');
    set(gcf, 'PaperSize', [30 21]);
    set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperPosition', [0 0 30 21]);
    set(gcf,'Renderer','painters');
    print(gcf, '-dpdf',[dir_out 'CTDprofiles11-20.pdf']);
end

%% Profiles 21 - 30

figure;
subplot(2,5,1)
plot(C2(21).data(:,11),-C2(21).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(21) ' ' datestr(C2(21).data(1,13),'HH:MM')]);

subplot(2,5,2)
plot(C2(22).data(:,11),-C2(22).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(22) ' ' datestr(C2(22).data(1,13),'HH:MM')]);

subplot(2,5,3)
plot(C2(23).data(:,11),-C2(23).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(23) ' ' datestr(C2(23).data(1,13),'HH:MM')]);

subplot(2,5,4)
plot(C2(24).data(:,11),-C2(24).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(24) ' ' datestr(C2(24).data(1,13),'HH:MM')]);

subplot(2,5,5)
plot(C2(25).data(:,11),-C2(25).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(25) ' ' datestr(C2(25).data(1,13),'HH:MM')]);

subplot(2,5,6)
plot(C2(26).data(:,11),-C2(26).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(26) ' ' datestr(C2(26).data(1,13),'HH:MM')]);

subplot(2,5,7)
plot(C2(27).data(:,11),-C2(27).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(27) ' ' datestr(C2(27).data(1,13),'HH:MM')]);

subplot(2,5,8)
plot(C2(28).data(:,11),-C2(28).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(28) ' ' datestr(C2(28).data(1,13),'HH:MM')]);

subplot(2,5,9)
plot(C2(29).data(:,11),-C2(29).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(29) ' ' datestr(C2(29).data(1,13),'HH:MM')]);

subplot(2,5,10)
plot(C2(30).data(:,11),-C2(30).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(30) ' ' datestr(C2(30).data(1,13),'HH:MM')]);

if strcmp(save_plot,'yes')
    set(gcf, 'PaperUnits', 'centimeters');
    set(gcf, 'PaperSize', [30 21]);
    set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperPosition', [0 0 30 21]);
    set(gcf,'Renderer','painters');
    print(gcf, '-dpdf',[dir_out 'CTDprofiles21-30.pdf']);
end

%% Profiles 31 - 32

figure;
subplot(1,2,1)
plot(C2(31).data(:,11),-C2(31).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(31) ' ' datestr(C2(31).data(1,13),'HH:MM')]);

subplot(1,2,2)
plot(C2(32).data(:,11),-C2(32).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(32) ' ' datestr(C2(32).data(1,13),'HH:MM')]);

if strcmp(save_plot,'yes')
    set(gcf, 'PaperUnits', 'centimeters');
    set(gcf, 'PaperSize', [30 21]);
    set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperPosition', [0 0 30 21]);
    set(gcf,'Renderer','painters');
    print(gcf, '-dpdf',[dir_out 'CTDprofiles31-32.pdf']);
end

%% YoYo profile 11

figure;
subplot(2,4,1)
plot(C2(11).data(:,13),-C2(11).data(:,2),'Color',[0.6 0.6 0.6])
hold on
plot(Sp11(1).data(:,13),-Sp11(1).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
datetick('x','HH:MM','keepticks');
xlabel('Time');
ylabel('Pressure');
title(['Cast' ' ' num2str(11) '-' num2str(1) ' ' datestr(Sp11(1).data(1,13),'HH:MM')]);

subplot(2,4,2)
plot(C2(11).data(:,13),-C2(11).data(:,2),'Color',[0.6 0.6 0.6])
hold on
plot(Sp11(2).data(:,13),-Sp11(2).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
datetick('x','HH:MM','keepticks');
xlabel('Time');
ylabel('Pressure');
title(['Cast' ' ' num2str(11) '-' num2str(2) ' ' datestr(Sp11(2).data(1,13),'HH:MM')]);

subplot(2,4,3)
plot(C2(11).data(:,13),-C2(11).data(:,2),'Color',[0.6 0.6 0.6])
hold on
plot(Sp11(3).data(:,13),-Sp11(3).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
datetick('x','HH:MM','keepticks');
xlabel('Time');
ylabel('Pressure');
title(['Cast' ' ' num2str(11) '-' num2str(3) ' ' datestr(Sp11(3).data(1,13),'HH:MM')]);

subplot(2,4,4)
plot(C2(11).data(:,13),-C2(11).data(:,2),'Color',[0.6 0.6 0.6])
hold on
plot(Sp11(4).data(:,13),-Sp11(4).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
datetick('x','HH:MM','keepticks');
xlabel('Time');
ylabel('Pressure');
title(['Cast' ' ' num2str(11) '-' num2str(4) ' ' datestr(Sp11(4).data(1,13),'HH:MM')]);

subplot(2,4,5)
plot(Sp11(1).data(:,11),-Sp11(1).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');

subplot(2,4,6)
plot(Sp11(2).data(:,11),-Sp11(2).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');

subplot(2,4,7)
plot(Sp11(3).data(:,11),-Sp11(3).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');

subplot(2,4,8)
plot(Sp11(4).data(:,11),-Sp11(4).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');

if strcmp(save_plot,'yes')
    set(gcf, 'PaperUnits', 'centimeters');
    set(gcf, 'PaperSize', [30 21]);
    set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperPosition', [0 0 30 21]);
    set(gcf,'Renderer','painters');
    print(gcf, '-dpdf',[dir_out 'CTDprofilescast11.pdf']);
end

%% YoYo profile 19

figure;
% AX = subplot_meshgrid(6,2,[.08 0.01 0.01 0.01 0.01 0.01 0.05],[.03 .01 .03],[nan nan nan nan nan nan],[nan nan]);
% axes(AX(1,1))
subplot(2,6,1)
plot(Sp19(1).data(:,11),-Sp19(1).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(19) '-' num2str(1) ' ' datestr(Sp19(1).data(1,13),'HH:MM')]);

% axes(AX(2,1))
subplot(2,6,2)
plot(Sp19(2).data(:,11),-Sp19(2).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(19) '-' num2str(2) ' ' datestr(Sp19(2).data(1,13),'HH:MM')]);

% axes(AX(3,1))
subplot(2,6,3)
plot(Sp19(3).data(:,11),-Sp19(3).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(19) '-' num2str(3) ' ' datestr(Sp19(3).data(1,13),'HH:MM')]);

% axes(AX(4,1))
subplot(2,6,4)
plot(Sp19(4).data(:,11),-Sp19(4).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(19) '-' num2str(4) ' ' datestr(Sp19(4).data(1,13),'HH:MM')]);

% axes(AX(5,1))
subplot(2,6,5)
plot(Sp19(5).data(:,11),-Sp19(5).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(19) '-' num2str(5) ' ' datestr(Sp19(5).data(1,13),'HH:MM')]);

% axes(AX(6,1))
subplot(2,6,6)
plot(Sp19(6).data(:,11),-Sp19(6).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(19) '-' num2str(6) ' ' datestr(Sp19(6).data(1,13),'HH:MM')]);

% axes(AX(1,2))
subplot(2,6,7)
plot(Sp19(7).data(:,11),-Sp19(7).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(19) '-' num2str(7) ' ' datestr(Sp19(7).data(1,13),'HH:MM')]);

% axes(AX(2,2))
subplot(2,6,8)
plot(Sp19(8).data(:,11),-Sp19(8).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(19) '-' num2str(8) ' ' datestr(Sp19(8).data(1,13),'HH:MM')]);

% axes(AX(3,2))
subplot(2,6,9)
plot(Sp19(9).data(:,11),-Sp19(9).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(19) '-' num2str(9) ' ' datestr(Sp19(9).data(1,13),'HH:MM')]);

% axes(AX(4,2))
subplot(2,6,10)
plot(Sp19(10).data(:,11),-Sp19(10).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(19) '-' num2str(10) ' ' datestr(Sp19(10).data(1,13),'HH:MM')]);

% axes(AX(5,2))
subplot(2,6,11)
plot(Sp19(11).data(:,11),-Sp19(11).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(19) '-' num2str(11) ' ' datestr(Sp19(11).data(1,13),'HH:MM')]);

% axes(AX(6,2))
subplot(2,6,12)
plot(Sp19(12).data(:,11),-Sp19(12).data(:,2),fig.line,'Linewidth',fig.lwidth)
set(gca,'fontsize',fig.fonts);
axis([fig.xaxis fig.yaxis]);
xlabel('Salinity (psu)');
ylabel('Pressure');
title(['Cast' ' ' num2str(19) '-' num2str(12) ' ' datestr(Sp19(12).data(1,13),'HH:MM')]);

if strcmp(save_plot,'yes')
    set(gcf, 'PaperUnits', 'centimeters');
    set(gcf, 'PaperSize', [30 21]);
    set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperPosition', [0 0 30 21]);
    set(gcf,'Renderer','painters');
    print(gcf, '-dpdf',[dir_out 'CTDprofilescast19.pdf']);
end
