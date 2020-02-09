import CoreData
import Foundation

protocol UserSessionProtocol {
    var coreDataManager: CoreDataManagerProtocol { get }
    var userDefaults: UserDefaultsProtocol { get }
}

final class UserSession: UserSessionProtocol {
    lazy var coreDataManager: CoreDataManagerProtocol = {
        let container = NSPersistentContainer(name: "Find-My-Food")
        container.loadPersistentStores { _, error in
            guard error == nil else { fatalError("Failed to load store: \(error!)") }
        }

        return CoreDataManager(persistentContainer: container)
    }()

    lazy var userDefaults: UserDefaultsProtocol = {
       UserDefaultsWrapper()
    }()

    static let shared = UserSession()

    private init() { }
}
