import UIKit

protocol BusinessDetailViewDelegate: class {
    func call(_ phone: String?, display: String?)
    func favorite()
}

final class BusinessDetailView: UIView {
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var businessImageView: UIImageView!
    @IBOutlet private weak var categoriesLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var phoneNumberButton: UIButton!
    @IBOutlet private weak var ratingLabel: UILabel!
    private var phoneNumber = ""
    private var displayPhoneNumber = ""
    private weak var delegate: BusinessDetailViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        businessImageView.layer.cornerRadius = businessImageView.frame.width / 2
        favoriteButton.layer.cornerRadius = 8
    }

    @IBAction private func phoneNumberButtonTapped(_ sender: UIButton) {
        delegate?.call(phoneNumber, display: displayPhoneNumber)
    }

    @IBAction private func favoriteButtonTapped(_ sender: UIButton) {
        delegate?.favorite()
    }
}

extension BusinessDetailView {
    func configure(with business: Business,
                   delegate: BusinessDetailViewDelegate,
                   isFavorite: Bool) {
        self.delegate = delegate
        ratingLabel.text = "\(business.rating)"
        categoriesLabel.text = business.categories.map { $0.title }.joined(separator: ", ")

        phoneNumberButton.setTitle(business.displayPhone, for: .normal)
        addressLabel.text = business.location.displayAddress.joined()
        businessImageView.image = business.image

        phoneNumber = business.phone
        displayPhoneNumber = business.displayPhone

        favoriteButton.setTitle(isFavorite ? "Favorited" : "Add to Favorites", for: .normal)
    }

    func saveDidSucceed() {
        favoriteButton.isEnabled = false
        favoriteButton.setTitle("Favorited", for: .normal)
    }
}
