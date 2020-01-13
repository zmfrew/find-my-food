import Quick
import Nimble

@testable import Find_My_Food

final class SettingsCoordinatorSpec: QuickSpec {
    override func spec() {
        var testObject: SettingsCoordinator!
        var navController: UINavigationController!
        
        beforeEach {
            navController = UINavigationController()
            testObject = SettingsCoordinator(navigationController: navController)
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = navController
            window.makeKeyAndVisible()
        }
        
        // MARK: - func start()
        describe("start()") {
            it("sets the coordinator on the SettingsTableViewController and makes it the delegate of the model") {
                testObject.start()
                
                let settingsTVC = testObject.rootViewController
                
                expect(settingsTVC.coordinator).to(be(testObject))
            }
        }
    }
}
