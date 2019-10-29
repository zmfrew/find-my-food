import UIKit

final class BusinessDetailViewController: UIViewController, Storyboarded {
    @IBOutlet private weak var locationButton: UIBarButtonItem!
    private var detailView: BusinessDetailView { view as! BusinessDetailView } //swiftlint:disable:this force_cast
    private var business: Business?
    weak var coordinator: MainCoordinator?

    func configure(with business: Business) {
        detailView.configure(with: business)
        title = business.name
        self.business = business
    }
    
    @IBAction private func locationButtonTapped(_ sender: UIBarButtonItem) {
        guard let business = business else { return }
        
        coordinator?.locationButtonTapped(business)
    }
}
