import UIKit

/// Shows exercises groups for the given stage.
/// May be it's better to use tableview instead but I couldn't make it work with adjusted height.
final class StageViewController: ListViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let aLevel = LevelType(rawValue: self.appDelegate.navigationTab!.rawValue + 1) else {
            return
        }
        level = aLevel

        switch(level) {
        case .first:
            navigationItem.title = "stage1_screen_title".localized
            break
        case .second:
            navigationItem.title = "stage2_screen_title".localized
            break
        case .third:
            navigationItem.title = "stage3_screen_title".localized
            break
        default:
            break
        }

        exercises = self.exerciseService.buildExerciseGroups(level: level)
        descriptionUrl = exerciseService.getPracticeDescription(level: level)
        initBarItems()
        self.listView.reloadData()
    }

    // MARK: UICollectionViewDataSource

    // MARK: UICollectionViewDelegate

    override func collectionView(
        _ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        assert(indexPath.item < exercises.count,
               "Bad challenge index when creating collection view")
        showExercises(indexPath: indexPath)
    }

    func showExercises(indexPath: IndexPath) {
        let ex: ExerciseGroup = exercises[indexPath.item]
        let viewController = ExerciseListViewController()
        viewController.level = level
        viewController.exerciseType = ex.type
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
