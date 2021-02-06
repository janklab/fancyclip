classdef Fancyclip < fancyclip.internal.FancyclipBase
  % Miscellaneous stuff
  
  methods (Static)
    
    function preview(data, format)
      arguments
        data
        format (1,1) string = "text/html"
      end
      validFormats = ["text/html" "text/plain"];
      cb = fancyclip.internal.Clipboard;
      binaryCbData = cb.makeCopyData(data, format);
      if format == "text/html"
        extn = ".html";
        html = sprintf("<html>\n<body>\n%s\n</body>\n</html>", native2unicode(binaryCbData, 'UTF-8'));
        binaryCbData = unicode2native(html, 'UTF-8');
      elseif format == "text/plain"
        extn = ".txt";
      else
        error('Unsupported format: %s. Valid formats are: %s', ...
          format, strjoin(validFormats, ', '));
      end
      tempDir = string([tempname '-fancyclip.d']);
      fancyclip.internal.util.mkdir2(tempDir);
      fileBase = sprintf("fancyclip preview %s", datestr(now, 'yyyy-mm-dd HH-MM-SS')) + extn;
      filePath = fullfile(tempDir, fileBase);
      fid = fancyclip.internal.util.fopen2(filePath, 'w');
      fwrite(fid, binaryCbData, 'uint8');
      fancyclip.internal.util.fclose2(fid);
      
      if ispc
        winopen(filePath);
      elseif ismac
        system(sprintf('open "%s"', filePath));
      else
        % TODO: Figure this out better
        web(filePath, '-browser');
      end
    end
    
  end
  
end

