function nearestNeighborDistanceRatio(img1,img2,des1,des2,kp1,kp2)
    min_index = 0;
    matches = [];
%     %best sift
%     threshold = 0.905;
%     %suboptimal sift
%     threshold = 0.955
    
    %best surf
%     threshold = 0.765;
    %suboptimal sift
    threshold = 0.825
    
    for i = 1:size(des1,2)
        min_distance = 9999;
        second_min_distance = 9990;
        
        for j = 1:size(des2,2)
            distance = sqrt(sum((des1(:,i)-des2(:,j)).^2));
            if distance < min_distance
                min_distance = distance;
                min_index = j;
            elseif  distance < second_min_distance
                    second_min_distance = distance;
            end
        end
       % ratio = [ratio; min_distance / second_min_distance];
        
        if (min_distance / second_min_distance) < threshold
            matches = [matches;[i,min_index]];
        end
    end
    
    img3 = cat(2,img1,img2);
    imagesc(img3);hold on;
    for i = 1:size(matches,1)
        x0 = kp1(1,matches(i,1));
        y0 = kp1(2,matches(i,1));
        x1 = size(img1,2) + kp2(1,matches(i,2));
        y1 = kp2(2,matches(i,2));
        line([x0,x1],[y0,y1],'color',rand(1,3),'LineWidth',2);
    end
end