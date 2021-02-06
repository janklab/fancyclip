function copy(data, formats)
% COPY Copy data to the system clipboard
%
% copy(data, formats)
%
% Data is the data you want to copy to the clipboard. It can be a numeric array,
% strings, a table array, whatever.
%
% Formats (string) is the list of formats you want to make it available in. This
% is a list of MIME types, like "text/plain", "text/html", and so on. Defaults
% to a list of common formats. Currently the default format list is:
%   ["text/plain", "text/html"]
% but this may change in the future.
%
% Currently, complex data types like table arrays and struct arrays only support
% the "text/html" format, so you must specify that when copying tables and
% structs. This will hopefully be fixed soon.
arguments
  data
  formats string = ["text/plain" "text/html"]
end
cb = fancyclip.internal.Clipboard.getSystemClipboard;
cb.copy(data, formats);
end
