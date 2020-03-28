import UIKit

final class StageCollectionViewCell: UICollectionViewCell {

    static let stageCellReuseIdentifier = "StageCell"

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!

    @IBOutlet weak var widthConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()

        typeLabel.textColor = UIColor.darkSkinColor
    }
}
