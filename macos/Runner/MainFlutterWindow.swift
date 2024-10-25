import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let fixedWidth: CGFloat = 210  // Set your desired width
    let fixedHeight: CGFloat = 170 // Set your desired height
    let windowFrame = NSRect(x: 0, y: 0, width: fixedWidth, height: fixedHeight)
    self.setFrame(windowFrame, display: true)

    // Set min and max sizes to prevent resizing
    self.minSize = NSSize(width: fixedWidth, height: fixedHeight)
    self.maxSize = NSSize(width: fixedWidth, height: fixedHeight)

    // Set the window level to stay on top of other windows
    self.level = .floating

    let flutterViewController = FlutterViewController()
    self.contentViewController = flutterViewController

    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
}
