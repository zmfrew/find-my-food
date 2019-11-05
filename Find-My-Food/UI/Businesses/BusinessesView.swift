import UIKit

protocol BusinessesViewDelegate: class {
	func business(for row: Int) -> Business?
    func businessSelected(at index: Int)
    func image(for business: Business)
    func randomizeButtonTapped()
    var businessCount: Int { get }
}

final class BusinessesView: UIView {
	@IBOutlet private weak var resultsCountLabel: UILabel!
	@IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var randomizeButton: UIButton!
    weak var delegate: BusinessesViewDelegate?
	
	override func awakeFromNib() {
        tableView.dataSource = self
        tableView.delegate = self
        // TODO: - Shape this button, change the color, update the text, and add gesture recognizer to move it around the screen.
        randomizeButton.layer.cornerRadius = 12
	}
    @IBAction func randomizeButtonTapped(_ sender: UIButton) {
        delegate?.randomizeButtonTapped()
    }
}

extension BusinessesView {
    func dataDidUpdate() {
        self.tableView.reloadData()
    }
    
    func updateResultsCount(_ results: Int) {
        resultsCountLabel.text = "\(results) results found"
    }
}

extension BusinessesView: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		delegate?.businessCount ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "businessCell", for: indexPath) as? BusinessTableViewCell,
			let business = delegate?.business(for: indexPath.row)
		else { return UITableViewCell() }
		
        let address = business.location.displayAddress.joined(separator: " ")
        
        cell.decorateView(with: business.name, address: address, rating: business.rating, image: business.image)
        
		return cell
	}
}

extension BusinessesView: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.businessSelected(at: indexPath.row)
	}
}
