import UIKit

protocol FavoritesCoordinatorProtocol: Coordinator {
    var navigationController: UINavigationController { get }
    var rootViewController: FavoritesViewController { get }

    func start()
}

final class FavoritesCoordinator: FavoritesCoordinatorProtocol {
    private(set) var navigationController: UINavigationController
    private(set) var rootViewController: FavoritesViewController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.rootViewController = FavoritesViewController.instantiate()
    }

    func start() {
        rootViewController.coordinator = self
        navigationController.pushViewController(rootViewController, animated: true)
    }
}
