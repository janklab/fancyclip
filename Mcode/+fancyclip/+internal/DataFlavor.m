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
  
  methods
    
    function this = DataFlavor(jObj)
      if nargin == 0
        return
      end
      mustBeA(jObj, 'java.awt.datatransfer.DataFlavor');
      this.j = jObj;
    end
    
  end
  
end

