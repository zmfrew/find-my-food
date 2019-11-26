import CoreData
import Foundation

final class UserSession {
    let coreDataManager: CoreDataManagerProtocol
    private let userDefaults: UserDefaultsProtocol

    init(coreDataManager: CoreDataManagerProtocol, userDefaults: UserDefaultsProtocol) {
        self.coreDataManager = coreDataManager
        self.userDefaults = userDefaults
    }
}
