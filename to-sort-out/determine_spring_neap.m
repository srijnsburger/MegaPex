function [period] = determine_spring_neap(t)

% t is in days
% need to make also part for datenum

% if (t >= 1) && (t <= 400)
    period.p1   = find(t>=t(1) & t<266);
    ind2        = find(t>=266 & t<273)';
    period.p2   = [period.p1(end) ind2];
    ind3        = find(t>=273 & t<280)';
    period.p3   = [period.p2(end) ind3];
    ind4        = find(t>=280 & t<287)';
    period.p4   = [period.p3(end) ind4];
    ind5        = find(t>=287 & t<294)';
    period.p5   = [period.p4(end) ind5];
% end

end