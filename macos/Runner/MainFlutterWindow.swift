import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let fixedWidth: CGFloat = 140  // Desired width
    let fixedHeight: CGFloat = 110 // Desired height

    // Get the main screen’s size, or provide a default if screen is nil
    let screenSize = NSScreen.main?.frame.size ?? NSSize(width: 1540, height: 900)

    // Calculate the position for the top right corner
    let originX = screenSize.width - fixedWidth
    let originY = screenSize.height - fixedHeight

    // Set the window frame at the top right corner with fixed size
    let windowFrame = NSRect(x: originX, y: originY, width: fixedWidth, height: fixedHeight)
    self.setFrame(windowFrame, display: true)

    // Prevent resizing by setting min and max sizes
    self.minSize = NSSize(width: fixedWidth, height: fixedHeight)
    self.maxSize = NSSize(width: fixedWidth, height: fixedHeight)

    // Set the window level to keep the window on top
    self.level = .floating

    let flutterViewController = FlutterViewController()
    self.contentViewController = flutterViewController

    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
}
