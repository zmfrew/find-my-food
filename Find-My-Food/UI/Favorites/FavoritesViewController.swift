import CoreData
import UIKit

final class FavoritesViewController: UIViewController, Storyboarded {
    weak var coordinator: BusinessCoordinator?
    private var favoritesView: FavoritesView { view as! FavoritesView } //swiftlint:disable:this force_cast
    private var model: FavoritesModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesView.delegate = self
        model = FavoritesModel(delegate: self, frc:
            BusinessFetchedResultsController(managedObjectContext: UserSession.shared.coreDataManager.viewContext))
        model.loadBusinesses()
    }
}

extension FavoritesViewController: FavoritesModelDelegate {
    func dataDidUpdate() {
        favoritesView.dataDidUpdate()
    }

    func downloadDidEnd() {
        favoritesView.downloadDidEnd()
    }
}

extension FavoritesViewController: FavoritesViewDelegate {
    var businessCount: Int { model.businessCount }

    func business(at indexPath: IndexPath) -> Business? {
        model.business(at: indexPath)
    }

    func businessSelected(at indexPath: IndexPath) {
        guard let business = business(at: indexPath) else { return }

        coordinator?.businessSelected(business, isFavorite: true)
    }

    func loadBusinesses() {
        model.loadBusinesses()
    }

    func delete(at indexPath: IndexPath) {
        model.delete(at: indexPath)
    }
}

extension FavoritesViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        favoritesView.tableView.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                favoritesView.tableView.insertRows(at: [indexPath], with: .automatic)
            }

        case .delete:
            if let indexPath = indexPath {
                favoritesView.tableView.deleteRows(at: [indexPath], with: .automatic)
            }

        case .update:
            if let indexPath = indexPath {
                _ = favoritesView.tableView.cellForRow(at: indexPath)
            }

        case .move:
            if let indexPath = indexPath {
                favoritesView.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            if let newIndexPath = newIndexPath {
                favoritesView.tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        @unknown default: break
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        favoritesView.tableView.endUpdates()
    }
}
