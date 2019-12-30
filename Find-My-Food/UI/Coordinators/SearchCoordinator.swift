import CoreLocation
import UIKit

protocol SearchCoordinatorProtocol: BusinessCoordinator {
    var navigationController: UINavigationController { get }
    var rootViewController: MapViewController { get }

    func dismiss()
    func downloadDidBegin()
    func downloadDidEnd()
    func pop(_ animated: Bool)
    func start()
}

final class SearchCoordinator: SearchCoordinatorProtocol {
    private(set) var navigationController: UINavigationController
    private(set) var rootViewController: MapViewController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.rootViewController = MapViewController.instantiate()
    }

    func businessSelected(_ business: Business) {
        let vc = BusinessDetailViewController.instantiate()
        vc.coordinator = self
        vc.configure(with: business)
        navigationController.pushViewController(vc, animated: true)
    }

    func dismiss() {
        navigationController.dismiss(animated: true)
    }

    func downloadCompleted(with businesses: [Business]) {
        let vc = BusinessesViewController.instantiate()
        vc.coordinator = self
        let decoder = DecoderWrapper(decoder: JSONDecoder())
        let serviceClient = BaseServiceClient(urlSession: URLSessionWrapper())
        let businessSearchClient = BusinessSearchClient(decoder: decoder, serviceClient: serviceClient)
        let businessesModel = BusinessesModel(businesses: businesses,
                                              businessSearchClient: businessSearchClient,
                                              coreDataManager: UserSession.shared.coreDataManager,
                                              delegate: vc)
        vc.configure(with: businessesModel)
        navigationController.pushViewController(vc, animated: true)
    }

    func downloadDidBegin() {
        guard let businessSearchVC = navigationController.presentedViewController as? BusinessSearchViewController else { return }

        businessSearchVC.downloadDidBegin()
    }

    func downloadDidEnd() {
        guard let businessSearchVC = navigationController.presentedViewController as? BusinessSearchViewController else { return }

        businessSearchVC.downloadDidEnd()
    }

    func location(for business: Business) {
        let vc = MapViewController.instantiate()
        vc.coordinator = self
        vc.hideSearchButton()
        vc.setBusinessLocation(business.location.displayAddress.joined(separator: ", "))
        navigationController.pushViewController(vc, animated: false)
    }

    func pop(_ animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }

    func searchButtonTapped(latitude: Double, longitude: Double) {
        let vc = BusinessSearchViewController.instantiate()
        vc.coordinator = self
        vc.delegate = rootViewController
        vc.configure(latitude: latitude, longitude: longitude)

        navigationController.present(vc, animated: true)
    }

    func start() {
        rootViewController.coordinator = self
        navigationController.pushViewController(rootViewController, animated: true)
    }
}
