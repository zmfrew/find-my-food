import Quick
import Nimble

@testable import Find_My_Food

final class BusinessesModelSpec: QuickSpec {
    override func spec() {
        var testObject: BusinessesModel!
        var businesses: [Business]!
        var mockBusinessSearchClient: MockBusinessSearchClient!
        var mockDelegate: MockBusinessesModelDelegate!
        
        beforeEach {
            businesses = TestData.businessesFromJson()
            mockBusinessSearchClient = MockBusinessSearchClient()
            mockDelegate = MockBusinessesModelDelegate()
            testObject = BusinessesModel(businesses: businesses, businessSearchClient: mockBusinessSearchClient, delegate: mockDelegate)
        }
        
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
        
        // MARK: - func image(for business: Business)
        describe("image(for business: Business") {
            context("given data returns from image search") {
                it("calls dataDidUpdate on the delegate")  {
                    
                }
            }
            
            context("given no data returns from image search") {
                it("does not call dataDidUpdate on the delegate") {
                    
                }
            }
        }
        
        // MARK: - randomBusiness() -> Business?
        describe("randomBusiness()") {
            context("given businesses is not empty") {
                it("returns a business") {
                    expect(testObject.randomBusiness()).toNot(beNil())
                    expect(testObject.randomBusiness()).to(beAKindOf(Business.self))
                }
            }
            
            context("given businesses is not empty") {
                it("returns nil") {
                    let emptyTestObject = BusinessesModel(businesses: [], businessSearchClient: mockBusinessSearchClient, delegate: mockDelegate)
                    
                    expect(emptyTestObject.randomBusiness()).to(beNil())
                }
            }
        }
    }
}
