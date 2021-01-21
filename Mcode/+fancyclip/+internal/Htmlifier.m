classdef Htmlifier
  % Converts Matlab data structures to HTML representations
  
  %#ok<*AGROW>
  %#ok<*INUSA>
  
  methods
    
    function out = htmlify(this, x)
      if istable(x)
        out = this.htmlifyTableAsTable(x);
      elseif ismatrix(x)
        out = this.htmlifyMatrixAsTable(x);
      else
        out = this.escapehtml(dispstr(x));
      end
    end
    
    function out = htmlifyMatrixAsTable(this, x)
      if istable(x)
        error('Tables are not supported');
      end
      assert(ismatrix(x));
      cellContents = this.htmlifyArrayElements(x);
      buf = string([]);
      buf(end+1) = '<table>';
      for iRow = 1:size(x, 1)
        buf(end+1) = "    <tr> " + strjoin(strcat('<td>', cellContents(iRow,:), '</td>'), ' ') + " </tr>"; 
      end
      buf(end+1) = '</table>';
      out = strjoin(buf, '\n');
    end
    
    function out = htmlifyArrayElements(this, x)
      if istable(x)
        error('Tables are not supported');
      end
      if iscell(x)
        strs = repmat(string(missing), size(x));
        for i = 1:numel(x)
          strs(i) = dispstr(x{i});
        end
      else
        strs = mydispstrs(x);
      end
      out = this.escapehtml(strs);
    end
    
    function out = escapehtml(this, strs)
      arguments
        this
        strs string
      end
      out = repmat(string(missing), size(strs));
      % TODO: Push this loop down into HTML
      for i = 1:numel(strs)
        out(i) = string(org.apache.commons.lang.StringEscapeUtils.escapeHtml(strs(i)));
      end
    end
    
  end
    
end

function out = mydispstrs(x)
out = dispstrs(x);
end