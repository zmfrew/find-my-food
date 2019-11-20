import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var coordinator: TabCoordinator!
    var appSession: AppSession!
    var window: UIWindow?
    // TODO: - Setup app session & include user defaults
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let coreDataStack = CoreDataStack()

        coreDataStack.createBusinessContainer { container in
            self.appSession = AppSession(persistentContainer: container)

            let navigationController = UINavigationController()
            let tabController = UITabBarController()
            self.coordinator = TabCoordinator(navigationController: navigationController, tabController: tabController)

            let businessCoordinator = BusinessCoordinator(navigationController: navigationController, parentCoordinator: self.coordinator!)
            let settingsCoordinator = SettingsCoordinator(navigationController: navigationController, parentCoordinator: self.coordinator!)
            let favoritesCoordinator = FavoritesCoordinator(navigationController: navigationController, parentCoordinator: self.coordinator!)
            self.coordinator?.start(with: [businessCoordinator, settingsCoordinator, favoritesCoordinator])

            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()

        }

        return true
    }
}
