%Plot Matrix of density and velocity per tidal cycle for 12m & 18m
clc; clear all;close all;
%% Load data 

dirin = 'd:\sabinerijnsbur\Matlab\Moorings\Mfiles\';
load([dirin,'Matrix_TC_12.mat']);
load([dirin,'Matrix_TC_18.mat']);

% load([dirin,'radar_adcp']);

%% distinction periods --> manually for now

if strcmp(dirin,'d:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\')
    p1 = [1:12];
    p2 = [13:26];
    p3 = [27:38];
    p4 = [39:52];
    p5 = [53:56];
else
    p1 = [1:12];
    p2 = [13:26];
    p3 = [27:38];
    p4 = [39:52];
    p5 = [53:66];
    p6 = [67:77];
end

fig.ylim = [14 24];

%% Calculate relative displacement:
% 12m
if strcmp(dir,'d:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\')
    
%     dx12 = nan(size(MT12.t,1),size(MT12.t,2)-1);
%     
%     for i = 1:size(MT12.t,1)
%         tt = MT12.t(i,:)*24*60*60; % in sec
%         vc = MT12.vc1527(i,:)-MT12.vc5426(i,:);% surface - bottom
%         nz = length(tt)-1;
%         dx12(i,1:nz) = f_trapz(tt,vc); % relative displacement between -1 and -8m
%         %    tt12(i) = t(i)+t(i+1)/2;
%     end
%     % dx12 = dx12./1000; % in km
%     
%     % 18m
%     dx18 = nan(size(MT18.t,1),size(MT18.t,2)-1);
%     
%     for i = 1:size(MT18.t,1)
%         t = MT18.t(i,:)*24*60*60; % in sec
%         vc = MT18.vc4939(i,:)-MT18.vc19(i,:);% surface - bottom
%         nz = length(t)-1;
%         dx18(i,1:nz) = f_trapz(t,vc); % relative displacement between -1 and -8m
%     end
%     % dx18 = dx18./1000; % in km
%     
%     for jj = 1:size(MT12.t,2)-1
%         tgdx12(jj) = (MT12.tg(jj)+MT12.tg(jj+1))/2;
%     end
%     
%     for jj = 1:size(MT18.t,2)-1
%         tgdx18(jj) = (MT18.tg(jj)+MT18.tg(jj+1))/2;
%     end
    
end
    
%% Density and velocity per tidal cycle 12m

if strcmp(dirin,'d:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\')
% period 1
figure; 
AX = subplot_meshgrid(2,13,[.06 0.01 0.06],[.06 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .03],[nan nan],[nan nan nan nan nan nan nan nan nan nan nan nan nan]);
axes(AX(1,1))
plot(MT12.tg,MT12.ssh(p1(1):p1(12),:));
title({'Neap tide 1 - 12m';'rel. density (kg/m^3)'});

axes(AX(2,1))
plot(MT12.tg,MT12.va1527(p1(1):p1(12),:));
text(58,0.72,'va at 1mbs');
title(['cross-shore velocity (m/s)']);

for i = 1:length(p1)
axes(AX(1,i+1))
plot(MT12.tg,MT12.D1527(p1(i),:)-1000);
hold on
plot(MT12.tg,MT12.D1526(p1(i),:)-1000);
plot(MT12.tg,MT12.D1842(p1(i),:)-1000);
plot(MT12.tg,15*MTR.on11(p1(i),:),'.','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',14);
plot(MT12.tg,15*MTR.on22(p1(i),:),'.','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',14);
plot(MT12.tg,15*MTR.on1l(p1(i),:),'s','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',3);
plot(MT12.tg,15*MTR.on2l(p1(i),:),'s','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',3);
plot(MT12.tg,15*MTR.on1h(p1(i),:),'*','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980]);
plot(MT12.tg,15*MTR.off1l(p1(i),:),'.','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',12);
plot(MT12.tg,15*MTR.off3l(p1(i),:),'.','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',12);
plot(MT12.tg,15*MTR.off11(p1(i),:),'s','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',3);
plot(MT12.tg,15*MTR.off22(p1(i),:),'s','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',3);
plot(MT12.tg,15*MTR.off1r(p1(i),:),'x','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3]);
plot(MT12.tg,15*MTR.off1c(p1(i),:),'+','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3]);
ylim(fig.ylim);
% ylabel('kg/MT12^3');

axes(AX(2,i+1))
plot(MT12.tg,MT12.vc1527(p1(i),:));
hold on
plot(MT12.tg,MT12.vc1526(p1(i),:));
plot(MT12.tg,MT12.vc5425(p1(i),:));
plot(MT12.tg,MT12.vc1842(p1(i),:));
plot(MT12.tg,MT12.vc355(p1(i),:));
hline(0,'k');

end

set(AX(2,:),'YAxisLocation','right');
set(AX(:,1:12),'xticklabel',[])
% set(AX(2,:),'yticklabel',[])
print2a4('D:\sabinerijnsbur\Matlab\Figures\Moorings\Period1_tc_dens_vc12m.png','v','w');

% period 2
figure; 
AX = subplot_meshgrid(2,15,[.06 0.01 0.06],[.06 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .03],[nan nan],[nan nan nan nan nan nan nan nan nan nan nan nan nan nan nan]);
axes(AX(1,1))
plot(MT12.tg,MT12.ssh(p2(1):p2(end),:));
title({'Spring tide 1 - 12m';'rel. density (kg/m^3)'});

axes(AX(2,1))
plot(MT12.tg,MT12.va1527(p2(1):p2(end),:));
text(58,0.72,'va at 1mbs');
title(['cross-shore velocity (m/s)']);

for i = 1:length(p2)
axes(AX(1,i+1))
plot(MT12.tg,MT12.D1527(p2(i),:)-1000);
hold on
plot(MT12.tg,MT12.D1526(p2(i),:)-1000);
plot(MT12.tg,MT12.D1842(p2(i),:)-1000);
plot(MT12.tg,15*MTR.on11(p2(i),:),'.','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',14);
plot(MT12.tg,15*MTR.on22(p2(i),:),'.','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',14);
plot(MT12.tg,15*MTR.on1l(p2(i),:),'s','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',3);
plot(MT12.tg,15*MTR.on2l(p2(i),:),'s','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',3);
plot(MT12.tg,15*MTR.on1h(p2(i),:),'*','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980]);
plot(MT12.tg,15*MTR.off1l(p2(i),:),'.','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',12);
plot(MT12.tg,15*MTR.off3l(p2(i),:),'.','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',12);
plot(MT12.tg,15*MTR.off11(p2(i),:),'s','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',3);
plot(MT12.tg,15*MTR.off22(p2(i),:),'s','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',3);
plot(MT12.tg,15*MTR.off1r(p2(i),:),'x','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3]);
plot(MT12.tg,15*MTR.off1c(p2(i),:),'+','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3]);
ylim(fig.ylim);
% ylabel('kg/MT12^3');

axes(AX(2,i+1))
plot(MT12.tg,MT12.vc1527(p2(i),:));
hold on
plot(MT12.tg,MT12.vc1526(p2(i),:));
plot(MT12.tg,MT12.vc5425(p2(i),:));
plot(MT12.tg,MT12.vc1842(p2(i),:));
plot(MT12.tg,MT12.vc355(p2(i),:));
hline(0,'k');

end

set(AX(2,:),'YAxisLocation','right');
set(AX(:,1:14),'xticklabel',[])
% set(AX(2,:),'yticklabel',[])
print2a4('D:\sabinerijnsbur\Matlab\Figures\Moorings\Period2_tc_dens_vc12m.png','v','w');

% period 3
figure; 
AX = subplot_meshgrid(2,13,[.06 0.01 0.06],[.06 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .03],[nan nan],[nan nan nan nan nan nan nan nan nan nan nan nan nan]);
axes(AX(1,1))
plot(MT12.tg,MT12.ssh(p3(1):p3(end),:));
title({['Neap tide 2 - 12m'];'rel. density (kg/m^3)'});

axes(AX(2,1))
plot(MT12.tg,MT12.va1527(p3(1):p3(end),:));
text(58,0.72,'va at 1mbs');
title(['cross-shore velocity (m/s)']);

for i = 1:length(p3)
axes(AX(1,i+1))
plot(MT12.tg,MT12.D1527(p3(i),:)-1000);
hold on
plot(MT12.tg,MT12.D1526(p3(i),:)-1000);
plot(MT12.tg,MT12.D1842(p3(i),:)-1000);
plot(MT12.tg,15*MTR.on11(p3(i),:),'.','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',14);
plot(MT12.tg,15*MTR.on22(p3(i),:),'.','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',14);
plot(MT12.tg,15*MTR.on1l(p3(i),:),'s','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',3);
plot(MT12.tg,15*MTR.on2l(p3(i),:),'s','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',3);
plot(MT12.tg,15*MTR.on1h(p3(i),:),'*','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980]);
plot(MT12.tg,15*MTR.off1l(p3(i),:),'.','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',12);
plot(MT12.tg,15*MTR.off3l(p3(i),:),'.','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',12);
plot(MT12.tg,15*MTR.off11(p3(i),:),'s','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',3);
plot(MT12.tg,15*MTR.off22(p3(i),:),'s','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',3);
plot(MT12.tg,15*MTR.off1r(p3(i),:),'x','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3]);
plot(MT12.tg,15*MTR.off1c(p3(i),:),'+','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3]);
ylim(fig.ylim);
% ylabel('kg/MT12^3');

axes(AX(2,i+1))
plot(MT12.tg,MT12.vc1527(p3(i),:));
hold on
plot(MT12.tg,MT12.vc1526(p3(i),:));
plot(MT12.tg,MT12.vc5425(p3(i),:));
plot(MT12.tg,MT12.vc1842(p3(i),:));
plot(MT12.tg,MT12.vc355(p3(i),:));
hline(0,'k');

end

set(AX(2,:),'YAxisLocation','right');
set(AX(:,1:12),'xticklabel',[])
% set(AX(2,:),'yticklabel',[])
print2a4('D:\sabinerijnsbur\Matlab\Figures\Moorings\Period3_tc_dens_vc12m.png','v','w');

% period 4
figure; 
AX = subplot_meshgrid(2,15,[.06 0.01 0.06],[.06 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .03],[nan nan],[nan nan nan nan nan nan nan nan nan nan nan nan nan nan nan]);
axes(AX(1,1))
plot(MT12.tg,MT12.ssh(p4(1):p4(end),:));
title({['Spring tide 2 - 12m'];'rel. density (kg/m^3)'});

axes(AX(2,1))
plot(MT12.tg,MT12.va1527(p4(1):p4(end),:));
text(58,0.72,'va at 1mbs');
title(['cross-shore velocity (m/s)']);

for i = 1:length(p4)
axes(AX(1,i+1))
plot(MT12.tg,MT12.D1527(p4(i),:)-1000);
hold on
plot(MT12.tg,MT12.D1526(p4(i),:)-1000);
plot(MT12.tg,MT12.D1842(p4(i),:)-1000);
plot(MT12.tg,15*MTR.on11(p4(i),:),'.','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',14);
plot(MT12.tg,15*MTR.on22(p4(i),:),'.','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',14);
plot(MT12.tg,15*MTR.on1l(p4(i),:),'s','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',3);
plot(MT12.tg,15*MTR.on2l(p4(i),:),'s','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',3);
plot(MT12.tg,15*MTR.on1h(p4(i),:),'*','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980]);
plot(MT12.tg,15*MTR.off1l(p4(i),:),'.','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',12);
plot(MT12.tg,15*MTR.off3l(p4(i),:),'.','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',12);
plot(MT12.tg,15*MTR.off11(p4(i),:),'s','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',3);
plot(MT12.tg,15*MTR.off22(p4(i),:),'s','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',3);
plot(MT12.tg,15*MTR.off1r(p4(i),:),'x','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3]);
plot(MT12.tg,15*MTR.off1c(p4(i),:),'+','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3]);
ylim(fig.ylim);
% ylabel('kg/MT12^3');

axes(AX(2,i+1))
plot(MT12.tg,MT12.vc1527(p4(i),:));
hold on
plot(MT12.tg,MT12.vc1526(p4(i),:));
plot(MT12.tg,MT12.vc5425(p4(i),:));
plot(MT12.tg,MT12.vc1842(p4(i),:));
plot(MT12.tg,MT12.vc355(p4(i),:));
hline(0,'k');

end

set(AX(2,:),'YAxisLocation','right');
set(AX(:,1:14),'xticklabel',[])
% set(AX(2,:),'yticklabel',[])
print2a4('D:\sabinerijnsbur\Matlab\Figures\Moorings\Period4_tc_dens_vc12m.png','v','w');

% period 5
figure; 
AX = subplot_meshgrid(2,5,[.06 0.01 0.06],[.06 .01 .01 .01 .01 .03],[nan nan],[nan nan nan nan nan]);
axes(AX(1,1))
plot(MT12.tg,MT12.ssh(p5(1):p5(end),:));
title({['Neap tide 3 - 12m'];'rel. density (kg/m^3)'});

axes(AX(2,1))
plot(MT12.tg,MT12.va1527(p5(1):p5(end),:));
text(58,0.72,'va at 1mbs');
title(['cross-shore velocity (m/s)']);

for i = 1:length(p5)
axes(AX(1,i+1))
plot(MT12.tg,MT12.D1527(p5(i),:)-1000);
hold on
plot(MT12.tg,MT12.D1526(p5(i),:)-1000);
plot(MT12.tg,MT12.D1842(p5(i),:)-1000);
plot(MT12.tg,15*MTR.on11(p5(i),:),'.','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',14);
plot(MT12.tg,15*MTR.on22(p5(i),:),'.','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',14);
plot(MT12.tg,15*MTR.on1l(p5(i),:),'s','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',3);
plot(MT12.tg,15*MTR.on2l(p5(i),:),'s','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',3);
plot(MT12.tg,15*MTR.on1h(p5(i),:),'*','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980]);
plot(MT12.tg,15*MTR.off1l(p5(i),:),'.','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',12);
plot(MT12.tg,15*MTR.off3l(p5(i),:),'.','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',12);
plot(MT12.tg,15*MTR.off11(p5(i),:),'s','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',3);
plot(MT12.tg,15*MTR.off22(p5(i),:),'s','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',3);
plot(MT12.tg,15*MTR.off1r(p5(i),:),'x','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3]);
plot(MT12.tg,15*MTR.off1c(p5(i),:),'+','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3]);
ylim(fig.ylim);
% ylabel('kg/MT12^3');

axes(AX(2,i+1))
plot(MT12.tg,MT12.vc1527(p5(i),:));
hold on
plot(MT12.tg,MT12.vc1526(p5(i),:));
plot(MT12.tg,MT12.vc5425(p5(i),:));
plot(MT12.tg,MT12.vc1842(p5(i),:));
plot(MT12.tg,MT12.vc355(p5(i),:));
hline(0,'k');

end

set(AX(2,:),'YAxisLocation','right');
set(AX(:,1:4),'xticklabel',[])
% set(AX(2,:),'yticklabel',[])
print2a4('D:\sabinerijnsbur\Matlab\Figures\Moorings\Period5_tc_dens_vc12m.png','v','w');

end
%% Plot of density only

% Period 1
figure; 
AX = subplot_meshgrid(1,13,[.06 0.06],[.06 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .03],[nan],[nan nan nan nan nan nan nan nan nan nan nan nan nan]);
axes(AX(1,1))
plot(MT12.tg,MT12.ssh(p1(1):p1(12),:));
title({'Neap tide 1 - 12m';'rel. density (kg/m^3)'});

for i = 1:length(p1)
axes(AX(1,i+1))
plot(MT12.tg,MT12.D1527(p1(i),:)-1000);
hold on
plot(MT12.tg,MT12.D1526(p1(i),:)-1000);
plot(MT12.tg,MT12.D1842(p1(i),:)-1000);
plot(MT12.tg,15*MTR.on11(p1(i),:),'.','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',14);
plot(MT12.tg,15*MTR.on22(p1(i),:),'.','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',14);
plot(MT12.tg,15*MTR.on1l(p1(i),:),'s','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',3);
plot(MT12.tg,15*MTR.on2l(p1(i),:),'s','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',3);
plot(MT12.tg,15*MTR.on1h(p1(i),:),'*','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980]);
plot(MT12.tg,15*MTR.off1l(p1(i),:),'.','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',12);
plot(MT12.tg,15*MTR.off3l(p1(i),:),'.','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',12);
plot(MT12.tg,15*MTR.off11(p1(i),:),'s','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',3);
plot(MT12.tg,15*MTR.off22(p1(i),:),'s','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',3);
plot(MT12.tg,15*MTR.off1r(p1(i),:),'x','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3]);
plot(MT12.tg,15*MTR.off1c(p1(i),:),'+','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3]);
ylim(fig.ylim);
% ylabel('kg/MT12^3');
end

set(AX(:,1:12),'xticklabel',[])
% set(AX(2,:),'yticklabel',[])
print2a4('D:\sabinerijnsbur\Matlab\Figures\Moorings\Period1_tc_dens12m.png','v','w');

% period 2
figure; 
AX = subplot_meshgrid(1,15,[.06 0.06],[.06 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .03],[nan],[nan nan nan nan nan nan nan nan nan nan nan nan nan nan nan]);
axes(AX(1,1))
plot(MT12.tg,MT12.ssh(p2(1):p2(end),:));
title({['Spring tide 1 - 12m'];'rel. density (kg/m^3)'});

for i = 1:length(p2)
axes(AX(1,i+1))
plot(MT12.tg,MT12.D1527(p2(i),:)-1000);
hold on
plot(MT12.tg,MT12.D1526(p2(i),:)-1000);
plot(MT12.tg,MT12.D1842(p2(i),:)-1000);
plot(MT12.tg,15*MTR.on11(p2(i),:),'.','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',14);
plot(MT12.tg,15*MTR.on22(p2(i),:),'.','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',14);
plot(MT12.tg,15*MTR.on1l(p2(i),:),'s','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',3);
plot(MT12.tg,15*MTR.on2l(p2(i),:),'s','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',3);
plot(MT12.tg,15*MTR.on1h(p2(i),:),'*','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980]);
plot(MT12.tg,15*MTR.off1l(p2(i),:),'.','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',12);
plot(MT12.tg,15*MTR.off3l(p2(i),:),'.','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',12);
plot(MT12.tg,15*MTR.off11(p2(i),:),'s','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',3);
plot(MT12.tg,15*MTR.off22(p2(i),:),'s','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',3);
plot(MT12.tg,15*MTR.off1r(p2(i),:),'x','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3]);
plot(MT12.tg,15*MTR.off1c(p2(i),:),'+','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3]);
ylim(fig.ylim);
% ylabel('kg/MT12^3');
end

set(AX(:,1:14),'xticklabel',[])
% set(AX(2,:),'yticklabel',[])
print2a4('D:\sabinerijnsbur\Matlab\Figures\Moorings\Period2_tc_dens12m.png','v','w');

% Period 3
figure; 
AX = subplot_meshgrid(1,13,[.06 0.06],[.06 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .03],[nan],[nan nan nan nan nan nan nan nan nan nan nan nan nan]);
axes(AX(1,1))
plot(MT12.tg,MT12.ssh(p3(1):p3(end),:));
title({['Neap tide 2 - 12m'];'rel. density (kg/m^3)'});

for i = 1:length(p3)
axes(AX(1,i+1))
plot(MT12.tg,MT12.D1527(p3(i),:)-1000);
hold on
plot(MT12.tg,MT12.D1526(p3(i),:)-1000);
plot(MT12.tg,MT12.D1842(p3(i),:)-1000);
plot(MT12.tg,15*MTR.on11(p3(i),:),'.','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',14);
plot(MT12.tg,15*MTR.on22(p3(i),:),'.','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',14);
plot(MT12.tg,15*MTR.on1l(p3(i),:),'s','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',3);
plot(MT12.tg,15*MTR.on2l(p3(i),:),'s','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',3);
plot(MT12.tg,15*MTR.on1h(p3(i),:),'*','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980]);
plot(MT12.tg,15*MTR.off1l(p3(i),:),'.','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',12);
plot(MT12.tg,15*MTR.off3l(p3(i),:),'.','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',12);
plot(MT12.tg,15*MTR.off11(p3(i),:),'s','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',3);
plot(MT12.tg,15*MTR.off22(p3(i),:),'s','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',3);
plot(MT12.tg,15*MTR.off1r(p3(i),:),'x','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3]);
plot(MT12.tg,15*MTR.off1c(p3(i),:),'+','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3]);
ylim(fig.ylim);
% ylabel('kg/MT12^3');
end

set(AX(:,1:12),'xticklabel',[])
% set(AX(2,:),'yticklabel',[])
print2a4('D:\sabinerijnsbur\Matlab\Figures\Moorings\Period3_tc_dens12m.png','v','w');


% Period 4
figure; 
AX = subplot_meshgrid(1,15,[.06 0.06],[.06 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .03],[nan],[nan nan nan nan nan nan nan nan nan nan nan nan nan nan nan]);
axes(AX(1,1))
plot(MT12.tg,MT12.ssh(p4(1):p4(end),:));
title({['Spring tide 2 - 12m'];'rel. density (kg/m^3)'});

for i = 1:length(p4)
axes(AX(1,i+1))
plot(MT12.tg,MT12.D1527(p4(i),:)-1000);
hold on
plot(MT12.tg,MT12.D1526(p4(i),:)-1000);
plot(MT12.tg,MT12.D1842(p4(i),:)-1000);
plot(MT12.tg,15*MTR.on11(p4(i),:),'.','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',14);
plot(MT12.tg,15*MTR.on22(p4(i),:),'.','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',14);
plot(MT12.tg,15*MTR.on1l(p4(i),:),'s','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',3);
plot(MT12.tg,15*MTR.on2l(p4(i),:),'s','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',3);
plot(MT12.tg,15*MTR.on1h(p4(i),:),'*','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980]);
plot(MT12.tg,15*MTR.off1l(p4(i),:),'.','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',12);
plot(MT12.tg,15*MTR.off3l(p4(i),:),'.','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',12);
plot(MT12.tg,15*MTR.off11(p4(i),:),'s','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',3);
plot(MT12.tg,15*MTR.off22(p4(i),:),'s','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',3);
plot(MT12.tg,15*MTR.off1r(p4(i),:),'x','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3]);
plot(MT12.tg,15*MTR.off1c(p4(i),:),'+','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3]);
ylim(fig.ylim);
% ylabel('kg/MT12^3');
end

set(AX(:,1:15),'xticklabel',[])
% set(AX(2,:),'yticklabel',[])
print2a4('D:\sabinerijnsbur\Matlab\Figures\Moorings\Period4_tc_dens12m.png','v','w');

if strcmp(dirin,'d:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\')
    % Period 5
    figure;
    AX = subplot_meshgrid(1,5,[.06 0.06],[.06  .01 .01 .01 .01 .03],[nan],[nan nan nan nan nan]);
    axes(AX(1,1))
    plot(MT12.tg,MT12.ssh(p5(1):p5(end),:));
    title({['Neap tide 3 - 12m'];'rel. density (kg/m^3)'});
    
    for i = 1:length(p5)
        axes(AX(1,i+1))
        plot(MT12.tg,MT12.D1527(p5(i),:)-1000);
        hold on
        plot(MT12.tg,MT12.D1526(p5(i),:)-1000);
        plot(MT12.tg,MT12.D1842(p5(i),:)-1000);
        plot(MT12.tg,15*MTR.on11(p5(i),:),'.','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',14);
        plot(MT12.tg,15*MTR.on22(p5(i),:),'.','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',14);
        plot(MT12.tg,15*MTR.on1l(p5(i),:),'s','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',3);
        plot(MT12.tg,15*MTR.on2l(p5(i),:),'s','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',3);
        plot(MT12.tg,15*MTR.on1h(p5(i),:),'*','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980]);
        plot(MT12.tg,15*MTR.off1l(p5(i),:),'.','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',12);
        plot(MT12.tg,15*MTR.off3l(p5(i),:),'.','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',12);
        plot(MT12.tg,15*MTR.off11(p5(i),:),'s','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',3);
        plot(MT12.tg,15*MTR.off22(p5(i),:),'s','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',3);
        plot(MT12.tg,15*MTR.off1r(p5(i),:),'x','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3]);
        plot(MT12.tg,15*MTR.off1c(p5(i),:),'+','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3]);
        
        ylim(fig.ylim);
        % ylabel('kg/MT12^3');
    end
    
    set(AX(:,1:4),'xticklabel',[])
    % set(AX(2,:),'yticklabel',[])
    print2a4('D:\sabinerijnsbur\Matlab\Figures\Moorings\Period5_tc_adcp_dens12m.png','v','w');
    
else
    
    % Period 5
    figure;
    AX = subplot_meshgrid(1,15,[.06 0.06],[.06 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .03],[nan],[nan nan nan nan nan nan nan nan nan nan nan nan nan nan nan]);
    axes(AX(1,1))
    plot(MT12.tg,MT12.ssh(p5(1):p5(end),:));
    title({['Neap tide 3 - 12m'];'rel. density (kg/m^3)'});
    
    for i = 1:length(p5)
        axes(AX(1,i+1))
        plot(MT12.tg,MT12.D1527(p5(i),:)-1000);
        hold on
        plot(MT12.tg,MT12.D1526(p5(i),:)-1000);
        plot(MT12.tg,MT12.D1842(p5(i),:)-1000);
        plot(MT12.tg,15*MTR.on11(p5(i),:),'.','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',14);
        plot(MT12.tg,15*MTR.on22(p5(i),:),'.','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',14);
        plot(MT12.tg,15*MTR.on1l(p5(i),:),'s','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',3);
        plot(MT12.tg,15*MTR.on2l(p5(i),:),'s','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',3);
        plot(MT12.tg,15*MTR.on1h(p5(i),:),'*','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980]);
        plot(MT12.tg,15*MTR.off1l(p5(i),:),'.','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',12);
        plot(MT12.tg,15*MTR.off3l(p5(i),:),'.','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',12);
        plot(MT12.tg,15*MTR.off11(p5(i),:),'s','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',3);
        plot(MT12.tg,15*MTR.off22(p5(i),:),'s','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',3);
        plot(MT12.tg,15*MTR.off1r(p5(i),:),'x','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3]);
        plot(MT12.tg,15*MTR.off1c(p5(i),:),'+','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3]);
        ylim(fig.ylim);
        % ylabel('kg/MT12^3');
    end
    set(AX(:,1:14),'xticklabel',[])
    print2a4('D:\sabinerijnsbur\Matlab\Figures\Moorings\Period5_tc_dens12m.png','v','w');
    
    % Period 6
    figure;
    AX = subplot_meshgrid(1,12,[.06 0.06],[.06 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .03],[nan],[nan nan nan nan nan nan nan nan nan nan nan nan]);
    axes(AX(1,1))
    plot(MT12.tg,MT12.ssh(p6(1):p6(end),:));
    title({['Spring tide 3 - 12m'];'rel. density (kg/m^3)'});
    
    for i = 1:length(p6)
        axes(AX(1,i+1))
        plot(MT12.tg,MT12.D1527(p6(i),:)-1000);
        hold on
        plot(MT12.tg,MT12.D1526(p6(i),:)-1000);
        plot(MT12.tg,MT12.D1842(p6(i),:)-1000);
        plot(MT12.tg,15*MTR.on11(p6(i),:),'.','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',14);
        plot(MT12.tg,15*MTR.on22(p6(i),:),'.','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',14);
        plot(MT12.tg,15*MTR.on1l(p6(i),:),'s','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',3);
        plot(MT12.tg,15*MTR.on2l(p6(i),:),'s','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980],'Markersize',3);
        plot(MT12.tg,15*MTR.on1h(p6(i),:),'*','MarkerFaceColor',[0.8500 0.3250 0.0980],'MarkerEdgeColor',[0.8500 0.3250 0.0980]);
        plot(MT12.tg,15*MTR.off1l(p6(i),:),'.','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',12);
        plot(MT12.tg,15*MTR.off3l(p6(i),:),'.','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',12);
        plot(MT12.tg,15*MTR.off11(p6(i),:),'s','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',3);
        plot(MT12.tg,15*MTR.off22(p6(i),:),'s','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3],'Markersize',3);
        plot(MT12.tg,15*MTR.off1r(p6(i),:),'x','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3]);
        plot(MT12.tg,15*MTR.off1c(p6(i),:),'+','MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor',[0.3 0.3 0.3]);
        ylim(fig.ylim);
        % ylabel('kg/MT12^3');
    end
    set(AX(:,1:11),'xticklabel',[])
    print2a4('D:\sabinerijnsbur\Matlab\Figures\Moorings\Period6_tc_dens12m.png','v','w');
    
end

%% Density and velocity per tidal cycle 18m

if strcmp(dirin,'d:\sabinerijnsbur\Matlab\Moorings\Mfiles_adcp\')
    
    % period 1
    figure;
    AX = subplot_meshgrid(2,13,[.06 0.05 0.06],[.06 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .03],[nan nan],[nan nan nan nan nan nan nan nan nan nan nan nan nan]);
    axes(AX(1,1))
    plot(MT18.tg,MT18.ssh(p1(1):p1(12),:));
    title({'Neap tide 1 - 18m';'rel. density (kg/m^3)'});
    
    axes(AX(2,1))
    plot(MT18.tg,MT18.va4939(p1(1):p1(12),:));
    text(58,0.72,'va at 2.5mbs');
    title(['cross-shore velocity (m/s)']);
    
    for i = 1:length(p1)
        axes(AX(1,i+1))
        plot(MT18.tg,MT18.D1525(p1(i),:)-1000);
        hold on
        plot(MT18.tg,MT18.D4939(p1(i),:)-1000);
        plot(MT18.tg,MT18.D19(p1(i),:)-1000);
        ylim(fig.ylim);
        % ylabel('kg/MT12^3');
        
        axes(AX(2,i+1))
        plotyy(MT18.tg,MT18.vc1525(p1(i),:),tgdx18,dx18(p1(i),:));
        hold on
        plot(MT18.tg,MT18.vc4939(p1(i),:));
        plot(MT18.tg,MT18.vc19(p1(i),:));
        hline(0,'k');
        
    end
    
%     set(AX(2,:),'YAxisLocation','right');
    set(AX(:,1:12),'xticklabel',[])
    % set(AX(2,:),'yticklabel',[])
    print2a4('D:\sabinerijnsbur\Matlab\Figures\Moorings\Period1_tc_dens_vc18m.png','v','w');
    
    % period 2
    figure;
    AX = subplot_meshgrid(2,15,[.06 0.01 0.06],[.06 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .03],[nan nan],[nan nan nan nan nan nan nan nan nan nan nan nan nan nan nan]);
    axes(AX(1,1))
    plot(MT18.tg,MT18.ssh(p2(1):p2(end),:));
    title({'Spring tide 1 - 18m';'rel. density (kg/m^3)'});
    
    axes(AX(2,1))
    plot(MT18.tg,MT18.va1525(p2(1):p2(end),:));
    text(58,0.72,'va at 2.5mbs');
    title(['cross-shore velocity (m/s)']);
    
    for i = 1:length(p2)
        axes(AX(1,i+1))
        plot(MT18.tg,MT18.D1525(p2(i),:)-1000);
        hold on
        plot(MT18.tg,MT18.D4939(p2(i),:)-1000);
        plot(MT18.tg,MT18.D19(p2(i),:)-1000);
        ylim(fig.ylim);
        % ylabel('kg/MT12^3');
        
        axes(AX(2,i+1))
        plot(MT18.tg,MT18.vc1525(p2(i),:));
        hold on
        plot(MT18.tg,MT18.vc4939(p2(i),:));
        plot(MT18.tg,MT18.vc19(p2(i),:));
%         plot(MT18.tg,dx18(p2(i),:),'--k');
        hline(0,'k');
        
    end
    
    set(AX(2,:),'YAxisLocation','right');
    set(AX(:,1:14),'xticklabel',[])
    % set(AX(2,:),'yticklabel',[])
    print2a4('D:\sabinerijnsbur\Matlab\Figures\Moorings\Period2_tc_dens_vc18m.png','v','w');
    
    % period 3
    figure;
    AX = subplot_meshgrid(2,13,[.06 0.01 0.06],[.06 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .03],[nan nan],[nan nan nan nan nan nan nan nan nan nan nan nan nan]);
    axes(AX(1,1))
    plot(MT12.tg,MT12.ssh(p3(1):p3(end),:));
    title({['Neap tide 2 - 18m'];'rel. density (kg/m^3)'});
    
    axes(AX(2,1))
    plot(MT18.tg,MT18.va1525(p3(1):p3(end),:));
    text(58,0.72,'va at 2.5mbs');
    title(['cross-shore velocity (m/s)']);
    
    for i = 1:length(p3)
        axes(AX(1,i+1))
        plot(MT18.tg,MT18.D1525(p3(i),:)-1000);
        hold on
        plot(MT18.tg,MT18.D4939(p3(i),:)-1000);
        plot(MT18.tg,MT18.D19(p3(i),:)-1000);
        ylim(fig.ylim);
        % ylabel('kg/MT12^3');
        
        axes(AX(2,i+1))
        plot(MT18.tg,MT18.vc1525(p3(i),:));
        hold on
        plot(MT18.tg,MT18.vc4939(p3(i),:));
        plot(MT18.tg,MT18.vc19(p3(i),:));
        hline(0,'k');
        
    end
    
    set(AX(2,:),'YAxisLocation','right');
    set(AX(:,1:12),'xticklabel',[])
    % set(AX(2,:),'yticklabel',[])
    print2a4('D:\sabinerijnsbur\Matlab\Figures\Moorings\Period3_tc_dens_vc18m.png','v','w');
    
end
%% Plot of density only 18m

% Period 1
figure; 
AX = subplot_meshgrid(1,13,[.06 0.06],[.06 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .03],[nan],[nan nan nan nan nan nan nan nan nan nan nan nan nan]);
axes(AX(1,1))
plot(MT18.tg,MT18.ssh(p1(1):p1(12),:));
title({'Neap tide 1 - 18m';'rel. density (kg/m^3)'});

for i = 1:length(p1)
axes(AX(1,i+1))
plot(MT18.tg,MT18.D1525(p1(i),:)-1000);
hold on
plot(MT18.tg,MT18.D4939(p1(i),:)-1000);
plot(MT18.tg,MT18.D19(p1(i),:)-1000);
ylim(fig.ylim);
% ylabel('kg/MT12^3');
end

set(AX(:,1:12),'xticklabel',[])
% set(AX(2,:),'yticklabel',[])
print2a4('D:\sabinerijnsbur\Matlab\Figures\Moorings\Period1_tc_dens18m.png','v','w');

% period 2
figure; 
AX = subplot_meshgrid(1,15,[.06 0.06],[.06 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .03],[nan],[nan nan nan nan nan nan nan nan nan nan nan nan nan nan nan]);
axes(AX(1,1))
plot(MT18.tg,MT18.ssh(p2(1):p2(end),:));
title({['Spring tide 1 - 18m'];'rel. density (kg/m^3)'});

for i = 1:length(p2)
axes(AX(1,i+1))
plot(MT18.tg,MT18.D1525(p2(i),:)-1000);
hold on
plot(MT18.tg,MT18.D4939(p2(i),:)-1000);
plot(MT18.tg,MT18.D19(p2(i),:)-1000);
ylim(fig.ylim);
% ylabel('kg/MT12^3');
end

set(AX(:,1:14),'xticklabel',[])
% set(AX(2,:),'yticklabel',[])
print2a4('D:\sabinerijnsbur\Matlab\Figures\Moorings\Period2_tc_dens18m.png','v','w');

% Period 3
figure; 
AX = subplot_meshgrid(1,13,[.06 0.06],[.06 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .03],[nan],[nan nan nan nan nan nan nan nan nan nan nan nan nan]);
axes(AX(1,1))
plot(MT18.tg,MT18.ssh(p3(1):p3(end),:));
title({['Neap tide 2 - 18m'];'rel. density (kg/m^3)'});

for i = 1:length(p3)
axes(AX(1,i+1))
plot(MT18.tg,MT18.D1525(p3(i),:)-1000);
hold on
plot(MT18.tg,MT18.D4939(p3(i),:)-1000);
plot(MT18.tg,MT18.D19(p3(i),:)-1000);
ylim(fig.ylim);
% ylabel('kg/MT12^3');
end

set(AX(:,1:12),'xticklabel',[])
% set(AX(2,:),'yticklabel',[])
print2a4('D:\sabinerijnsbur\Matlab\Figures\Moorings\Period3_tc_dens18m.png','v','w');

if strcmp(dirin,'d:\sabinerijnsbur\Matlab\Moorings\Mfiles\')
    
    % Period 4
    figure;
    AX = subplot_meshgrid(1,15,[.06 0.06],[.06 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .03],[nan],[nan nan nan nan nan nan nan nan nan nan nan nan nan nan nan]);
    axes(AX(1,1))
    plot(MT18.tg,MT18.ssh(p4(1):p4(end),:));
    title({['Spring tide 2 - 18m'];'rel. density (kg/m^3)'});
    
    for i = 1:length(p4)
        axes(AX(1,i+1))
        plot(MT18.tg,MT18.D1525(p4(i),:)-1000);
        hold on
        plot(MT18.tg,MT18.D4939(p4(i),:)-1000);
        plot(MT18.tg,MT18.D19(p4(i),:)-1000);
        ylim(fig.ylim);
        % ylabel('kg/MT12^3');
    end
    
    set(AX(:,1:14),'xticklabel',[])
    % set(AX(2,:),'yticklabel',[])
    print2a4('D:\sabinerijnsbur\Matlab\Figures\Moorings\Period4_tc_dens18m.png','v','w');
    
    
    % Period 5
    figure;
    AX = subplot_meshgrid(1,15,[.06 0.06],[.06 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .03],[nan],[nan nan nan nan nan nan nan nan nan nan nan nan nan nan nan]);
    axes(AX(1,1))
    plot(MT18.tg,MT18.ssh(p5(1):p5(end),:));
    title({['Neap tide 3 - 18m'];'rel. density (kg/m^3)'});
    
    for i = 1:length(p5)
        axes(AX(1,i+1))
        plot(MT18.tg,MT18.D1525(p5(i),:)-1000);
        hold on
        plot(MT18.tg,MT18.D4939(p5(i),:)-1000);
        plot(MT18.tg,MT18.D19(p5(i),:)-1000);
        ylim(fig.ylim);
        % ylabel('kg/MT12^3');
    end
    set(AX(:,1:14),'xticklabel',[])
    print2a4('D:\sabinerijnsbur\Matlab\Figures\Moorings\Period5_tc_dens18m.png','v','w');
    
    % Period 6
    figure;
    AX = subplot_meshgrid(1,12,[.06 0.06],[.06 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .01 .03],[nan],[nan nan nan nan nan nan nan nan nan nan nan nan]);
    axes(AX(1,1))
    plot(MT18.tg,MT18.ssh(p6(1):p6(end),:));
    title({['Spring tide 3 - 18m'];'rel. density (kg/m^3)'});
    
    for i = 1:length(p6)
        axes(AX(1,i+1))
        plot(MT18.tg,MT18.D1525(p6(i),:)-1000);
        hold on
        plot(MT18.tg,MT18.D4939(p6(i),:)-1000);
        plot(MT18.tg,MT18.D19(p6(i),:)-1000);
        ylim(fig.ylim);
        % ylabel('kg/MT12^3');
    end
    set(AX(:,1:11),'xticklabel',[])
    print2a4('D:\sabinerijnsbur\Matlab\Figures\Moorings\Period6_tc_dens18m.png','v','w');
    
end

%% 

% figure; 
% AX = subplot_meshgrid(2,4,[.06 0.01 0.06],[.06 .01 .01 .01 .03],[nan nan],[nan nan nan nan]);
% axes(AX(1,1))
% plot(MT18.tg,MT18.ssh(p2(1),:));
% title({['Spring tide 1 - 18m'];'rel. density (kg/m^3)'});
% 
% axes(AX(1,2))
% plot(MT18.tg,MT18.D1525(p2(1),:)-1000);
% hold on
% plot(MT18.tg,MT18.D4939(p2(1),:)-1000);
% plot(MT18.tg,MT18.D19(p2(1),:)-1000);
% ylim(fig.ylim);
% 
% axes(AX(1,3))
% plot(MT18.tg,MT18.vc1525(p2(1),:));
% hold on
% plot(MT18.tg,MT18.vc4939(p2(1),:));
% plot(MT18.tg,MT18.vc19(p2(1),:));
% 
% axes(AX(1,4))
% plot(tgdx18,dx18(p2(1),:));
% hold on
% hline(0,'k');
% 
% axes(AX(2,1))
% plot(MT18.tg,MT18.ssh(p2(2),:));
% 
% axes(AX(2,2))
% plot(MT18.tg,MT18.D1525(p2(2),:)-1000);
% hold on
% plot(MT18.tg,MT18.D4939(p2(2),:)-1000);
% plot(MT18.tg,MT18.D19(p2(2),:)-1000);
% ylim(fig.ylim);
% 
% axes(AX(2,3))
% plot(MT18.tg,MT18.vc1525(p2(2),:));
% hold on
% plot(MT18.tg,MT18.vc4939(p2(2),:));
% plot(MT18.tg,MT18.vc19(p2(2),:));
% 
% axes(AX(2,4))
% plot(tgdx18,dx18(p2(2),:));
% hold on
% hline(0,'k');
% 
% set(AX(2,:),'YAxisLocation','right');
% set(AX(:,1:3),'xticklabel',[])



%% Density in one plot

% figure;
% AX = subplot_meshgrid(1,2,[.06 0.05],[.03 .01 .03],[nan],[nan nan]);
% axes(AX(1,1))
% plot(MT12.tg,MT12.ssh(1,:));
% hold on
% plot(MT12.tg,MT12.ssh(2,:));
% plot(MT12.tg,MT12.ssh(3,:));
% plot(MT12.tg,MT12.ssh(4,:));
% plot(MT12.tg,MT12.ssh(5,:));
% plot(MT12.tg,MT12.ssh(6,:));
% plot(MT12.tg,MT12.ssh(7,:));
% plot(MT12.tg,MT12.ssh(8,:));
% plot(MT12.tg,MT12.ssh(9,:));
% plot(MT12.tg,MT12.ssh(10,:));
% 
% axes(AX(1,2))
% plot(MT12.tg,MT12.D1527(1,:));
% hold on
% plot(MT12.tg,MT12.D1527(2,:));
% plot(MT12.tg,MT12.D1527(3,:));
% plot(MT12.tg,MT12.D1527(4,:));
% plot(MT12.tg,MT12.D1527(5,:));
% plot(MT12.tg,MT12.D1527(6,:));
% plot(MT12.tg,MT12.D1527(7,:));
% plot(MT12.tg,MT12.D1527(8,:));
% plot(MT12.tg,MT12.D1527(9,:));
% plot(MT12.tg,MT12.D1527(10,:));
