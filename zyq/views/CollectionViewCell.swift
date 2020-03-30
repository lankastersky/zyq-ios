import UIKit

final class CollectionViewCell: UICollectionViewCell {

    static let collectionCellReuseIdentifier = "CollectionCell"

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!

    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet var typeBottomConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()

        typeLabel.textColor = UIColor.darkSkinColor
    }

    func showType(_ show : Bool) {
        if (!show) {
            typeLabel.isHidden = true
            typeBottomConstraint.isActive = false;
        } else {
            typeLabel.isHidden = false
            typeBottomConstraint.isActive = true;
        }
    }
}
