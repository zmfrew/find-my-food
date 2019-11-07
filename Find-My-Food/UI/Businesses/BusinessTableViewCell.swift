import UIKit

final class BusinessTableViewCell: UITableViewCell {
	@IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var businessImageView: UIImageView!

    func decorateView(with name: String, address: String, rating: Double, image: UIImage?) {
		nameLabel.text = name
        addressLabel.text = address
        ratingLabel.text = "\(rating)"
        businessImageView.image = image
	}
}
