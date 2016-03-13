function [adcp] = convert_vel(adcp,alpha)
% Convert velocities to along- and cross-shore

beta = alpha*pi/180;
adcp.va = adcp.north_vel.*cos(beta)+adcp.east_vel.*sin(beta);
adcp.vc = -adcp.north_vel.*sin(beta)+adcp.east_vel.*cos(beta);

end