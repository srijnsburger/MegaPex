function [adcp] = adcpsoundlevelclean(adcp,cfg,Sv)
info=('this only goes from bin 5 to the end you might need to change it');
%int(:,:)=adcp.intens(:,1,:);[x,ind]=nanmax(int(30:length(cfg.ranges),:));
%int(:,:)=mean(adcp.intens,2);
int=Sv;[x,ind]=nanmax(int(20:length(cfg.ranges),:));
for i=1:length(adcp.mtime),
ddep(i)=cfg.ranges(19+ind(i));
adcp.uw_str(find(cfg.ranges>0.9*ddep(i)),i)=NaN;
adcp.vw_str(find(cfg.ranges>0.9*ddep(i)),i)=NaN;
adcp.north_vel(find(cfg.ranges>0.9*ddep(i)),i)=NaN;
adcp.east_vel(find(cfg.ranges>0.9*ddep(i)),i)=NaN;
adcp.vert_vel(find(cfg.ranges>0.9*ddep(i)),i)=NaN;
adcp.error_vel(find(cfg.ranges>0.9*ddep(i)),i)=NaN;
Sv(find(cfg.ranges>0.9*ddep(i)),i)=NaN;
adcp.sv = Sv;
end
end
