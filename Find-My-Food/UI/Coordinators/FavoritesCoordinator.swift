import UIKit

protocol FavoritesCoordinatorProtocol: BusinessCoordinator {
    var navigationController: UINavigationController { get }
    var rootViewController: FavoritesViewController { get }

    func start()
}

final class FavoritesCoordinator: FavoritesCoordinatorProtocol {
    private(set) var navigationController: UINavigationController
    private(set) var rootViewController: FavoritesViewController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.prefersLargeTitles = true
        self.rootViewController = FavoritesViewController.instantiate()
    }

    func businessSelected(_ business: Business, isFavorite: Bool) {
        let vc = BusinessDetailViewController.instantiate()
        vc.coordinator = self
        let model = BusinessDetailModel(business: business,
                                        coreDataManager: UserSession.shared.coreDataManager,
                                        delegate: vc)
        vc.configure(with: model, isFavorite: isFavorite)
        navigationController.pushViewController(vc, animated: true)
    }

    func downloadCompleted(with businesses: [Business]) { }

    func location(for business: Business) {
        let vc = MapViewController.instantiate()
        vc.coordinator = self
        vc.hideSearchButton()
        vc.setBusinessLocation(business.location.displayAddress.joined(separator: ", "))
        navigationController.pushViewController(vc, animated: false)
    }

    func searchButtonTapped(latitude: Double?, longitude: Double?) { }

    func start() {
        rootViewController.coordinator = self
        navigationController.pushViewController(rootViewController, animated: true)
    }
}
