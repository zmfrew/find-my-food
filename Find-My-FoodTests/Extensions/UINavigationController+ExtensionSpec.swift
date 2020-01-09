import Quick
import Nimble

@testable import Find_My_Food

final class UINavigationControllerExtensionSpec: QuickSpec {
    override func spec() {
        // MARK: - func statusBar(backgroundColor: UIColor)
        describe("statusBar(backgroundColor: UIColor)") {
            it("adds a subview to the navigation controller with the color provided") {
                let navController = UINavigationController()
                navController.statusBar(backgroundColor: .blue)
                
                expect(navController.view.subviews.contains(where: { $0.backgroundColor == .blue })).to(beTrue())
            }
        }
    }
}
