import UIKit

@testable import Find_My_Food

final class MockFavoritesCoordinator: FavoritesCoordinatorProtocol {
    final class Stub {
        var startCallCount = 0
        var navigationControllerShouldReturn = UINavigationController()
        var rootViewControllerShouldReturn = FavoritesViewController()
    }
    
    var stub = Stub()
    
    var navigationController: UINavigationController {
        stub.navigationControllerShouldReturn
    }
    
    var rootViewController: FavoritesViewController {
        stub.rootViewControllerShouldReturn
    }
        
    func start() {
        stub.startCallCount += 1
    }
}
