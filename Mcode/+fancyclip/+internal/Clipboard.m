classdef Clipboard < fancyclip.internal.FancyclipBase & handle
  % Main implementation class for clipboard functionality
  
  %#ok<*INUSL>
  
  properties
    % The underlying java.awt.datatransfer.Clipboard object
    j
  end
  properties (SetAccess=private)
    validCopyFormats = ["text/plain", "text/html"]
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
    
    function out = availableDataFlavors(this)
      jFlavors = this.j.getAvailableDataFlavors;
      out = fancyclip.internal.DataFlavor.ofJavaArray(jFlavors);
    end
    
    function out = availableMimeTypes(this)
      flavors = this.availableDataFlavors;
      out = unique([flavors.mimeType])';
    end
    
    function out = paste(this, mimeTypes)
      arguments
        this (1,1)
        mimeTypes string
      end
      availMimeTypes = this.availableMimeTypes;
      for i = 1:numel(mimeTypes)
        if ismember(mimeTypes(i), availMimeTypes)
          out = this.pasteSpecificMimeType(mimeTypes(i));
          return
        end
      end
      error('Requested MIME types (%s) not available in clipboard. Available MIME types: %s', ...
        strjoin(mimeTypes, ', '), strjoin(availMimeTypes, ', '));
    end
    
    function out = pasteSpecificMimeType(this, mimeType)
      arguments
        this (1,1)
        mimeType (1,1) string
      end
      availFlavors = this.availableDataFlavors;
      availMimeTypes = [availFlavors.mimeType];
      availJavaMimeTypes = [availFlavors.javaMimeType];
      primaryMimeType = regexprep(mimeType, '/.*', '');
      flavor = [];
      if primaryMimeType == "text"
        % Special handling for text
        % Hack: Use a MIME type we know we can deal with
        preferred = [
          mimeType + "; class=java.io.InputStream; charset=unicode"
          mimeType + "; class=java.io.InputStream"
          mimeType + "; document=selection; class = java.io.Reader; charset=Unicode" % for HTML from Chrome
          ];
        ix = find(ismember(preferred, availJavaMimeTypes));
        if isempty(ix)
          error('No suitable Java MIME type found on the clipboard. Available javaMimeTypes: %s', ...
            strjoin(availJavaMimeTypes, ', '));
        end
        flavor = availFlavors(ix(1));
      end
      if isempty(flavor)
        % Just pick one
        [tf,loc] = ismember(mimeType, availMimeTypes);
        if ~tf
          error('No suitable MIME type found on the clipboard. Available MIME types: %s', ...
            strjoin(unique(availMimeTypes), ', '));
        end
        flavor = availFlavors(loc);
      end
      jdata = this.j.getData(flavor.j);
      if ischar(jdata) || isstring(jdata) || isa(jdata, 'java.lang.String')
        out = string(jdata);
      elseif isa(jdata, 'java.io.InputStream')
        buf = java.io.ByteArrayOutputStream;
        com.google.common.io.ByteStreams.copy(jdata, buf);
        if primaryMimeType == "text"
          out = string(buf.toString);
        else
          % Dunno how to convert it, so just return raw bytes
          out = typecast(buf.toByteArray, 'uint8');
        end
      elseif isa(jdata, 'java.io.Reader')
        out = com.google.common.io.CharStreams.toString(jdata);
      else
        % TODO: Read all data from InputStream or Reader
        out = jdata;
      end
    end
    
    function copy(this, data, formats)
      arguments
        this
        data
        formats (1,:) string = ["text/plain", "text/html"]
      end
      buf = net.janklab.fancyclip.BufferedTransferable;
      for format = formats
        cbData = this.makeCopyData(data, format);
        if format == "text/plain"
          dataFlavor = java.awt.datatransfer.DataFlavor('text/plain');
        elseif format == "text/html"
          dataFlavor = java.awt.datatransfer.DataFlavor('text/html');
        else
          error('Unsupported clipboard copy format: "%s". Valid formats are: ', ...
            format, strjoin(this.validCopyFormats, ', '));
        end
        buf.addContent(dataFlavor, cbData);
      end
      this.j.setContents(buf, net.janklab.fancyclip.DummyClipboardOwner);
    end
    
    function out = makeCopyData(this, data, format)
      if format == "text/plain"
        txt = this.textPlainRepresentation(data);
        out = unicode2native(txt, 'UTF-8');
      elseif format == "text/html"
        htmlifier = fancyclip.internal.Htmlifier;
        htmlText = htmlifier.htmlify(data);
        out = unicode2native(htmlText, 'UTF-8');
      else
        error('Unsupported clipboard copy format: "%s". Valid formats are: ', ...
          format, strjoin(this.validCopyFormats, ', '));
      end
    end
    
    function out = textPlainRepresentation(this, data)
      if istable(data)
        error('text/plain is not supported for table arrays.')
      else
        out = mat2str(data);
      end
    end
    
  end
  
  
end

