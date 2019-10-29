import UIKit

final class BusinessDetailViewController: UIViewController, Storyboarded {
    @IBOutlet private weak var locationButton: UIBarButtonItem!
    private var detailView: BusinessDetailView { view as! BusinessDetailView } //swiftlint:disable:this force_cast
    weak var coordinator: MainCoordinator?

    func configure(with business: Business) {
        // TODO: - Make network call for businesses' images as they're loaded and inject here
        detailView.configure(with: business)
        title = business.name
    }
    
    @IBAction private func locationButtonTapped(_ sender: UIBarButtonItem) {
        coordinator?.locationButtonTapped()
    }
}
