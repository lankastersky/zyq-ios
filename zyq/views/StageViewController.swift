import UIKit

/// Shows Stage screen
class StageViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let tabBarController = self.appDelegate.window?.rootViewController as? UITabBarController else {
            assertionFailure("Failed to get tab bar controller")
            return
        }
        switch(tabBarController.selectedIndex) {
        case 0:
            break;
        case 1:
            break;
        case 2:
            break;
        default:
            break;
        }
    }
}
