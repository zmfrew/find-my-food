import UIKit

protocol BusinessesViewDelegate: class {
	func business(for row: Int) -> Business?
    var businessCount: Int { get }
}

final class BusinessesView: UIView {
	@IBOutlet private weak var resultsCountLabel: UILabel!
	@IBOutlet private weak var tableView: UITableView!
	weak var delegate: BusinessesViewDelegate?
	
	override func awakeFromNib() {
        tableView.dataSource = self
        tableView.delegate = self
	}
}

extension BusinessesView {
    func updateResultsCount(_ results: Int) {
        resultsCountLabel.text = "\(results) results found"
    }
}

extension BusinessesView: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return delegate?.businessCount ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "businessCell", for: indexPath) as? BusinessTableViewCell,
			let business = delegate?.business(for: indexPath.row)
		else { return UITableViewCell() }
		
		cell.decorateView(with: business.name)
		
		return cell
	}
}

extension BusinessesView: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		// TODO: - Add detail view.
	}
}
