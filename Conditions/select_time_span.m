function select_time_span(time,var,start,stop)

id1 = find(time == datenum(start));
id2 = find(time == datenum(stop));

if isstruct(var)== 1
    fld = fieldnames(var);
    for i = 1:length(fld)
        field = fld{i};
        a{i} = find(length(var.(field))==length(time));
    end
end


end