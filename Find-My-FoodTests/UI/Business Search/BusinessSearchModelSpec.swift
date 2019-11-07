import Quick
import Nimble

@testable import Find_My_Food

final class BusinessSearchModelSpec: QuickSpec {
    override func spec() {
        var testObject: BusinessSearchModel!
        var mockBusinessSearchClient: MockBusinessSearchClient!
        var mockDelegate: MockBusinessSearchModelDelegate!
        
        beforeEach {
            mockBusinessSearchClient = MockBusinessSearchClient()
            mockDelegate = MockBusinessSearchModelDelegate()
            testObject = BusinessSearchModel(businessSearchClient: mockBusinessSearchClient, delegate: mockDelegate)
        }
        
        // MARK: - func deSelected(_ price: String)
        describe("deSelected(_ price: String)") {
            context("given price is in selectedPrices") {
                it("removes the price") {
                    testObject.selected("$$")
                    testObject.selected("$$$$")
                    testObject.selected("$")
                    
                    testObject.deSelected("$$")
                    testObject.deSelected("$$$$")
                    testObject.deSelected("$")
                    
                    expect(testObject.selectedPrices).to(equal([]))
                }
            }
            
            context("given price is not in selectedPrices") {
                it("does nothing") {
                    let expectedPrices = ["$$", "$$$$", "$"]
                    testObject.selected("$$")
                    testObject.selected("$$$$")
                    testObject.selected("$")
                    
                    testObject.deSelected("$$$")
                    testObject.deSelected("$$$")
                    testObject.deSelected("$$$")
                    
                    expect(testObject.selectedPrices).to(equal(expectedPrices))
                }
            }
        }
        
        // MARK: - func search(for business: String)
        describe("search(for business:)") {
            context("given businessSearchClient returns businesses") {
                it("sets businesses") {
                    let expectedBusinesses = [
                        TestData.createBusiness(),
                        TestData.createBusiness()
                    ]
                    
                    mockBusinessSearchClient.stub.searchShouldCompleteWith = expectedBusinesses
                    
                    testObject.search(for: "Peel", latitude: 38.752209, longitude: -89.986610, radius: 0, prices: ["$"], openNow: false)
                   
                    expect(mockDelegate.stub.downloadDidBeginCallCount).toEventually(equal(1))
                    expect(mockDelegate.stub.downloadDidEndCallCount).toEventually(equal(1))
                    expect(testObject.businesses).toEventually(equal(expectedBusinesses))
                }
            }
            
            context("given businessSearchClient returns an empty array") {
                it("sets businesses as an empty array") {
                    let expectedBusinesses = [Business]()
                    
                    mockBusinessSearchClient.stub.searchShouldCompleteWith = expectedBusinesses
                    
                    testObject.search(for: "Chophouse", latitude: 38.752209, longitude: -89.986610, radius: 0, prices: ["$$"], openNow: false)
                    
                    expect(mockDelegate.stub.downloadDidBeginCallCount).toEventually(equal(1))
                    expect(mockDelegate.stub.downloadDidEndCallCount).toEventually(equal(1))
                    expect(testObject.businesses).toEventually(equal(expectedBusinesses))
                }
            }
        }
        
        // MARK: - func selected(_ price: String)
        describe("selected(_ price: String)") {
            context("given price is not in selectedPrices") {
                it("adds the price") {
                    let expectedPrices = ["$$", "$$$$", "$"]
                    
                    testObject.selected("$$")
                    testObject.selected("$$$$")
                    testObject.selected("$")
                    
                    expect(testObject.selectedPrices).to(equal(expectedPrices))
                }
            }
            
            context("given price is in selectedPrices") {
                it("does nothing") {
                    let expectedPrices = ["$$$"]
                    
                    testObject.selected("$$$")
                    testObject.selected("$$$")
                    testObject.selected("$$$")
                    
                    expect(testObject.selectedPrices).to(equal(expectedPrices))
                }
            }
        }
    }
}
