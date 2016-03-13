function [Sv] = backs(adcp,cfg)
%script to calculate the acoustic backscatter from an
%RDI

R=cfg.ranges/(cos(pi/180*cfg.beam_angle));
taR=2*.48*R;    % for 1200
%taR=2*.153*R;    % for 600
ldbm=10*log10(cfg.xmit_pulse);
kk(:,:)=mean(adcp.intens,2);
bsk=0.458*(kk-40);
for i=1:cfg.n_cells,
    Sv(i,:)=-139.3+10*log10((adcp.temperature+273.16).*R(i).^2)-ldbm-9.0+taR(i)+bsk(i,:);
end

end