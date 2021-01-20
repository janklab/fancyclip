classdef Clipboard < fancyclip.internal.FancyclipBaseHandle
  % Main implementation class for clipboard functionality
  
  properties
    % The underlying java.awt.datatransfer.Clipboard object
    j
  end
  
  methods (Static)
    
    function out = getSystemClipboard()
      tk = java.awt.Toolkit.getDefaultToolkit;
      out = fancyclip.internal.Clipboard(tk.getSystemClipboard);
    end
    
  end
  
  methods
    
    function this = Clipboard(jObj)
      if nargin == 0
        return
      end
      mustBeA(jObj, 'java.awt.datatransfer.Clipboard');
      this.j = jObj;
    end
    
  end
  
end

