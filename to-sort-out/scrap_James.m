clear all
close all
clc

%Check arbritary code

%% Generate random time variables
in.dT  = ceil(rand*10)*60;                  %Period to average over; seconds; random
in.dt  = ceil(rand*10);                     %Sampling of raw data; seconds; random
in.t   = [0:in.dt:(in.dT*rand*10)*1.5];     %time of random variables

in.TT = [ceil(rand)*20:in.dT:in.t(end)];    %times to output average value

in.a = 0.5*(in.TT(1:end-1)+in.TT(2:end));   %limits for averaging
if any(in.t >= in.TT(end)+0.5*in.dT)
    in.a = [in.a,in.TT(end)+0.5*in.dT];     %add additional upper limit depending on random dataset
end

%% Generate random properties
in.fld = {'prop1','prop2','prop3'}; 
in.X.(in.fld{1}) = rand(size(in.t)).^2;
in.X.(in.fld{2}) = cos(in.t)+0.5;
in.X.(in.fld{3}) = sin(in.t)+0.1*rand(size(in.t))+0.5;

%% Visualise raw data
figure
for i=1:length(in.fld)
    subplot(3,1,i)
    plot(in.t,in.X.(['prop',num2str(i)]),'-k')
    hold on
    line(repmat(in.TT,[2,1]),...                                                                        %Center of average
         repmat([max(in.X.(['prop',num2str(i)]));min(in.X.(['prop',num2str(i)]))],[1,length(in.TT)]),...
         'LineStyle','-','Color','r','LineWidth',2)
    line(repmat(in.a,[2,1]),...                                                                         %Limits to find
         repmat([max(in.X.(['prop',num2str(i)]));min(in.X.(['prop',num2str(i)]))],[1,length(in.a)]),...
         'LineStyle','-.','Color','b','LineWidth',2)
end
legend('Raw Data','Time to center average',1)
%% Perform averaging

%#Crude average: assumes that limits lie exactly on points defined by in.t use simple nanmean
%Determine indices
pr.id = arrayfun(@(x1,x2) find(in.t >= x1 & in.t <= x2),in.a(1:end-1),in.a(2:end),'UniformOutput',false);

%Do average
pr.av = cellfun(@(x) cellfun(@(I) nanmean(in.X.(x)(I)),pr.id,'UniformOutput',false),in.fld,'UniformOutput',false);

%Flatten from nested cell array to matrix
pr.av = reshape(cell2mat([pr.av{:}]),[length(in.fld),length(pr.id)]);

%Visualise
for i=1:length(in.fld)
    subplot(3,1,i)
    line([in.a(1:end-1);in.a(2:end)],...
         repmat(pr.av(i,:),[2,1]),...
         'LineStyle','--','Color','m','LineWidth',2)                                                    %Crude average
    cellfun(@(x) line(repmat([in.t(x(1)),in.t(x(end))],[2,1]),...
                      repmat([max(in.X.(['prop',num2str(i)]));min(in.X.(['prop',num2str(i)]))],[1,2]),...
                      'LineStyle','-','Color','m'),pr.id)                                               %Limits used for crude av.    
end

%#Improved average: also makes assumptions on limit but computes average using an integral
pr.av2 = cellfun(@(x) cellfun(@(I) trapz(in.t(I),in.X.(x)(I))/(in.t(I(end))-in.t(I(1))),pr.id,...
                                     'UniformOutput',false),in.fld,'UniformOutput',false);
                                 
%Flatten from nested cell array to matrix
pr.av2 = reshape(cell2mat([pr.av2{:}]),[length(in.fld),length(pr.id)]);

%Visualise
for i=1:length(in.fld)
    subplot(3,1,i)
    line([in.a(1:end-1);in.a(2:end)],...
         repmat(pr.av2(i,:),[2,1]),...
         'LineStyle','--','Color','b','LineWidth',2)                                                    %Improved average  
end

%#Corrected average: include an fractions between points defined by in.t and limits defined by in.a
if any(ismember(in.a,in.t)==0) %Check if any values of in.a do not match any value of in.t
    fprintf('#Limits of averaging used do not match raw data time step! Recalculating ...\n')
    
    %Crude average uses a reduced averaging range due to <= and >=
    %These contributions must be < in.dt
    
    %Lower contribution = (crude - (grad*time_mismatch))
    pr.lc = cellfun(@(x) cellfun(@(I,a) (in.X.(x)(I(1)) - ((in.X.(x)(I(1))-in.X.(x)(I(1)-1))/in.dt)), ...
                                                               pr.id,num2cell(in.a(1:end-1)),'UniformOutput',false),...                
                                                               in.fld,'UniformOutput',false);
    
    %Upper contribution = (crude + (grad*time_mismatch)) 
    pr.uc = cellfun(@(x) cellfun(@(I,a) (in.X.(x)(I(end)) + ((in.X.(x)(I(end)+1)-in.X.(x)(I(end)))/in.dt)), ...
                                                               pr.id,num2cell(in.a(2:end)),'UniformOutput',false),...                
                                                               in.fld,'UniformOutput',false);
  
    %Corrected average
    pr.av3 = cellfun(@(x,c1,c2) cellfun(@(I,a1,a2,cc1,cc2) trapz([a1,in.t(I),a2],[cc1,in.X.(x)(I),cc2])/(a2-a1),...
                                        pr.id,num2cell(in.a(1:end-1)),num2cell(in.a(2:end)),c1,c2,'UniformOutput',false),...
                                        in.fld,pr.lc,pr.uc,'UniformOutput',false);
    
    %Flatten from nested cell array to matrix
    pr.av3 = reshape(cell2mat([pr.av3{:}]),[length(in.fld),length(pr.id)]);
else
    pr.av3 = pr.av2;
end

%Visualise
for i=1:length(in.fld)
    subplot(3,1,i)
    line([in.a(1:end-1);in.a(2:end)],...
         repmat(pr.av3(i,:),[2,1]),...
         'LineStyle','-','Color','g','LineWidth',2)                                                    %Corrected improved average  
end

%% Output example ...
out = cell2struct(cellfun(@(x) in.X.(x),in.fld,'UniformOutput',false),in.fld,2);





