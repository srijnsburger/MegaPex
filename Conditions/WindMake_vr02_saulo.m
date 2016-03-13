ccc
findpathmycomputer
%%
if strcmp(mydir,GDdir1)==1 || strcmp(mydir,GDdir2)==1
    cd([mydir,'\00_PhD\Dataset\STRAINS\04_Metocean\']);    
elseif strcmp(mydir,GDdir3)==1
    cd([mydir,'/00_PhD/Dataset/STRAINS/04_Metocean/']);   
else
    load([mydir,'\']);
end
%%
W =  knmi_uurgeg('windHoekVanHolRaw.txt');
%
wdate        = num2str(W.data.YYYYMMDD);
wyear        = str2num(wdate(:,1:4));
wmon         = str2num(wdate(:,5:6));
wday         = str2num(wdate(:,7:8));
whour        = W.data.HH;
%
II           = find(wyear==2013 & wmon>=2 & wmon<=3);
%
wind.timenum = datenum(wyear(II),wmon(II),wday(II),whour(II),0,0);
%
wind.vhour    = W.data.FH(II);%/10;
wind.v10avg   = W.data.FF(II);%/10;
wind.dir10avg = W.data.DD(II);
wind.vgust    = W.data.FX(II);%/10;
%
save('WindPar.mat','wind')

