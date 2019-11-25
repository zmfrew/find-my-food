import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var appSession: AppSession!
    var window: UIWindow?
    // TODO: - Setup app session & include user defaults
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let coreDataStack = CoreDataStack()

        coreDataStack.createBusinessContainer { container in
            self.appSession = AppSession(persistentContainer: container)

            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = MainTabBarController()
            self.window?.makeKeyAndVisible()

        }

        return true
    }
}
