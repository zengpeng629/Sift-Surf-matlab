I = imread('obj1_5.JPG');
I_gray = single(rgb2gray(I));
I_target = imread('obj1_t1.jpg');
I_target_gray = single(rgb2gray(I_target));

%SIFT
peak_thresh = 12;
edge_thresh = 7;
[kps_sift,des_sift] = vl_sift(I_gray,'PeakThresh', peak_thresh, 'edgethresh', edge_thresh);
[kps_target_sift,des_target_sift] = vl_sift(I_target_gray,'PeakThresh', peak_thresh, 'edgethresh', edge_thresh);

% figure(1);
% imshow(I_target); hold on;
% h1 = vl_plotframe(kps_target_sift) ;
% set(h1,'color','blue','linewidth',2) ;

% 3b-Fixed threshold
%fixedThreshold(I,I_target,des_sift, des_target_sift,kps_sift,kps_target_sift);

% 3c-Nearest Neighbor
%nearestNeighbor(I,I_target,des_sift, des_target_sift,kps_sift,kps_target_sift);

% 3d-NNRD
%nearestNeighborDistanceRatio(I,I_target,des_sift, des_target_sift,kps_sift,kps_target_sift)

% 3e-NNRD,SURF
%SURF
I = imread('obj1_5.JPG');
I_gray = rgb2gray(I);
I_target = imread('obj1_t1.jpg');
I_target_gray = rgb2gray(I_target);

strongest_threshold = 4500;
points = detectSURFFeatures(I_gray,'MetricThreshold',strongest_threshold);
[des, valid_points] = extractFeatures(I_gray, points);

points_target = detectSURFFeatures(I_target_gray,'MetricThreshold',strongest_threshold);
[des_target, valid_points_target] = extractFeatures(I_target_gray, points_target);

% Apply NNRD on SURF
nearestNeighborDistanceRatio(I,I_target,des', des_target',points.Location',points_target.Location')
