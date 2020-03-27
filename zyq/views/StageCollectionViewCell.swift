import UIKit

final class StageCollectionViewCell: UICollectionViewCell {

    static let stageCellReuseIdentifier = "StageCell"

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!

    @IBOutlet weak private var widthConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()

        // Used to make cells resizable by height. See https://goo.gl/yAUR1R
        // Consider using table cells instead.
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let screenWidth = UIScreen.main.bounds.size.width
        widthConstraint.constant = screenWidth

        typeLabel.textColor = UIColor.darkSkinColor
    }
}
