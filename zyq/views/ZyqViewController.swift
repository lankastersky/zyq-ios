import UIKit

class ZyqViewController: UIViewController {
    var descriptionUrl: URL?

    func initBarItems() {
        if (descriptionUrl != nil) {
            let helpButton = UIBarButtonItem(
                image: UIImage(named: "help_icon")?.withRenderingMode(.alwaysOriginal),
            style: .plain, target: self, action: #selector(showDescription))
            navigationItem.rightBarButtonItem = helpButton
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }

    @objc func showDescription() {
        let descriptionViewController = DescriptionViewController()
        descriptionViewController.url = descriptionUrl
        self.navigationController?.pushViewController(descriptionViewController, animated: true)
    }
}
