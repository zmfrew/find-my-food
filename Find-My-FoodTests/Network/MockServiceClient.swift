import Foundation

@testable import Find_My_Food

final class MockServiceClient: ServiceClientInterface {
	final class Stub {
        var getCallCount: Int { return getCalledWith.count }
		var getCalledWith = [(url: URL, queryParams: [String: String], headers: [String: String], completion: (Result<Data, Error>) -> Void)]()
        var getShouldReturn: Result<Data, Error> = .failure(NetworkError.invalidApiResponse)
	}

	var stub = Stub()

	func get(from url: URL, queryParams: [String: String], headers: [String: String], completion: @escaping (Result<Data, Error>) -> Void) {
		stub.getCalledWith.append((url, queryParams, headers, completion))
	}
}
