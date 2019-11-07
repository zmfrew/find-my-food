import Foundation

@testable import Find_My_Food

final class MockBusinessSearchClient: BusinessSearchClientProtocol {
    
    final class Stub {
        var imageCallCount: Int { imageCalledWith.count }
        var imageCalledWith = [String]()
        var imageShouldCompleteWith: Data? = Data(base64Encoded: "empty")
        var searchCallCount: Int { searchCalledWith.count }
        var searchCalledWith = [(business: String, latitude: Double, longitude: Double, radius: Int, prices: [Int], openNow: Bool, completion: ([Business]) -> Void)]()
        var searchShouldCompleteWith = [Business]()
    }

    var stub = Stub()

    func image(at urlString: String, completion: @escaping (Data?) -> Void) {
        stub.imageCalledWith.append(urlString)
        completion(stub.imageShouldCompleteWith)
    }
    
    func search(for business: String, latitude: Double, longitude: Double, radius: Int, prices: [Int], openNow: Bool, completion: @escaping ([Business]) -> Void) {
		stub.searchCalledWith.append((business, latitude, longitude, radius, prices, openNow, completion))
        completion(stub.searchShouldCompleteWith)
	}
}
