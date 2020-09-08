function [kps_rotate] = rotateKps(width, height, kps, degree)
    kps_rotate = kps;
    rad = pi*degree/180;
    
    for i = 1:size(kps,2)
        new_width = abs(width * cos(rad)) + abs(height * sin(rad));
        new_height = abs(width * sin(rad)) + abs(height * cos(rad));

        rotation_matrix = [cos(rad), -sin(rad);sin(rad), cos(rad)]*[(kps(1,i)-0.5*width);(0.5*height-kps(2,i))];

        kps_rotate(1,i) = rotation_matrix(1,1) + 0.5*new_width;
        kps_rotate(2,i) = 0.5 * new_height - rotation_matrix(2,1);
    end  
end
 

