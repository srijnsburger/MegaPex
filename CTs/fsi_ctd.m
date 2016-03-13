function [ctd] = fsi_ctd(file,SN,Location)

D = importdata(file,',');
ctd.time = datenum(D.textdata(3:end));
ctd.cond = D.data(:,1);
ctd.temp = D.data(:,2);
ctd.press= D.data(:,3);
ctd.sal  = D.data(:,4);
ctd.sv   = D.data(:,5);
ctd.turb = D.data(:,7);
ctd.units = D.textdata(1:2,1);
ctd.description = {[SN,Location]};

end
