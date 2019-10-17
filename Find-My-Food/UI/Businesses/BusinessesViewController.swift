import UIKit

final class BusinessesViewController: UIViewController, Storyboarded {
	private var businessesView: BusinessesView { return self.view as! BusinessesView } //swiftlint:disable:this force_cast
	private var model: BusinessModelInterface!
    weak var coordinator: MainCoordinator?
	
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
    
    func businessSelected(at index: Int) {
        guard let business = business(for: index) else { return }
        
        coordinator?.businessSelected(business)
    }
	
	var businessCount: Int {
		return model.businessCount
	}
}
