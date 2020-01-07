@testable import Find_My_Food

final class MockUserSession: UserSessionProtocol {
    final class Stub {
        var coreDataManagerCallCount = 0
        var userDefaultsCallCount = 0
        var userDefaultsShouldReturn = MockUserDefaults()
    }
    
    var stub = Stub()
    
    var coreDataManager: CoreDataManagerProtocol {
        get {
            stub.coreDataManagerCallCount += 1
            return globalInMemoryCoreDataManager
        }
    }
    
    var userDefaults: UserDefaultsProtocol {
        get {
            stub.userDefaultsCallCount += 1
            return stub.userDefaultsShouldReturn
        }
    }
}
