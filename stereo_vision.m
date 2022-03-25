load("handshakeStereoParams.mat");
showExtrinsics(stereoParams);
frameLeft = imread("");
frameRight = imread("");
[frameLeftRect, frameRightRect] = ...
    rectifyStereoImages(frameLeft, frameRight, stereoParams);
[~, ~, ~, camMatrix1,camMatrix2,R1,R2] = ...
    rectifyStereoImages(frameLeft, frameRight, stereoParams);
frameLeftUdistorted = undistortImage(frameLeft,stereoParams.CameraParameters1);
frameRightUdistorted = undistortImage(frameRight,stereoParams.CameraParameters2);
figure;
subplot(3,2,1);
imshow(frameLeftRect');
title('frameLeftRect');
subplot(3,2,2);
imshow(frameLeft);
title('frameLeft');
subplot(3,2,3);
imshow(frameLeftUdistorted);
title('frameLeftUdistorted');
subplot(3,2,4);
imshow(frameRightRect');
title('frameRightRect');
subplot(3,2,5);
imshow(frameRight);
title('frameRight');
subplot(3,2,6);
imshow(frameRightUdistorted);
title('frameRightUdistorted');

frameLeftGray  = frameLeftRect;
frameRightGray = frameRightRect;
disparityRange = [0 48];    
disparityMap = disparitySGM(frameLeftGray, frameRightGray, 'DisparityRange',disparityRange,'UniquenessThreshold',8);
figure;
imshow(disparityMap, disparityRange);
title('Disparity Map');
colormap jet
colorbar
points3D = reconstructScene(disparityMap, reprojectionMatrix);
% Convert to meters and create a pointCloud object
points3D = points3D ./ 1000;
rgb = cat(3,frameLeftRect,frameLeftRect,frameLeftRect);
ptCloud = pointCloud(points3D, 'Color', rgb);

% Create a streaming point cloud viewer
player3D = pcplayer([-3, 3], [-3, 3], [0, 8], 'VerticalAxis', 'y', ...
    'VerticalAxisDir', 'down');

% Visualize the point cloud
view(player3D, ptCloud);