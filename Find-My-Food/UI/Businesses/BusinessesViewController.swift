import UIKit

final class BusinessesViewController: UIViewController, Storyboarded {
	private var businessesView: BusinessesView { view as! BusinessesView } //swiftlint:disable:this force_cast
    weak var coordinator: SearchCoordinatorProtocol?
    private var model: BusinessModelProtocol!

	override func viewDidLoad() {
        super.viewDidLoad()
		businessesView.delegate = self
        businessesView.updateResultsCount(model.businessCount)
        coordinator?.statusBar(backgroundColor: .white)
	}

	func configure(with model: BusinessModelProtocol) {
		self.model = model
	}
}

extension BusinessesViewController: BusinessesModelDelegate {
    func dataDidUpdate() {
        businessesView.dataDidUpdate()
    }

    func saveDidFail() {
        let alert = UIAlertController(title: "Oh no!", message: "Favoriting failed. Please try again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true)
    }

    func saveDidSucceed(at index: Int) {
        businessesView.saveDidSucceed(at: index)
    }
}

extension BusinessesViewController: BusinessesViewDelegate {
    var businessCount: Int { model.businessCount }

	func business(for row: Int) -> Business? {
		model.business(for: row)
	}

    func businessSelected(at index: Int) {
        guard let business = business(for: index) else { return }

        coordinator?.businessSelected(business)
    }

    func favorite(at index: Int) {
        model.favorite(at: index)
    }

    func image(for business: Business) {
        model.image(for: business)
    }

    func isFavorite(_ business: Business) -> Bool {
        model.isFavorite(business)
    }

    func randomize() {
        guard let business = model.randomBusiness() else { return }

        coordinator?.businessSelected(business)
    }
}
