import UIKit

protocol BusinessesViewDelegate: class {
    var businessCount: Int { get }

    func business(for row: Int) -> Business?
    func businessSelected(at index: Int)
    func favorite(at index: Int)
    func image(for business: Business)
    func isFavorite(_ business: Business) -> Bool
    func randomize()
}

final class BusinessesView: UIView {
    @IBOutlet private weak var randomizeButton: UIButton!
    @IBOutlet private weak var resultsCountLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    weak var delegate: BusinessesViewDelegate?

	override func awakeFromNib() {
        super.awakeFromNib()
        tableView.dataSource = self
        tableView.delegate = self
        randomizeButton.layer.cornerRadius = 12
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .background
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .none
	}

    @IBAction private func randomizeButtonTapped(_ sender: UIButton) {
        delegate?.randomize()
    }
}

extension BusinessesView {
    func dataDidUpdate() {
        self.tableView.reloadData()
    }

    func saveDidSucceed(at index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        guard let cell = tableView.cellForRow(at: indexPath) as? BusinessTableViewCell else { return }

        cell.favoriteDidSucceed()
        tableView.reloadRows(at: [indexPath], with: .automatic)
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

        cell.decorateView(with: address,
                          delegate: self,
                          image: business.image,
                          isFavorite: delegate?.isFavorite(business),
                          name: business.name,
                          rating: business.rating)

		return cell
	}
}

extension BusinessesView: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.businessSelected(at: indexPath.row)
	}
}

extension BusinessesView: BusinessTableViewCellDelegate {
    func favoriteTapped(on cell: BusinessTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }

        delegate?.favorite(at: indexPath.row)
    }
}
