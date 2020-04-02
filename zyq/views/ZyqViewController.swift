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

        let navbar = self.navigationController?.navigationBar
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundImage = headerImage
            appearance.backgroundImageContentMode = UIView.ContentMode.scaleAspectFill
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

            navbar?.standardAppearance = appearance
            navbar?.compactAppearance = appearance
            navbar?.scrollEdgeAppearance = appearance
//            navbar?.layer.contents = headerImage!.cgImage
        } else {
            navbar?.barTintColor = UIColor(patternImage: headerImage!)
        }
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
        let descriptionViewController = DescriptionViewController()
        descriptionViewController.url = descriptionUrl
        self.navigationController?.pushViewController(descriptionViewController, animated: true)
    }
}
