import Quick
import Nimble

@testable import Find_My_Food

final class BusinessCoordinatorSpec: QuickSpec {
    override func spec() {
        var testObject: BusinessCoordinator!
        var navController: UINavigationController!
        var mockTabCoordinator: MockTabCoordinator!
        
        beforeEach {
            navController = UINavigationController()
            mockTabCoordinator = MockTabCoordinator()
            testObject = BusinessCoordinator(navigationController: navController, parentCoordinator: mockTabCoordinator)
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = navController
            window.makeKeyAndVisible()
        }
        
        // MARK: - func businessSelected(_ business: Business)
        describe("businessSelected(_ business: Business)") {
            it("pushes a BusinessDetailViewController on the navigation stack") {
                let business = TestData.businessesFromJson().first!
                
                testObject.businessSelected(business)
                
                let detailVC = testObject.navigationController.viewControllers.first(where: { $0 is BusinessDetailViewController}) as! BusinessDetailViewController
                
                expect(testObject.navigationController.viewControllers).toNot(beEmpty())
                expect(detailVC.coordinator).to(be(testObject))
            }
        }
        
        // MARK: - func dismiss()
        describe("dismiss") {
            it("dismisses a modal presentation from the navigation stack") {
                let vc = UIViewController()
                testObject.navigationController.present(vc, animated: false)
                
                testObject.dismiss()
                
                expect(testObject.navigationController.viewControllers).to(beEmpty())
            }
        }
        
        // MARK: - func downloadCompleted(with businesses: [Business])
        describe("downloadCompleted(with businesses: [Business])") {
            it("pushes a BusinessesViewController on the navigation stack and sets the coordinator") {
                let businesses = TestData.businessesFromJson()
                
                testObject.downloadCompleted(with: businesses)
                
                let businessesVC = testObject.navigationController.viewControllers.first(where: { $0 is BusinessesViewController}) as! BusinessesViewController
                let serviceClient = BaseServiceClient(urlSession: URLSessionWrapper())
                let businessSearchClient = BusinessSearchClient(serviceClient: serviceClient)
                let businessesModel = BusinessesModel(businesses: businesses, businessSearchClient: businessSearchClient, delegate: businessesVC)
               
                expect(businessesModel.delegate).to(be(businessesVC))
                expect(testObject.navigationController.viewControllers).toNot(beEmpty())
                expect(businessesVC.coordinator).to(be(testObject))
            }
        }
        
        // MARK: - func locationButtonTapped(_ business: Business)
        describe("locationButtonTapped(_ business: Business)") {
            it("pushes a MapViewController on the navigation stack and sets the coordinator") {
                let business = TestData.createBusiness()
                
                testObject.locationButtonTapped(business)
                
                let mapVC = testObject.navigationController.viewControllers.first(where: { $0 is MapViewController}) as! MapViewController
                expect(testObject.navigationController.viewControllers).toNot(beEmpty())
                expect(mapVC.coordinator).to(be(testObject))
            }
        }
        
        // MARK: - func pop()
        describe("pop()") {
            it("pops the top view controller off the navigation stack and sets the coordinator") {
                let vc1 = BusinessDetailViewController()
                let vc2 = BusinessesViewController()
                testObject.navigationController.pushViewController(vc1, animated: false)
                testObject.navigationController.pushViewController(vc2, animated: false)

                expect(testObject.navigationController.viewControllers.count).to(equal(2))
                
                testObject.pop(false)
                
                expect(testObject.navigationController.viewControllers.count).to(equal(1))
            }
        }
        
        // MARK: - func searchButtonTapped(latitude: Double, longitude: Double)
        describe("searchButtonTapped(latitude: Double, longitude: Double)") {
            it("pushes a BusinessSearchViewController on the navigation stack, sets the coordinator, and sets the delegate as the MapViewController") {
                testObject.start()
                
                testObject.searchButtonTapped(latitude: 100, longitude: 100)
                
                let mapVC = testObject.rootViewController
                let businessSearchVC = testObject.navigationController.presentedViewController as! BusinessSearchViewController
                
                expect(businessSearchVC.coordinator).to(be(testObject))
                expect(businessSearchVC.delegate).to(be(mapVC))
            }
        }
        
        // MARK: - func start()
        describe("start()") {
            it("sets the coordinator on the MapViewController") {
                testObject.start()
                
                let mapVC = testObject.rootViewController
                
                expect(mapVC.coordinator).to(be(testObject))
            }
        }
    }
}
