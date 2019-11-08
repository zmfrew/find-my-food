import UIKit

protocol TabCoordinatorProtocol: class {
    var coordinators: [BusinessCoordinator] { get set }
    var navigationController: UINavigationController { get set }
    var tabController: UITabBarController { get set }

    func start()
}
// TODO: - Write tests.
final class TabCoordinator: TabCoordinatorProtocol {
    var coordinators = [BusinessCoordinator]()
    var navigationController: UINavigationController
    var tabController: UITabBarController

    init(navigationController: UINavigationController, tabController: UITabBarController) {
        self.navigationController = navigationController
        self.tabController = tabController
    }

    func start() {
        navigationController.pushViewController(tabController, animated: true)
        let businessCoordinator = BusinessCoordinator(navigationController: navigationController, parentCoordinator: self)
        coordinators.append(businessCoordinator)

        businessCoordinator.rootViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        tabController.viewControllers = [businessCoordinator.rootViewController]

        businessCoordinator.start()
    }
}
