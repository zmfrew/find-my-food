import UIKit

protocol BusinessTableViewCellDelegate: class {
    func favoriteTapped(on cell: BusinessTableViewCell)
}

final class BusinessTableViewCell: UITableViewCell {
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var businessImageView: UIImageView!
    @IBOutlet private weak var favoriteButton: UIButton! // TODO: - Fill the favorite button in if it's already a favorite.
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!

    weak var delegate: BusinessTableViewCellDelegate?

    @IBAction private func favoriteButtonTapped(_ sender: UIButton) {
        delegate?.favoriteTapped(on: self)
    }
}

extension BusinessTableViewCell {
    func decorateView(with address: String, delegate: BusinessTableViewCellDelegate, image: UIImage?, isFavorite: Bool, name: String, rating: Double) {
        addressLabel.text = address
        self.delegate = delegate
        businessImageView.image = image
        favoriteButton.setImage(UIImage(systemName: isFavorite ? "star.fill" : "star"), for: .normal)
        nameLabel.text = name
        ratingLabel.text = "\(rating)"
	}

    func favoriteDidSucceed() {
        favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
    }
}
