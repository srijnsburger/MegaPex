%Plot discharge
dis = MSM.dis+HVS.dis; %total Maasmond and haringvlietsluis

figure;
% plot(MSS.t,MSS.dis)
plot(MSM.t,MSM.dis,'b')
hold on
grid on
plot(HVS.t,HVS.dis,'.-r')
% plot(MSS.t,dis,'k');
