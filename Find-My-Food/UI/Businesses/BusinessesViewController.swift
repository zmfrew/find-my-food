import UIKit

final class BusinessesViewController: UIViewController {
	private var businessesView: BusinessesView { return self.view as! BusinessesView } //swiftlint:disable:this force_cast
	private var model: BusinessModelInterface!
	var businesses: [Business] = []
	
	override func viewDidLoad() {
		businessesView.delegate = self
        businessesView.updateResultsCount(model.businessCount)
	}
	
	func configure(with model: BusinessModelInterface) {
		self.model = model
	}
}

extension BusinessesViewController: BusinessesViewDelegate {
	func business(for row: Int) -> Business? {
		return model.business(for: row)
	}
	
	var businessCount: Int {
		return model.businessCount
	}
}
