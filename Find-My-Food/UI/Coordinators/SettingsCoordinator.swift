import UIKit

protocol SettingsCoordinatorProtocol: Coordinator {
    var navigationController: UINavigationController { get }
    var rootViewController: SettingsTableViewController { get }

    func start()
}

final class SettingsCoordinator: SettingsCoordinatorProtocol {
    private(set) var navigationController: UINavigationController
    private(set) var rootViewController: SettingsTableViewController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.prefersLargeTitles = true
        self.rootViewController = SettingsTableViewController.instantiate()
    }

    func start() {
        rootViewController.coordinator = self
        let model = SettingsModel(radiusData: Radius.range, delegate: rootViewController, userDefaults: UserDefaultsWrapper())
        rootViewController.configure(with: model)
        navigationController.pushViewController(rootViewController, animated: true)
    }
}
