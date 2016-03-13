function [Split11,Split19] = split_data(C2)
%% Splits the "yoyo"-casts
% When a cast contains more than 1 down and upcast, the data will be
% splitted.
% The data will be splitted in different " individual casts" (= with one down and upcast)
%
% Input:  - C2 (struct with all the data of the casts)
% Output: - Split11 (data of a splitted cast, here cast 11)
%         - Split19 (data of splitted cast, here cast 19)

%% Split the data into different casts

ki=[11,19]; %the casts

for i = 1:2
    k = ki(i);
    %    if k == or(11,19) % yoyo-ing files
    v1{i} = find(C2(k).data(:,2)<= 2.0);% find indices with treshold of 2m (the minimum values)
    v2{i} = v1{i}(2:end)-v1{i}(1:end-1);
    w1{i} = find(C2(k).data(:,2)>= 10.5);% find indices with threshold larger than 10.5m (maximum values)
    w2{i} = w1{i}(2:end)-w1{i}(1:end-1);
    th = max(v2{:,i})./2; % threshold for minimum values
    th2= max(w2{:,i})./2; % threshold for maximum values
    id{i} = find(v2{i}>th); % find indices 
    id2{i}= find(w2{i}>th2);
    d{1,i} = 1:v1{i}(id{i}(1)); 
    ds{1,i} = 1:w1{i}(id2{i}(1));
    for n = 2:length(id{i})
        d{n,i} = v1{i}(id{i}(n-1)+1):(v1{i}(id{i}(n)));
    end
    
    for j = 2:length(id2{i})
        ds{j,i} = w1{i}(id2{i}(j-1)+1):(w1{i}(id2{i}(j)));
    end
    
    d{length(id{i})+1,i} = v1{i}(id{i}(end)+1):v1{i}(end);
    ds{length(id2{i})+1,i} = w1{i}(id2{i}(end)+1):w1{i}(end);

    for m = 1:(length(id{i})+1)
        [dm{m,i},Im{m,i}] = min(C2(k).data(d{m,i},2));% minimum values, with indices corresponding to d
        imin{m,i} = d{m,i}(Im{m,i}); % "real" indices corresponding to C2
    end
    
    for l = 1:(length(id2{i})+1)
        [da{l,i},Ia{l,i}] = min(C2(k).data(ds{l,i},2));
        imax{l,i} = ds{l,i}(Ia{l,i}); % "real" indices corresponding to C2
    end
    
end

%% Insert in data structure



%% Make a struct for the splitted date 

 field1  = 'data';
 value1  = {C2(11).data(imin{1,1}:imin{2,1},:),C2(11).data(imin{2,1}:imin{3,1},:),C2(11).data(imin{3,1}:imin{4,1},:),C2(11).data(imin{4,1}:imin{5,1},:)};
 value2  = {C2(19).data(imin{1,2}:imin{2,2},:),C2(19).data(imin{2,2}:imin{3,2},:),C2(19).data(imin{3,2}:imin{4,2},:),C2(19).data(imin{4,2}:imin{5,2},:),C2(19).data(imin{5,2}:imin{6,2},:),C2(19).data(imin{6,2}:imin{7,2},:),C2(19).data(imin{7,2}:imin{8,2},:),C2(19).data(imin{8,2}:imin{9,2},:),C2(19).data(imin{9,2}:imin{10,2},:),C2(19).data(imin{10,2}:imin{11,2},:),C2(19).data(imin{11,2}:imin{12,2},:),C2(19).data(imin{12,2}:imin{13,2},:)};
 Split11 = struct(field1,value1);
 Split19 = struct(field1,value2);
 

 
 
end