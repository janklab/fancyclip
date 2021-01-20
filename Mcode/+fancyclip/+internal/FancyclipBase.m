classdef FancyclipBase
  % This class is a trick to support automatic library initialization
  %
  % To use it, have all your classes that depend on the library being
  % initialized inherit from this or FancyclipBaseHandle.
  
  properties (Constant, Hidden)
    initializer = fancyclip.internal.LibraryInitializer;
  end
  
end

