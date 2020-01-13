import Quick
import Nimble

@testable import Find_My_Food

final class UIColorExtensionSpec: QuickSpec {
    override func spec() {
        // MARK: - static let background
        describe("background") {
            it("is UIColor.systemGray6") {
                expect(UIColor.background).to(equal(UIColor.systemGray6))
            }
        }
    }
}
