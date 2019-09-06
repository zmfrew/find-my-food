import Quick
import Nimble

@testable import Find_My_Food

final class BaseServiceClientSpec: QuickSpec {
    override func spec() {
        var mockUrlSession: MockUrlSession!
        var testObject: BaseServiceClient!
        
        beforeEach {
            mockUrlSession = MockUrlSession()
            testObject = BaseServiceClient(urlSession: mockUrlSession)
        }
        
        // MARK: - get(from url: URL, queryParams: [String: String], headers: [String: String], completion: @escaping (Result<Data, Error>) -> Void)
        describe("get") {
            context("given a valid url, queryParams, and headers") {
                it("returns data") {
                    let url = URL(string: "https://apple.com")!
                    testObject.get(from: url, queryParams: [:], headers: [:], completion: { result in
                        switch result {
                        case .success(let data):
                            let expectedRequest = URLRequest(url: url)
                            let actualRequest = mockUrlSession.stub.dataTaskCalledWith.first!.request
                            
                            expect(mockUrlSession.stub.dataTaskCallCount).to(equal(1))
                            expect(actualRequest).to(equal(expectedRequest))
                            expect(data).toNot(beNil())
                        case .failure:
                            fail("This call should succeed.")
                        }
                    })
                }
            }
            
            context("given an invalid url") {
                it("returns an invalidUrl NetworkError") {
                    let url = URL(string: "//apple")!
                    testObject.get(from: url, queryParams: [:], headers: [:], completion: { result in
                        switch result {
                        case .success:
                            fail("This call should not succeed.")
                        case .failure(let error):
                            let actualError = error as! NetworkError
                            let expectedRequest = URLRequest(url: url)
                            let actualRequest = mockUrlSession.stub.dataTaskCalledWith.first!.request
                            
                            expect(mockUrlSession.stub.dataTaskCallCount).to(equal(1))
                            expect(actualRequest).to(equal(expectedRequest))
                            expect(actualError).to(equal(NetworkError.invalidUrl))
                        }
                    })
                }
            }
        }
    }
}
