function [mat] = time_averaging_reft2(mat,reft,avp)
% Function for doing a time average based on a reference time
% 
% Input     - matfile (with fields to average time, sal, temp, cond and possible obs and/or press)
%           - reft    (reference time -> an array with times which are
%                      already averaged over the avp period)
%           - avp     (averaging period)
%
%% Time averaging

debug = 0; % Plot averaging debug=1 ; No plot debug = 0;
% n          = length(reft);
if ~mod(avp,mat.time(2)-mat.time(1))
    disp('Warning: check time difference');
end

if isfield(mat,'obs')  == 1;    O.obs   = mat.obs;      end;
if isfield(mat,'press')== 1;    O.press = mat.press;    end;
if isfield(mat,'sal')  == 1;    O.sal   = mat.sal;      end;          
if isfield(mat,'cond') == 1;    O.cond  = mat.cond;     end;
if isfield(mat,'temp') == 1;    O.temp  = mat.temp;     end;
% if isfield(mat,'time') == 1;    O.time  = mat.time;     end;
in.fld  = fieldnames(O);
in.a    = (reft(1:end-1) + reft(2:end)).*0.5; %limits for averaging
in.dt   = diff(mat.time); in.dt = in.dt(1)*24*3600; %sampling frequency/difference between two points in time; in seconds
in.time = mat.time;

%% Visualise

if debug
    figure
    n = length(in.fld);
    for i=1:length(in.fld)
        field = in.fld{i};
        subplot(n,1,i)
        plot(in.time,O.(field),'-k')
        hold on
        line(repmat(reft,[2,1]),...                                                                        %Center of average
            repmat([max(O.(field));min(O.(field))],[1,length(reft)]),...
            'LineStyle','-','Color','r','LineWidth',2)
        line(repmat(in.a,[2,1]),...                                                                         %Limits to find
            repmat([max(O.(field));min(O.(field))],[1,length(in.a)]),...
            'LineStyle','-.','Color','b','LineWidth',2)
    end
    legend('Raw Data','Time to center average','Limits',1)
end

%% Averaging

%Determine indices
pr.id = arrayfun(@(x1,x2) find(in.time >= x1 & in.time <= x2),in.a(1:end-1),in.a(2:end),'UniformOutput',false);
%Do average
pr.av = cellfun(@(x) cellfun(@(I) nanmean(O.(x)(I)),pr.id,'UniformOutput',false),in.fld,'UniformOutput',false);

%Flatten from nested cell array to matrix
% pr.av = reshape(cell2mat([pr.av{:}]),[length(in.fld),length(pr.id)]);
pr.av = reshape(cell2mat([pr.av{:}]),[length(pr.id),length(in.fld)]);
pr.av = pr.av';

%% Visualise

if debug
    for i = 1:length(in.fld)
        field = in.fld{i};
        subplot(3,1,i)
        line([in.a(1:end-1);in.a(2:end)],...
            repmat(pr.av(i,:),[2,1]),...
            'LineStyle','--','Color','m','LineWidth',2)                                                    %Crude average
        cellfun(@(x) line(repmat([in.time(x(1)),in.time(x(end))],[2,1]),...
            repmat([max(O.(field));min(O.(field))],[1,2]),...
            'LineStyle','-','Color','m'),pr.id)                                               %Limits used for crude av.
    end
end

%% Improved average
%#Improved average: also makes assumptions on limit but computes average using an integral
pr.av2 = cellfun(@(x) cellfun(@(I) trapz(in.time(I),O.(x)(I))/(in.time(I(end))-in.time(I(1))),pr.id,...
                                     'UniformOutput',false),in.fld,'UniformOutput',false);                                 
%Flatten from nested cell array to matrix
pr.av2 = reshape(cell2mat([pr.av2{:}]),[length(pr.id),length(in.fld)]);
pr.av2 = pr.av2';

%% Visualise
if debug
    for i = 1:length(in.fld)
        field = in.fld{i};
        subplot(3,1,i)
        line([in.a(1:end-1);in.a(2:end)],...
            repmat(pr.av2(i,:),[2,1]),...
            'LineStyle','--','Color','b','LineWidth',2)                                                    %Improved average
    end
end

%% Correction averaging

%#Corrected average: include an fractions between points defined by in.t and limits defined by in.a
if any(ismember(in.a,in.time)==0) %Check if any values of in.a do not match any value of in.t
    fprintf('#Limits of averaging used do not match raw data time step! Recalculating ...\n')
    
    %Crude average uses a reduced averaging range due to <= and >=
    %These contributions must be < in.dt
    
    %Lower contribution = (crude - (grad*time_mismatch))
    pr.lc = cellfun(@(x) cellfun(@(I,a) (O.(x)(I(1)) - ((O.(x)(I(1))-O.(x)(I(1)-1))/in.dt)), ...
                                                               pr.id,num2cell(in.a(1:end-1)),'UniformOutput',false),...                
                                                               in.fld,'UniformOutput',false);
    
    %Upper contribution = (crude + (grad*time_mismatch)) 
    pr.uc = cellfun(@(x) cellfun(@(I,a) (O.(x)(I(end)) + ((O.(x)(I(end)+1)-O.(x)(I(end)))/in.dt)), ...
                                                               pr.id,num2cell(in.a(2:end)),'UniformOutput',false),...                
                                                               in.fld,'UniformOutput',false);
  
    %Corrected average
    pr.av3 = cellfun(@(x,c1,c2) cellfun(@(I,a1,a2,cc1,cc2) trapz([a1,in.time(I)',a2],[cc1,O.(x)(I)',cc2])/(a2-a1),...
                                        pr.id,num2cell(in.a(1:end-1)),num2cell(in.a(2:end)),c1,c2,'UniformOutput',false),...
                                        in.fld,pr.lc,pr.uc,'UniformOutput',false);
    
%    pr.av3 = cellfun(@(x,c1,c2) cellfun(@(I,a1,a2,cc1,cc2) trapz([a1,in.t(I),a2],[cc1,in.X.(x)(I),cc2])/(a2-a1),...
%                                         pr.id,num2cell(in.a(1:end-1)),num2cell(in.a(2:end)),c1,c2,'UniformOutput',false),...
%                                         in.fld,pr.lc,pr.uc,'UniformOutput',false);
                                    
                                    
    %Flatten from nested cell array to matrix
    pr.av3 = reshape(cell2mat([pr.av3{:}]),[length(pr.id),length(in.fld)]);
    pr.av3 = pr.av3';
else
    pr.av3 = pr.av2;
end

%% Visualise

if debug
    for i=1:length(in.fld)
        subplot(3,1,i)
        line([in.a(1:end-1);in.a(2:end)],...
            repmat(pr.av3(i,:),[2,1]),...
            'LineStyle','-','Color','g','LineWidth',2)                                                    %Corrected improved average
    end
end

%% Output example ...
% out = cell2struct(cellfun(@(x) O.(x),in.fld,'UniformOutput',false),in.fld,2);

for k = 1:length(in.fld)
    field = in.fld{k};
    name  = [field,num2str(round(avp/60))];
    mat.(name) = pr.av3(k,:);
end
end