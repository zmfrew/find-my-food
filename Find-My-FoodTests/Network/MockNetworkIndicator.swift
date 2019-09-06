@testable import Find_My_Food

final class MockNetworkIndicator: NetworkInterface {
	final class Stub {	
		var activityDidBeginCallCount = 0
		var activityDidEndCallCount = 0
	}

	var stub = Stub()

	func activityDidBegin() {
		stub.activityDidBeginCallCount += 1
	}

	func activityDidEnd() {
		stub.activityDidEndCallCount += 1
	}
}
