import UIKit

final class BusinessesViewController: UIViewController, Storyboarded {
	private var businessesView: BusinessesView { self.view as! BusinessesView } //swiftlint:disable:this force_cast
	private var model: BusinessModelProtocol!
    weak var coordinator: BusinessCoordinator?

	override func viewDidLoad() {
        super.viewDidLoad()
		businessesView.delegate = self
        businessesView.updateResultsCount(model.businessCount)
	}

	func configure(with model: BusinessModelProtocol) {
		self.model = model
	}
}

extension BusinessesViewController: BusinessesModelDelegate {
    func dataDidUpdate() {
        self.businessesView.dataDidUpdate()
    }
}

extension BusinessesViewController: BusinessesViewDelegate {
	func business(for row: Int) -> Business? {
		model.business(for: row)
	}

    func businessSelected(at index: Int) {
        guard let business = business(for: index) else { return }

        coordinator?.businessSelected(business)
    }

    func image(for business: Business) {
        model.image(for: business)
    }

    func randomizeButtonTapped() {
        guard let business = model.randomBusiness() else { return }

        coordinator?.businessSelected(business)
    }

	var businessCount: Int {
		model.businessCount
	}
}
