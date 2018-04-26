function [] = coolwater_go()


%% Altering the code to handle a directory input with multiple TDMS files.

fileroot = uigetdir('CoolWater File Selector');


[files,keep_mat_files] = coolwater_file_process(fileroot);

coolwater_TDMS_import(fileroot,files,1);

[files,keep_mat_files] = coolwater_file_process(fileroot);

coolwater_alt_process(keep_mat_files);

%coolwater_cumulative_fit(fileroot);

end