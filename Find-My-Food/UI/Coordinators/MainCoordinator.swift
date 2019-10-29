import UIKit

final class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
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
        let serviceClient = BaseServiceClient(urlSession: URLSessionWrapper())
        let businessSearchClient = BusinessSearchClient(serviceClient: serviceClient)
        let businessesModel = BusinessesModel(businesses: businesses, businessSearchClient: businessSearchClient, delegate: vc)
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
    
    func locationButtonTapped() {
        let vc = MapViewController.instantiate()
        vc.coordinator = self
        vc.hideSearchButton()
        navigationController.pushViewController(vc, animated: false)
    }
    
    func pop(_ animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
    
    func searchButtonTapped(latitude: Double, longitude: Double) {
        guard let mapVC = navigationController.viewControllers.first(where: { $0 is MapViewController }) as? MapViewController else { return }

        let vc = BusinessSearchViewController.instantiate()
        vc.coordinator = self
        vc.delegate = mapVC
        vc.configure(latitude: latitude, longitude: longitude)
        
        navigationController.present(vc, animated: true)
    }
    
    func start() {
        let vc = MapViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
}
