import Foundation

@testable import Find_My_Food

final class MockBusinessSearchClient: BusinessSearchClientProtocol {
    final class Stub {
        var imageCallCount = 0
        var imageShouldCompleteWith: Data? = Data(base64Encoded: "empty")
        var searchCallCount: Int { searchCalledWith.count }
        var searchCalledWith = [(business: String, latitude: Double?, location: String?, longitude: Double?, radius: Int, prices: [Int], openNow: Bool, completion: ([Business]) -> Void)]()
        var searchShouldCompleteWith = [Business]()
    }

    var stub = Stub()

    func image(at urlString: String, completion: @escaping (Data?) -> Void) {
        stub.imageCallCount += 1
        completion(stub.imageShouldCompleteWith)
    }
    
    func search(for business: String, latitude: Double?, location: String?, longitude: Double?, radius: Int, prices: [Int], openNow: Bool, completion: @escaping ([Business]) -> Void) {
        stub.searchCalledWith.append((business, latitude, location, longitude, radius, prices, openNow, completion))
        completion(stub.searchShouldCompleteWith)
	}
}
