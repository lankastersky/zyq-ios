import UIKit

/// UIViewController Utils.
extension UIViewController {
    var appDelegate: AppDelegate {
        get {
            return (UIApplication.shared.delegate as? AppDelegate)!
        }
        set {}
    }
}
