
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UITabBarControllerDelegate {

    lazy var exerciseService = ExerciseService()

    var window: UIWindow?
    private(set) var navigationTab : NavigationTab? = .stage1

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions:
        [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        configureAppearance()
        configureTabBarIcons()

        FeaturesService().storeAppVersion()
        exerciseService.load()
        return true
    }

    // MARK: UITabBarControllerDelegate

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController:
        UIViewController) {
        navigationTab = NavigationTab(rawValue: tabBarController.selectedIndex);
    }

    private func configureAppearance() {
        UITabBar.appearance().barTintColor = UIColor.skinColor
        UITabBar.appearance().tintColor = UIColor.black
        UINavigationBar.appearance().barTintColor = UIColor.darkSkinColor
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barStyle = .black
    }

    private func configureTabBarIcons() {
        guard let tabBarController = window?.rootViewController as? UITabBarController else {
            assertionFailure("Failed to get tab bar controller")
            return
        }
        tabBarController.delegate = self

        let image1 = UIImage(named: "red_ball")?.withRenderingMode(.alwaysOriginal)
        let image1dis = UIImage(named: "red_ball_dis")?.withRenderingMode(.alwaysOriginal)
        let stage1TabBarItem = tabBarController.tabBar.items?[NavigationTab.stage1.rawValue]
        stage1TabBarItem?.title = "tab_bar_stage1_title".localized
        stage1TabBarItem?.image = image1dis
        stage1TabBarItem?.selectedImage = image1

        let image2 = UIImage(named: "yellow_ball")?.withRenderingMode(.alwaysOriginal)
        let image2dis = UIImage(named: "yellow_ball_dis")?.withRenderingMode(.alwaysOriginal)
        let stage2TabBarItem = tabBarController.tabBar.items?[NavigationTab.stage2.rawValue]
        stage2TabBarItem?.title = "tab_bar_stage2_title".localized
        stage2TabBarItem?.image = image2dis
        stage2TabBarItem?.selectedImage = image2

        let image3dis = UIImage(named: "green_ball_dis")?.withRenderingMode(.alwaysOriginal)
        let image3 = UIImage(named: "green_ball")?.withRenderingMode(.alwaysOriginal)
        let stage3TabBarItem = tabBarController.tabBar.items?[NavigationTab.stage3.rawValue]
        stage3TabBarItem?.title = "tab_bar_stage3_title".localized
        stage3TabBarItem?.image = image3dis
        stage3TabBarItem?.selectedImage = image3

        let audioTabBarItem = tabBarController.tabBar.items?[NavigationTab.audio.rawValue]
        audioTabBarItem?.title = "tab_bar_audio_title".localized
        audioTabBarItem?.image = UIImage(named: "music_icon")
        audioTabBarItem?.selectedImage = UIImage(named: "music_icon")

        let helpTabBarItem = tabBarController.tabBar.items?[NavigationTab.help.rawValue]
        helpTabBarItem?.title = "tab_bar_help_title".localized
        helpTabBarItem?.image = UIImage(named: "baseline_help_black_24pt")
        helpTabBarItem?.selectedImage = UIImage(named: "baseline_help_black_24pt")
    }
}
