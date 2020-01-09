import UIKit

@testable import Find_My_Food

final class MockSettingsCoordinator: SettingsCoordinatorProtocol {
    final class Stub {
        var startCallCount = 0
        var statusBarCallCount: Int { statusBarCalledWith.count }
        var statusBarCalledWith = [UIColor]()
        var navigationControllerShouldReturn = UINavigationController()
        var rootViewControllerShouldReturn = SettingsTableViewController()
    }
    
    var stub = Stub()
    
    var navigationController: UINavigationController {
        stub.navigationControllerShouldReturn
    }
    
    var rootViewController: SettingsTableViewController {
        stub.rootViewControllerShouldReturn
    }
        
    func start() {
        stub.startCallCount += 1
    }
    
    func statusBar(backgroundColor: UIColor) {
        stub.statusBarCalledWith.append(backgroundColor)
    }
}
