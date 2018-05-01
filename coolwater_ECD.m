function [mean_drop,time_drop,ecds] = coolwater_ECD(good_translocations)

ecds = [];
mean_drop = [];
time_drop = [];

for i=1:length(good_translocations)
    data = good_translocations(i);
    time = data(:,2);
    [mean_drop(i),time_drop(i),ecds(i)]=coolwater_crude_drop(data,time);
    %ecds(i) = coolwater_integrate(data);
end

%     function [area] = coolwater_integrate(data)
%         area = 0;
%         time = data(:,2);
%         current = data(:,1);
%         for x = 2:2:length(current)
%             step = time(x)-time(x-1);
%             area = area + (step*(current(x)-current(x-1)));
%         end
%     end

end