import UIKit

class ZyqViewController: UIViewController {

    var descriptionUrl: URL?
    var indicator: UIActivityIndicatorView?

    override func viewDidLoad() {
        indicator =
            UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        indicator?.color = UIColor.gray
        indicator?.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        indicator?.center = view.center
        self.view.addSubview(indicator!)
        self.view.bringSubviewToFront(indicator!)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

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
            let descriptionButton = UIBarButtonItem(
                image: UIImage(named: "help_icon")?.withRenderingMode(.alwaysOriginal),
            style: .plain, target: self, action: #selector(showDescription))
            navigationItem.rightBarButtonItem = descriptionButton
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
