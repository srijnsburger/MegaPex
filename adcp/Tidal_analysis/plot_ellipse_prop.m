function plot_ellipse_prop(adcp,T,fig,comp,save_plot)

if ~fig.fonts
    fig.fonts = 8;
end


eval(['T.major = T.' comp 'major']);
eval(['T.minor = T.' comp 'minor']);
eval(['T.incl  = T.' comp 'incl']);
eval(['T.phase = T.' comp 'phase']);

%% Ellipse properties

AX = subplot_meshgrid(3,1,[.04 .02 .02 .04],[0.04 0.04],[nan nan nan],[nan]);
axes(AX(1,1))
pcolorcorcen(adcp.t(T.times),adcp.z,T.major)
hold on
plot(adcp.t,adcp.h)
set(gca,'fontsize',fig.fonts);
ylim(fig.ylim)
xlim(fig.xlim);
% datetick('x');
clim([0 1.4]);
colorbarwithhtext('maj','horiz','fontsize',fig.fonts)
title({[comp 'position ', fig.position]})

axes(AX(2,1))
pcolorcorcen(adcp.t(T.times),adcp.z,T.minor)
hold on
plot(adcp.t,adcp.h)
set(gca,'fontsize',fig.fonts);
ylim(fig.ylim);
xlim(fig.xlim);
% datetick('x');
clim([-0.3 0.3]);
colorbarwithhtext('min','horiz','fontsize',fig.fonts)

axes(AX(3,1))
pcolorcorcen(adcp.t(T.times),adcp.z,T.minor./T.major)
hold on
plot(adcp.t,adcp.h)
set(gca,'fontsize',fig.fonts);
ylim(fig.ylim)
xlim(fig.xlim);
% datetick('x');
clim([-0.4 0.6]);
colorbarwithhtext('ecc','horiz','fontsize',fig.fonts)

set(AX(2:3,:),'yticklabel',[])
% Save
if strcmp(save_plot,'yes')
    fname1 = ['Ellipseprop1' fig.position 'comp' comp '.png'];
print2a4(fname1,'h','t');
end

%% Inclination & phase

figure;
AX = subplot_meshgrid(4,1,[.04 .02 .02 .02 .04],[0.04 0.04],[nan nan nan nan],[nan]);
axes(AX(1,1))
pcolorcorcen(adcp.t(T.times),adcp.z,T.major)
hold on
plot(adcp.t,adcp.h)
set(gca,'fontsize',fig.fonts);
ylim(fig.ylim)
xlim(fig.xlim);
% datetick('x');
clim([0 1.4]);
colorbarwithhtext('maj','horiz','fontsize',fig.fonts)
title({[comp,', position ', fig.position]})

axes(AX(2,1))
pcolorcorcen(adcp.t(T.times),adcp.z,T.minor)
hold on
plot(adcp.t,adcp.h)
set(gca,'fontsize',fig.fonts);
ylim(fig.ylim);
xlim(fig.xlim);
% datetick('x');
clim([-0.3 0.3]);
colorbarwithhtext('min','horiz','fontsize',fig.fonts)

axes(AX(3,1))
pcolorcorcen(adcp.t(T.times),adcp.z,T.incl)
hold on
plot(adcp.t,adcp.h)
set(gca,'fontsize',fig.fonts);
ylim(fig.ylim)
xlim(fig.xlim);
% datetick('x');
% clim([-0.4 0.6]);
colorbarwithhtext('incl','horiz','fontsize',fig.fonts)

axes(AX(4,1))
pcolorcorcen(adcp.t(T.times),adcp.z,T.phase)
hold on
plot(adcp.t,adcp.h)
set(gca,'fontsize',fig.fonts);
ylim(fig.ylim)
xlim(fig.xlim);
% datetick('x');
% clim([-0.4 0.6]);
colorbarwithhtext('phase','horiz','fontsize',fig.fonts)

set(AX(2:4,:),'yticklabel',[])
% Save
if strcmp(save_plot,'yes')
fname2 = ['Ellipseproperties' fig.position  '_comp_',comp,'.png'];
print2a4(fname2,'h','t');
end

%% Ellipticity

figure;
pcolorcorcen(adcp.t(T.times),adcp.z,T.minor./T.major)
hold on
plot(adcp.t,adcp.h)
set(gca,'fontsize',fig.fonts);
ylim(fig.ylim)
xlim(fig.xlim);
% datetick('x');
clim([-0.4 0.6]);
colorbarwithhtext('ecc','horiz')
title({[T.comp,', position ', fig.position, ' tstep =', num2str(T.tstep)]})

% Save
if strcmp(save_plot,'yes')
    fname3 = ['Ellipticity' fig.position  '_comp_',comp,'.png'];
    print2a4(fname3,'h','t');
end
end