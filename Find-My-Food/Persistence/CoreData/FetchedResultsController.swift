import CoreData

public typealias FetchedResultsControllerDelegate = NSFetchedResultsControllerDelegate

protocol FetchedResultsControllerProtocol: class {
    associatedtype ManagedObject: NSManagedObject & CoreDataConvertible

    var delegate: FetchedResultsControllerDelegate? { get set }

    var fetchedResultsController: NSFetchedResultsController<ManagedObject> { get }
    var numberOfSections: Int { get }

    init(managedObjectContext: NSManagedObjectContext)
    func numberOfObjects(in section: Int) -> Int
    func object(at indexPath: IndexPath) -> ManagedObject.ConvertibleType?
    func performFetch()
    func randomElement() -> ManagedObject.ConvertibleType?
}

extension FetchedResultsControllerProtocol {
    weak var delegate: FetchedResultsControllerDelegate? {
        get { fetchedResultsController.delegate }
        set { fetchedResultsController.delegate = newValue }
    }

    var numberOfSections: Int { fetchedResultsController.sections?.count ?? 0 }

    func numberOfObjects(in section: Int) -> Int {
        fetchedResultsController.sections?.element(at: section)?.numberOfObjects ?? 0
    }

    func object(at indexPath: IndexPath) -> ManagedObject.ConvertibleType? {
        fetchedResultsController.object(at: indexPath).convert()
    }

    func performFetch() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Error occurred fetching: \(error.localizedDescription)")
        }
    }

    func randomElement() -> ManagedObject.ConvertibleType? {
        fetchedResultsController.fetchedObjects?.randomElement()?.convert()
    }
}
