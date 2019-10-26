@testable import Find_My_Food

//@@parrot-mock
final class MockBusinessesModelDelegate: BusinessesModelDelegate {
    final class Stub {
        var dataDidUpdateCallCount = 0
    }
    
    var stub = Stub()
    
    func dataDidUpdate() {
        stub.dataDidUpdateCallCount += 1
    }
}
