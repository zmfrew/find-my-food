import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var coordinator: TabCoordinator?
    // TODO: - Setup app session & include user defaults
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let navigationController = UINavigationController()
        let tabController = UITabBarController()
        coordinator = TabCoordinator(navigationController: navigationController, tabController: tabController)

        let businessCoordinator = BusinessCoordinator(navigationController: navigationController, parentCoordinator: coordinator!)
        let settingsCoordinator = SettingsCoordinator(navigationController: navigationController, parentCoordinator: coordinator!)
        coordinator?.start(with: [businessCoordinator, settingsCoordinator])

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }
}
