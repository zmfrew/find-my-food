import CoreData

final class CoreDataStack {
    func createBusinessContainer(completion: @escaping (NSPersistentContainer) -> Void) {
        let container = NSPersistentContainer(name: "Find-My-Food")
        container.loadPersistentStores { _, error in
            guard error == nil else { fatalError("Failed to load store: \(error!)") }
            DispatchQueue.main.async { completion(container) }
        }
    }
}
