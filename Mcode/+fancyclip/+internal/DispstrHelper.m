classdef DispstrHelper
  
  methods (Static)
    
    function txt = disparray(x)
      strs = dispstrs(x);
      txt = fancyclip.internal.Dispstr.prettyprintArray(strs);
      if nargout == 0
        disp(txt)
        clear txt
      end
    end
    
  end
  
end