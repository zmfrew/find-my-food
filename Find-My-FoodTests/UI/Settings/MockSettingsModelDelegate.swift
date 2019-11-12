@testable import Find_My_Food

final class MockSettingsModelDelegate: SettingsModelDelegate {
    final class Stub {
        var dataDidUpdateCallCount: Int { dataDidUpdateCalledWith.count }
        var dataDidUpdateCalledWith = [(darkMode: Bool, selectRadius: Int, location: String?)]()
    }
    
    var stub = Stub()
    
    func dataDidUpdate(_ darkMode: Bool, selectRadius: Int, location: String?) {
        stub.dataDidUpdateCalledWith.append((darkMode: darkMode, selectRadius: selectRadius, location: location))
    }
}
