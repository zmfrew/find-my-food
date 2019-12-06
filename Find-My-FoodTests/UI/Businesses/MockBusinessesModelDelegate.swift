@testable import Find_My_Food

final class MockBusinessesModelDelegate: BusinessesModelDelegate {
    final class Stub {
        var dataDidUpdateCallCount = 0
        var saveDidFailCallCount = 0
        var saveDidSucceedCallCount: Int { saveDidSucceedCalledWith.count }
        var saveDidSucceedCalledWith = [Int]()
    }
    
    var stub = Stub()
    
    func dataDidUpdate() {
        stub.dataDidUpdateCallCount += 1
    }
    
    func saveDidFail() {
        stub.saveDidFailCallCount += 1
    }
    
    func saveDidSucceed(at index: Int) {
        stub.saveDidSucceedCalledWith.append(index)
    }
}
