import Foundation

@testable import Find_My_Food

final class MockFavoritesModelDelegate: NSObject, FavoritesModelDelegate {
    final class Stub {
        var dataDidUpdateCallCount = 0
        var downloadDidEndCallCount = 0
    }
    
    var stub = Stub()
    
    func dataDidUpdate() {
        stub.dataDidUpdateCallCount += 1
    }
    
    func downloadDidEnd() {
        stub.downloadDidEndCallCount += 1
    }
}
