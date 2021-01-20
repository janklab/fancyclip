function batch_package_fancyclip_toolbox
% An entry point for building the toolbox from a "matlab -batch" call
%
% This has error handling to set matlab's exit status appropriately.

try
  load_fancyclip;
  package_fancyclip_toolbox;
catch err
  fprintf('Error occurred:\n');
  fprintf('%s\n', getReport(err));
  exit(1);
end
