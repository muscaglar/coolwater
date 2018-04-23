function [] = coolwater_import(fileroot, files, files_mat)

% [baseName, folder] = uigetfile({'*.dat';'*.mat';},'CoolWater File Selector');
% filepath = fullfile(folder, baseName);

for i = 1:numel(files)
    if(ispc)
        filepath = char(strcat(fileroot,'\',files(i).name));
    else
        filepath = char(strcat(fileroot,'/',files(i).name));
    end
    
    name = strsplit(files(i).name,'.');
    
    if(ispc)
        savepath = strcat(fileroot,'\',name(1))
    else
        savepath = strcat(fileroot,'/',name(1))
    end
    
    result = coolwater_txt2mat(filepath);
    save_mat = char(strcat(savepath,'.mat'));
    voltage = result(:,1);
    current = result(:,2);
    
    save(save_mat,'voltage','current');
    
    close all;
end

files_mat = dir(fullfile(fileroot, '*.mat'));

for i = 1:numel(files_mat)
    coolwater_alt_process(files_mat(i));
end

end