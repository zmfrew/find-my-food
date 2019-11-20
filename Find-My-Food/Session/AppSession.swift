import CoreData
import Foundation

final class AppSession {
    private let persistentContainer: NSPersistentContainer
    private let managedObjectContext: NSManagedObjectContext

    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
        self.managedObjectContext = persistentContainer.viewContext
    }
}
