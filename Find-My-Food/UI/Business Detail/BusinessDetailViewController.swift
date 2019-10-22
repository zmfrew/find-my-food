import UIKit

final class BusinessDetailViewController: UIViewController, Storyboarded {
    private var detailView: BusinessDetailView { view as! BusinessDetailView } //swiftlint:disable:this force_cast
    weak var coordinator: MainCoordinator?

    func configure(with business: Business) {
        // TODO: - Make network call for businesses' images as they're loaded and inject here
        detailView.configure(with: business)
    }
}