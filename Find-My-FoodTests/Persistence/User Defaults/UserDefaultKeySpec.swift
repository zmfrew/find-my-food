import Quick
import Nimble

@testable import Find_My_Food

final class UserDefaultKeySpec: QuickSpec {
    override func spec() {
        describe("radiusIndex key") {
            it("returns RadiusIndex string") {
                expect(UserDefaultKey.radiusIndex).to(equal("RadiusIndex"))
            }
        }
        
        describe("defaultLocation key") {
            it("returns DefaultLocation string") {
                expect(UserDefaultKey.defaultLocation).to(equal("DefaultLocation"))
            }
        }
    }
}
