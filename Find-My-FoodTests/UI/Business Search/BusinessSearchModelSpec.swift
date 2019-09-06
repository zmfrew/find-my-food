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
        
        // MARK: - search(for business: String)
        describe("search(for business:)") {
            context("given businessSearchClient returns businesses") {
                it("sets businesses") {
                    let expectedBusinesses = [
                        TestData.createBusiness(),
                        TestData.createBusiness()
                    ]
                    
                    mockBusinessSearchClient.stub.searchShouldReturn = expectedBusinesses
                    
                    testObject.search(for: "Peel", latitude: 38.752209, longitude: -89.986610)
                    
                    expect(mockDelegate.stub.downloadDidBeginCallCount).to(equal(1))
                    expect(mockDelegate.stub.downloadDidEndCallCount).toEventually(equal(1))
                    expect(testObject.businesses).toEventually(equal(expectedBusinesses))
                }
            }
            
            context("given businessSearchClient returns an empty array") {
                it("sets businesses as an empty array") {
                    let expectedBusinesses: [Business] = []
                    
                    mockBusinessSearchClient.stub.searchShouldReturn = expectedBusinesses
                    
                    testObject.search(for: "Chophouse", latitude: 38.752209, longitude: -89.986610)
                    
                    expect(mockDelegate.stub.downloadDidBeginCallCount).to(equal(1))
                    expect(mockDelegate.stub.downloadDidEndCallCount).toEventually(equal(1))
                    expect(testObject.businesses).toEventually(equal(expectedBusinesses))
                }
            }
        }
    }
}
