import UIKit

protocol BusinessCoordinator: Coordinator {
    var navigationController: UINavigationController { get }

    func businessSelected(_ business: Business)
    func downloadCompleted(with businesses: [Business])
    func location(for business: Business)
    func searchButtonTapped(latitude: Double?, longitude: Double?)
}
