function fancyclip_launchtests
% Entry point for running full test suite from command line or automation

rootdir = fileparts(fileparts(mfilename('fullpath')));
addpath(fullfile(rootdir, 'Mcode'))

results = fancyclip.test.runtests %#ok<NOPRT,NASGU>

end
