import Quick
import Nimble

@testable import Find_My_Food

final class BusinessModelSpec: QuickSpec {
    override func spec() {
        let businesses = TestData.businessesFromJson()
        let testObject = BusinessesModel(businesses: businesses)
        
        // MARK: - businessCount: Int
        describe("businessCount: Int") {
            it("returns correct number of businesses") {
                expect(testObject.businessCount).to(equal(3))
            }
        }
        
        // MARK: - business(for row: Int) -> Business?
        describe("business(for row: Int) -> Business?") {
            context("given a valid index") {
                it("returns the expected business") {
                    expect(testObject.business(for: 0)).to(equal(businesses.first))
                    expect(testObject.business(for: businesses.count - 1)).to(equal(businesses.last))
                }
            }
            
            context("given an invalid index") {
                it("returns nil") {
                    expect(testObject.business(for: 1000000)).to(beNil())
                    expect(testObject.business(for: -1)).to(beNil())
                }
            }
        }
    }
}
