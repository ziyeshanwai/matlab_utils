dirtory = "dir";
formatS =  "//xxx/%s/c/";
formatT =  "//xxx/%s/undistored/c/";
souredir = sprintf(formatS, dirtory);
suffix = "jpg";
files = dir([souredir+'*.'+ suffix]);
targetdir = sprintf(formatT, dirtory);
if exist(targetdir) == 0
    mkdir(targetdir)
end
parfor i=1:length(files)
    I = imread(souredir+files(i).name);
    J1 = undistortImage(I,cameraParams);
    imwrite(J1, targetdir+files(i).name);
end