import UIKit

protocol BusinessSearchViewDelegate: class {
	func search(for business: String)
}

final class BusinessSearchView: UIView {
	@IBOutlet private weak var searchTextField: UITextField!
	@IBOutlet private weak var searchButton: UIButton!
	
	weak var delegate: BusinessSearchViewDelegate?
	
	@IBAction func searchButtonTapped(_ sender: Any) {
		guard let business = searchTextField.text, !business.isEmpty else { return }
		
		delegate?.search(for: business)
	}
}

extension BusinessSearchView: UITextFieldDelegate {
	func textFieldDidEndEditing(_ textField: UITextField) {
		textField.resignFirstResponder()
	}
}
