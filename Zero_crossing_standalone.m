%Zero-crossing code

load('d:\sabinerijnsbur\Matlab\Measurements\Conditions\tide.mat');

tide=T1.ssh;
time=T1.time;

aux=find(tide(1:end-1)<0 & tide(2:end)>0);
aux2=zeros(size(aux));

for i=1:numel(aux)
    if abs(tide(aux(i)))<abs(tide(aux(i)+1))
        aux2(i)=aux(i);
    else
        aux2(i)=aux(i)+1;
    end
end
    

figure
set(gcf,'Color','w')
plot(time,tide,'.-')
hold on
plot(time(aux2),tide(aux2),'ro','MarkerSize',8)
plot([time(1) time(end)],[0 0],'k--')
