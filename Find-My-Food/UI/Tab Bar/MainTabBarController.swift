import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let businessCoordinator = BusinessCoordinator(navigationController: UINavigationController())
        let favoritesCoordinator = FavoritesCoordinator(navigationController: UINavigationController())
        let settingsCoordinator = SettingsCoordinator(navigationController: UINavigationController())

        start(with: [businessCoordinator, favoritesCoordinator, settingsCoordinator])
    }

    private func start(with coordinators: [Coordinator]) {
        let businessSearchCoordinator = coordinators.first(where: { $0 is BusinessCoordinatorProtocol }) as! BusinessCoordinatorProtocol //swiftlint:disable:this force_cast line_length
        businessSearchCoordinator.navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)

        let favoritesCoordinator = coordinators.first(where: { $0 is FavoritesCoordinatorProtocol }) as! FavoritesCoordinatorProtocol //swiftlint:disable:this force_cast line_length
        favoritesCoordinator.navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)

        let settingsCoordinator = coordinators.first(where: { $0 is SettingsCoordinatorProtocol }) as! SettingsCoordinatorProtocol //swiftlint:disable:this force_cast line_length
        settingsCoordinator.navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 2)

        viewControllers = [businessSearchCoordinator.navigationController,
                                         favoritesCoordinator.navigationController,
                                         settingsCoordinator.navigationController]

        businessSearchCoordinator.start()
        favoritesCoordinator.start()
        settingsCoordinator.start()
    }
}