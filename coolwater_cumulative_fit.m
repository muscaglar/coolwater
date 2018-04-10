function [] = coolwater_cumulative_fit(fileroot)

%fileroot = uigetdir('CoolWater File Selector');
files = dir(fullfile(fileroot, '*_ksdensity.mat'));

x = [];
y = [];

y2 = zeros(1,100);

c_p = zeros(1,100);
    
    for i = 1:numel(files)
        if(ispc)
            filepath = char(strcat(fileroot,'\',files(i).name));
        else
            filepath = char(strcat(fileroot,'/',files(i).name));
        end

        result = load(filepath);
        
        minimum_peak=5;
        [pks,locs]=findpeaks(result.p,'MINPEAKHEIGHT',minimum_peak);
        
        shift = 90 - max(locs);
        
        s_p = circshift(result.p',shift);
        s_xi = circshift(result.xi',shift);
        
        c_p = c_p + s_p';
        
        x = [x, s_xi'];
        y = [y, s_p'];
        
        y2 = y2 + s_p';
    end
    
    close all;
    
    plot(c_p);
    
    figure;
    
    plot(x, y);
    
    figure;
    
    x2 = linspace(min(x),max(x),100);
    
    plot(x2, y2);

end