import Quick
import Nimble

@testable import Find_My_Food

final class IntExtensionSpec: QuickSpec {
    override func spec() {
        // MARK: - var milesToMeters: Int
        describe("milesToMeters: Int") {
            it("approximates 25 miles to 40,000 meters") {
                expect(25.milesToMeters).to(equal(40_000))
            }
            
            it("converts miles to meters") {
                expect(-1.milesToMeters).to(equal(-1609))
                expect(0.milesToMeters).to(equal(0))
            }
        }
    }
}
