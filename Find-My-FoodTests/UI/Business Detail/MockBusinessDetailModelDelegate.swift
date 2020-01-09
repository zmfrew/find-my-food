@testable import Find_My_Food

final class MockBusinessDetailModelDelegate: BusinessDetailModelDelegate {
    final class Stub {
        var saveDidFailCallCount = 0
        var saveDidSucceedCallCount = 0
    }
    
    var stub = Stub()
    
    func saveDidFail() {
        stub.saveDidFailCallCount += 1
    }
    
    func saveDidSucceed() {
        stub.saveDidSucceedCallCount += 1
    }
}
 
