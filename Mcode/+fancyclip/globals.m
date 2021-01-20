classdef globals
  % Global library properties and settings for fancyclip.
  %
  % Note that if you want to change the settings, you can't do this:
  %
  %    fancyclip.globals.settings.someSetting = 42;
  %
  % That will break due to how Matlab Constant properties work. Instead, you need
  % to first grab the Settings object and store it in a variable, and then work
  % on that:
  %
  %    s = fancyclip.globals.settings;
  %    s.someSetting = 42;
  
  properties (Constant)
    % Path to the root directory of this fancyclip distribution
    distroot = string(fileparts(fileparts(fileparts(mfilename('fullpath')))));
    % Global settings for fancyclip.
    settings = fancyclip.Settings.discover
  end
  
  methods (Static)
    
    function out = version
      % The version of the fancyclip library
      %
      % Returns a string.
      persistent val
      if isempty(val)
        versionFile = fullfile(fancyclip.globals.distroot, 'VERSION');
        val = strtrim(fancyclip.internal.readtext(versionFile));
      end
      out = val;
    end
    
    function initialize
      % Initialize this library/package
      fancyclip.internal.initializePackage;
    end
    
  end
  
end

