import Quick
import Nimble

@testable import Find_My_Food

final class BusinessSearchClientSpec: QuickSpec {
    override func spec() {
        var testObject: BusinessSearchClient!
        var mockDecoder: MockDecoder!
        var mockServiceClient: MockServiceClient!
        
        beforeEach {
            mockDecoder = MockDecoder()
            mockServiceClient = MockServiceClient()
            testObject = BusinessSearchClient(decoder: mockDecoder, serviceClient: mockServiceClient)
        }
        
        // MARK: - func search(for business: String, completion: @escaping ([Business]) -> Void)
        describe("search(for business: String, completion: @escaping ([Business]) -> Void)") {
            context("given success and data is returned") {
                it("decodes and returns an array of businesses") {
                    let expectedBusinesses = TestData.businessesFromJson()
                    let searchText = "Chipotle"
                    let expectedQueryParams = [
                        "term": searchText,
                        "latitude": "\(38.752209)",
                        "longitude": "\(-89.986610)",
                        "radius": "40000",
                        "price": "1",
                        "openNow": "false"
                    ]
                    let expectedHeaders = ["Authorization": "Bearer \(Secret.apiKey)"]
                    
                    mockServiceClient.stub.getShouldCompleteWith = .success(TestData.businessData())
                    
                    testObject.search(for: searchText, latitude: 38.752209, longitude: -89.986610, radius: 40_000, prices: [1], openNow: false) { businesses in
                        expect(businesses).toEventually(equal(expectedBusinesses))
                        expect(mockServiceClient.stub.getCallCount).to(equal(1))
                       
                       let (url, queryParams, headers, _) = mockServiceClient.stub.getCalledWith.first!
                        
                        expect(url).to(equal(YelpRoutes.businessSearch))
                        expect(queryParams).to(equal(expectedQueryParams))
                        expect(headers).to(equal(expectedHeaders))
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
                        "radius": "40000",
                        "price": "1",
                        "openNow": "false"
                    ]
                    let expectedHeaders = ["Authorization": "Bearer \(Secret.apiKey)"]
                    
                    testObject.search(for: searchText, latitude: 38.752209, longitude: -89.986610, radius: 40_000, prices: [1], openNow: false) { businesses in
                        expect(businesses).to(equal([]))
                        expect(mockServiceClient.stub.getCallCount).to(equal(1))
                        
                        let (url, queryParams, headers, _) = mockServiceClient.stub.getCalledWith.first!
                        
                        expect(url).to(equal(YelpRoutes.businessSearch))
                        expect(queryParams).to(equal(expectedQueryParams))
                        expect(headers).to(equal(expectedHeaders))
                    }
                }
            }
        }
        
        // MARK: - func image(at urlString: String, completion: @escaping (Data?) -> Void)
        describe("image(at urlString: String, completion: @escaping (Data?) -> Void)") {
            context("given a valid url and get completes with data") {
                it("completes with data") {
                    let expectedData = Data(capacity: 0)
                    mockServiceClient.stub.getShouldCompleteWith = .success(expectedData)
                    
                    testObject.image(at: "developer.apple.com") { data in
                        expect(data).to(equal(expectedData))
                        expect(mockServiceClient.stub.getCallCount).to(equal(1))
                    }
                }
            }
            
            context("given a valid url and get completes with an error") {
                it("completes with nil") {
                    let expectedError = NSError(domain: "expected error", code: -1, userInfo: nil)
                    mockServiceClient.stub.getShouldCompleteWith = .failure(expectedError)
                    
                    testObject.image(at: "apple.com") { data in
                        expect(data).to(beNil())
                        expect(mockServiceClient.stub.getCallCount).to(equal(1))
                    }
                }
            }
            
            context("given an invalid url") {
                it("completes with nil") {
                    let urlString = "invalid url string"
                    
                    testObject.image(at: urlString) { data in
                        expect(data).to(beNil())
                        expect(mockServiceClient.stub.getCallCount).to(equal(0))
                    }
                }
            }
        }
    }
}
