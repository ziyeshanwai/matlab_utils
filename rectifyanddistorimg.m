clc;
clear all;
close all;
load("handshakeStereoParams.mat");
c1imgPath = '';
c2imgPath = '';
c1_rectify_path = strrep(c1imgPath, 'c1_rot', 'c1_rectify' );
c2_rectify_path = strrep(c1imgPath, 'c1_rot', 'c2_rectify' );
c1_distortion_path = strrep(c1imgPath, 'c1_rot', 'c1_distorted' );
c2_distortion_path = strrep(c1imgPath, 'c1_rot', 'c2_distorted' );
c1imgnames = dir([c1imgPath  '*.jpg']);
parfor i=1:length(c1imgnames)
    c1 = imread([c1imgPath c1imgnames(i).name]);
    c2 = imread([c2imgPath c1imgnames(i).name]);
    [c1Rect, c2Rect] = rectifyStereoImages(c1, c2, stereoParams);
    c1Undistorted = undistortImage(c1,stereoParams.CameraParameters1);
    c2Undistorted = undistortImage(c2,stereoParams.CameraParameters2);
    imwrite(c1Rect', [c1_rectify_path c1imgnames(i).name]);
    imwrite(c2Rect', [c2_rectify_path c1imgnames(i).name]);
    imwrite(c1Undistorted, [c1_distortion_path c1imgnames(i).name]);
    imwrite(c2Undistorted, [c2_distortion_path c1imgnames(i).name]);
    fprintf('the process is %6.2f / %6.2f \n', i, length(c1imgnames) );
end


