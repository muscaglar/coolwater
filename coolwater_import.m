function [] = coolwater_import(fileroot, files, files_mat)

% [baseName, folder] = uigetfile({'*.dat';'*.mat';},'CoolWater File Selector');
% filepath = fullfile(folder, baseName);

    for i = 1:numel(files)
        if(ispc)
            filepath = char(strcat(fileroot,'\',files(i).name));
        else
            filepath = char(strcat(fileroot,'/',files(i).name));
        end
        
        result = coolwater_txt2mat(filepath);
        
        fig_trace = figure;
        plot(result(:,1),result(:,2));
        
        fig_hist = figure;
        h = histfit(result(:,2),100,'kernel');
        x = get(h(2),'xdata');
        y = get(h(2),'ydata');
        
        [p, xi, bw] = ksdensity(result(:,2));
        
        name = strsplit(files(i).name,'.')
       
        if(ispc)
            savepath = strcat(fileroot,'\',name(1))
        else
            savepath = strcat(fileroot,'/',name(1))
        end
        
        save_trace = char(strcat(savepath,'_trace.png'));
        save_hist = char(strcat(savepath,'_hist.png'));
        save_mat = char(strcat(savepath,'.mat'));
        save_fit = char(strcat(savepath,'_fit.mat'));
        save_ksdensity = char(strcat(savepath,'_ksdensity.mat'));
        
        saveas(fig_trace,save_trace);
        saveas(fig_hist,save_hist);

        save(save_mat,'result');
        save(save_fit,'x','y');
        save(save_ksdensity,'p','xi','bw');
        
        close all;
    end

end