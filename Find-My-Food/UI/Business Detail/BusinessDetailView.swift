import UIKit

protocol BusinessDetailViewDelegate: class {
    func call(_ phone: String?, display: String?)
}

final class BusinessDetailView: UIView {
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var categoriesLabel: UILabel!
    @IBOutlet private weak var phoneNumberButton: UIButton!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var businessImageView: UIImageView!
    private var phoneNumber = ""
    private var displayPhoneNumber = ""
    private weak var delegate: BusinessDetailViewDelegate?

    func configure(with business: Business, delegate: BusinessDetailViewDelegate) {
        self.delegate = delegate
        ratingLabel.text = "\(business.rating)"
        categoriesLabel.text = business.categories.map { $0.title }.joined(separator: ", ")

        phoneNumberButton.setTitle(business.displayPhone, for: .normal)
        addressLabel.text = business.location.displayAddress.joined()
        businessImageView.image = business.image

        phoneNumber = business.phone
        displayPhoneNumber = business.displayPhone
    }
    @IBAction private func phoneNumberButtonTapped(_ sender: UIButton) {
        delegate?.call(phoneNumber, display: displayPhoneNumber)
    }
}
