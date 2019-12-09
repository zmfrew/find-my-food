import UIKit

protocol FavoritesModelProtocol {
    var businessCount: Int { get }

    func business(at indexPath: IndexPath) -> Business?
    func loadBusinesses()
}

protocol FavoritesModelDelegate: class, FetchedResultsControllerDelegate {
    func dataDidUpdate()
    func downloadDidEnd()
}

final class FavoritesModel: FavoritesModelProtocol {
    private var frc: BusinessFetchedResultsControllerProtocol
    var businessCount: Int { frc.numberOfObjects(in: 0) }

    weak var delegate: FavoritesModelDelegate? {
        didSet {
            frc.delegate = self.delegate
        }
    }

    init(delegate: FavoritesModelDelegate,
         frc: BusinessFetchedResultsControllerProtocol) {
        self.delegate = delegate
        self.frc = frc
    }

    func business(at indexPath: IndexPath) -> Business? {
        frc.object(at: indexPath)
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
