import UIKit

@testable import Find_My_Food

final class MockBusinessCoordinator: BusinessCoordinatorProtocol {
    final class Stub {
        var navigationControllerShouldReturn: UINavigationController = UINavigationController()
        var rootViewControllerShouldReturn: MapViewController = MapViewController()
        var startCallCount = 0
    }
    
    var stub = Stub()
    
    var navigationController: UINavigationController {
        stub.navigationControllerShouldReturn
    }
    
    var rootViewController: MapViewController {
        stub.rootViewControllerShouldReturn
    }
    
    func start() {
        stub.startCallCount += 1
    }
}
