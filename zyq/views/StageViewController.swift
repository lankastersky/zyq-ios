import UIKit

/// Shows exercises groups for the given stage.
/// May be it's better to use tableview instead but I couldn't make it work with adjusted height.
final class StageViewController: ListViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard let tabBarController = self.appDelegate.window?.rootViewController as?
            UITabBarController else {
            assertionFailure("Failed to get tab bar controller")
            return
        }

        let stage = tabBarController.selectedIndex;
        var headerImage: UIImage?
        switch(stage) {
        case NavigationTab.stage1.rawValue:
            navigationItem.title = "stage1_screen_title".localized
            headerImage = UIImage(named: "header_stage1")
            break
        case NavigationTab.stage2.rawValue:
            navigationItem.title = "stage2_screen_title".localized
            headerImage = UIImage(named: "header_stage2")
            break
        case NavigationTab.stage3.rawValue:
            navigationItem.title = "stage3_screen_title".localized
            headerImage = UIImage(named: "header_stage3")
            break
        default:
            break
        }
        guard let aLevel = LevelType(rawValue: stage + 1) else {
            return
        }
        level = aLevel
        exercises = self.exerciseService.buildExerciseGroups(level: level)
        descriptionUrl = exerciseService.getPracticeDescription(level: level)
        initBarItems()
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
            UINavigationBar.appearance().barTintColor = UIColor(patternImage: headerImage!)
//            self.navigationController?.navigationBar.layer.contents = headerImage!.cgImage
//            self.navigationController?.navigationBar.barTintColor =
//                UIColor(patternImage: headerImage!)
        }
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
