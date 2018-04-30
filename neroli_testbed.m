function [] = neroli_testbed()

data = [];
time = [];
load('/Users/Mus/Dropbox/PhD/MATLAB/neroli/test.mat');

[time_drop,end_data,start_data] = neroli_find_time(data,time);

scatter(time,data);

%find baseline

size_data = length(data);
first_max = max(data(1:size_data/2));
second_max = max(data(size_data/2:size_data));

tolerance = 0.0045;

%%extent of baseline

for i = 1:size_data/2
    if(isalmost(first_max,data(i),first_max*tolerance))
    else
        first_end = i;
        break
    end
end

for i = size_data/2:size_data
    if(isalmost(second_max,data(i),second_max*tolerance))
        second_end = i;
        break
    else
    end
end

%%peaks

plot(time,data,[time(first_end),time(second_end)],[data(first_end),data(second_end)],'r*');


%plot(time,data,[time(start_data),time(end_data)],[data(start_data),data(end_data)],'r*');

end