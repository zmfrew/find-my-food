import Foundation

@testable import Find_My_Food

final class MockBusinessSearchClient: BusinessSearchClientInterface {
    
    final class Stub {
        var imageCallCount: Int { return imageCalledWith.count }
        var imageCalledWith = [String]()
        var imageShouldCompleteWith: Data? = Data(base64Encoded: "empty")
        var searchCallCount: Int { return searchCalledWith.count }
        var searchCalledWith = [(business: String, latitude: Double, longitude: Double, completion: ([Business]) -> Void)]()
        var searchShouldCompleteWith: [Business] = []
    }

    var stub = Stub()

    func image(at urlString: String, completion: @escaping (Data?) -> Void) {
        stub.imageCalledWith.append(urlString)
        completion(stub.imageShouldCompleteWith)
    }
    
	func search(for business: String, latitude: Double, longitude: Double, completion: @escaping ([Business]) -> Void) {
		stub.searchCalledWith.append((business, latitude, longitude, completion))
        completion(stub.searchShouldCompleteWith)
	}
}
