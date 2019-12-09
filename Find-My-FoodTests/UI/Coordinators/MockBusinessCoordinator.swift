import UIKit

@testable import Find_My_Food

final class MockBusinessCoordinator: SearchCoordinatorProtocol {
    
    final class Stub {
        var navigationControllerShouldReturn = UINavigationController()
        var rootViewControllerShouldReturn = MapViewController()
        var startCallCount = 0
    }
    
    var stub = Stub()
    
    var navigationController: UINavigationController {
        stub.navigationControllerShouldReturn
    }
    
    var rootViewController: MapViewController {
        stub.rootViewControllerShouldReturn
    }

    func businessSelected(_ business: Business) { }
    
    func dismiss() { }
    
    func downloadCompleted(with businesses: [Business]) { }
    
    func downloadDidBegin() { }
    
    func downloadDidEnd() { }
    
    func locationButtonTapped(_ business: Business) { }
    
    func pop(_ animated: Bool) { }
    
    func searchButtonTapped(latitude: Double, longitude: Double) { }
    
    func start() {
        stub.startCallCount += 1
    }
}
