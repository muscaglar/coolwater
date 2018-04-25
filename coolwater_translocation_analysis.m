function [] = coolwater_translocation_analysis()

fileroot = uigetdir('CoolWater File Selector');
%files = dir(fullfile(fileroot, '*.dat'));

files = dir(fullfile(fileroot, '*.tdms'));

coolwater_TDMS_import(fileroot,files,0);


end