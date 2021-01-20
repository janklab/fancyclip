classdef DataFlavor < fancyclip.internal.FancyclipBaseHandle & fancyclip.internal.DisplayableHandle
  % A Java DataFlavor for data transfer
  
  %#ok<*PROP>
  
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
    javaRepresentationClass
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
    
    function out = get.mimeType(this)
      out = repmat(string(missing), size(this));
      for i = 1:numel(this)
        out(i) = this(i).j.getMimeType;
      end
    end
    
    function out = get.javaRepresentationClass(this)
      out = repmat(string(missing), size(this));
      for i = 1:numel(this)
        out(i) = this(i).j.getRepresentationClass.getName;
      end
    end
    
    function out = get.humanPresentableName(this)
      out = repmat(string(missing), size(this));
      for i = 1:numel(this)
        out(i) = this(i).j.getHumanPresentableName;
      end
    end
    
    function out = get.primaryType(this)
      out = repmat(string(missing), size(this));
      for i = 1:numel(this)
        out(i) = this(i).j.getPrimaryType;
      end
    end
    
    function out = get.subType(this)
      out = repmat(string(missing), size(this));
      for i = 1:numel(this)
        out(i) = this(i).j.getSubType;
      end
    end
    
    function disp(this)
      if iscolumn(this)
        mimeType = string({this.mimeType})';
        javaRepresentationClass = string({this.javaRepresentationClass})';
        humanName = string({this.humanPresentableName})';
        primaryType = string({this.primaryType})';
        subType = string({this.subType})';
        tbl = table(mimeType, javaRepresentationClass, humanName, primaryType, subType);
        fprintf('%s (%s):\n', class(this), size2str(size(this)));
        disp(tbl);
      else
        disp@fancyclip.internal.DisplayableHandle(this);
      end
    end
     
  end
  
  methods (Access=protected)
    
    function out = dispstr_scalar(this)
      if isempty(this.j)
        out = '<missing>';
      else
        jRepClass = this.j.getRepresentationClass;
        repJavaClassName = string(jRepClass.getName);
        out = string(sprintf('<DataFlavor: mimeType=%s, repJavaClass=%s>', ...
          this.mimeType, repJavaClassName));
      end
    end
    
  end
  
end

