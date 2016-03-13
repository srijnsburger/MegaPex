function [out] = surface_bottom_velocity(va,vc)

out.bva = nanmean(va(2:11,:));
out.bvc = nanmean(vc(2:11,:));

out.bva2 = va(3,:);
out.bvc2 = vc(3,:);

for i = 1:length(va)
    id(i)  = find(~isnan(va(:,i)),1,'last');
    out.sva(i)  = nanmean(va((id(i)-7:id(i)-1),i));
    out.sva2(i) = va((id(i)-2),i);
    %     id2(i)  = find(~isnan(adcp.vc(:,i)),1,'last');
    out.svc(i)  = nanmean(vc((id(i)-7:id(i)-1),i));
    out.svc2(i) = vc((id(i)-2),i);
end


end