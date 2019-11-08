import Quick
import Nimble

@testable import Find_My_Food

final class TabCoordinatorSpec: QuickSpec {
    override func spec() {
        var testObject: TabCoordinator!
        var mockBusinessCoordinator: MockBusinessCoordinator!
        var navigationController: UINavigationController!
        var tabController: UITabBarController!
        
        beforeEach {
            mockBusinessCoordinator = MockBusinessCoordinator()
            mockBusinessCoordinator.stub.rootViewControllerShouldReturn.view = MapView()
            navigationController = UINavigationController()
            tabController = UITabBarController()
            testObject = TabCoordinator(navigationController: navigationController, tabController: tabController)
        }
        
        // MARK: - func start()
        describe("start()") {
            it("pushes the tabController on the navigation stack") {
                testObject.start(with: mockBusinessCoordinator)
                
                expect(navigationController.viewControllers.contains(tabController)).to(beTrue())
            }
            
            it("appends the BusinessCoordinator to the coordinators array") {
                testObject.start(with: mockBusinessCoordinator)
                
                let actualBusinessCoordinator = testObject.coordinators.first
                
                expect(testObject.coordinators.count).to(equal(1))
                expect(actualBusinessCoordinator?.navigationController).to(equal(mockBusinessCoordinator.navigationController))
                expect(actualBusinessCoordinator?.rootViewController).to(equal(mockBusinessCoordinator.rootViewController))
            }
            
            it("sets a tab bar item with the root view controller in the BusinessCoordinator and calls start") {
                testObject.start(with: mockBusinessCoordinator)
                
                expect(tabController.viewControllers).to(contain(mockBusinessCoordinator.rootViewController))
                expect(tabController.tabBar.items).to(contain(mockBusinessCoordinator.rootViewController.tabBarItem))
                expect(mockBusinessCoordinator.stub.startCallCount).to(equal(1))
            }
        }
    }
}
