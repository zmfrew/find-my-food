import Quick
import Nimble

@testable import Find_My_Food

final class BusinessSpec: QuickSpec {
    override func spec() {
        describe("init(from decoder:)") {
            it("decodes properly") {
                let businesses = TestData.businessesFromJson()
                
                let firstBusiness = businesses.first!
                expect(firstBusiness.id).to(equal("FmGF1B-Rpsjq1f5b56qMwg"))
                expect(firstBusiness.alias).to(equal("molinari-delicatessen-san-francisco"))
                expect(firstBusiness.name).to(equal("Molinari Delicatessen"))
                expect(firstBusiness.imageUrlString).to(equal("https://s3-media3.fl.yelpcdn.com/bphoto/6He-NlZrAv2mDV-yg6jW3g/o.jpg"))
                expect(firstBusiness.isClosed).to(beFalse())
                expect(firstBusiness.urlString).to(equal("https://www.yelp.com/biz/molinari-delicatessen-san-francisco?adjust_creative=kzhjn27Bx3CErspNt_sViA&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=kzhjn27Bx3CErspNt_sViA"))
                expect(firstBusiness.reviewCount).to(equal(1063))
                expect(firstBusiness.categories.first!.alias).to(equal("delis"))
                expect(firstBusiness.categories.first!.title).to(equal("Delis"))
                expect(firstBusiness.rating).to(equal(4.5))
                expect(firstBusiness.coordinates.latitude).to(equal(37.79838))
                expect(firstBusiness.coordinates.longitude).to(equal(-122.40782))
                expect(firstBusiness.transactions.first!).to(equal("delivery"))
                expect(firstBusiness.transactions.last!).to(equal("pickup"))
                expect(firstBusiness.priceLevel).to(equal("$$"))
                expect(firstBusiness.location.address1).to(equal("373 Columbus Ave"))
                expect(firstBusiness.location.address2).to(beEmpty())
                expect(firstBusiness.location.address3).to(beEmpty())
                expect(firstBusiness.location.city).to(equal("San Francisco"))
                expect(firstBusiness.location.zipCode).to(equal("94133"))
                expect(firstBusiness.location.country).to(equal("US"))
                expect(firstBusiness.location.state).to(equal("CA"))
                expect(firstBusiness.location.displayAddress.first).to(equal("373 Columbus Ave"))
                expect(firstBusiness.location.displayAddress.last).to(equal("San Francisco, CA 94133"))
                expect(firstBusiness.phone).to(equal("+14154212337"))
                expect(firstBusiness.displayPhone).to(equal("(415) 421-2337"))
                expect(firstBusiness.distance).to(equal(1453.998141679007))
            }
            
            it("throws if decoding fails") {
                let path = Bundle(for: type(of: self)).path(forResource: "IncompleteMockBusiness", ofType: "json")!
                let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                do {
                    let businesses = try JSONDecoder().decode([Business].self, from: data)
                    fail("Decoding businesses should fail. Here are the businesses: \(businesses)")
                } catch {
                    expect(error.localizedDescription).to(equal("The data couldn’t be read because it is missing."))
                }
            }
        }
    }
}
