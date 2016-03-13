clc;clear all;close all;

load('d:\sabinerijnsbur\Measurements\Measurements2014\Matlab\Navicula_170914\SBENav.mat');
load('CastAway170914.mat');

% make bins
n = [2:8,10:41,43:60];
binsize = 0.1;
dmax    = max(max(CW17.press));
nbins   = ceil(max(dmax)/binsize);

% sort rows in descending order
for i = n
[tmp,I] = sortrows(CW17.press(:,i));
sal(1:348,i)  = CW17.sal(I,i);
temp(1:348,i) = CW17.temp(I,i);
cond(1:348,i) = CW17.cond(I,i);
dens(1:348,i) = CW17.dens(I,i);
press(1:348,i)= CW17.press(I,i);
end

% delete empty columns
sal = sal(:,n);
temp= temp(:,n);
cond= cond(:,n);
dens= dens(:,n);
press= press(:,n);
CW17.bin.time = CW17.time(:,n);

for i = 1:size(sal,2)
    for j = 1:nbins
        minbinsize = (j-1)*binsize;
        maxbinsize = minbinsize+binsize;
        bin(j) = minbinsize+0.5*binsize;
        jj = 0;
        totalbin = [];
        for k = 1:length(press)
            if press(k,i) > minbinsize && press(k,i) < maxbinsize
                totalbin = [totalbin,k];
                jj = jj+1;
            end
        end
        if jj == 0;
            salbin(j)  = NaN;
            tempbin(j) = NaN;
            condbin(j) = NaN;
            densbin(j) = NaN;
            pressbin(j)= NaN;
        else
            salbin(j)  = mean(sal(totalbin(1):totalbin(end),i));
            tempbin(j) = mean(temp(totalbin(1):totalbin(end),i));
            condbin(j) = mean(cond(totalbin(1):totalbin(end),i));
            densbin(j) = mean(dens(totalbin(1):totalbin(end),i));
            pressbin(j)= mean(press(totalbin(1):totalbin(end),i));
        end
    end

    CW17.bin.sal(:,i) = salbin';
    CW17.bin.temp(:,i)= tempbin';
    CW17.bin.press(:,i)= pressbin';
    CW17.bin.cond(:,i) = condbin';
    CW17.bin.dens(:,i) = densbin';
    CW17.bin.bin(:,i)  = bin';
end


tmp = nan(122,30);
tmp(1:120,:) = SBENav.sal;

for ii = 1:length(SBENav.time)
id = find(and(SBENav.time(ii)-(1/(24*60)*2) <= CW17.bin.time,SBENav.time(ii)+(1/(24*60)*2) >= CW17.bin.time),1);
if isempty(id) == 1
    id = nan;
end
    x(ii) = id;
end

temp = find(~isnan(x)==1);
dd = x(temp);


%% 


figure;
plot(tmp(:,temp(1)),CW17.bin.sal(:,dd(1)),'.');
