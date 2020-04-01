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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBarAppearance()
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

    private func setupNavigationBarAppearance() {
        var headerImage: UIImage?
        switch(level) {
        case .first:
            headerImage = UIImage(named: "header_stage1")
            break
        case .second:
            headerImage = UIImage(named: "header_stage2")
            break
        case .third:
            headerImage = UIImage(named: "header_stage3")
            break
        default:
            break
        }

//        let resizedImage = headerImage!.resizableImage(withCapInsets:
//            UIEdgeInsets(top: 0, left: 100, bottom: 0, right: 100), resizingMode: .stretch)
//        self.navigationController?.navigationBar.barTintColor = UIColor(patternImage: headerImage!)

        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            //appearance.backgroundColor = .purple
            appearance.backgroundImage = headerImage
            appearance.backgroundImageContentMode = UIView.ContentMode.scaleAspectFill
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
//            UINavigationBar.appearance().barTintColor = UIColor(patternImage: headerImage!)
//            self.navigationController?.navigationBar.layer.contents = headerImage!.cgImage
            self.navigationController?.navigationBar.barTintColor =
                UIColor(patternImage: headerImage!)
        }
    }
}
