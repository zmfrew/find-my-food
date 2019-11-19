import UIKit

protocol SettingsCoordinatorProtocol: Coordinator {
    var navigationController: UINavigationController { get }
    var rootViewController: SettingsTableViewController { get }

    func start()
}

final class SettingsCoordinator: SettingsCoordinatorProtocol {
    private(set) var navigationController: UINavigationController
    private(set) var rootViewController: SettingsTableViewController
    weak var parentCoordinator: TabCoordinatorProtocol?

    init(navigationController: UINavigationController, parentCoordinator: TabCoordinatorProtocol) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
        self.rootViewController = SettingsTableViewController.instantiate()
    }

    func start() {
        rootViewController.coordinator = self
        let model = SettingsModel(radiusData: Radius.range, delegate: rootViewController, userDefaults: UserDefaultsWrapper())
        rootViewController.configure(with: model)
    }
}
