import UIKit

@testable import Find_My_Food

final class MockBusinessSearchModelDelegate: BusinessSearchModelDelegate {
    final class Stub {
        var downloadDidBeginCallCount = 0
        var downloadDidEndCallCount = 0
        var presentCallCount: Int { presentCalledWith.count }
        var presentCalledWith = [(viewControllerToPresent: UIViewController, animated: Bool)]()
    }

    var stub = Stub()
    
    func downloadDidBegin() {
        stub.downloadDidBeginCallCount += 1
    }

    func downloadDidEnd() {
		stub.downloadDidEndCallCount += 1
	}
    
    func present(_ viewControllerToPresent: UIViewController, animated: Bool) {
        stub.presentCalledWith.append((viewControllerToPresent: viewControllerToPresent, animated: animated))
     }
}
