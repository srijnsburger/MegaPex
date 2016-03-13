function [ctd] = despike_fsi_ctd(ctd)

% Remove artificial spikes

nlines = length(ctd.sal);

for i = 1:nlines
    if ctd.sal(i)<20
        ctd.sal(i) = nan;
        ctd.temp(i) = nan;
        ctd.cond(i) = nan;
        ctd.press(i) = nan;
        ctd.sv(i) = nan;
        ctd.turb(i) = nan;
        ctd.time(i) = nan;
    elseif ctd.sal(i)>35
        ctd.sal(i) = nan;
        ctd.temp(i) = nan;
        ctd.cond(i) = nan;
        ctd.press(i) = nan;
        ctd.sv(i) = nan;
        ctd.turb(i) = nan;
        ctd.time(i) = nan;
    elseif ctd.press(i) > 20;
        ctd.sal(i) = nan;
        ctd.temp(i) = nan;
        ctd.cond(i) = nan;
        ctd.press(i) = nan;
        ctd.sv(i) = nan;
        ctd.turb(i) = nan;
        ctd.time(i) = nan;
    end
end
    
end

