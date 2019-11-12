import Foundation

@testable import Find_My_Food

final class MockUserDefaults: UserDefaultsProtocol {
    final class Stub {
        var objectCallCount: Int { objectCalledWith.count }
        var objectCalledWith = [String]()
        var setCallCount: Int { setCalledWith.count }
        var setCalledWith = [(value: Any?, forKey: String)]()
    }
    
    var stub = Stub()
    
    func object(forKey defaultName: String) -> Any? {
        stub.objectCalledWith.append(defaultName)
    }
    
    func set(_ value: Any?, forKey defaultName: String) {
        stub.setCalledWith.append((value: value, forKey: defaultName))
    }
}
