classdef DataFlavor < fancyclip.internal.FancyclipBaseHandle & fancyclip.internal.DisplayableHandle
  % A Java DataFlavor for data transfer
  
  properties
    % The underlying java.awt.datatransfer.DataFlavor object
    j
  end
  properties (Dependent)
    defaultRepClass
    humanPresentableName
    mimeType
    primaryType
    subType
  end
  
  methods (Static)
    
    function out = ofJavaArray(jDataFlavors)
      n = numel(jDataFlavors);
      out = repmat(fancyclip.internal.DataFlavor, [n 1]);
      for i = 1:numel(jDataFlavors)
        out(i) = fancyclip.internal.DataFlavor(jDataFlavors(i));
      end
    end
    
  end
  
  methods
    
    function this = DataFlavor(jObj)
      if nargin == 0
        return
      end
      mustBeA(jObj, 'java.awt.datatransfer.DataFlavor');
      this.j = jObj;
    end
    
  end
  
  methods (Access=protected)
    
    function out = dispstr_scalar(this)
      if isempty(this.j)
        out = '<missing>';
      else
        out = string(this.j.toString);
      end
    end
    
  end
  
end

