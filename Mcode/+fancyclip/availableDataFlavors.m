function out = availableDataFlavors()

syscb = fancyclip.internal.Clipboard.getSystemClipboard;
out = syscb.availableDataFlavors;

end
