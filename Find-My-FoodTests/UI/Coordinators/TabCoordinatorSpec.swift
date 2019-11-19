import Quick
import Nimble

@testable import Find_My_Food

final class TabCoordinatorSpec: QuickSpec {
    override func spec() {
        var testObject: TabCoordinator!
        var mockBusinessCoordinator: MockBusinessCoordinator!
        var mockFavoritesCoordinator: MockFavoritesCoordinator!
        var mockSettingsCoordinator: MockSettingsCoordinator!
        var navigationController: UINavigationController!
        var tabController: UITabBarController!
        
        beforeEach {
            mockBusinessCoordinator = MockBusinessCoordinator()
            mockFavoritesCoordinator = MockFavoritesCoordinator()
            mockSettingsCoordinator = MockSettingsCoordinator()
            mockBusinessCoordinator.stub.rootViewControllerShouldReturn.view = MapView()
            navigationController = UINavigationController()
            tabController = UITabBarController()
            testObject = TabCoordinator(navigationController: navigationController, tabController: tabController)
        }
        
        // MARK: - func start()
        describe("start()") {
            it("pushes the tabController on the navigation stack") {
                testObject.start(with: [mockBusinessCoordinator, mockFavoritesCoordinator, mockSettingsCoordinator])
                
                expect(navigationController.viewControllers.contains(tabController)).to(beTrue())
            }
            
            it("appends the coordinators to the coordinators array") {
                testObject.start(with: [mockBusinessCoordinator, mockFavoritesCoordinator, mockSettingsCoordinator])
                
                let actualBusinessCoordinator = testObject.coordinators.first(where: { $0 is BusinessCoordinatorProtocol }) as! BusinessCoordinatorProtocol
                let actualFavoritesCoordinator = testObject.coordinators.first(where: { $0 is FavoritesCoordinatorProtocol }) as! FavoritesCoordinatorProtocol
                let actualSettingsCoordinator = testObject.coordinators.first(where: { $0 is SettingsCoordinatorProtocol }) as! SettingsCoordinatorProtocol
                
                expect(testObject.coordinators.count).to(equal(3))
                expect(actualBusinessCoordinator.navigationController).to(equal(mockBusinessCoordinator.navigationController))
                expect(actualBusinessCoordinator.rootViewController).to(equal(mockBusinessCoordinator.rootViewController))
                
                expect(actualFavoritesCoordinator.navigationController).to(equal(mockFavoritesCoordinator.navigationController))
                expect(actualFavoritesCoordinator.rootViewController).to(equal(mockFavoritesCoordinator.rootViewController))
                
                expect(actualSettingsCoordinator.navigationController).to(equal(mockSettingsCoordinator.navigationController))
                expect(actualSettingsCoordinator.rootViewController).to(equal(mockSettingsCoordinator.rootViewController))
            }
            
            it("sets tab bar items with root view controllers and calls start on all coordinators") {
                testObject.start(with: [mockBusinessCoordinator, mockFavoritesCoordinator, mockSettingsCoordinator])
                
                expect(tabController.viewControllers).to(contain(mockBusinessCoordinator.rootViewController))
                expect(tabController.tabBar.items).to(contain(mockBusinessCoordinator.rootViewController.tabBarItem))
                expect(mockBusinessCoordinator.rootViewController.tabBarItem.tag).to(equal(0))
                expect(mockBusinessCoordinator.stub.startCallCount).to(equal(1))
                
                expect(tabController.viewControllers).to(contain(mockFavoritesCoordinator.rootViewController))
                expect(tabController.tabBar.items).to(contain(mockFavoritesCoordinator.rootViewController.tabBarItem))
                expect(mockFavoritesCoordinator.rootViewController.tabBarItem.tag).to(equal(1))
                expect(mockBusinessCoordinator.stub.startCallCount).to(equal(1))
                
                expect(tabController.viewControllers).to(contain(mockSettingsCoordinator.rootViewController))
                expect(tabController.tabBar.items).to(contain(mockSettingsCoordinator.rootViewController.tabBarItem))
                expect(mockSettingsCoordinator.rootViewController.tabBarItem.tag).to(equal(2))
                expect(mockSettingsCoordinator.stub.startCallCount).to(equal(1))
            }
        }
    }
}
