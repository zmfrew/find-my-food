import UIKit

protocol BusinessSearchViewDelegate: class {
	func search(for business: String)
}

final class BusinessSearchView: UIView {
	@IBOutlet private weak var searchTextField: UITextField!
	@IBOutlet private weak var searchButton: UIButton!
    private let activityIndicator = UIActivityIndicatorView(style: .large)
	
	weak var delegate: BusinessSearchViewDelegate?
	
    override func awakeFromNib() {
        activityIndicator.center = self.center
        activityIndicator.color = .darkGray
        addSubview(activityIndicator)
    }
    
	@IBAction private func searchButtonTapped(_ sender: Any) {
		guard let business = searchTextField.text, !business.isEmpty else { return }
		
		delegate?.search(for: business)
	}
}

extension BusinessSearchView {
    func downloadDidBegin() {
        activityIndicator.startAnimating()
    }

    func downloadDidEnd() {
        activityIndicator.stopAnimating()
    }
}

extension BusinessSearchView: UITextFieldDelegate {
	func textFieldDidEndEditing(_ textField: UITextField) {
		textField.resignFirstResponder()
	}
}
