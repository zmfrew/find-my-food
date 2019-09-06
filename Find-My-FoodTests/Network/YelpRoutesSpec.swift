import Quick
import Nimble

@testable import Find_My_Food

final class YelpRoutesSpec: QuickSpec {
    override func spec() {
        describe("businessSearch variable") {
            it("returns correct url") {
                let expectedUrl = URL(string: "https://api.yelp.com/v3/businesses/search")!
                expect(YelpRoutes.businessSearch).to(equal(expectedUrl))
            }
        }
    }
}
