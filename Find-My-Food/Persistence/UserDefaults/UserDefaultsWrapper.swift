import Foundation

protocol UserDefaultsProtocol {
    func object(forKey defaultName: String) -> Any?
    func set(_ value: Any?, forKey defaultName: String)
}

final class UserDefaultsWrapper: UserDefaultsProtocol {
    func object(forKey defaultName: String) -> Any? {
        UserDefaults.standard.object(forKey: defaultName)
    }

    func set(_ value: Any?, forKey defaultName: String) {
        UserDefaults.standard.set(value, forKey: defaultName)
    }
}
