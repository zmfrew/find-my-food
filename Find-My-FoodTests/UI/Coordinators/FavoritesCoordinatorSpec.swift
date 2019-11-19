import Quick
import Nimble

@testable import Find_My_Food

final class FavoritesCoordinatorSpec: QuickSpec {
    override func spec() {
        var testObject: FavoritesCoordinator!
        var navController: UINavigationController!
        var mockTabCoordinator: MockTabCoordinator!
        
        beforeEach {
            navController = UINavigationController()
            mockTabCoordinator = MockTabCoordinator()
            testObject = FavoritesCoordinator(navigationController: navController, parentCoordinator: mockTabCoordinator)
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = navController
            window.makeKeyAndVisible()
        }
        
        // MARK: - func start()
        describe("start()") {
            it("sets the coordinator on the FavoritesViewController and makes it the delegate of the model") {
                testObject.start()
                
                let favoritesVC = testObject.rootViewController
                
                expect(favoritesVC.coordinator).to(be(testObject))
            }
        }
    }
}
