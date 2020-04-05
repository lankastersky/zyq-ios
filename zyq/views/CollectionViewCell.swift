import UIKit

final class CollectionViewCell: UICollectionViewCell {

    static let collectionCellReuseIdentifier = "CollectionCell"

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!

    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet var typeBottomConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()

        // See https://github.com/larrylegend/CollectionViewAutoSizingTest
        contentView.translatesAutoresizingMaskIntoConstraints = false

        // Code below is needed to make the self-sizing cell work when building for iOS 12
        let leftConstraint = contentView.leftAnchor.constraint(equalTo: leftAnchor)
        let rightConstraint = contentView.rightAnchor.constraint(equalTo: rightAnchor)
        let topConstraint = contentView.topAnchor.constraint(equalTo: topAnchor)
        let bottomConstraint = contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate(
            [leftConstraint, rightConstraint, topConstraint, bottomConstraint])

        applyShadows()
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

    func applyShadows() {
        contentView.layer.cornerRadius = 1.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true

        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
        layer.backgroundColor = UIColor.white.cgColor
    }
}
