%% vplstxt_to_vplsmat: convert data_vpls.txt to data_vpls.mat
% usage: B=EXR_NORMALS_TO_NPY(folder)          % default method
% 
% Convert all files called vpls_data.txt to vpls_data.mat to speed up its
% later usage. The function find all vpls_data.txt recursively inside the
% given folder
%
% arguments (folder):
%   A - string containing the full path of the folder 
%
% arguments (output):
%   none
%
%
% Author: Henrique Weber
% e-mail address: henrique.weber.1@ulaval.ca
% Release: 0
% Release date: 06/28/17

function vplstxt_to_vplsmat(folder)
    
    %find all files called data_vpls.txt
    filenames = rdir([folder,'*/**/data_vpls.txt']);

    for ix = 1:length(filenames)

        %get name of current file
        filename = filenames(ix).name;

        %skip files that were already converted to .mat
        if exist([filename(1:end-3),'mat'], 'file') ~= 2 

            % open the file
            fid = fopen(filename);

            % read the file headers, find N (one value)
            N = fscanf(fid, 'NVPLS: %d\n');

            % read each set of measurements
            for n = 1:N
                vpls(n).pos = fscanf(fid, sprintf('pos_%d %%g %%g %%g\n',n-1));
                vpls(n).nor = fscanf(fid, sprintf('nor_%d %%g %%g %%g\n',n-1));
                vpls(n).col = fscanf(fid, sprintf('col_%d %%g %%g %%g\n',n-1));
                vpls(n).scale = fscanf(fid, sprintf('scale_%d: %%g\n',n-1));
            end

            % close the file
            fclose(fid);

            save([filename(1:end-3),'mat'],'vpls');
        end
    end
end
