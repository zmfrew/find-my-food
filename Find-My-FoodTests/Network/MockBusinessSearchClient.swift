@testable import Find_My_Food

final class MockBusinessSearchClient: BusinessSearchClientInterface {
	final class Stub {
        var searchCallCount: Int { return searchCalledWith.count }
        var searchCalledWith = [(business: String, latitude: Double, longitude: Double, completion: ([Business]) -> Void)]()
        var searchShouldReturn: [Business] = []
	}

	var stub = Stub()

	func search(for business: String, latitude: Double, longitude: Double, completion: @escaping ([Business]) -> Void) {
		stub.searchCalledWith.append((business, latitude, longitude, completion))
        completion(stub.searchShouldReturn)
	}
}
