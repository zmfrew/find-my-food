@testable import Find_My_Food

final class MockSettingsModelDelegate: SettingsModelDelegate {
    final class Stub {
        var dataDidUpdateCallCount: Int { dataDidUpdateCalledWith.count }
        var dataDidUpdateCalledWith = [(darkMode: Bool, location: String?, selectRadius: Int)]()
        var saveDidEndCallCount = 0
    }
    
    var stub = Stub()
    
    func dataDidUpdate(_ darkMode: Bool, location: String?, selectRadius: Int) {
        stub.dataDidUpdateCalledWith.append((darkMode: darkMode, location: location, selectRadius: selectRadius))
    }
    
    func saveDidEnd() {
        stub.saveDidEndCallCount += 1
    }
}
