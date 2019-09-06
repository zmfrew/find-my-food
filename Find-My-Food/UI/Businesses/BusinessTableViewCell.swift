import UIKit

final class BusinessTableViewCell: UITableViewCell {
	@IBOutlet private weak var nameLabel: UILabel!
	
	func decorateView(with name: String) {
		nameLabel.text = name
	}
}
