import UIKit

protocol TabCoordinatorProtocol: Coordinator {
    var coordinators: [Coordinator] { get }
    var navigationController: UINavigationController { get }
    var tabController: UITabBarController { get }

    func start(with coordinators: [Coordinator])
}

final class TabCoordinator: TabCoordinatorProtocol {
    private(set) var coordinators = [Coordinator]()
    private(set) var navigationController: UINavigationController
    private(set) var tabController: UITabBarController

    init(navigationController: UINavigationController, tabController: UITabBarController) {
        self.navigationController = navigationController
        self.tabController = tabController
    }

    func start(with coordinators: [Coordinator]) {
        navigationController.pushViewController(tabController, animated: true)
        self.coordinators += coordinators

        let businessSearchCoordinator = coordinators.first(where: { $0 is BusinessCoordinatorProtocol }) as! BusinessCoordinatorProtocol //swiftlint:disable:this force_cast line_length
        businessSearchCoordinator.rootViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)

        let settingsCoordinator = coordinators.first(where: { $0 is SettingsCoordinatorProtocol }) as! SettingsCoordinatorProtocol //swiftlint:disable:this force_cast line_length
        settingsCoordinator.rootViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)

        tabController.viewControllers = [businessSearchCoordinator.rootViewController, settingsCoordinator.rootViewController]

        businessSearchCoordinator.start()
        settingsCoordinator.start()
    }
}
