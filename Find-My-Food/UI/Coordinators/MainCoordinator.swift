import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        // TODO: - Configure to style correctly.
        self.navigationController = navigationController
    }

    func start() {
        let vc = MapViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
}
