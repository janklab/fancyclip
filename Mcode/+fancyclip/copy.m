function copy(data, formats)
% COPY Copy data to the system clipboard
%
% copy(data, formats)
%
% Data is the data you want to copy to the clipboard. It can be a numeric array,
% strings, a table array, whatever.
%
% Format (string) is the list of formats you want to make it available in. This
% is a list of MIME types, like "text/plain", "text/html", and so on. Defaults
% to a list of common formats. Currently the default format list is:
%   ["text/plain", "text/html"]
% but this may change in the future.
arguments
  data
  formats string = []
end
cb = fancyclip.internal.Clipboard.getSystemClipboard;
cb.copy(data, formats);
end
