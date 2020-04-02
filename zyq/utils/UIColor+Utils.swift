import UIKit

extension UIColor {

    static let disabledSkinColor = UIColor(rgb: 0xFFD700)//UIColor(red: 255/255, green: 198/255, blue: 173/255, alpha: 1)
    static let skinColor = UIColor(rgb: 0xfafafa)//UIColor(red: 209/255, green: 178/255, blue: 136/255, alpha: 1)
    static let darkSkinColor = UIColor(rgb: 0xd4353a)//UIColor(red: 204/255, green: 160/255, blue: 97/255, alpha: 1)
    //static let accentSkinColor = UIColor(rgb: 0xFF4500)//UIColor(red: 255/255, green: 99/255, blue: 71/255, alpha: 1)

    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0,
                  green: CGFloat(green) / 255.0,
                  blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
