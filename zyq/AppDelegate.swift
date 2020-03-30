
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var exerciseService = ExerciseService()

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions:
        [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        configureAppearance()
        configureTabBarIcons()

        FeaturesService().storeAppVersion()
        exerciseService.load()
        return true
    }

    private func configureAppearance() {
        UITabBar.appearance().barTintColor = UIColor.skinColor
        UITabBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = UIColor.skinColor
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barStyle = .black
    }

    private func configureTabBarIcons() {
        guard let tabBarController = window?.rootViewController as? UITabBarController else {
            assertionFailure("Failed to get tab bar controller")
            return
        }
        let stage1TabBarItem = tabBarController.tabBar.items?[NavigationTab.stage1.rawValue]
        stage1TabBarItem?.title = "tab_bar_stage1_title".localized
        stage1TabBarItem?.image = UIImage(named: "baseline_help_black_24pt")
        stage1TabBarItem?.selectedImage = UIImage(named: "baseline_help_black_24pt")

        let stage2TabBarItem = tabBarController.tabBar.items?[NavigationTab.stage2.rawValue]
        stage2TabBarItem?.title = "tab_bar_stage2_title".localized
        stage2TabBarItem?.image = UIImage(named: "baseline_help_black_24pt")
        stage2TabBarItem?.selectedImage = UIImage(named: "baseline_help_black_24pt")

        let stage3TabBarItem = tabBarController.tabBar.items?[NavigationTab.stage3.rawValue]
        stage3TabBarItem?.title = "tab_bar_stage3_title".localized
        stage3TabBarItem?.image = UIImage(named: "baseline_help_black_24pt")
        stage3TabBarItem?.selectedImage = UIImage(named: "baseline_help_black_24pt")

        let helpTabBarItem = tabBarController.tabBar.items?[NavigationTab.help.rawValue]
        helpTabBarItem?.title = "tab_bar_help_title".localized
        helpTabBarItem?.image = UIImage(named: "baseline_help_black_24pt")
        helpTabBarItem?.selectedImage = UIImage(named: "baseline_help_black_24pt")
    }
}
