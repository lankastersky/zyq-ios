import UIKit

/// Shows exercises.
/// May be it's better to use tableview instead but I couldn't make it work with adjusted height.
class ExerciseListViewController: ListViewController {

    var level: LevelType = LevelType.unknown
    var exerciseType: ExerciseType = ExerciseType.unknown

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = exerciseType.description
        exercises = self.exerciseService.getExercises(level: level, type: exerciseType)
        self.listView.reloadData()
    }

    // MARK: UICollectionViewDataSource

    override func initCell(cell: CollectionViewCell, indexPath: IndexPath) {
        let ex: Exercise = exercises[indexPath.item] as! Exercise
        cell.nameLabel.text = ex.name
        cell.typeLabel.text = ex.tags
        cell.showType(!ex.tags.isEmpty)
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        assert(indexPath.item < exercises.count,
               "Bad index when creating collection view")

        showExercise(indexPath: indexPath)
    }

    func showExercise(indexPath: IndexPath) {
        let ex: Exercise = exercises[indexPath.item] as! Exercise
        let viewController = ExerciseViewController()
        viewController.exercise = ex
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
