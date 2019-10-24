import UIKit

final class BusinessTableViewCell: UITableViewCell {
	@IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    func decorateView(with name: String, address: String, rating: Double) {
		nameLabel.text = name
        addressLabel.text = address
        ratingLabel.text = "\(rating)"
	}
}
