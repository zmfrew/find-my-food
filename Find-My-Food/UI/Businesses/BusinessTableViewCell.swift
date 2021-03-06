import UIKit

protocol BusinessTableViewCellDelegate: class {
    func favoriteTapped(on cell: BusinessTableViewCell)
}

final class BusinessTableViewCell: UITableViewCell {
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var businessImageView: UIImageView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!

    weak var delegate: BusinessTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        businessImageView.layer.cornerRadius = businessImageView.frame.width / 2
        containerView.layer.cornerRadius = 8
        containerView.backgroundColor = .background
        contentView.backgroundColor = .systemGray2
    }

    @IBAction private func favoriteButtonTapped(_ sender: UIButton) {
        delegate?.favoriteTapped(on: self)
    }
}

extension BusinessTableViewCell {
    //swiftlint:disable function_parameter_count
    func decorateView(with address: String,
                      delegate: BusinessTableViewCellDelegate,
                      image: UIImage?,
                      isFavorite: Bool?,
                      name: String,
                      rating: Double) {
        addressLabel.text = address
        self.delegate = delegate
        businessImageView.image = image
        favoriteButton.setImage(UIImage(systemName: isFavorite ?? false ? "star.fill" : "star"), for: .normal)
        favoriteButton.isUserInteractionEnabled = !(isFavorite ?? false)
        nameLabel.text = name
        ratingLabel.text = "Rating: \(rating)"
	}

    func favoriteDidSucceed() {
        favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
    }

    func hideFavoriteButton() {
        favoriteButton.isHidden = true
    }
}
