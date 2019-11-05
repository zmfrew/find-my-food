import Foundation

@testable import Find_My_Food

final class MockUrlSession: URLSessionWrapperInterface {
	final class Stub {
        var dataTaskCallCount: Int {
            dataTaskCalledWith.count
        }
		var dataTaskCalledWith = [(request: URLRequest, completionHandler: (Data?, URLResponse?, Error?) -> Void)]()
	}

	var stub = Stub()

	func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
		stub.dataTaskCalledWith.append((request, completionHandler))
	}
}
