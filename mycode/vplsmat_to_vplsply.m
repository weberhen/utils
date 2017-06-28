%% vplsmat_to_vplsply: convert data_vpls.txt to data_vpls.mat
% usage: vplsmat_to_vplsply(folder)          % default method
% 
% Convert all files called vpls_data.mat to vpls_data.ply to later generate
% mashes with it. Aditionally one can multiply all vertices' color by a
% constant 'c' to allow its visualization.
%
% arguments:
%   folder - string containing the full path of the folder 
%   c - multiplication factor to be applied to all intensity values
%
% arguments (output):
%   none
%
%
% Author: Henrique Weber
% e-mail address: henrique.weber.1@ulaval.ca
% Release: 0
% Release date: 06/28/17

function vplsmat_to_vplsply(folder,c)

    if nargin < 2
        c = 1;
    end
        
    %find all files called data_vpls.mat
    exr_filenames = rdir([folder,'*/**/data_vpls.mat']);

    for ix = 1:length(exr_filenames)
        
        %get name of current file
        filename = exr_filenames(ix).name;

        load(filename);
        
        %create output file
        fileID = fopen([filename(1:end-4),'.ply'],'w');
        N = size(vpls,2);
        
        %save header in ply format
        fprintf(fileID,'ply\n');
        fprintf(fileID,'format ascii 1.0\n');
        fprintf(fileID,'element vertex %d\n',N);
        fprintf(fileID,'property float x\nproperty float y\nproperty float z\n');
        fprintf(fileID,'property uchar red\nproperty uchar green\nproperty uchar blue\nproperty uchar alpha\n');
        fprintf(fileID,'element face 0\n');
        fprintf(fileID,'property list uchar int vertex_indices\n');
        fprintf(fileID,'end_header\n');
    
        %save the data
        for n = 1:N
            fprintf(fileID,'%g %g %g %g %g %g %g\n',vpls(n).pos,round(c*vpls(n).col),1);
        end

        fclose(fileID);
    end
end
