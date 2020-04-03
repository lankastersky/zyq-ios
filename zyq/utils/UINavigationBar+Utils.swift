import UIKit

extension UINavigationBar {
    
    func setupTitleAppearance(headerImage: UIImage) {
        setupTitleFontAppearance()
        setupTitleImageAppearance(headerImage)
    }

    func setupTitleImageAppearance(_ image: UIImage) {
        if #available(iOS 13.0, *) {
            let appearance = self.standardAppearance
            appearance.backgroundImage = image
            appearance.backgroundImageContentMode = UIView.ContentMode.scaleAspectFill

            self.standardAppearance = appearance
            self.compactAppearance = appearance
            self.scrollEdgeAppearance = appearance
    //            self.layer.contents = image!.cgImage
        } else {
            self.barTintColor = UIColor(patternImage: image)
        }
    }

    func setupTitleColorAppearance(_ color: UIColor) {
        if #available(iOS 13.0, *) {
            let appearance = self.standardAppearance
            appearance.backgroundColor = color

            self.standardAppearance = appearance
            self.compactAppearance = appearance
            self.scrollEdgeAppearance = appearance
        } else {
            self.barTintColor = color
        }
    }

    func setupTitleFontAppearance() {
        let titleFont = UIFont(name: "Papyrus", size: 20) ?? UIFont.systemFont(ofSize: 20)
        let largeTitleFont = UIFont(name: "Papyrus", size: 26) ?? UIFont.systemFont(ofSize: 26)
        if #available(iOS 13.0, *) {
            let appearance = self.standardAppearance
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: titleFont]
            appearance.largeTitleTextAttributes = [
                .foregroundColor: UIColor.white, .font: largeTitleFont]

            self.standardAppearance = appearance
            self.compactAppearance = appearance
            self.scrollEdgeAppearance = appearance
        } else {
            self.titleTextAttributes = [NSAttributedString.Key.font: titleFont]
            self.largeTitleTextAttributes = [NSAttributedString.Key.font:largeTitleFont]
        }
    }
}
