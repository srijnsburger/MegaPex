function [va,vc] = convert_vel_raul(ve,vn,alpha)
% Convert North and East velocities in along- and cross-shore
% North is +ve ; offshore is +ve
% Theta is defined from horizontal x-axis and rotates anti-clockwise

theta = alpha*pi/180; % convert to radians
va = ve.*cos(theta)+vn.*sin(theta);
vc = vn.*cos(theta)-ve.*sin(theta);

end

