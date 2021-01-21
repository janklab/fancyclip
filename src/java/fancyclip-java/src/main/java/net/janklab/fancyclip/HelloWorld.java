package net.janklab.fancyclip;

class HelloWorld {
  public static void main(String[] args) {
    System.out.println("Hello, World!"); 
    DummyClipboardOwner dummy = new DummyClipboardOwner();
    System.out.println("Created a DummyClipboardOwner");
  }

  public static void createClipboardOwner() {
    DummyClipboardOwner dummy = new DummyClipboardOwner();
    System.out.println("Created a DummyClipboardOwner");
  }

  public static void createClipboardOwnerWithDummyArgs(double x) {
    DummyClipboardOwner dummy = new DummyClipboardOwner();
    System.out.println("Created a DummyClipboardOwner");
  }

}