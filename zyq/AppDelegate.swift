
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private enum NavigationTab: Int {
        case help
    }

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions:
        [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        configureAppearance()
        configureTabBarIcons()

        FeaturesService().storeAppVersion()
        
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
        let helpTabBarItem = tabBarController.tabBar.items?[NavigationTab.help.rawValue]
        helpTabBarItem?.title = "tab_bar_help_title".localized
        helpTabBarItem?.image = UIImage(named: "baseline_help_black_24pt")
        helpTabBarItem?.selectedImage = UIImage(named: "baseline_help_black_24pt")
    }
}
