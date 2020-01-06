import CoreData

protocol BusinessFetchedResultsControllerProtocol {
    var delegate: FetchedResultsControllerDelegate? { get set }
    var fetchedResultsController: NSFetchedResultsController<CDBusiness> { get }
    var numberOfSections: Int { get }

    init(managedObjectContext: NSManagedObjectContext)
    func cdObject(at indexPath: IndexPath) -> CDBusiness?
    func numberOfObjects(in section: Int) -> Int
    func object(at indexPath: IndexPath) -> CDBusiness.ConvertibleType?
    func performFetch()
    func randomElement() -> CDBusiness.ConvertibleType?
}

final class BusinessFetchedResultsController: BusinessFetchedResultsControllerProtocol {

    private(set) var fetchedResultsController: NSFetchedResultsController<CDBusiness>

    init(managedObjectContext: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<CDBusiness> = CDBusiness.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]

        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                   managedObjectContext: managedObjectContext,
                                                                   sectionNameKeyPath: nil,
                                                                   cacheName: nil)
    }

    func cdObject(at indexPath: IndexPath) -> CDBusiness? {
        fetchedResultsController.object(at: indexPath)
    }
}

extension BusinessFetchedResultsController: FetchedResultsControllerProtocol { }
