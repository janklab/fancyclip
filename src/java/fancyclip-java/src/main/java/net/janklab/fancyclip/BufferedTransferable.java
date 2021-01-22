package net.janklab.fancyclip;

import java.util.*;
import java.awt.datatransfer.*;

/**
 * A Transferable implementation that just keeps its data in memory.
 */
public class BufferedTransferable implements Transferable {
  
  public List<byte[]> dataBuffer = new ArrayList<>();
  public List<DataFlavor> flavors = new ArrayList<>();

  public void addContent(DataFlavor flavor, byte[] data) {
    dataBuffer.add(data);
    flavors.add(flavor);
  }

  public Object getTransferData(DataFlavor flavor) {
    for (int i = 0; i < flavors.size(); i++) {
      if (flavors.get(i).match(flavor)) {
        return dataBuffer.get(i);
      }
    }
    throw new RuntimeException("No match for flavor "+flavor+" found.");
  }

  public DataFlavor[] getTransferDataFlavors() {
    return flavors.toArray(new DataFlavor[0]);
  }

  public boolean isDataFlavorSupported(DataFlavor flavor) {
    Iterator<DataFlavor> it = flavors.iterator();
    while (it.hasNext()) {
      if (it.next().match(flavor)) {
        return true;
      }
    }
    return false;
  }

}
