function out = paste(mimeType)
% PASTE Paste data for requested MIME type(s)
%
% out = paste(mimeType)
%
% MimeType (string) is a list of the MIME types you'll accept, in order of
% preference.
%
% Examples:
%
% x = fancyclip.paste('text/html')
arguments
  mimeType string
end
cb = fancyclip.internal.Clipboard.getSystemClipboard;
out = cb.paste(mimeType);
end