function [] = coolwater_tiff2png()

[FileName,PathName] = uigetfile('*.tif','CoolWater Tif File Selector');

fname = [PathName, FileName];
file = strsplit(FileName,'.');
mkdir([PathName,file{1}]);
save = [PathName,file{1},'\'];

info = imfinfo(fname);
num_images = numel(info);

cmap = colormap(gray(256));

for k = 1:num_images
    [A] = imread(fname, k);
    A = imshow(A,cmap);
    saveas(A,[save,'\',num2str(k),'.png']);
end

end