function out = reporoot
% The root dir of the fancyclip repo
out = string(fileparts(fileparts(fileparts(mfilename('fullpath')))));
end