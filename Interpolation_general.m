function [mat] = Interpolation_general(mat,nfiles)

%% Interpolate data

% Fill the NaN's 
% nfiles = size(mat,2);

for i = 1:nfiles
idnan = find(isnan(mat(:,i))==1);
idnotnan = find(isnan(mat(:,i))==0);
ID= [];
    for k = 1:length(idnan)
        if idnan(k)<idnotnan(1)||idnan(k)>idnotnan(length(idnotnan))
                ID = cat(1,ID,k);
        end 
    end
idnan(ID)=[];

for j = 1:length(idnan)
    
    if isnan(mat(idnan(j),i))
        index1 = idnan(j)-1;
        r = idnan(j)+1;
        while 1-(isempty(find(idnan==r)));
            r=r+1;
        end
        index2 = r;
%         if R.salinity(index2,i)==R.salinity(index1,i)
%             vector=ones((index2-index1-1),1).*R.salinity(index2,i);
%         else
%             delta = (R.salinity(index2,i)-R.salinity(index1,i))/(index2-index1);
%             vector = [R.salinity(index1,i)+delta:delta:R.salinity(index2,i)-delta]';
%         end
        vector=interp1([index1,index2],[mat(index1,i),mat(index2,i)],[index1+1:1:index2-1]);
        mat(index1+1:index2-1,i)=vector;
    end   
end
end 

 
end 