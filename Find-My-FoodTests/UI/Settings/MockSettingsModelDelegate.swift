@testable import Find_My_Food

final class MockSettingsModelDelegate: SettingsModelDelegate {
    final class Stub {
        var dataDidUpdateCallCount: Int { dataDidUpdateCalledWith.count }
        var dataDidUpdateCalledWith = [(location: String?, selectRadius: Int)]()
        var saveDidEndCallCount = 0
    }
    
    var stub = Stub()
    
    func dataDidUpdate(location: String?, selectRadius: Int) {
        stub.dataDidUpdateCalledWith.append((location: location, selectRadius: selectRadius))
    }
    
    func saveDidEnd() {
        stub.saveDidEndCallCount += 1
    }
}
