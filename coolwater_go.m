function [] = coolwater_go()

remove_id = [];

fileroot = uigetdir('CoolWater File Selector');
files = dir(fullfile(fileroot, '*.dat'));
files_mat = dir(fullfile(fileroot, '*.mat'));

    for j = 1:numel(files_mat)
        mat_name = strsplit(files_mat(j).name,'.');
        mat_name = mat_name(1);
        for k = 1:numel(files)
            file_name = strsplit(files(k).name,'.');
            file_name = file_name(1);
            if(strcmp(mat_name,file_name))
               remove_id = [remove_id, k];
            end
        end
    end
    
    files(remove_id) = [];
    
    coolwater_import(fileroot, files, files_mat);
    
    coolwater_cumulative_fit();

end