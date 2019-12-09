import UIKit

protocol FavoritesViewDelegate: class {
    var businessCount: Int { get }

    func business(at indexPath: IndexPath) -> Business?
    func businessSelected(at indexPath: IndexPath)
    func loadBusinesses()
}

final class FavoritesView: UIView {
    @IBOutlet weak var tableView: UITableView! //swiftlint:disable:this private_outlet
    private let refreshControl = UIRefreshControl()

    weak var delegate: FavoritesViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }

    @objc private func refresh() {
        delegate?.loadBusinesses()
    }
}

extension FavoritesView {
    func dataDidUpdate() {
        tableView.reloadData()
    }
}

extension FavoritesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        delegate?.businessCount ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "businessCell", for: indexPath) as? BusinessTableViewCell,
            let business = delegate?.business(at: indexPath)
        else { return UITableViewCell() }

        let address = business.location.displayAddress.joined(separator: " ")

        cell.decorateView(with: address,
                          delegate: self,
                          image: business.image,
                          isFavorite: business.isFavorite,
                          name: business.name,
                          rating: business.rating)

        return cell
    }
}

extension FavoritesView: UITableViewDelegate { }

extension FavoritesView: BusinessTableViewCellDelegate {
    func favoriteTapped(on cell: BusinessTableViewCell) { }
}
