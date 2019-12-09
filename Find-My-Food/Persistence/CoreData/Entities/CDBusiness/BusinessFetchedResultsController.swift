import CoreData

protocol BusinessFetchedResultsControllerProtocol {
    var delegate: FetchedResultsControllerDelegate? { get set }
    var fetchedResultsController: NSFetchedResultsController<CDBusiness> { get }
    var numberOfSections: Int { get }

    init(managedObjectContext: NSManagedObjectContext)
    func numberOfObjects(in section: Int) -> Int
    func object(at indexPath: IndexPath) -> CDBusiness.ConvertibleType?
    func performFetch()
    func randomElement() -> CDBusiness.ConvertibleType?
}

final class BusinessFetchedResultsController: BusinessFetchedResultsControllerProtocol {

    fileprivate(set) var fetchedResultsController: NSFetchedResultsController<CDBusiness>

    init(managedObjectContext: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<CDBusiness> = CDBusiness.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]

        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                   managedObjectContext: managedObjectContext,
                                                                   sectionNameKeyPath: nil,
                                                                   cacheName: nil)
    }
}

extension BusinessFetchedResultsController: FetchedResultsControllerProtocol { }
