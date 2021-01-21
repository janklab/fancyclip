package net.janklab.fancyclip;

import java.awt.datatransfer.*;

class DummyClipboardOwner implements ClipboardOwner {

  public DummyClipboardOwner() {

  }
  
  
  public void lostOwnership(Clipboard clipboard, Transferable contents) {
    // NOP
  }

}