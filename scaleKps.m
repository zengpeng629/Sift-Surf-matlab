function [kps_scale] = scaleKps(width, height, kps, m)
    % Scale the coordinates based on the center point of the image.
    kps_scale = kps;
    
    for i = 1:size(kps,2)
        new_width = width * m;
        new_height = height * m;
        
        %build the scale matrix
        scale_matrix = [m, 0;0, m]*[(kps(1,i)-0.5*width);(0.5*height-kps(2,i))];

        kps_scale(1,i) = scale_matrix(1,1) + 0.5*new_width;
        kps_scale(2,i) = 0.5 * new_height - scale_matrix(2,1);
    end  
end
 

