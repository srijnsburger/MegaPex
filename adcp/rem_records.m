function [adcp] = rem_records(adcp)
% Removes empty (NaNs) rows or columns; unrecorded data

id     = find(isnan(adcp.va(1,:))==0,1,'first');
ref    = length(adcp.time);
in.fld = fieldnames(adcp);

for i = 1:length(in.fld)
    field = in.fld{i};
    
    if size(adcp.(field),1) == ref
        adcp.(field)= adcp.(field)(id:end,:);
    elseif size(adcp.(field),2) == ref
        adcp.(field) = adcp.(field)(:,id:end);
    else
    end
    
end 
end 