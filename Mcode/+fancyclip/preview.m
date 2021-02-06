function preview(data, format)
% PREVIEW Preview some data in a particular format
%
% preview(data, format)
%
% This will convert the input data to its copied form for the given format, but
% instead of placing it on the system clipboard, it will write it out to a file
% and open that file in a web browser or text editor or whatever.
%
% Data is the data you want to preview the copied form of. It can be just about
% any Matlab data structure.
%
% Format (string) is the format you want to preview it in. Defaults to
% "text/html". Supported formats are currently:
%   - "text/html"
%   - "text/plain"

arguments
  data
  format (1,1) string = "text/html"
end

fancyclip.internal.Fancyclip.preview(data, format);

end