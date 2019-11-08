import UIKit

protocol TabCoordinatorProtocol: class {
    var coordinators: [BusinessCoordinatorProtocol] { get }
    var navigationController: UINavigationController { get }
    var tabController: UITabBarController { get }

    func start(with coordinator: BusinessCoordinatorProtocol)
}

final class TabCoordinator: TabCoordinatorProtocol {
    private(set) var coordinators = [BusinessCoordinatorProtocol]()
    private(set) var navigationController: UINavigationController
    private(set) var tabController: UITabBarController

    init(navigationController: UINavigationController, tabController: UITabBarController) {
        self.navigationController = navigationController
        self.tabController = tabController
    }

    func start(with coordinator: BusinessCoordinatorProtocol) {
        navigationController.pushViewController(tabController, animated: true)
        coordinators.append(coordinator)

        coordinator.rootViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        tabController.viewControllers = [coordinator.rootViewController]
        coordinator.start()
    }
}
