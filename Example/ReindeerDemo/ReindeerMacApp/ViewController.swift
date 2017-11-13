import Cocoa
import Reindeers

class ViewController: NSViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    let document = try? Document(string: "<xml></xml>")
  }

  override var representedObject: Any? {
    didSet {
    // Update the view, if already loaded.
    }
  }
}

