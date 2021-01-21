package net.janklab.fancyclip;

import java.awt.datatransfer.*;

class DummyClipboardOwner implements ClipboardOwner {

  public DummyClipboardOwner() {
    /* Empty because Matlab doesn't work with default constructors? So we have
     * to explicitly supply a no-arg constructor? */
  }
  
  public void lostOwnership(Clipboard clipboard, Transferable contents) {
    // NOP
  }

}