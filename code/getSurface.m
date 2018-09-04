function  heightMap = getSurface(surfaceNormals, method)
% GETSURFACE computes the surface depth from normals
%   HEIGHTMAP = GETSURFACE(SURFACENORMALS, IMAGESIZE, METHOD) computes
%   HEIGHTMAP from the SURFACENORMALS using various METHODs. 
%  
% Input:
%   SURFACENORMALS: height x width x 3 array of unit surface normals
%   METHOD: the intergration method to be used
%
% Output:
%   HEIGHTMAP: height map of object
[h,w,n] = size(surfaceNormals);
fx = surfaceNormals(:,:,1)./surfaceNormals(:,:,3);
fy = surfaceNormals(:,:,2)./surfaceNormals(:,:,3);
heightMap = zeros(h,w);

switch method
    case 'column'
        %%% implement this %%%
        heightMap(:,1) = cumsum(fy(:,1),1);
        for i = 1:h
           heightMap(i,:) = cumsum(fx(i,:),2) + heightMap(i,1); 
        end
      
    case 'row'
        %%% implement this %%%
        heightMap(1,:) = cumsum(fx(1,:),2);
        for i = 1:w
            heightMap(:,i) = cumsum(fy(:,i),1) + heightMap(1,i);
        end
      
    case 'average'
        %%% implement this %%%
        heightMap_r = zeros(h,w);
        heightMap_c = zeros(h,w);
        %column
        heightMap_c(:,1) = cumsum(fy(:,1),1);
        for i = 1:h
           heightMap_c(i,:) = cumsum(fx(i,:),2) + heightMap_c(i,1); 
        end
        %row
        heightMap_r(1,:) = cumsum(fx(1,:),2);
        for i = 1:w
            heightMap_r(:,i) = cumsum(fy(:,i),1) + heightMap_r(1,i);
        end
        heightMap = (heightMap_r + heightMap_c)/2;
        
        
    case 'random'
        %%% implement this %%%
        count = 100;
        x_sum = cumsum(fx,2);
        y_sum = cumsum(fy,1);
        
        for i = 2:h
            for j = 2:w
                val = 0.0;
                for k = 1:count
                    %rand point
                    p = randi([2,i]);
                    q = randi([2,j]);
                    temp = 0.0;
                    temp = temp + x_sum(1,q) + y_sum(p,q);
                    temp = temp + x_sum(p,j) - x_sum(p,q - 1);
                    temp = temp + y_sum(i,j) - y_sum(p - 1,j);
                    
                    val = val + temp;
                end
                heightMap(i,j) = val/count;
            end
        end
end

