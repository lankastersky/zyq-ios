import UIKit

final class StageCollectionViewCell: UICollectionViewCell {

    static let stageCellReuseIdentifier = "StageCell"

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!

    @IBOutlet weak var widthConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()

        // Used to make cells resizable by height. See https://goo.gl/yAUR1R
        contentView.translatesAutoresizingMaskIntoConstraints = false

        // Code below is needed to make the self-sizing cell work when building for iOS 12 from
        // Xcode 10.0.
        // See https://github.com/larrylegend/CollectionViewAutoSizingTest.
        let leftConstraint = contentView.leftAnchor.constraint(equalTo: leftAnchor)
        let rightConstraint = contentView.rightAnchor.constraint(equalTo: rightAnchor)
        let topConstraint = contentView.topAnchor.constraint(equalTo: topAnchor)
        let bottomConstraint = contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate(
            [leftConstraint, rightConstraint, topConstraint, bottomConstraint])

//        let screenWidth = UIScreen.main.bounds.size.width
//        widthConstraint.constant = screenWidth

        typeLabel.textColor = UIColor.darkSkinColor
    }
}
