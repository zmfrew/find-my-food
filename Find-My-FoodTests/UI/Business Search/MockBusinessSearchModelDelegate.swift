@testable import Find_My_Food

final class MockBusinessSearchModelDelegate: BusinessSearchModelDelegate {
	final class Stub {
		var downloadDidEndCallCount = 0
	}

	var stub = Stub()

    func downloadDidEnd() {
		stub.downloadDidEndCallCount += 1
	}
}
