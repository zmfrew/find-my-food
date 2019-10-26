import UIKit

final class BusinessDetailView: UIView {
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var categoriesLabel: UILabel!
    @IBOutlet private weak var phoneNumberLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var businessImageView: UIImageView!
    
    func configure(with business: Business) {
        ratingLabel.text = "\(business.rating)"
        categoriesLabel.text = business.categories.map { $0.title }.joined(separator: ", ")
        phoneNumberLabel.text = business.displayPhone
        addressLabel.text = business.location.displayAddress.joined()
        businessImageView.image = business.image
    }
}
