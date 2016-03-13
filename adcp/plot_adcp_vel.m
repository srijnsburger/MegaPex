function plot_adcp_vel(adcp,fig)
% Plot along- and cross-shore velocities
%
% Input:    adcp (with t, z, va, vc and depth)
%                         z -> distance above bottom
%           fig  (information needed for figure)
%         
% Output: plot with along and cross-shore velocities

%% Insert colormap

% cbwr = colormapbluewhitered;

%%
figure;
AX = subplot_meshgrid(1,2,[.07 .05],[.09 .07 .09],[nan],[nan nan]);
axes(AX(1,1))
pcolorcorcen(adcp.t,adcp.z,adcp.va)
hold on
plot(adcp.t,adcp.h,'k')
set(gca,'fontsize',fig.fonts);
set(gca,'XTick',fig.xtick);
ylim(fig.ylim);
caxis([fig.clim_va]);
colorbar('fontsize',fig.fonts,'YTick',fig.ytick_va);
ylabel('z (m)');
title({['Alongshore velocities',' ',fig.position,' ','(in m/s)']; '(+ is northwards)'});

axes(AX(1,2))
pcolorcorcen(adcp.t,adcp.z,adcp.vc)
hold on
plot(adcp.t,adcp.h,'k')
set(gca,'fontsize',fig.fonts);
set(gca,'XTick',fig.xtick);
ylim(fig.ylim);
caxis([fig.clim_vc]); 
colorbar('fontsize',fig.fonts,'YTick',fig.ytick_vc);
ylabel('z (m)');
xlabel(fig.xlabel);
title({['Cross-shore velocities',' ',fig.position,' ','(in m/s)'];'(+ is offshore)'});

set(AX(:,1),'xticklabel',[])

set(findall(gcf,'type','text'),'FontSize',fig.txtfonts)
end



