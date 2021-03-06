function [adcp] = adcpdepthclean_test(adcp,cfg)
for i=1:length(adcp.mtime),
adcp.north_vel(find(cfg.ranges>=0.99*adcp.depth(i)),i)=NaN;
adcp.east_vel(find(cfg.ranges>=0.99*adcp.depth(i)),i)=NaN;
adcp.vert_vel(find(cfg.ranges>=0.99*adcp.depth(i)),i)=NaN;
adcp.error_vel(find(cfg.ranges>=0.99*adcp.depth(i)),i)=NaN;
adcp.uw_str(find(cfg.ranges>=0.99*adcp.depth(i)),i)=NaN;
adcp.vw_str(find(cfg.ranges>=0.99*adcp.depth(i)),i)=NaN;
Sv(find(cfg.ranges>=0.99*adcp.depth(i)),i)=NaN;
end
end