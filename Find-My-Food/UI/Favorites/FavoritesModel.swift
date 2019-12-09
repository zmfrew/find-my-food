import UIKit

protocol FavoritesModelProtocol {
    var businessCount: Int { get }

    func business(at indexPath: IndexPath) -> Business?
    func loadBusinesses()
}

protocol FavoritesModelDelegate: class, FetchedResultsControllerDelegate {
    func dataDidUpdate()
}

final class FavoritesModel: FavoritesModelProtocol {
    private let frc: BusinessFetchedResultsControllerProtocol
    var businessCount: Int { frc.numberOfObjects(in: 0) }

    weak var delegate: FavoritesModelDelegate?

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
        }
    }

    func randomBusiness() -> Business? {
        frc.randomElement()
    }
}
