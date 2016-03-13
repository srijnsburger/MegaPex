function check_downcast(originaldata,downcastSBE,downcastMan,number)
% Check_downcast - plots the manual determined downcast or upcast with the
%                  original data
% Now specific for my dataset (column with pressure and time)
%
% Input:  - original data (structure with cells with pressure and time)
%         - downcastSBE (the downcast determined by Seabird for example)
%         - downcastMan (the downcast determined "manually")
%         - number (when the original data is not the same length as
%         the original data structure)
%                
%

nfiles = length(downcastMan);
for i = 1:nfiles
    
    if nargin == 4
        j = number;
    else 
        j = i;
    end
    
    figure;
    plot(originaldata(j).data(:,13),-originaldata(j).data(:,2))
    hold on
%     plot(downcastSBE(j).data(:,13),-downcastSBE(j).data(:,2),'--r')
    plot(downcastSBE(j).data(:,13),-downcastSBE(j).data(:,2),'r')
    plot(downcastMan(i).data(:,13),-downcastMan(i).data(:,2),'-.g');
    datetick('x','HH:MM:SS','keepticks');
    xlabel('Time (GMT)');
    ylabel('Pressure (m)');
    legend('original','downcast SBE','downcast Manually');
    if j == i
        title(['Cast' ' ' num2str(j) ' ' datestr(downcastMan(i).data(1,13))]);
        print2screensize(['Check_downcast_Cast-' num2str(j),'.png']);
    else
        title(['Cast' ' ' num2str(j) '-' num2str(i) ' ' datestr(downcastMan(i).data(1,13))]);
        print2screensize(['Check_downcast_Cast-' num2str(j) '-' num2str(i),'.png']);
    end
    
end

% nfiles = length(downcastMan);
% for i = 1:nfiles
%     figure;
%     plot(originaldata,-originaldata)
%     hold on
%     plot(downcastSBE,-downcastSBE,'r')
%     plot(downcastMan(i).data(:,13),-downcastMan(i).data(:,2),'-.g');
%     datetick('x','HH:MM:SS','keepticks');
%     legend('original','downcast SBE','downcast Manually');
% end

end 