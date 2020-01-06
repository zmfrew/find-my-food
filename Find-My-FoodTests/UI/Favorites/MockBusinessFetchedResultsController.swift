import CoreData
import Foundation

@testable import Find_My_Food

final class MockBusinessFetchedResultsController: BusinessFetchedResultsControllerProtocol {
    static private var fetchRequest: NSFetchRequest<CDBusiness> {
        let request: NSFetchRequest<CDBusiness> = CDBusiness.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        return request
    }
    
    final class Stub {
        var delegateCallCount = 0
        var delegateShouldReturn: FetchedResultsControllerDelegate? = nil
        var fetchedResultsControllerShouldReturn: NSFetchedResultsController<CDBusiness> = NSFetchedResultsController(fetchRequest: MockBusinessFetchedResultsController.fetchRequest, managedObjectContext: globalInMemoryCoreDataManager.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        var cdObjectCallCount: Int { cdObjectCalledWith.count }
        var cdObjectCalledWith = [IndexPath]()
        var cdObjectShouldReturn: CDBusiness? = nil
        var numberOfSectionsShouldReturn = 0
        var numberOfObjectsCallCount: Int { numberOfObjectsCalledWith.count }
        var numberOfObjectsCalledWith = [Int]()
        var numberOfObjectsShouldReturn = 0
        var objectCallCount: Int { objectCalledWith.count }
        var objectCalledWith = [IndexPath]()
        var objectShouldReturn: CDBusiness.ConvertibleType? = nil
        var performFetchCallCount = 0
        var randomElementShouldReturn: CDBusiness.ConvertibleType? = nil
    }
    
    var stub = Stub()
    
    var delegate: FetchedResultsControllerDelegate? {
        get {
            self.stub.delegateCallCount += 1
            return stub.delegateShouldReturn
        }
        set {
            self.stub.delegateShouldReturn = newValue
        }
    }
    
    var fetchedResultsController: NSFetchedResultsController<CDBusiness> {
        stub.fetchedResultsControllerShouldReturn
    }
    
    var numberOfSections: Int {
        stub.numberOfSectionsShouldReturn
    }
    
    init() { }
    
    convenience init(managedObjectContext: NSManagedObjectContext) {
        self.init()
    }
    
    func cdObject(at indexPath: IndexPath) -> CDBusiness? {
        stub.cdObjectCalledWith.append(indexPath)
        return stub.cdObjectShouldReturn
    }
    
    func numberOfObjects(in section: Int) -> Int {
        stub.numberOfObjectsCalledWith.append(section)
        return stub.numberOfObjectsShouldReturn
    }
    
    func object(at indexPath: IndexPath) -> CDBusiness.ConvertibleType? {
        stub.objectCalledWith.append(indexPath)
        return stub.objectShouldReturn
    }
    
    func performFetch() {
        stub.performFetchCallCount += 1
    }
    
    func randomElement() -> CDBusiness.ConvertibleType? {
        stub.randomElementShouldReturn
    }
}
