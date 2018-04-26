
fileroot = uigetdir('CoolWater Mat File Selector');

files = dir(fullfile(fileroot, '*.mat'));
trans = 1;

translocation = containers.Map('KeyType','double','ValueType','any');
ecd = containers.Map('KeyType','double','ValueType','any');

for j = 1:length(files)
    
    if(ispc)
        filepath = char(strcat(fileroot,'\',files(j).name));
    else
        filepath = char(strcat(fileroot,'/',files(j).name));
    end
    
    load(filepath);
    
    time = 0:1/100000:2000;
    time = time(1:length(current));
    
    fil_current = butterworth_filter(10e3,100e3,current,'low');
    
    fil_current = fil_current(time>0.5);
    time = time(time>0.5);
    
    high_bound = (fil_current>(mean(fil_current)+(10*std(fil_current))));
    low_bound = (fil_current<(mean(fil_current)-(10*std(fil_current))));
    logical_fil_current = high_bound|low_bound;
    
    temp_logical_fil_current = high_bound|low_bound;
    padValue= 50;
    
    for i = padValue:length(temp_logical_fil_current)
        if(temp_logical_fil_current(i)==1 && temp_logical_fil_current(i-1)==0)
            logical_fil_current(i-padValue:i)=1;
        elseif(temp_logical_fil_current(i)==1 && temp_logical_fil_current(i+1)==0)
            logical_fil_current(i:i+padValue)=1;
        end
    end
    
    new_time = time(logical_fil_current);
    new_current = current - mean(current);
    
    i=1;
    while ( i<length(logical_fil_current))
        switch logical_fil_current(i)
            case 1
                start = i;
                while (logical_fil_current(i)==1)
                    i = i+1;
                end
                finish =i;
                translocation(trans) = [new_current(start:finish)',time(start:finish)'];
                trans = trans+1;
            case 0
                i = i+1;
        end
    end
    
end

ecds = [];

figure;
hold on;
for i=1:length(translocation)
    data = translocation(i);
    ecd(i) = trapz(data(:,2),-1./data(:,1));
    ecds(i) = ecd(i);
    plot(data(:,2),data(:,1));
end



%plot(new_time,new_current);