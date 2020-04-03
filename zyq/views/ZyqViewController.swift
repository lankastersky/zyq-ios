import UIKit

class ZyqViewController: UIViewController {

    var descriptionUrl: URL?

    func setupNavigationBarAppearance(level: LevelType) {
        var headerImage: UIImage?
        switch(level) {
        case .first:
            headerImage = UIImage(named: "header_stage1")
            break
        case .second:
            headerImage = UIImage(named: "header_stage2")
            break
        case .third:
            headerImage = UIImage(named: "header_stage3")
            break
        default:
            return
        }

//        let resizedImage = headerImage!.resizableImage(withCapInsets:
//            UIEdgeInsets(top: 0, left: 100, bottom: 0, right: 100), resizingMode: .stretch)
//        self.navigationController?.navigationBar.barTintColor = UIColor(patternImage: headerImage!)

        self.navigationController?.navigationBar.setupTitleAppearance(headerImage: headerImage!)
    }

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
        let descriptionViewController = WebViewController()
        descriptionViewController.url = descriptionUrl
        descriptionViewController.titleString = "description_title".localized
        self.navigationController?.pushViewController(descriptionViewController, animated: true)
    }
}
