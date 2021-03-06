classdef (HandleCompatible) FancyclipBase
  % This class is a trick to support automatic library initialization
  %
  % To use it, have all your classes that depend on the library being
  % initialized inherit from this.
  
  properties (Constant, Hidden)
    initializer = fancyclip.internal.LibraryInitializer;
  end
  
end

