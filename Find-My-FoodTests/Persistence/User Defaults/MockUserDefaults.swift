import Foundation

@testable import Find_My_Food

final class MockUserDefaults: UserDefaultsProtocol {
    final class Stub {
        var objectCallCount: Int { objectCalledWith.count }
        var objectCalledWith = [String]()
        var objectCalledWithDarkMode: Bool? = nil
        var objectCalledWithDefaultLocation: String? = nil
        var objectCalledWithRadiusIndex: Int? = nil
        var setCallCount: Int { setCalledWith.count }
        var setCalledWith = [(value: Any?, forKey: String)]()
    }
    
    var stub = Stub()
    
    func object(forKey defaultName: String) -> Any? {
        stub.objectCalledWith.append(defaultName)
        switch defaultName {
        case UserDefaultKey.darkMode:
            return stub.objectCalledWithDarkMode
            
        case UserDefaultKey.defaultLocation:
            return stub.objectCalledWithDefaultLocation
            
        case UserDefaultKey.radiusIndex:
            return stub.objectCalledWithRadiusIndex
            
        default:
            return "This shouldn't happen."
        }
        
    }
    
    func set(_ value: Any?, forKey defaultName: String) {
        stub.setCalledWith.append((value: value, forKey: defaultName))
    }
}
