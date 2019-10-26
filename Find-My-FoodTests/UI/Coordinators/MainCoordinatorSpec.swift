import Quick
import Nimble

@testable import Find_My_Food

final class MainCoordinatorSpec: QuickSpec {
    override func spec() {
        var testObject: MainCoordinator!
        var navController: UINavigationController!
        
        beforeEach {
            navController = UINavigationController()
            testObject = MainCoordinator(navigationController: navController)
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = navController
            window.makeKeyAndVisible()
        }
        
        // MARK: - businessSelected(_ business: Business)
        describe("businessSelected(_ business: Business)") {
            it("pushes a BusinessDetailViewController on the navigation stack") {
                let business = TestData.businessesFromJson().first!
                
                testObject.businessSelected(business)
                
                let detailVC = testObject.navigationController.viewControllers.first(where: { $0 is BusinessDetailViewController}) as! BusinessDetailViewController
                
                expect(testObject.navigationController.viewControllers).toNot(beEmpty())
                expect(detailVC.coordinator).to(be(testObject))
            }
        }
        
        // MARK: - dismiss()
        describe("dismiss") {
            it("dismisses a modal presentation from the navigation stack") {
                let vc = UIViewController()
                testObject.navigationController.present(vc, animated: false)
                
                testObject.dismiss()
                
                expect(testObject.navigationController.viewControllers).to(beEmpty())
            }
        }
        
        // MARK: - downloadCompleted(with businesses: [Business])
        describe("downloadCompleted(with businesses: [Business])") {
            it("pushes a BusinessesViewController on the navigation stack and sets the coordinator") {
                let businesses = TestData.businessesFromJson()
                
                testObject.downloadCompleted(with: businesses)
                
                let businessesVC = testObject.navigationController.viewControllers.first(where: { $0 is BusinessesViewController}) as! BusinessesViewController
                
                expect(testObject.navigationController.viewControllers).toNot(beEmpty())
                expect(businessesVC.coordinator).to(be(testObject))
            }
        }
        
        // MARK: - pop()
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
        
        // MARK: - searchButtonTapped(latitude: Double, longitude: Double)
        describe("searchButtonTapped(latitude: Double, longitude: Double)") {
            context("given a MapViewController is in the navigation hierarchy") {
                it("pushes a BusinessSearchViewController on the navigation stack, sets the coordinator, and sets the delegate as the MapViewController") {
                    testObject.start()
                    
                    testObject.searchButtonTapped(latitude: 100, longitude: 100)
                    
                    let mapVC = testObject.navigationController.viewControllers.first(where: { $0 is MapViewController}) as! MapViewController
                    let businessSearchVC = testObject.navigationController.presentedViewController as! BusinessSearchViewController
                    
                    expect(businessSearchVC.coordinator).to(be(testObject))
                    expect(businessSearchVC.delegate).to(be(mapVC))
                }
            }
            
            context("given a MapViewController is NOT in the navigation hierarchy") {
                it("does NOT push a view controller on the navigation stack") {
                    testObject.searchButtonTapped(latitude: 100, longitude: 100)
                    
                    let mapVC = testObject.navigationController.viewControllers.first(where: { $0 is MapViewController}) as? MapViewController
                    
                    expect(mapVC).to(beNil())
                    expect(testObject.navigationController.viewControllers).to(beEmpty())
                }
            }
        }
        
        // MARK: - start()
        describe("start()") {
            it("pushes a MapViewController on the navigation stack and sets the coordinator") {
                testObject.start()
                
                let mapVC = testObject.navigationController.viewControllers.first(where: { $0 is MapViewController}) as! MapViewController
                
                expect(testObject.navigationController.viewControllers).toNot(beEmpty())
                expect(mapVC.coordinator).to(be(testObject))
            }
        }
        
    }
}