%% exr_normals_to_npy: converts exr containing normals to a numpy file
% usage: exr_normals_to_npy(exr_filename)          % default method
% 
% Take an exr file and loads it using the pfstools to save
% it as npy using the npy-matlab converter
%
% arguments:
%   exr_filename - string containing the HOLE name of the file (including its
%   location)
%
% arguments (output):
%   none
%
%
% Author: Henrique Weber
% e-mail address: henrique.weber.1@ulaval.ca
% Release: 0
% Release date: 06/27/17

function exr_normals_to_npy(exr_filename)

%load normal map
exr_normal_map_data = pfs_read_image(exr_filename);

%flip x and z coordinates
exr_normal_map_data(:,:,1) = exr_normal_map_data(:,:,1)*-1;
exr_normal_map_data(:,:,3) = exr_normal_map_data(:,:,3)*-1;

%save as npy
writeNPY(exr_normal_map_data, [exr_filename(1:end-4),'.npy']);

end