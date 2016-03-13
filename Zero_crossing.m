function [zc] = Zero_crossing(time,signal)

debug = 0;

aux  = find(signal(1:end-1)<=0 & signal(2:end)>=0);
zc   = zeros(size(aux));

for i=1:numel(aux)
    if abs(signal(aux(i)))<abs(signal(aux(i)+1))
        zc(i)=aux(i);
    else
        zc(i)=aux(i)+1;
    end
end
    
if debug
figure
set(gcf,'Color','w')
plot(time,signal,'.-')
hold on
plot(time(zc),signal(zc),'ro','MarkerSize',8)
plot([time(1) time(end)],[0 0],'k--')
end

end