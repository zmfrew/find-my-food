import UIKit

protocol BusinessDetailViewDelegate: class {
    func call(_ phone: String?)
}

final class BusinessDetailView: UIView {
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var categoriesLabel: UILabel!
    @IBOutlet private weak var phoneNumberLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var businessImageView: UIImageView!
    private weak var delegate: BusinessDetailViewDelegate?
    
    func configure(with business: Business, delegate: BusinessDetailViewDelegate) {
        self.delegate = delegate
        ratingLabel.text = "\(business.rating)"
        categoriesLabel.text = business.categories.map { $0.title }.joined(separator: ", ")
        
        phoneNumberLabel.text = business.displayPhone
        addressLabel.text = business.location.displayAddress.joined()
        businessImageView.image = business.image
        
        addGestureRecognizer(UIGestureRecognizer(target: phoneNumberLabel, action: #selector(call)))
    }
    
    @objc private func call() {
        delegate?.call(phoneNumberLabel?.text)
    }
}
