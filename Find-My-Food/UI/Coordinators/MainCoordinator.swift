import UIKit

final class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    // TODO: - Use this class to display activity indicators and remove from other VC's.
    init(navigationController: UINavigationController) {
        // TODO: - Configure to style correctly.
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
        let businessesModel = BusinessesModel(businesses: businesses)
        vc.configure(with: businessesModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
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
