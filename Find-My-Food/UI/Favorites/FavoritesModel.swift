import UIKit

protocol FavoritesModelProtocol {
    var businessCount: Int { get }

    func business(at indexPath: IndexPath) -> Business?
    func delete(at indexPath: IndexPath)
    func loadBusinesses()
}

protocol FavoritesModelDelegate: class, FetchedResultsControllerDelegate {
    func dataDidUpdate()
    func downloadDidEnd()
}

final class FavoritesModel: FavoritesModelProtocol {
    var businessCount: Int { frc.numberOfObjects(in: 0) }
    weak var delegate: FavoritesModelDelegate? {
        didSet {
            frc.delegate = self.delegate
        }
    }
    private var frc: BusinessFetchedResultsControllerProtocol

    init(delegate: FavoritesModelDelegate,
         frc: BusinessFetchedResultsControllerProtocol) {
        self.delegate = delegate
        self.frc = frc
        self.frc.delegate = delegate
    }

    func business(at indexPath: IndexPath) -> Business? {
        frc.object(at: indexPath)
    }

    func delete(at indexPath: IndexPath) {
        guard let business = frc.cdObject(at: indexPath) else { return }

        business.managedObjectContext?.delete(business)
        business.managedObjectContext?.performSave()
    }

    func loadBusinesses() {
        DispatchQueue.main.async {
            self.frc.performFetch()
            self.delegate?.downloadDidEnd()
        }
    }

    func randomBusiness() -> Business? {
        frc.randomElement()
    }
}
