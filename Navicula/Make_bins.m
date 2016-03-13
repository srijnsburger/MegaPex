function [DD] = Make_bins(C3)
% Function to bin the data of Seabird in vertical bins
% The CTD data will be binned and therefore smoothed

%% Sortrows on descending order

nfiles = length(C3);
[tmp,Ix] = arrayfun(@(x) sortrows(x.data(:,2)), C3,'UniformOutput',false);

for i = 1:nfiles
D3(i).data = C3(i).data(Ix{1,i},:);
end


%% Make bins

binsize = 0.1;
dmax    = arrayfun(@(x) max(x.data(:,9)), D3);% max depth
nbins   = ceil(max(dmax)/binsize);

for i = 1:length(D3)
%     maxbin = ceil((dmax(i) - dmin(i))/binsize);
% maxbin = ceil((D3(i).data(end,9)-D3(i).data(1,9))/binsize);
    for j = 1:nbins
        minbinsize = (j-1)*binsize;
        maxbinsize = minbinsize+binsize;
        bin(j) = minbinsize+0.5*binsize;
        jj = 0;
        totalbin = [];
        for k = 1:length(D3(i).data(:,9))
            if D3(i).data(k,9) > minbinsize && D3(i).data(k,9) < maxbinsize
%                 totalbin = k;
                totalbin = [totalbin,k];
                jj = jj+1;
            end
        end
%         totalbin = find(D3(i).data(:,9) > minbinsize & D3(i).data(:,9) < maxbinsize);
        if jj == 0;
            salbin(j)  = NaN;
            tempbin(j) = NaN;
            turbbin(j) = NaN;
            voltbin(j) = NaN;
            pressbin(j)= NaN;
            depthbin(j)= NaN;
        else
            salbin(j)  = mean(D3(i).data(totalbin(1):totalbin(end),11));
            tempbin(j) = mean(D3(i).data(totalbin(1):totalbin(end),4));
            turbbin(j) = mean(D3(i).data(totalbin(1):totalbin(end),5));
            voltbin(j) = mean(D3(i).data(totalbin(1):totalbin(end),6));
            pressbin(j)= mean(D3(i).data(totalbin(1):totalbin(end),2));
            depthbin(j)= mean(D3(i).data(totalbin(1):totalbin(end),9));
        end
    end

DD(i).data(:,1) = bin;
DD(i).data(:,2) = pressbin; 
DD(i).data(:,3) = tempbin;
DD(i).data(:,4) = salbin;
DD(i).data(:,5) = turbbin;
DD(i).data(:,6) = voltbin;
DD(i).data(:,7) = depthbin;


end
end
