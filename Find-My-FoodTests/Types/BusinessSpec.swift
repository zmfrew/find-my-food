import Quick
import Nimble

@testable import Find_My_Food

final class BusinessSpec: QuickSpec {
    override func spec() {
        // MARK: init(from decoder:)
        describe("init(from decoder:)") {
            it("decodes properly") {
                let businesses = TestData.businessesFromMockBusinessesFile()
                
                let firstBusiness = businesses.first!
                expect(firstBusiness.id).to(equal("FmGF1B-Rpsjq1f5b56qMwg"))
                expect(firstBusiness.alias).to(equal("molinari-delicatessen-san-francisco"))
                expect(firstBusiness.name).to(equal("Molinari Delicatessen"))
                expect(firstBusiness.imageUrlString).to(equal("https://s3-media3.fl.yelpcdn.com/bphoto/6He-NlZrAv2mDV-yg6jW3g/o.jpg"))
                expect(firstBusiness.image).to(beNil())
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
        
        // MARK: - func copy(:)
        describe("copy(:)") {
            context("given all non-nil values") {
                it("returns a new business") {
                    let business = TestData.businessesFromJson().first!
                    
                    let newBusiness = business.copy(id: "test id",
                                                    alias: "test alias",
                                                    name: "test name",
                                                    imageUrlString: "test image url string",
                                                    image: UIImage(),
                                                    isClosed: true,
                                                    urlString: "test url string",
                                                    reviewCount: 0,
                                                    categories: [],
                                                    rating: 5.0,
                                                    coordinates: Coordinate(latitude: 0, longitude: 0),
                                                    transactions: [],
                                                    priceLevel: "test price level",
                                                    location: Business.Location(address1: "test address 1",
                                                                                address2: "test address 2",
                                                                                address3: "test address 3",
                                                                                city: "test city",
                                                                                zipCode: "test zip code",
                                                                                country: "test country",
                                                                                state: "test state",
                                                                                displayAddress: []),
                                                    phone: "test phone",
                                                    displayPhone: "test display phone",
                                                    distance: 0)
                    
                    expect(business).toNot(equal(newBusiness))
                    
                    expect(newBusiness.id).to(equal("test id"))
                    expect(newBusiness.alias).to(equal("test alias"))
                    expect(newBusiness.name).to(equal("test name"))
                    expect(newBusiness.imageUrlString).to(equal("test image url string"))
                    expect(newBusiness.image).to(equal(UIImage()))
                    expect(newBusiness.isClosed).to(beTrue())
                    expect(newBusiness.urlString).to(equal("test url string"))
                    expect(newBusiness.reviewCount).to(equal(0))
                    expect(newBusiness.categories).to(beEmpty())
                    expect(newBusiness.rating).to(equal(5.0))
                    expect(newBusiness.coordinates.latitude).to(equal(0))
                    expect(newBusiness.coordinates.longitude).to(equal(0))
                    expect(newBusiness.transactions).to(beEmpty())
                    expect(newBusiness.priceLevel).to(equal("test price level"))
                    expect(newBusiness.location.address1).to(equal("test address 1"))
                    expect(newBusiness.location.address2).to(equal("test address 2"))
                    expect(newBusiness.location.address3).to(equal("test address 3"))
                    expect(newBusiness.location.city).to(equal("test city"))
                    expect(newBusiness.location.zipCode).to(equal("test zip code"))
                    expect(newBusiness.location.country).to(equal("test country"))
                    expect(newBusiness.location.state).to(equal("test state"))
                    expect(newBusiness.location.displayAddress).to(beEmpty())
                    expect(newBusiness.location.displayAddress).to(beEmpty())
                    expect(newBusiness.phone).to(equal("test phone"))
                    expect(newBusiness.displayPhone).to(equal("test display phone"))
                    expect(newBusiness.distance).to(equal(0))
                }
            }
            
            context("given all nil values") {
                it("returns a new business with the same values") {
                    let business = TestData.businessesFromJson().first!
                    let newBusiness = business.copy()
                    
                    expect(business).to(equal(newBusiness))
                }
            }
    
        }
    }
}
