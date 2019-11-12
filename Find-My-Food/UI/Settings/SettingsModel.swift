import Foundation

protocol SettingsModelProtocol {
    var radiusCount: Int { get }

    func loadDefaults()
    func radius(at index: Int) -> Int
    func selectedDefaults(darkMode: Bool, defaultLocation: String?, radiusIndex: Int)
}

protocol SettingsModelDelegate: class {
    func dataDidUpdate(_ darkMode: Bool, location: String?, selectRadius: Int)
}

final class SettingsModel: SettingsModelProtocol {
    private let radiusData: [Int]
    private var defaultLocation: String?
    private var isDarkModeActive = false
    private var radiusIndex = Radius.rangeMax
    private let userDefaults: UserDefaultsProtocol
    private weak var delegate: SettingsModelDelegate?

    var radiusCount: Int { radiusData.count }

    init(radiusData: [Int], delegate: SettingsModelDelegate, userDefaults: UserDefaultsProtocol) {
        self.delegate = delegate
        self.radiusData = radiusData
        self.userDefaults = userDefaults
    }

    func loadDefaults() {
        isDarkModeActive = userDefaults.object(forKey: UserDefaultKey.darkMode) as? Bool ?? false
        defaultLocation = userDefaults.object(forKey: UserDefaultKey.defaultLocation) as? String
        radiusIndex = userDefaults.object(forKey: UserDefaultKey.radiusIndex) as? Int ?? 24

        delegate?.dataDidUpdate(isDarkModeActive, location: defaultLocation, selectRadius: radiusIndex)
    }

    func radius(at index: Int) -> Int {
        return radiusData.element(at: index) ?? Radius.rangeMax
    }

    func selectedDefaults(darkMode: Bool, defaultLocation: String?, radiusIndex: Int) {
        userDefaults.set(darkMode, forKey: UserDefaultKey.darkMode)
        userDefaults.set(defaultLocation, forKey: UserDefaultKey.defaultLocation)
        userDefaults.set(radiusIndex, forKey: UserDefaultKey.radiusIndex)
    }
}
