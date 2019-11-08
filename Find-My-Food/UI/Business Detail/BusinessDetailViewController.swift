import UIKit

final class BusinessDetailViewController: UIViewController, Storyboarded {
    @IBOutlet private weak var locationButton: UIBarButtonItem!
    private var detailView: BusinessDetailView { view as! BusinessDetailView } //swiftlint:disable:this force_cast
    private var business: Business?
    weak var coordinator: BusinessCoordinator?

    func configure(with business: Business) {
        detailView.configure(with: business, delegate: self)
        title = business.name
        self.business = business
    }

    @IBAction private func locationButtonTapped(_ sender: UIBarButtonItem) {
        guard let business = business else { return }

        coordinator?.locationButtonTapped(business)
    }
}

extension BusinessDetailViewController: BusinessDetailViewDelegate {
    func call(_ phone: String?, display: String?) {
        guard let phone = phone?.phoneURL,
            let display = display else { return }

        let alert = UIAlertController(title: "Call \(display)", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Call", style: .default) { _ in
            phone.call()
        })

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        self.present(alert, animated: true)
    }
}
