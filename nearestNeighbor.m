function nearestNeighbor(img1,img2,des1,des2,kp1,kp2)
    % This function is for find the nearest neighbor as matched keypoint.    
    min_index = 0;
    matches = [];

    % Compute the distances, while finding the minimal one.
    for i = 1:size(des1,2)
        min_distance = 9999;
        for j = 1:size(des2,2)
            distance = sqrt(sum((des1(:,i)-des2(:,j)).^2));
            if distance < min_distance
                % find the min value, store its index.
                min_distance = distance;
                min_index = j;
            end
        end
        matches = [matches;[i,min_index]];
    end
    
    % Draw lines
    img3 = cat(2,img1,img2);
    imagesc(img3);hold on;
    for i = 1:200
        x0 = kp1(1,matches(i,1));
        y0 = kp1(2,matches(i,1));
        x1 = size(img1,2) + kp2(1,matches(i,2));
        y1 = kp2(2,matches(i,2));
        line([x0,x1],[y0,y1],'color',rand(1,3),'LineWidth',2);
    end
end