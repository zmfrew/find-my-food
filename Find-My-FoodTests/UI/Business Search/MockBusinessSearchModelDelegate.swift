@testable import Find_My_Food

final class MockBusinessSearchModelDelegate: BusinessSearchModelDelegate {
	final class Stub {
		var downloadDidBeginCallCount = 0
		var downloadDidEndCallCount = 0
	}

	var stub = Stub()

	func downloadDidBegin() {
		stub.downloadDidBeginCallCount += 1
	}

	func downloadDidEnd() {
		stub.downloadDidEndCallCount += 1
	}
}
