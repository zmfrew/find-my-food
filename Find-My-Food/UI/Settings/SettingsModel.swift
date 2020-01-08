import Foundation

protocol SettingsModelProtocol {
    var radiusCount: Int { get }

    func loadDefaults()
    func radius(at index: Int) -> Int
    func selectedDefaults(defaultLocation: String?, radiusIndex: Int)
}

protocol SettingsModelDelegate: class {
    func dataDidUpdate(location: String?, selectRadius: Int)
    func saveDidEnd()
}

final class SettingsModel: SettingsModelProtocol {
    private var defaultLocation: String?
    private weak var delegate: SettingsModelDelegate?
    private let radiusData: [Int]
    private var radiusIndex = Radius.rangeMax
    private let userDefaults: UserDefaultsProtocol

    var radiusCount: Int { radiusData.count }

    init(radiusData: [Int], delegate: SettingsModelDelegate, userDefaults: UserDefaultsProtocol) {
        self.delegate = delegate
        self.radiusData = radiusData
        self.userDefaults = userDefaults
    }

    func loadDefaults() {
        defaultLocation = userDefaults.object(forKey: UserDefaultKey.defaultLocation) as? String
        radiusIndex = userDefaults.object(forKey: UserDefaultKey.radiusIndex) as? Int ?? 24

        delegate?.dataDidUpdate(location: defaultLocation, selectRadius: radiusIndex)
    }

    func radius(at index: Int) -> Int {
        radiusData.element(at: index) ?? Radius.rangeMax
    }

    func selectedDefaults(defaultLocation: String?, radiusIndex: Int) {
        userDefaults.set(defaultLocation, forKey: UserDefaultKey.defaultLocation)
        userDefaults.set(radiusIndex, forKey: UserDefaultKey.radiusIndex)

        delegate?.saveDidEnd()
    }
}
