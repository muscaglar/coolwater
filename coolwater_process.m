function [] = coolwater_process(files)

% [baseName, folder] = uigetfile({'*.dat';'*.mat';},'CoolWater File Selector');
% filepath = fullfile(folder, baseName);
time = 0:1/100000:2000;

for i = 1:numel(files)
    name = strsplit(files(i).name,'.');
    if(ispc)
        full_path = strcat(files(i).folder,'\',files(i).name);
        savepath = strcat(files(i).folder,'\',name{1});
    else
        full_path = strcat(files(i).folder,'/',files(i).name);
        savepath = strcat(files(i).folder,'/',name{1});
    end
    load(full_path);
    
    fig_trace = figure;
    plot(time(1:length(current)),current);
    
    fig_hist = figure;
    h = histfit(current,100,'kernel');
    x = get(h(2),'xdata'); %h(2) is the density curve plot. h(1) is histrogram plot
    y = get(h(2),'ydata');
    
    [p, xi, bw] = ksdensity(current);
    
    
    save_trace = char(strcat(savepath,'_trace.png'));
    save_hist = char(strcat(savepath,'_hist.png'));
    save_fit = char(strcat(savepath,'_fit.mat'));
    save_ksdensity = char(strcat(savepath,'_ksdensity.mat'));
    
    saveas(fig_trace,save_trace);
    saveas(fig_hist,save_hist);
    
    save(save_fit,'x','y');
    save(save_ksdensity,'p','xi','bw');
    
    close all;
end

end