import UIKit

/// Shows exercises groups for the given stage.
/// May be it's better to use tableview instead but I couldn't make it work with adjusted height.
final class StageViewController: UIViewController {

    private let leftRightMargin: CGFloat = 12.0

    @IBOutlet private var collectionView: UICollectionView!

    private var exercises: [String] = []
    private var selectedItem: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.register(
            UINib(nibName: "StageCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: StageCollectionViewCell.stageCellReuseIdentifier
        )
        
        // See https://goo.gl/yAUR1R
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard let tabBarController = self.appDelegate.window?.rootViewController as?
            UITabBarController else {
            assertionFailure("Failed to get tab bar controller")
            return
        }

        let stage = tabBarController.selectedIndex;
        switch(stage) {
        case NavigationTab.stage1.rawValue:
            navigationItem.title = "stage1_screen_title".localized
            exercises = [String](repeating: "1", count: 12)
            break
        case NavigationTab.stage2.rawValue:
            navigationItem.title = "stage2_screen_title".localized
            exercises = [String](repeating: "2", count: 5)
            break
        case NavigationTab.stage3.rawValue:
            navigationItem.title = "stage3_screen_title".localized
            exercises = [String](repeating: "3", count: 2)
            break
        default:
            break
        }
        collectionView.reloadData()
    }
}

extension StageViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {

        return exercises.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: StageCollectionViewCell.stageCellReuseIdentifier,
            for: indexPath
        ) as? StageCollectionViewCell else {
            print("Failed to instantiate journal cell")
            return UICollectionViewCell()
        }

        assert(indexPath.item < exercises.count,
               "Bad challenge index when creating collection view")

        let challenge: String = exercises[indexPath.item]
        cell.nameLabel.text = challenge
        cell.showType(indexPath.item % 2 == 0)

        cell.widthConstraint.constant = collectionView.frame.size.width - 2.0 * leftRightMargin
        return cell
    }
}

extension StageViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        assert(indexPath.item < exercises.count,
               "Bad challenge index when creating collection view")
        selectedItem = indexPath.item
        let challenge: String = exercises[indexPath.item]
        //openChallengeView(challenge)
    }
}
