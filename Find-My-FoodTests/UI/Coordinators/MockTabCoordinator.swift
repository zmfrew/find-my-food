import UIKit

@testable import Find_My_Food

final class MockTabCoordinator: TabCoordinatorProtocol {
    final class Stub {
        var coordinatorsShouldReturn = [BusinessCoordinatorProtocol]()
        var navigationControllerShouldReturn = UINavigationController()
        var tabControllerShouldReturn = UITabBarController()
        var startCalledWith = [BusinessCoordinatorProtocol]()
    }
    
    var stub = Stub()
    
    var coordinators: [BusinessCoordinatorProtocol] {
        stub.coordinatorsShouldReturn
    }
    
    var navigationController: UINavigationController {
        stub.navigationControllerShouldReturn
    }
    
    var tabController: UITabBarController {
        stub.tabControllerShouldReturn
    }
    
    func start(with coordinator: BusinessCoordinatorProtocol) {
        stub.startCalledWith.append(coordinator)
    }
}
