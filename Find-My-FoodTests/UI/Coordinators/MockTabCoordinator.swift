import UIKit

@testable import Find_My_Food

final class MockTabCoordinator: TabCoordinatorProtocol {
    
    final class Stub {
        var coordinatorsShouldReturn = [Coordinator]()
        var navigationControllerShouldReturn = UINavigationController()
        var tabControllerShouldReturn = UITabBarController()
        var startCalledWith = [[Coordinator]]()
    }
    
    var stub = Stub()
    
    var coordinators: [Coordinator] {
        stub.coordinatorsShouldReturn
    }
    
    var navigationController: UINavigationController {
        stub.navigationControllerShouldReturn
    }
    
    var tabController: UITabBarController {
        stub.tabControllerShouldReturn
    }
    
    func start(with coordinators: [Coordinator]) {
        stub.startCalledWith.append(coordinators)
    }
}
