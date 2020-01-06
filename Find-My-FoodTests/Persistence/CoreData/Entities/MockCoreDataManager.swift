import CoreData
import Foundation

@testable import Find_My_Food

final class MockCoreDataManager: CoreDataManagerProtocol {
    final class Stub {
        var viewContextShouldReturn: NSManagedObjectContext {
            let mom = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
             let container = NSPersistentContainer(name: "Find-My-Food", managedObjectModel: mom)
             let description = NSPersistentStoreDescription()
             description.type = NSInMemoryStoreType
             description.shouldAddStoreAsynchronously = false

             container.persistentStoreDescriptions = [description]
             container.loadPersistentStores { (description, error) in
                 precondition( description.type == NSInMemoryStoreType )

                 if let error = error {
                     fatalError("Creating in memory core data manager failed: \(error.localizedDescription)")
                 }
             }

            return CoreDataManager(persistentContainer: container).viewContext
        }
        var saveCallCount: Int { saveCalledWith.count }
        var saveCalledWith = [[Business]]()
        var saveShouldCompleteWith: Result<Void, Error> = .success(())
    }
    
    var stub = Stub()
    
    var viewContext: NSManagedObjectContext { stub.viewContextShouldReturn }
    
    func save(_ businesses: [Business], completion: @escaping (Result<Void, Error>) -> Void) {
        stub.saveCalledWith.append(businesses)
        completion(stub.saveShouldCompleteWith)
    }
}
