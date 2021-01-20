classdef Settings < fancyclip.internal.FancyclipBaseHandle
% Global settings for the fancyclip package
%
% Don't use this class directly. If you want to get or set the settings,
% work with the instance of this in the fancyclip.globals.settings field

  properties
  end

  methods (Static=true)

    function out = discover()
      % Discovery of initial values for package settings.
      %
      % This could look at config files, environment variables, Matlab appdata, and
      % so on.
      %
      % This needs to avoid referencing fancyclip.globals, to avoid a circular dependency.
      out = fancyclip.Settings;
    end

  end

end