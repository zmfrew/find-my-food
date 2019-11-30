import CoreData
import Foundation

protocol CoreDataManagerProtocol {
    var viewContext: NSManagedObjectContext { get }
    func save(_ businesses: [Business], completion: @escaping (Result<Void, Error>) -> Void)
}

final class CoreDataManager: CoreDataManagerProtocol {
    private(set) var viewContext: NSManagedObjectContext
    private let persistentContainer: NSPersistentContainer

    init(persistentContainer: NSPersistentContainer) {
        self.viewContext = persistentContainer.viewContext
        self.persistentContainer = persistentContainer
    }

    func save(_ businesses: [Business], completion: @escaping (Result<Void, Error>) -> Void) {
        guard businesses.isNotEmpty else { completion(.success(())); return }

        viewContext.perform {
            // businesses.forEach { CDBusiness(object: $0, context: managedObjectContext) }

            // completion(managedObjectContext.performSave())
        }
    }
}
