import UIKit
import Reindeers

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.white

    let document = try? Document(string: "<xml></xml>")
  }
}

