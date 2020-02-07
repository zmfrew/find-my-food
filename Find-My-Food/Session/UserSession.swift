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

// TODO: - Fix current bugs

// TODO: - Bug: search view isn't centered
// TODO: - Bug: address truncates on table view & on detail view
// TODO: - Bug: show restaurants in the map view just by default
