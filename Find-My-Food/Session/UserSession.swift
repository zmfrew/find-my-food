import CoreData
import Foundation

final class UserSession {
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
