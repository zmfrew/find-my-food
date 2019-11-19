import UIKit

protocol FavoritesCoordinatorProtocol: Coordinator {
    var navigationController: UINavigationController { get }
    var rootViewController: FavoritesViewController { get }

    func start()
}

final class FavoritesCoordinator: FavoritesCoordinatorProtocol {
    private(set) var navigationController: UINavigationController
     private(set) var rootViewController: FavoritesViewController
     weak var parentCoordinator: TabCoordinatorProtocol?

     init(navigationController: UINavigationController, parentCoordinator: TabCoordinatorProtocol) {
         self.navigationController = navigationController
         self.parentCoordinator = parentCoordinator
         self.rootViewController = FavoritesViewController.instantiate()
     }

     func start() {
         rootViewController.coordinator = self
     }
}
