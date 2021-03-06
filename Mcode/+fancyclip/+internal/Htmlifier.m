classdef Htmlifier < fancyclip.internal.FancyclipBase
  % Converts Matlab data structures to HTML representations
  
  %#ok<*AGROW>
  %#ok<*INUSA>
  %#ok<*MANU>
  %#ok<*STRNU>
  
  properties
  end
  
  methods
    
    function out = htmlify(this, x, format)
      arguments
        this
        x
        format (1,1) string = "loose"
      end
      if istable(x)
        out = this.htmlifyTableAsTable(x);
      elseif isstruct(x)
        out = this.htmlifyStructAsTable(x);
      elseif ischar(x)
        out = this.htmlifyCharArray(x);
      elseif isscalar(x)
        out = this.escapehtml(dispstr(x, {'QuoteStrings',true}));
      elseif ismatrix(x)
        if format == "tight"
          out = this.escapehtml(dispstr(x, {'QuoteStrings',true}));
        else
          out = this.htmlifyMatrixAsTable(x);
        end
      else
        out = this.escapehtml(dispstr(x));
      end
    end
    
    % TODO: Implement htmlifyTableAsTable()
    
    function out = htmlifyMatrixAsTable(this, x)
      if istable(x)
        error('Table arrays are not supported');
      end
      assert(ismatrix(x));
      cellContents = this.htmlifyArrayElements(x);
      buf = string([]);
      buf(end+1) = this.tableStart;
      for iRow = 1:size(x, 1)
        tds = repmat(string(missing), [1 size(x, 2)]);
        for iCol = 1:size(x, 2)
          tds(iCol) = this.td(cellContents(iRow,iCol));
        end
        buf(end+1) = "    <tr> " + strjoin(tds, ' ') + " </tr>"; 
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
      if isdatetime(x)
        out = strcat("<date>", out, "</date>");
      end
    end
    
    function out = htmlifyTableAsTable(this, t)
      colNames = string(t.Properties.VariableNames);
      nCols = numel(colNames);
      colDataReprs = cell(1, nCols);
      for i = 1:nCols
        colDataReprs{i} = this.htmlifyArrayElements(t.(colNames{i}));
      end
      buf = this.tableStart;
      buf(end+1) = "<thead>";
      buf(end+1) = "    <tr>";
      for colName = colNames
        buf(end+1) = sprintf('        <th scope="col">%s</th>', this.escapehtml(colName));
      end
      buf(end+1) = "    </tr>";
      buf(end+1) = "</thead>";
      buf(end+1) = "<tbody>";
      for iRow = 1:height(t)
        tds = repmat(string(missing), [1 nCols]);
        for iCol = 1:width(t)
          tds(iCol) = sprintf("<td>%s</td>", colDataReprs{iCol}(iRow));
        end
        buf(end+1) = sprintf("    <tr> %s </tr>", strjoin(tds, " "));
      end
      buf(end+1) = "</tbody>";
      buf(end+1) = "</table>";
      out = strjoin(buf, '\n');
    end
    
    function out = htmlifyStructAsTable(this, s)
      buf = this.tableStart;
      flds = string(fieldnames(s));
      for iEl = 1:numel(s)
        si = s(iEl);
        if numel(s) > 1
          buf(end+1) = "  <tr>" + this.td("Element "+iEl, "", "colspan=2") + "</tr>";
        end
        for iFld = 1:numel(flds)
          fld = flds(iFld);
          valHtmlStr = this.htmlify(si.(fld));
          buf(end+1) = "  <tr>" + this.td(fld+":", "text-align:right; vertical-align:top") + this.td(valHtmlStr) + "</tr>";
        end
      end
      buf(end+1) = "</table>";
      out = strjoin(buf, '\n');
    end
    
    function out = htmlifyObjectAsTable(this, obj)
      RAII.warn = fancyclip.internal.util.withwarnoff('MATLAB:structOnObject');
      % TODO: Remove Constant properties
      s = builtin('struct', obj);
      out = this.htmlifyStructAsTable(s);
    end
    
    function out = htmlifyCharArray(this, c)
      strs = this.dispstrsChar(c);
      if isscalar(strs)
        out = strs(1);
      elseif ~ismatrix(c)
        out = sprintf('<%s %s>', size2str(c), class(c));
      else
        out = string(['[', strjoin(strs, '; '), ']']);
      end
      out = this.escapehtml(out);
    end
    
    function out = dispstrsChar(this, c)
      strs = string(c);
      out = repmat(string(missing), size(strs));
      for i = 1:numel(strs)
        out(i) = this.escapeChar(strs(i));
      end
    end
    
    function out = escapeChar(this, c)
      arguments
        this
        c (1,:) char
      end
      out = ['''' strrep(c, '''', '''''') ''''];
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
    
    % HTML construction

    function out = tableStart(this)
      tableStyle = "";
      out = sprintf("<table style=""%s"">", tableStyle);
    end
    
    function out = td(this, content, addStyle, properties)
      arguments
        this
        content (1,1) string
        addStyle (1,1) string = missing
        properties (1,1) string = missing
      end
      style = "";
      if ~ismissing(addStyle)
        style = style + "; " + addStyle;
      end
      propStr = "";
      if ~ismissing(properties)
        propStr = " " + properties;
      end
      out = sprintf("<td style=""%s""%s>%s</td>", style, propStr, content);
    end
    
  end
    
end

function out = mydispstrs(x)
out = dispstrs(x);
end