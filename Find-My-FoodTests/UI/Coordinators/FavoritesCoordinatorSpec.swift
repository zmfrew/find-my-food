import Quick
import Nimble

@testable import Find_My_Food

final class FavoritesCoordinatorSpec: QuickSpec {
    override func spec() {
        var testObject: FavoritesCoordinator!
        var navController: UINavigationController!
        
        beforeEach {
            navController = UINavigationController()
            testObject = FavoritesCoordinator(navigationController: navController)
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = navController
            window.makeKeyAndVisible()
        }
        
        // MARK: - func businessSelected(_ business: Business)
        describe("businessSelected(_ business: Business)") {
            it("pushes a BusinessDetailViewController on the navigation stack") {
                let business = TestData.businessesFromJson().first!
                
                testObject.businessSelected(business, isFavorite: false)
                
                let detailVC = testObject.navigationController.viewControllers.first(where: { $0 is BusinessDetailViewController}) as! BusinessDetailViewController
                
                expect(testObject.navigationController.viewControllers).toNot(beEmpty())
                expect(detailVC.coordinator).to(be(testObject))
            }
        }
        
        // MARK: - func location(for business: Business)
        describe("locationButtonTapped(_ business: Business)") {
            it("pushes a MapViewController on the navigation stack and sets the coordinator") {
                let business = TestData.createBusiness()
                
                testObject.location(for: business)
                
                let mapVC = testObject.navigationController.viewControllers.first(where: { $0 is MapViewController}) as! MapViewController
                expect(testObject.navigationController.viewControllers).toNot(beEmpty())
                expect(mapVC.coordinator).to(be(testObject))
            }
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
