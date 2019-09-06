import Quick
import Nimble

@testable import Find_My_Food

final class BusinessSearchClientSpec: QuickSpec {
    override func spec() {
        var testObject: BusinessSearchClient!
        var mockServiceClient: MockServiceClient!
		var mockNetworkIndicator: MockNetworkIndicator!
        
        beforeEach {
            mockServiceClient = MockServiceClient()
			mockNetworkIndicator = MockNetworkIndicator()
			testObject = BusinessSearchClient(serviceClient: mockServiceClient, networkIndicator: mockNetworkIndicator)
        }
        
        // MARK: - search(for business: String, completion: @escaping ([Business]) -> Void)
        describe("search(for business: String, completion: @escaping ([Business]) -> Void)") {
            context("given success and data is returned") {
                it("decodes and returns an array of businesses") {
                    let expectedBusinesses = TestData.businessesFromJson()
                    let searchText = "Chipotle"
                    let expectedQueryParams = [
                        "term": searchText,
                        "latitude": "\(38.752209)",
                        "longitude": "\(-89.986610)",
                        "radius": "40000"
                    ]
                    let expectedHeaders = ["Authorization": "Bearer \(Secret.apiKey)"]
                    
                    mockServiceClient.stub.getShouldReturn = .success(TestData.businessData())
                    
                    testObject.search(for: searchText, latitude: 38.752209, longitude: -89.986610) { businesses in
                        expect(businesses).to(equal(expectedBusinesses))
                        expect(mockServiceClient.stub.getCallCount).to(equal(1))
                       
                       let (url, queryParams, headers, _) = mockServiceClient.stub.getCalledWith.first!
                        
                        expect(url).to(equal(YelpRoutes.businessSearch))
                        expect(queryParams).to(equal(expectedQueryParams))
                        expect(headers).to(equal(expectedHeaders))
						expect(mockNetworkIndicator.stub.activityDidBeginCallCount).to(equal(1))
						expect(mockNetworkIndicator.stub.activityDidEndCallCount).to(equal(1))
                    }
                }
            }
            
            context("given a failure") {
                it("returns an empty array") {
                    let searchText = "FAILURE"
                    let expectedQueryParams = [
                        "term": searchText,
                        "latitude": "\(38.752209)",
                        "longitude": "\(-89.986610)",
                        "radius": "40000"
                    ]
                    let expectedHeaders = ["Authorization": "Bearer \(Secret.apiKey)"]
                    
                    testObject.search(for: searchText, latitude: 38.752209, longitude: -89.986610) { businesses in
                        expect(businesses).to(equal([]))
                        expect(mockServiceClient.stub.getCallCount).to(equal(1))
                        
                        let (url, queryParams, headers, _) = mockServiceClient.stub.getCalledWith.first!
                        
                        expect(url).to(equal(YelpRoutes.businessSearch))
                        expect(queryParams).to(equal(expectedQueryParams))
                        expect(headers).to(equal(expectedHeaders))
						expect(mockNetworkIndicator.stub.activityDidBeginCallCount).to(equal(1))
						expect(mockNetworkIndicator.stub.activityDidEndCallCount).to(equal(1))
                    }
                }
            }
        }
    }
}
