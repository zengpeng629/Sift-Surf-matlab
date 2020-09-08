I = imread('obj1_5.JPG');
I_gray = single(rgb2gray(I));
%subplot(1,2,1);
figure(1);
imshow(I); hold on;

%SIFT
peak_thresh = 12;
%The edge threshold eliminates peaks of the DoG scale space whose curvature is too small (such peaks yield badly localized frames).
edge_thresh = 7;
[kps_sift,des_sift] = vl_sift(I_gray,'PeakThresh', peak_thresh, 'edgethresh', edge_thresh);

h1 = vl_plotframe(kps_sift) ;
set(h1,'color','yellow','linewidth',2) ;

%SURF
I_gray = rgb2gray(I);
strongest_threshold = 4500;
points_surf = detectSURFFeatures(I_gray,'MetricThreshold',strongest_threshold);
[surf_kps, vpts1] = extractFeatures(I_gray, points_surf);

%subplot(1,2,2);
figure(2);
imshow(I); hold on;
plot(points_surf)
%
