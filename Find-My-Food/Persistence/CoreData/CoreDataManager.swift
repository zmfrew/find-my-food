import CoreData
import Foundation

protocol CoreDataManagerProtocol {
    func save(_ businesses: [Business], completion: @escaping (Result<Void, Error>) -> Void)
}

final class CoreDataManager: CoreDataManagerProtocol {
    private let managedObjectContext: NSManagedObjectContext
    private let persistentContainer: NSPersistentContainer

    init(persistentContainer: NSPersistentContainer) {
        self.managedObjectContext = persistentContainer.viewContext
        self.persistentContainer = persistentContainer
    }

    func save(_ businesses: [Business], completion: @escaping (Result<Void, Error>) -> Void) {
        guard businesses.isNotEmpty else { completion(.success(())); return }

        managedObjectContext.perform {
            // businesses.forEach { CDBusiness(object: $0, context: managedObjectContext) }

            // completion(managedObjectContext.performSave())
        }
    }
}
