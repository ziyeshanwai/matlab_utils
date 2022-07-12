
souredir = "";
suffix = "jpg";
files = dir([souredir+'*.'+ suffix]);
targetdir = "";
parfor i=1:length(files)
    I = imread(souredir+files(i).name);
    J1 = undistortImage(I,cameraParams);
    imwrite(J1, targetdir+files(i).name);
end