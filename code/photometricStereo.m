function [albedoImage, surfaceNormals] = photometricStereo(imArray, lightDirs)
% PHOTOMETRICSTEREO compute intrinsic image decomposition from images
%   [ALBEDOIMAGE, SURFACENORMALS] = PHOTOMETRICSTEREO(IMARRAY, LIGHTDIRS)
%   comptutes the ALBEDOIMAGE and SURFACENORMALS from an array of images
%   with their lighting directions. The surface is assumed to be perfectly
%   lambertian so that the measured intensity is proportional to the albedo
%   times the dot product between the surface normal and lighting
%   direction. The lights are assumed to be of unit intensity.
%
%   Input:
%       IMARRAY - [h w n] array of images, i.e., n images of size [h w]
%       LIGHTDIRS - [n 3] array of unit normals for the light directions
%
%   Output:
%        ALBEDOIMAGE - [h w] image specifying albedos
%        SURFACENORMALS - [h w 3] array of unit normals for each pixel
%
% Author: Subhransu Maji
%
% Acknowledgement: Based on a similar homework by Lana Lazebnik


%%% implement this %% 
[h, w, n] = size(imArray);
im = reshape(imArray, h*w, n);
g = lightDirs\im'; % g(3, h * w)
g = reshape(g',h,w,3);

albedoImage = zeros(h, w);
surfaceNormals = zeros(h, w, 3);
for i = 1 : h
    for j = 1 : w
        v = reshape(g(i,j,:), 3, 1);
        albedoImage(i,j) = sqrt(sum(v.^2));
        surfaceNormals(i,j,:) = g (i,j,:) ./ albedoImage(i,j);
    end
end
