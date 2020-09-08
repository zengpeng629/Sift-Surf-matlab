%Read input images
I = imread('obj1_5.JPG');
I_gray_single = single(rgb2gray(I));

%Select best parameters for SIFT to detect few hundred key points.
peak_thresh = 10;
edge_thresh = 9;
[kps_sift,des_sift] = vl_sift(I_gray_single,'PeakThresh', peak_thresh, 'edgethresh', edge_thresh);
x = [];
y = [];

%Select best parameters for Surf to detect few hundred key points.
I_gray = rgb2gray(I);
strongest_threshold = 4500;
points_surf = detectSURFFeatures(I_gray,'MetricThreshold',strongest_threshold);
kps_surf = points_surf.Location';
x_surf = [];
y_surf = [];

for i = 0:15:360
    %SIFT
    I_gray_single_modify = imrotate(I_gray_single, i);
    cnt_matches = 0;
    
    %Rotate the image with 15 degree step, detect modified keypoints
    [kps_sift_modify,des_sift_modify] = vl_sift(I_gray_single_modify,'PeakThresh', peak_thresh, 'edgethresh', edge_thresh);
    %Rotate the keypoints of the original image
    kps_sift_rotate = rotateKps(size(I,2), size(I,1),kps_sift,i);
    
    %To indicate if the keypoints of modified image is alread matched
    flags = zeros(1,size(kps_sift_modify,2));
    kps_sift_modify = [kps_sift_modify; flags];
    
    %for loop to compare keypoints in both images
    for j = 1:size(kps_sift_rotate,2)
        for k = 1:size(kps_sift_modify,2)
            % if the keypoints of modified image hasn't been mathced
            if kps_sift_modify(5,k) == 0
                x1 = kps_sift_modify(1,k);
                y1 = kps_sift_modify(2,k);
                
                x0 = kps_sift_rotate(1,j);
                y0 = kps_sift_rotate(2,j);
                
                if abs(x1-x0) <= 2 && abs(y1-y0) <= 2
                    cnt_matches = cnt_matches + 1;
                    kps_sift_modify(5,k) = 1;
                end
            end
        end
    end
    
    % Compute repeatability
    repeatability = cnt_matches / size(kps_sift_rotate,2);
    y = [y,repeatability];
    x = [x,i];
    
    %SURF part, same logic as above.
    I_gray_modify = imrotate(I_gray, i);
    cnt_matches = 0;
    
    points_surf_modify = detectSURFFeatures(I_gray_modify,'MetricThreshold',strongest_threshold);
    kps_surf_modify = points_surf_modify.Location';
    
    kps_surf_rotate = rotateKps(size(I,2), size(I,1),kps_surf,i);
    
    flags = zeros(1,size(kps_surf_modify,2));
    kps_surf_modify = [kps_surf_modify; flags];
    
    for j = 1:size(kps_surf_rotate,2)
        for k = 1:size(kps_surf_modify,2)
            if kps_surf_modify(3,k) == 0
                x1 = kps_surf_modify(1,k);
                y1 = kps_surf_modify(2,k);
                
                x0 = kps_surf_rotate(1,j);
                y0 = kps_surf_rotate(2,j);
                
                if abs(x1-x0) <= 2 && abs(y1-y0) <= 2
                    cnt_matches = cnt_matches + 1;
                    kps_surf_modify(3,k) = 1;
                end
            end
        end
    end
    
    repeatability = cnt_matches / size(kps_surf_rotate,2);
    y_surf = [y_surf,repeatability];
    x_surf = [x_surf,i];    
end

plot(x,y,'red','LineWidth',1.5 ); hold on;
plot(x_surf,y_surf,'black','LineWidth',1.5 );    

title('Repeatability Versus Rotation Angle');           
xlabel('Rotation Degree');                    
ylabel('Repeatability');  