function [] = coolwater_go()

remove_id = [];

%% Altering the code to handle a directory input with multiple TDMS files.

fileroot = uigetdir('CoolWater File Selector');
%files = dir(fullfile(fileroot, '*.dat'));

files = dir(fullfile(fileroot, '*.tdms'));
files_mat = dir(fullfile(fileroot, '*.mat'));
%% This checks if the DAT file has a corressponding MAT file and will omit it from analysis.

%     for j = 1:numel(files_mat)
%         mat_name = strsplit(files_mat(j).name,'.');
%         mat_name = mat_name(1);
%         for k = 1:numel(files)
%             file_name = strsplit(files(k).name,'.');
%             file_name = file_name(1);
%             if(strcmp(mat_name,file_name))
%                remove_id = [remove_id, k];
%             end
%         end
%     end
keep_mat = [];

for j = 1:numel(files_mat)
    mat_number = coolwater_getNumber(files_mat(j).name);
    for k = 1:numel(files)
        file_number = coolwater_getNumber(files(k).name);
        if(mat_number==file_number)
            remove_id = [remove_id, k];
            keep_mat = [keep_mat, j];
        end
    end
end

files(remove_id) = [];
keep_mat = sort(unique(keep_mat));
keep_mat_files = files_mat(keep_mat);
%coolwater_import(fileroot, files, files_mat);
coolwater_TDMS_import(fileroot,files,1);

%coolwater_process(keep_mat_files);
coolwater_alt_process(keep_mat_files);

%coolwater_cumulative_fit(fileroot);


    function [number] = coolwater_getNumber(fName)
        out = str2double(regexp(fName,'[\d.]+','match'));
        number = out(1);
    end
end